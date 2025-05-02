import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:samacharpatra/core/business/entities/article_entity.dart';
import 'package:samacharpatra/core/constants/numeric_constants.dart';
import 'package:samacharpatra/core/scroll_behaviour/custom_scroll_behaviour.dart';
import 'package:samacharpatra/features/home/presentation/bloc/home_bloc.dart';
import 'package:samacharpatra/features/home/presentation/widgets/home_api_key_not_set_widget.dart';
import 'package:samacharpatra/features/home/presentation/widgets/home_empty_widget.dart';
import 'package:samacharpatra/features/home/presentation/widgets/home_load_more_error_widget.dart';
import 'package:samacharpatra/features/home/presentation/widgets/home_loading_more_widget.dart';
import 'package:samacharpatra/features/home/presentation/widgets/home_loading_widget.dart';
import 'package:samacharpatra/features/home/presentation/widgets/home_max_page_reached_widget.dart';
import 'package:samacharpatra/features/home/presentation/widgets/home_network_issue_widget.dart';
import 'package:samacharpatra/features/home/presentation/widgets/home_unauthorized_api_key_widget.dart';
import 'package:samacharpatra/shared/widgets/article_widget.dart';

import '../../../api_key_setup/presentation/bloc/api_key_bloc.dart';
import '../widgets/home_error_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // variables
  int page = 2;
  bool loading = false;
  bool loadMoreError = false;
  bool maxPageReached = false;
  final ScrollController _scrollController = ScrollController();

  List<ArticleEntity> articleList = [];

  // functions
  void _loadMore() {
    if (!mounted) return;

    setState(() {
      loading = true;
    });
  }

  void _stopLoadMore() {
    if (!mounted) return;

    setState(() {
      loading = false;
    });
  }

  // reset values
  void _resetValues() {
    if (!mounted) return;
    setState(() {
      page = 2;
      loadMoreError = false;
      articleList.clear();
      maxPageReached = false;
    });
  }

  // update values
  void _updateValues(List<ArticleEntity> newArticles) {
    if (!mounted) return;
    setState(() {
      page++;
      articleList.addAll(newArticles);
      loadMoreError = false;
      if (page == NumericConstants.maxPage) {
        maxPageReached = true;
        debugPrint("Max page reached");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        if (!loading && !maxPageReached) {
          if (!mounted) return;
          setState(() {
            loadMoreError = false;
          });
          context.read<HomeBloc>().add(HomeLoadMoreEvent(page: page, oldArticles: articleList));
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomMaterialIndicator(
        onRefresh: () async => context.read<HomeBloc>().add(HomeFetchEvent()),
        indicatorBuilder: (context, controller) => CircularProgressIndicator(backgroundColor: Colors.transparent),
        child: CustomScrollView(
          controller: _scrollController,
          scrollBehavior: CustomScrollBehaviour(),
          slivers: [
            // appbar
            SliverAppBar(floating: true, pinned: false, elevation: 1, title: const Text('Top Headlines in the US')),

            // content
            BlocConsumer<HomeBloc, HomeState>(
              listenWhen: (previous, current) => current is HomeActionState,
              buildWhen: (previous, current) => current is! HomeActionState,
              listener: (context, state) {
                if (state is HomeViewArticleNavigateActionState) {
                  context.push('/article', extra: state.articleEntity);
                } else if (state is HomeLoadMoreActionState) {
                  _loadMore();
                } else if (state is HomeStopLoadMoreActionState) {
                  _stopLoadMore();
                } else if (state is HomeApiSetupNavigateActionState) {
                  context.read<ApiKeyBloc>().add(ApiKeyFetchEvent());
                  context.push('/setting/api-key-setup');
                } else if (state is HomeUpdateListActionState) {
                  _updateValues(state.articles);
                } else if (state is HomeLoadMoreErrorActionState) {
                  _stopLoadMore();
                  if (!mounted) return;
                  setState(() {
                    loadMoreError = true;
                  });
                } else if (state is HomeResetValuesActionState) {
                  _resetValues();
                } else if (state is HomeAllCaughtUpActionState) {
                  if (!mounted) return;

                  setState(() {
                    maxPageReached = true;
                  });
                }
              },
              builder: (context, state) {
                switch (state) {
                  case HomeLoadedState():
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => ArticleWidget(articleEntity: state.articles[index]),
                        childCount: state.articles.length,
                      ),
                    );
                  case HomeEmptyState():
                    return HomeEmptyWidget();
                  case HomeNetworkIssueState():
                    return HomeNetworkIssueWidget(message: state.message);
                  case HomeApiKeyNotSetState():
                    return HomeApiKeyNotSetWidget();
                  case HomeUnauthorizedApiKeyState():
                    return HomeUnauthorizedApiKeyWidget();
                  case HomeErrorState():
                    return HomeErrorWidget();
                  default:
                    return HomeLoadingWidget();
                }
              },
            ),

            // loading more articles
            SliverToBoxAdapter(child: loading ? const HomeLoadingMoreWidget() : const SizedBox.shrink()),

            // error in loading more articles
            SliverToBoxAdapter(child: !loadMoreError ? const SizedBox.shrink() : const HomeLoadMoreErrorWidget()),

            // max page reached
            SliverToBoxAdapter(child: !maxPageReached ? const SizedBox.shrink() : const HomeMaxPageReachedWidget()),
          ],
        ),
      ),
    );
  }
}
