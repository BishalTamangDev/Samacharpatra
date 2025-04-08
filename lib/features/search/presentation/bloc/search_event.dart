part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

// search
final class SearchArticleEvent extends SearchEvent {
  final String searchTitle;

  SearchArticleEvent({required this.searchTitle});
}

// clear
final class SearchResetEvent extends SearchEvent {}

// load more
final class SearchLoadMoreEvent extends SearchEvent {}

// navigate to api setup page
final class SearchNavigateApiSetupPage extends SearchEvent {}
