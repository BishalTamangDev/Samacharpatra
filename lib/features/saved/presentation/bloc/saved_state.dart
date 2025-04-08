part of 'saved_bloc.dart';

@immutable
sealed class SavedState {}

// initial state
final class SavedInitial extends SavedState {}

// action state
final class SavedActionState extends SavedState {}

// loading
final class SavedLoadingState extends SavedState {}

// loaded
final class SavedLoadedState extends SavedState {
  final List<ArticleEntity> articles;

  SavedLoadedState({required this.articles});
}

// error
final class SavedErrorState extends SavedState {}

// empty
final class SavedEmptyState extends SavedState {}

// navigate to view page
final class SavedViewNavigateActionState extends SavedActionState {
  final ArticleEntity article;

  SavedViewNavigateActionState({required this.article});
}
