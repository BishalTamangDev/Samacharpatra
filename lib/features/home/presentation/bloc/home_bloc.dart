import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:samacharpatra/core/business/entities/article_entity.dart';
import 'package:samacharpatra/features/home/business/usecases/fetch_articles_usecase.dart';
import 'package:samacharpatra/features/home/data/repositories/home_repository_impl.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {});
    on<HomeFetchEvent>(_homeFetchEvent);
    on<HomeViewArticleNavigateEvent>(_homeViewArticleNavigateEvent);
  }

  // fetch articles
  Future<void> _homeFetchEvent(HomeFetchEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());

    await Future.delayed(const Duration(seconds: 2));

    final HomeRepositoryImpl homeRepository = HomeRepositoryImpl();
    final FetchArticlesUseCase fetchArticlesUseCase = FetchArticlesUseCase(homeRepository: homeRepository);

    final response = await fetchArticlesUseCase.call();

    response.fold(
      (failure) {
        emit(HomeErrorState());
      },
      (data) {
        // emit(HomeEmptyState());
        emit(HomeLoadedState(articles: data));
      },
    );
  }

  Future<void> _homeViewArticleNavigateEvent(HomeViewArticleNavigateEvent event, Emitter<HomeState> emit) async {
    emit(HomeViewArticleNavigateActionState(articleEntity: event.articleEntity));
  }
}
