part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

// fetch articles
final class HomeFetchEvent extends HomeEvent {}

// view article :: navigate to article page
final class HomeViewArticleNavigateEvent extends HomeEvent {
  final ArticleEntity articleEntity;

  HomeViewArticleNavigateEvent({required this.articleEntity});
}
