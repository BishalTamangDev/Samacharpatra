import 'package:bloc/bloc.dart';
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

    await Future.delayed(const Duration(seconds: 2));

    final HomeRepositoryImpl homeRepository = HomeRepositoryImpl();
    final FetchArticlesUseCase fetchArticlesUseCase = FetchArticlesUseCase(homeRepository);

    final response = await fetchArticlesUseCase.call();

    response.fold(
      (failure) {
        debugPrint("Failure :: $failure");
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
          emit(HomeLoadedState(articles: data));
        }
      },
    );
  }

  // load more articles
  Future<void> _homeLoadMoreEvent(HomeLoadMoreEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadMoreActionState());
    await Future.delayed(const Duration(seconds: 3));
    emit(HomeStopLoadMoreActionState());
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
