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

// no network
final class HomeNoNetworkState extends HomeState {}

// action state
@immutable
sealed class HomeActionState extends HomeState {}

// view article :: navigate to article page
final class HomeViewArticleNavigateActionState extends HomeActionState {
  final ArticleEntity articleEntity;

  HomeViewArticleNavigateActionState({required this.articleEntity});
}
