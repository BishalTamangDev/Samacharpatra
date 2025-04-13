import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:samacharpatra/core/business/entities/article_entity.dart';
import 'package:samacharpatra/core/errors/failures/failures.dart';
import 'package:samacharpatra/features/home/business/usecases/fetch_articles_usecase.dart';
import 'package:samacharpatra/features/home/data/repositories/home_repository_impl.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {});
    on<HomeFetchEvent>(_homeFetchEvent);
    on<HomeLoadMoreEvent>(_homeLoadMoreEvent);
    on<HomeViewArticleNavigateEvent>(_homeViewArticleNavigateEvent);
    on<HomeApiSetupNavigateEvent>(_homeApiSetupNavigateEvent);
  }

  // fetch articles
  Future<void> _homeFetchEvent(HomeFetchEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(milliseconds: 100));

    emit(HomeResetValuesActionState());

    final HomeRepositoryImpl homeRepository = HomeRepositoryImpl();
    final FetchArticlesUseCase fetchArticlesUseCase = FetchArticlesUseCase(homeRepository);

    final Either<Failure, List<ArticleEntity>> response = await fetchArticlesUseCase.call();

    response.fold(
      (failure) {
        if (failure is UnauthorizedApiKeyFailure) {
          emit(HomeUnauthorizedApiKeyState());
        } else if (failure is ApiKeyNotSetFailure) {
          emit(HomeApiKeyNotSetState());
        } else if (failure is NetworkFailure) {
          emit(HomeNetworkIssueState(failure.message));
        } else {
          emit(HomeErrorState());
        }
      },
      (data) {
        if (data.isEmpty) {
          emit(HomeEmptyState());
        } else {
          emit(HomeLoadedState(data));
          // add delay
          emit(HomeUpdateListActionState(data));
        }
      },
    );
  }

  // load more articles
  Future<void> _homeLoadMoreEvent(HomeLoadMoreEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadMoreActionState());

    final HomeRepositoryImpl homeRepository = HomeRepositoryImpl();
    final FetchArticlesUseCase fetchArticlesUseCase = FetchArticlesUseCase(homeRepository);

    final Either<Failure, List<ArticleEntity>> response = await fetchArticlesUseCase.call(page: event.page);

    if (response.isLeft()) {
      emit(HomeStopLoadMoreActionState());
      await Future.delayed(const Duration(milliseconds: 100));
      emit(HomeLoadMoreErrorActionState(status: false, message: "Something went wrong."));
      return;
    }

    final List<ArticleEntity> data = response.getOrElse(() => []);

    if (data.isEmpty) {
      // all caught up
      emit(HomeStopLoadMoreActionState());
      await Future.delayed(const Duration(milliseconds: 100));
      emit(HomeAllCaughtUpActionState());
    } else {
      emit(HomeStopLoadMoreActionState());

      final List<ArticleEntity> finalData = event.oldArticles;
      finalData.addAll(data.toList());

      emit(HomeLoadedState(finalData));
      await Future.delayed(const Duration(milliseconds: 100));
      emit(HomeUpdateListActionState(data));
    }
  }

  // view article
  Future<void> _homeViewArticleNavigateEvent(HomeViewArticleNavigateEvent event, Emitter<HomeState> emit) async {
    emit(HomeViewArticleNavigateActionState(event.articleEntity));
  }

  // navigate to api key setup page
  Future<void> _homeApiSetupNavigateEvent(HomeApiSetupNavigateEvent event, Emitter<HomeState> emit) async {
    emit(HomeApiSetupNavigateActionState());
  }
}
