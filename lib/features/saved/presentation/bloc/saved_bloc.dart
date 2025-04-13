import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:samacharpatra/core/business/entities/article_entity.dart';
import 'package:samacharpatra/features/saved/business/usecases/fetch_all_articles_usecase.dart';
import 'package:samacharpatra/features/saved/data/repositories/saved_repository_impl.dart';

import '../../../../core/errors/failures/failures.dart';

part 'saved_event.dart';
part 'saved_state.dart';

class SavedBloc extends Bloc<SavedEvent, SavedState> {
  SavedBloc() : super(SavedInitial()) {
    on<SavedEvent>((event, emit) {});
    on<SavedFetchEvent>(_savedFetchEvent);
    on<SavedSaveArticleEvent>(_savedSaveArticleEvent);
    on<SavedUnSaveArticleEvent>(_savedUnSaveArticleEvent);
    on<SavedViewArticleEvent>(_savedViewArticleEvent);
  }

  // fetch saved articles
  Future<void> _savedFetchEvent(SavedFetchEvent event, Emitter<SavedState> emit) async {
    emit(SavedLoadingState());

    await Future.delayed(Duration(milliseconds: 100));

    final SavedRepositoryImpl savedRepository = SavedRepositoryImpl();
    final FetchAllArticlesUseCase fetchAllArticlesUseCase = FetchAllArticlesUseCase(savedRepository);

    final Either<Failure, List<ArticleEntity>> response = await fetchAllArticlesUseCase.call();

    response.fold(
      (failure) {
        emit(SavedErrorState());
      },
      (articles) {
        if (articles.isEmpty) {
          emit(SavedEmptyState());
        } else {
          emit(SavedLoadedState(articles));
        }
      },
    );
  }

  // save article
  Future<void> _savedSaveArticleEvent(SavedSaveArticleEvent event, Emitter<SavedState> emit) async {}

  // un-save article
  Future<void> _savedUnSaveArticleEvent(SavedUnSaveArticleEvent event, Emitter<SavedState> emit) async {
    debugPrint("Article id to delete :: ${event.id}");
  }

  // view article
  Future<void> _savedViewArticleEvent(SavedViewArticleEvent event, Emitter<SavedState> emit) async {
    emit(SavedViewNavigateActionState(event.article));
  }
}
