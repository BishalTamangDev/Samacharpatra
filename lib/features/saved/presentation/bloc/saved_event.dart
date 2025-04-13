part of 'saved_bloc.dart';

@immutable
sealed class SavedEvent {}

// fetch saved articles
final class SavedFetchEvent extends SavedEvent {}

// save
final class SavedSaveArticleEvent extends SavedEvent {
  final ArticleEntity article;

  SavedSaveArticleEvent(this.article);
}

// un-save
final class SavedUnSaveArticleEvent extends SavedEvent {
  final int id;

  SavedUnSaveArticleEvent(this.id);
}

// view article
final class SavedViewArticleEvent extends SavedEvent {
  final ArticleEntity article;

  SavedViewArticleEvent(this.article);
}
