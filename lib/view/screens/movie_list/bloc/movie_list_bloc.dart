import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../repository/movie_repository.dart';
import 'movie_list_event.dart';
import 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final MovieRepository movieRepository;

  MovieListBloc({required this.movieRepository}) : super(const MoviesInitialState()) {
    on<FetchUpcomingMoviesEvent>(_onFetchUpcomingMovies);
    on<SearchMoviesEvent>(_onSearchMovies);
  }

  Future<void> _onFetchUpcomingMovies(FetchUpcomingMoviesEvent event, Emitter<MovieListState> emit) async {
    emit(const MoviesLoadingState());
    try {
      final movies = await movieRepository.getUpcomingMovies();
      emit(MoviesLoadedState(movies: movies));
    } catch (e) {
      emit(MoviesErrorState(message: e.toString()));
    }
  }

  Future<void> _onSearchMovies(SearchMoviesEvent event, Emitter<MovieListState> emit) async {
    emit(const MoviesLoadingState());
    try {
      final movies = await movieRepository.searchMovies(event.query);
      emit(MoviesSearchedState(movies: movies));
    } catch (e) {
      emit(MoviesErrorState(message: e.toString()));
    }
  }
}
