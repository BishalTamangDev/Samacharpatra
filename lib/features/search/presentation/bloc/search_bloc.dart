import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:samacharpatra/core/errors/failures/failures.dart';
import 'package:samacharpatra/features/search/business/usecases/search_usecase.dart';
import 'package:samacharpatra/features/search/data/repositories/search_repository_impl.dart';

import '../../../../core/business/entities/article_entity.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchEvent>((event, emit) {});
    on<SearchArticleEvent>(_searchArticleEvent);
    on<SearchResetEvent>(_searchResetEvent);
    on<SearchApiSetupNavigateEvent>(_searchApiSetupNavigateEvent);
  }

  // search article
  Future<void> _searchArticleEvent(event, emit) async {
    emit(SearchingState(event.searchTitle));

    final SearchRepositoryImpl searchRepository = SearchRepositoryImpl();
    final SearchUseCase searchUseCase = SearchUseCase(searchRepository);

    // search article
    final Either<Failure, List<ArticleEntity>> response = await searchUseCase.call(event.searchTitle);

    response.fold(
      (failure) {
        if (failure is ApiKeyNotSetFailure) {
          // api key not set
          emit(SearchApiKeyNotSetState());
        } else if (failure is UnauthorizedApiKeyFailure) {
          // invalid api key
          emit(SearchInvalidApiKeyState());
        } else if (failure is NetworkFailure) {
          // network failure
        } else if (failure is ServerFailure) {
          // server failure
        } else {
          // unexpected failure
          emit(SearchErrorState());
        }
      },
      (articles) {
        if (articles.isEmpty) {
          emit(SearchEmptyState());
        } else {
          emit(SearchedState(articles));
        }
      },
    );

    // emit(SearchEmptyState());
    // emit(SearchErrorState());
    // emit(SearchKeyError());
    // emit(SearchNetworkError());
  }

  // reset search
  Future<void> _searchResetEvent(SearchResetEvent event, Emitter<SearchState> emit) async {
    emit(SearchResetActionState());
    emit(SearchInitial());
  }

  // navigate to api setup page
  Future<void> _searchApiSetupNavigateEvent(SearchApiSetupNavigateEvent event, Emitter<SearchState> emit) async {
    emit(SearchApiKeySetupNavigateActionState());
  }
}
