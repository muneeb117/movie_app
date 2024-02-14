import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/utils/colors_list.dart';
import 'package:movie_app/view/screens/cinema_booking/screens/cinema_screen/cinema_screen_hall.dart';
import 'package:movie_app/view/screens/movie_detail_screen/bloc/movie_detail_bloc.dart';
import 'package:movie_app/view/screens/movie_detail_screen/widgets/build_action_button.dart';
import '../../../repository/movie_repository.dart';
import '../mqtt/chat_screen.dart';
import '../trailer_screen/trailer_screen.dart';
import 'bloc/movie_detail_event.dart';
import 'bloc/movie_detail_state.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie? movie;

  const MovieDetailScreen({super.key, this.movie});

  @override
  Widget build(BuildContext context) {
    const imageUrl = "https://image.tmdb.org/t/p/w500";
    return BlocProvider(
      create: (context) => MovieDetailBloc(
          movieRepository: RepositoryProvider.of<MovieRepository>(context))
        ..add(LoadMovieDetail(movie!.id)),
      child: Scaffold(
        body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) {
            if (state is MovieDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MovieDetailLoaded) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          height: 400.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                offset: const Offset(0, 4),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Image.network(
                                imageUrl + movie!.posterPath,
                                fit: BoxFit.cover,
                                height: 400.h,
                                width: double.infinity,
                              ),
                              Positioned(
                                top: 0,
                                child: Container(
                                  height: 80,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.black.withOpacity(0.6),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // Bottom shadow
                              Positioned(
                                bottom: 0,
                                child: Container(
                                  height: 80,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Colors.black.withOpacity(0.6),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 40,
                          left: 16,
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_back_ios,
                                    color: Colors.white),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              const Text(
                                "Watch",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              const SizedBox(
                                width: 200,
                              ),
                              IconButton(
                                onPressed: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChatScreen(
                                        movieId: movie!.id.toString(),
                                        movieName: movie!.title,
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.message_outlined,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          top: 250,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Text(
                              'In Theaters ${DateFormat('MMMM dd, yyyy').format(DateTime.parse(movie!.releaseDate))}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 70,
                          left: 16,
                          right: 16,
                          child: Column(
                            children: [
                              buildActionButton(
                                context: context,
                                text: 'Get Tickets',
                                color: fillColor,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MovieDateAndHallSelectionScreen(
                                                movieName: movie!.title,
                                                releaseDate: movie!.releaseDate,
                                              )));
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              buildActionButton(
                                  context: context,
                                  text: 'Watch Trailer',
                                  color: Colors.transparent,
                                  borderColor: Colors.blue,
                                  onTap: () {
                                    // print(movie!.trailers.length);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TrailerPlayerScreen(
                                                    movieId: movie!.id)));
                                  }),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20.0, top: 20),
                      child: Text(
                        'Genre',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20),
                      child: Wrap(
                        spacing: 8.0,
                        children: movie!.genres.map((genre) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              chipTheme: Theme.of(context).chipTheme.copyWith(
                                    side: BorderSide.none,
                                  ),
                            ),
                            child: Chip(
                              labelPadding: const EdgeInsets.all(2.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              label: Text(
                                genre.name,
                                style: const TextStyle(color: Colors.white),
                              ),
                              backgroundColor:
                                  genreColors[genre.id % genreColors.length],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Divider(
                        color: AppColors.strokeColor,
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                      child: Text(
                        'Overview',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: Text(movie!.overview),
                    ),
                  ],
                ),
              );
            } else if (state is MovieDetailError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return const Center(child: Text('Something went wrong'));
            }
          },
        ),
      ),
    );
  }
}
