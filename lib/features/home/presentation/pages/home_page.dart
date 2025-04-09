import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:samacharpatra/core/scroll_behaviour/custom_scroll_behaviour.dart';
import 'package:samacharpatra/features/home/presentation/bloc/home_bloc.dart';
import 'package:samacharpatra/features/home/presentation/widgets/home_api_key_not_set_widget.dart';
import 'package:samacharpatra/features/home/presentation/widgets/home_empty_widget.dart';
import 'package:samacharpatra/features/home/presentation/widgets/home_loading_widget.dart';
import 'package:samacharpatra/features/home/presentation/widgets/home_network_issue_widget.dart';
import 'package:samacharpatra/features/home/presentation/widgets/home_unauthorized_api_key_widget.dart';
import 'package:samacharpatra/shared/widgets/article_widget.dart';
import 'package:samacharpatra/shared/widgets/loading_article_widget.dart';

import '../widgets/home_error_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // variables
  bool _loading = false;
  final ScrollController _scrollController = ScrollController();

  // functions
  Future<void> _loadMore() async {
    setState(() {
      _loading = true;
    });
  }

  Future<void> _stopLoadMore() async {
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        if (_loading == false) {
          context.read<HomeBloc>().add(HomeLoadMoreEvent());
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
                debugPrint("Home state :: ${state.runtimeType}");
                if (state is HomeViewArticleNavigateActionState) {
                  context.push('/article', extra: state.articleEntity);
                } else if (state is HomeLoadMoreActionState) {
                  _loadMore();
                } else if (state is HomeStopLoadMoreActionState) {
                  _stopLoadMore();
                } else if (state is HomeApiSetupNavigateActionState) {
                  context.push('/setting/api-key-setup');
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

            SliverToBoxAdapter(child: _loading ? LoadingArticleWidget() : SizedBox.shrink()),
          ],
        ),
      ),
    );
  }
}
