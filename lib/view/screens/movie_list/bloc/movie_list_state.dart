import '../../../../models/movie_model.dart';

abstract class MovieListState {
  const MovieListState();
}

class MoviesInitialState extends MovieListState {
  const MoviesInitialState() : super();
}

class MoviesLoadingState extends MovieListState {
  const MoviesLoadingState() : super();
}

class MoviesLoadedState extends MovieListState {
  final List<Movie> movies;

  const MoviesLoadedState({required this.movies}) : super();
}

class MoviesErrorState extends MovieListState {
  final String message;

  const MoviesErrorState({required this.message}) : super();
}

class MoviesSearchedState extends MovieListState {
  final List<Movie> movies;

  const MoviesSearchedState({required this.movies}) : super();
}
