import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:samacharpatra/core/constants/app_constants.dart';
import 'package:samacharpatra/core/data/source/local/local_service.dart';
import 'package:samacharpatra/features/article/business/usecases/toggle_article_status_usecase.dart';
import 'package:samacharpatra/features/article/data/repository/article_repository.dart';

import '../../../../core/business/entities/article_entity.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  ArticleBloc() : super(ArticleInitial()) {
    on<ArticleEvent>((event, emit) {});
    on<ArticleFetchEvent>(_articleFetchEvent);
    on<ArticleToggleEvent>(_articleToggleEvent);
    on<ArticleShareEvent>(_articleShareEvent);
    on<ArticleReadMoreEvent>(_articleReadMoreEvent);
  }

  // fetch article
  Future<void> _articleFetchEvent(ArticleFetchEvent event, Emitter<ArticleState> emit) async {
    emit(ArticleLoadingState());

    // check if the article is saved
    final bool isSaved = await LocalService.getInstance().isSaved(event.article.url ?? '-');

    final ArticleStatusEnum status = isSaved ? ArticleStatusEnum.saved : ArticleStatusEnum.deleted;

    emit(ArticleLoadedState(article: event.article, status: status));
    await Future.delayed(const Duration(milliseconds: 100));

    emit(ArticleToggleActionState(status));

    // emit(ArticleErrorState(event.article));
  }

  // toggle article status
  Future<void> _articleToggleEvent(ArticleToggleEvent event, Emitter<ArticleState> emit) async {
    final ArticleRepositoryImpl articleRepository = ArticleRepositoryImpl();
    final ToggleArticleStatusUseCase toggleArticleStatusUseCase = ToggleArticleStatusUseCase(articleRepository);
    final ArticleStatusEnum status = await toggleArticleStatusUseCase.call(task: event.task, article: event.article);
    emit(ArticleToggleActionState(status));
  }

  // share article
  Future<void> _articleShareEvent(ArticleShareEvent event, Emitter<ArticleState> emit) async {
    if (event.url == '' || event.url == '-') {
      emit(ArticleShareActionState(response: false, title: event.title, url: event.url));
    } else {
      // TODO :: check if the url can be launched
      final bool response = true;
      emit(ArticleShareActionState(response: response, title: event.title, url: event.url));
    }
  }

  // read more
  Future<void> _articleReadMoreEvent(ArticleReadMoreEvent event, Emitter<ArticleState> emit) async {
    final url = Uri.parse(event.url);
    if (event.url == '' || event.url == '-') {
      emit(ArticleReadMoreActionState(response: false, url: url));
    } else {
      // TODO :: check if the url can be launched
      final bool response = true;
      emit(ArticleReadMoreActionState(response: response, url: url));
    }
  }
}
