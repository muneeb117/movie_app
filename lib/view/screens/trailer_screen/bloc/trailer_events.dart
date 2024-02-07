import 'package:equatable/equatable.dart';

abstract class TrailerEvent extends Equatable {
  const TrailerEvent();

  @override
  List<Object> get props => [];
}

class FetchTrailers extends TrailerEvent {
  final int movieId;

  const FetchTrailers(this.movieId);

  @override
  List<Object> get props => [movieId];
}

class SelectTrailer extends TrailerEvent {
  final String trailerKey;

  const SelectTrailer(this.trailerKey);

  @override
  List<Object> get props => [trailerKey];
}
