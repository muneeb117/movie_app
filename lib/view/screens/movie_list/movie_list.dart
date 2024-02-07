import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/routes/name.dart';
import 'package:movie_app/view/screens/movie_list/widgets/movie_card_widgets.dart';

import '../../../utils/colors_list.dart';
import '../movie_detail_screen/movie_detail_screen.dart';
import '../search/search_screen.dart';
import 'bloc/movie_list_bloc.dart';
import 'bloc/movie_list_event.dart';
import 'bloc/movie_list_state.dart';

class MovieListScreen extends StatefulWidget {
  @override
  _MovieListScreenState createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MovieListBloc>().add(FetchUpcomingMoviesEvent());
  }

  void _navigateToSearchScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SearchScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryText,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            "Watch",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: IconButton(
              icon: const Icon(Icons.search, color: Colors.black),
              onPressed: _navigateToSearchScreen,
              tooltip: 'Search',
            ),
          ),
        ],
        elevation: 0,
      ),

      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<MovieListBloc, MovieListState>(
              builder: (context, state) {
                if (state is MoviesLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MoviesLoadedState) {
                  return ListView.builder(
                    itemCount: state.movies.length,
                    itemBuilder: (context, index) {
                      final movie = state.movies[index];
                      return MovieCardWidget(
                        movie: movie,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MovieDetailScreen(movie: movie),
                            ),
                          );
                        },
                      );
                    },
                  );
                } else if (state is MoviesErrorState) {
                  return Center(child: Text('Error: ${state.message}'));
                } else {
                  return const Center(child: Text('Please wait while we load movies.'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
