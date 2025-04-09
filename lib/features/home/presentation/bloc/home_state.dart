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

  HomeLoadedState({required this.articles});
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

// view article :: navigate to article page
final class HomeViewArticleNavigateActionState extends HomeActionState {
  final ArticleEntity articleEntity;

  HomeViewArticleNavigateActionState(this.articleEntity);
}

// navigate to api setup page
final class HomeApiSetupNavigateActionState extends HomeActionState {}
