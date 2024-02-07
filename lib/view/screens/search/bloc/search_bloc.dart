import 'package:bloc/bloc.dart';
import 'package:movie_app/view/screens/search/bloc/search_events.dart';
import 'package:movie_app/view/screens/search/bloc/search_states.dart';

import '../../../../models/movie_model.dart';
import '../../../../repository/movie_repository.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final MovieRepository movieRepository;

  SearchBloc(this.movieRepository) : super(SearchInitial()) {
    on<SearchTermChanged>((event, emit) async {
      emit(SearchLoading());
      try {
        final List<Movie> movies = await movieRepository.searchMovies(event.term);
        emit(SearchSuccess(movies));
      } catch (e) {
        emit(SearchError(e.toString()));
      }
    });
  }
}
