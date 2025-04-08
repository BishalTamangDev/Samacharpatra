import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/business/entities/article_entity.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchEvent>((event, emit) {});
    on<SearchArticleEvent>(_searchArticleEvent);
    on<SearchResetEvent>(_searchResetEvent);
  }

  // search article
  Future<void> _searchArticleEvent(event, emit) async {
    emit(SearchingState());
    debugPrint("Searching for ${event.searchTitle}");

    debugPrint("Search completed");
    emit(SearchedState(articles: []));

    final List<ArticleEntity> articles = [];

    if (articles.isEmpty) {
      emit(SearchEmptyState());
    }

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
}
