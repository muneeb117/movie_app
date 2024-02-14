import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'bloc/trailer_bloc.dart';
import 'bloc/trailer_events.dart';
import 'bloc/trailer_states.dart';

class TrailerPlayerScreen extends StatefulWidget {
  final int? movieId;

  const TrailerPlayerScreen({Key? key, this.movieId}) : super(key: key);

  @override
  State<TrailerPlayerScreen> createState() => _TrailerPlayerScreenState();
}

class _TrailerPlayerScreenState extends State<TrailerPlayerScreen> {
   YoutubePlayerController? _controller;

  void _initializePlayer(String videoId) {
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
    )..addListener(() {
      if (_controller!.value.playerState == PlayerState.ended) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<TrailerBloc>().add(FetchTrailers(widget.movieId!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Trailer',style: TextStyle(color: Colors.white),),
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon:  const Icon(Icons.arrow_back_ios,color: Colors.white,size: 18,),),
        backgroundColor: Colors.black,
      ),
      body: BlocConsumer<TrailerBloc, TrailerState>(
        listener: (context, state) {
          if (state is TrailersLoaded && state.trailers.isNotEmpty) {
            final videoId = YoutubePlayer.convertUrlToId(state.selectedTrailerKey ?? state.trailers.first.key);
            if (videoId != null) {
              if (_controller == null) {
                _initializePlayer(videoId);
              } else {
                _controller!.load(videoId);
              }
            }
          }
        },
        builder: (context, state) {
          if (state is TrailerLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TrailersLoaded) {
            return Column(
              children: [
                Expanded(
                  child: _controller != null
                      ? YoutubePlayer(
                    controller: _controller!,
                    showVideoProgressIndicator: true,
                  )
                      :const Center(child: Text("Select a trailer")),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SizedBox(
                    height: 140,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.trailers.length,
                      itemBuilder: (context, index) {
                        final trailer = state.trailers[index];
                        return InkWell(
                          onTap: () => context.read<TrailerBloc>().add(SelectTrailer(trailer.key)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    YoutubePlayer.getThumbnail(videoId: trailer.key, quality: ThumbnailQuality.medium),
                                    width: 160,
                                  ),
                                ),
                                SizedBox(
                                  width: 160,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      trailer.name,
                                      style:const TextStyle(color: Colors.black),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],

            );
          } else if (state is TrailerError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('No trailers available.'));
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
