part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

// fetch articles
final class HomeFetchEvent extends HomeEvent {}

// load more articles
final class HomeLoadMoreEvent extends HomeEvent {
  final int page;
  final List<ArticleEntity> oldArticles;

  HomeLoadMoreEvent({required this.page, required this.oldArticles});
}

// view article :: navigate to article page
final class HomeViewArticleNavigateEvent extends HomeEvent {
  final ArticleEntity articleEntity;

  HomeViewArticleNavigateEvent(this.articleEntity);
}

// navigate to api setup page
final class HomeApiSetupNavigateEvent extends HomeEvent {}
