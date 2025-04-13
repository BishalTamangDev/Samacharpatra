part of 'article_bloc.dart';

@immutable
sealed class ArticleState {}

// initial state
final class ArticleInitial extends ArticleState {}

// loading state
final class ArticleLoadingState extends ArticleState {}

// loaded state
final class ArticleLoadedState extends ArticleState {
  final ArticleEntity article;
  final ArticleStatusEnum status;

  ArticleLoadedState({required this.article, required this.status});
}

// error state
final class ArticleErrorState extends ArticleState {
  final ArticleEntity article;

  ArticleErrorState(this.article);
}

// action state
@immutable
sealed class ArticleActionState extends ArticleState {}

// save || delete article
final class ArticleToggleActionState extends ArticleActionState {
  final ArticleStatusEnum status;

  ArticleToggleActionState(this.status);
}

// share article
final class ArticleShareActionState extends ArticleActionState {
  final bool response;
  final String title;
  final String url;

  ArticleShareActionState({required this.response, required this.title, required this.url});
}

// read more
final class ArticleReadMoreActionState extends ArticleActionState {
  final bool response;
  final Uri url;

  ArticleReadMoreActionState({required this.response, required this.url});
}
