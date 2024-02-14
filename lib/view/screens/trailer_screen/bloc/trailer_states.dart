import 'package:equatable/equatable.dart';
import '../../../../models/trailer_model.dart';

abstract class TrailerState extends Equatable {
  const TrailerState();

  @override
  List<Object> get props => [];
}

class TrailerInitial extends TrailerState {}

class TrailerLoading extends TrailerState {}

class TrailersLoaded extends TrailerState {
  final List<Trailer> trailers;
  final String? selectedTrailerKey;

  const TrailersLoaded(this.trailers, {this.selectedTrailerKey});

  @override
  List<Object> get props => [trailers, selectedTrailerKey ?? ''];
}

class TrailerError extends TrailerState {
  final String message;

  const TrailerError(this.message);

  @override
  List<Object> get props => [message];
}