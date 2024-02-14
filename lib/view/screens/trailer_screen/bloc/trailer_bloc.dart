import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/view/screens/trailer_screen/bloc/trailer_events.dart';
import 'package:movie_app/view/screens/trailer_screen/bloc/trailer_states.dart';

import '../../../../services/api/tmdb_api_client.dart';

class TrailerBloc extends Bloc<TrailerEvent, TrailerState> {
  final TmdbApiClient apiClient = TmdbApiClient();

  TrailerBloc() : super(TrailerInitial()) {
    on<FetchTrailers>(_onFetchTrailers);
    on<SelectTrailer>(_onSelectTrailer);
  }

  Future<void> _onFetchTrailers(FetchTrailers event, Emitter<TrailerState> emit) async {
    emit(TrailerLoading());
    try {
      final trailers = await apiClient.fetchMovieTrailers(event.movieId);
      emit(TrailersLoaded(trailers));
    } catch (e) {
      emit( const TrailerError('Failed to fetch trailers'));
    }
  }

  void _onSelectTrailer(SelectTrailer event, Emitter<TrailerState> emit) {
    if (state is TrailersLoaded) {
      final currentState = state as TrailersLoaded;
      emit(TrailersLoaded(currentState.trailers, selectedTrailerKey: event.trailerKey));
    }
  }
}
