abstract class MovieListEvent {
  const MovieListEvent();
}

class FetchUpcomingMoviesEvent extends MovieListEvent {
  const FetchUpcomingMoviesEvent() : super();
}

class SearchMoviesEvent extends MovieListEvent {
  final String query;

  const SearchMoviesEvent(this.query) : super();
}
