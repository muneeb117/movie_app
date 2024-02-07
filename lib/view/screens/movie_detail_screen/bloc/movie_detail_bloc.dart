import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/movie_model.dart';
import '../../../../repository/movie_repository.dart';
import 'movie_detail_event.dart';
import 'movie_detail_state.dart';
class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final MovieRepository movieRepository;

  MovieDetailBloc({required this.movieRepository}) : super(MovieDetailInitial()) {
    on<LoadMovieDetail>(_onLoadMovieDetail);
    on<WatchTrailer>(_onWatchTrailer);
  }

  Future<void> _onLoadMovieDetail(LoadMovieDetail event, Emitter<MovieDetailState> emit) async {
    emit(MovieDetailLoading());
    try {
      final movie = await movieRepository.getMovieDetails(event.movieId);
      emit(MovieDetailLoaded(movie));
    } catch (e) {
      emit(MovieDetailError('Failed to load movie details'));
    }
  }

  Future<void> _onWatchTrailer(WatchTrailer event, Emitter<MovieDetailState> emit) async {
    if (state is MovieDetailLoaded) {
      final movie = (state as MovieDetailLoaded).movie;
      if (movie.trailers.isNotEmpty) {
        emit(TrailersAvailable(movie.trailers));
      } else {
        emit(MovieDetailError('No trailers available'));
      }
    }
  }
}
