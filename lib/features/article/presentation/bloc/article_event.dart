part of 'article_bloc.dart';

@immutable
sealed class ArticleEvent {}

// fetch
final class ArticleFetchEvent extends ArticleEvent {
  final ArticleEntity article;

  ArticleFetchEvent(this.article);
}

// toggle status
final class ArticleToggleEvent extends ArticleEvent {
  final String task;
  final ArticleEntity article;

  ArticleToggleEvent({required this.task, required this.article});
}

// share
final class ArticleShareEvent extends ArticleEvent {
  final String title;
  final String url;

  ArticleShareEvent({required this.title, required this.url});
}

// read more
final class ArticleReadMoreEvent extends ArticleEvent {
  final String url;

  ArticleReadMoreEvent(this.url);
}
