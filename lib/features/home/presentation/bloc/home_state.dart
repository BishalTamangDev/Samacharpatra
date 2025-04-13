part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

// initial state
final class HomeInitial extends HomeState {}

// loading
final class HomeLoadingState extends HomeState {}

// loaded state
final class HomeLoadedState extends HomeState {
  final List<ArticleEntity> articles;

  HomeLoadedState(this.articles);
}

// empty article
final class HomeEmptyState extends HomeState {}

// error state
final class HomeErrorState extends HomeState {}

// api key not set
final class HomeApiKeyNotSetState extends HomeState {}

// invalid api key
final class HomeUnauthorizedApiKeyState extends HomeState {}

// no network
final class HomeNetworkIssueState extends HomeState {
  final String message;

  HomeNetworkIssueState(this.message);
}

// action state
@immutable
sealed class HomeActionState extends HomeState {}

// load more
final class HomeLoadMoreActionState extends HomeActionState {}

// stop load more
final class HomeStopLoadMoreActionState extends HomeActionState {}

// update list
final class HomeUpdateListActionState extends HomeActionState {
  final List<ArticleEntity> articles;

  HomeUpdateListActionState(this.articles);
}

// load more error
final class HomeLoadMoreErrorActionState extends HomeActionState {
  final bool status;
  final String message;

  HomeLoadMoreErrorActionState({required this.status, required this.message});
}

// view article :: navigate to article page
final class HomeViewArticleNavigateActionState extends HomeActionState {
  final ArticleEntity articleEntity;

  HomeViewArticleNavigateActionState(this.articleEntity);
}

// navigate to api setup page
final class HomeApiSetupNavigateActionState extends HomeActionState {}

// reset values
final class HomeResetValuesActionState extends HomeActionState {}

// all caught up
final class HomeAllCaughtUpActionState extends HomeActionState {}
