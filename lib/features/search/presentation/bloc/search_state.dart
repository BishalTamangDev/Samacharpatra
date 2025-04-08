part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

// action state
final class SearchActionState extends SearchState {}

// searching
final class SearchingState extends SearchState {}

// searched
final class SearchedState extends SearchState {
  final List<ArticleEntity> articles;

  SearchedState({required this.articles});
}

// empty
final class SearchEmptyState extends SearchState {}

// error
final class SearchErrorState extends SearchState {}

// network issue :: show dialog box
final class SearchNetworkErrorActionState extends SearchActionState {}

// api key issue action state :: show dialog box
final class SearchKeyErrorActionState extends SearchActionState {}

// reset search action state
final class SearchResetActionState extends SearchActionState {}
