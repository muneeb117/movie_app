abstract class SearchEvent {}

class SearchTermChanged extends SearchEvent {
  final String term;

  SearchTermChanged(this.term);
}
