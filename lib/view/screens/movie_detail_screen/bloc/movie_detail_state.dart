import '../../../../models/movie_model.dart';
import '../../../../models/trailer_model.dart';

abstract class MovieDetailState {}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  final Movie movie;
  MovieDetailLoaded(this.movie);
}

class MovieDetailError extends MovieDetailState {
  final String message;
  MovieDetailError(this.message);
}

class TrailerLoading extends MovieDetailState {}

class TrailersAvailable extends MovieDetailState {
  final List<Trailer> trailers;
  TrailersAvailable(this.trailers);
}
