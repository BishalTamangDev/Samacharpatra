import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:samacharpatra/features/search/presentation/widgets/search_empty_widget.dart';
import 'package:samacharpatra/features/search/presentation/widgets/search_error_widget.dart';
import 'package:samacharpatra/features/search/presentation/widgets/search_initial_widget.dart';
import 'package:samacharpatra/features/search/presentation/widgets/search_invalid_api_key_widget.dart';
import 'package:samacharpatra/features/search/presentation/widgets/search_searching_widget.dart';

import '../../../../shared/widgets/article_widget.dart';
import '../../../api_key_setup/presentation/bloc/api_key_bloc.dart';
import '../bloc/search_bloc.dart';
import '../widgets/search_api_key_not_set_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // variables
  bool hasText = false;
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: TextField(
          // autofocus: true,
          controller: searchController,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            prefixIcon: Icon(Icons.search_rounded),
            border: InputBorder.none,
            hintText: "Search article",
            suffixIcon:
                !hasText
                    ? null
                    : IconButton(
                      onPressed: () => context.read<SearchBloc>().add(SearchResetEvent()),
                      icon: const Icon(Icons.close),
                    ),
          ),
          onChanged: (newValue) {
            setState(() {
              hasText = newValue == '' ? false : true;
            });
          },
          onSubmitted: (title) {
            FocusScope.of(context).unfocus();
            if (title != '') {
              context.read<SearchBloc>().add(SearchArticleEvent(title));
            }
          },
        ),
      ),
      body: BlocConsumer<SearchBloc, SearchState>(
        listenWhen: (previous, current) => current is SearchActionState,
        buildWhen: (previous, current) => current is! SearchActionState,
        listener: (context, state) {
          if (state is SearchApiKeySetupNavigateActionState) {
            context.read<ApiKeyBloc>().add(ApiKeyFetchEvent());
            context.push('/setting/api-key-setup');
          } else if (state is SearchResetActionState) {
            searchController.clear();
          }
        },
        builder: (context, state) {
          switch (state) {
            case SearchInitial():
              return const SearchInitialWidget();
            case SearchingState():
              return SearchSearchingWidget(searchTitle: state.searchTitle);
            case SearchInvalidApiKeyState():
              return const SearchInvalidApiKeyWidget();
            case SearchEmptyState():
              return SearchEmptyWidget();
            case SearchApiKeyNotSetState():
              return const SearchApiKeyNotSetWidget();
            case SearchErrorState():
              return const SearchErrorWidget();
            case SearchedState():
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.articles.length,
                itemBuilder: (context, index) {
                  return ArticleWidget(articleEntity: state.articles[index]);
                },
              );
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
