part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

// searching
final class SearchingState extends SearchState {
  final String searchTitle;

  SearchingState(this.searchTitle);
}

// searched
final class SearchedState extends SearchState {
  final List<ArticleEntity> articles;

  SearchedState(this.articles);
}

// empty
final class SearchEmptyState extends SearchState {}

// error
final class SearchErrorState extends SearchState {}

// api key not set
final class SearchApiKeyNotSetState extends SearchState {}

// invalid api key
final class SearchInvalidApiKeyState extends SearchState {}

// network issue :: show dialog box
final class SearchNetworkErrorState extends SearchState {}

// action state
final class SearchActionState extends SearchState {}

// reset search action state
final class SearchResetActionState extends SearchActionState {}

// navigate to api key setup page
final class SearchApiKeySetupNavigateActionState extends SearchActionState {}
