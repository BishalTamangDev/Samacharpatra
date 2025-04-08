import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:samacharpatra/features/search/presentation/bloc/search_bloc.dart';
import 'package:samacharpatra/shared/widgets/custom_alert_dialog_single_option_widget.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: TextField(
          autofocus: true,
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
                      icon: Icon(Icons.close),
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
              context.read<SearchBloc>().add(SearchArticleEvent(searchTitle: title));
            }
          },
        ),
      ),
      body: BlocConsumer<SearchBloc, SearchState>(
        listenWhen: (previous, current) => current is SearchActionState,
        buildWhen: (previous, current) => current is! SearchActionState,
        listener: (context, state) {
          if (state is SearchKeyErrorActionState) {
            showDialog(
              context: context,
              builder: (context) {
                return CustomAlertDialogSingleOptionWidget(
                  title: "Issue in API Key",
                  description: "An error occurred with your API key.",
                  option: "Change Now",
                  callBack: () {
                    context.pop();
                    context.read<SearchBloc>().add(SearchNavigateApiSetupPage());
                  },
                );
              },
            );
          } else if (state is SearchNavigateApiSetupPage) {
            context.push('/setting/api-key-setup');
          } else if (state is SearchNetworkErrorActionState) {
            showDialog(
              context: context,
              builder: (context) {
                return CustomAlertDialogSingleOptionWidget(
                  title: "Network Error",
                  description: "Check your network connection and try again.",
                  option: "Okay",
                  callBack: () => context.pop(),
                );
              },
            );
          } else if (state is SearchResetActionState) {
            searchController.clear();
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case SearchInitial:
              return const Padding(
                padding: EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    Center(child: Opacity(opacity: 0.6, child: Text("Feel free to search the article you like."))),
                  ],
                ),
              );
            case SearchedState:
              final currentState = state as SearchedState;
              return Text("${state.articles}");
            case SearchEmptyState:
              return const Padding(
                padding: EdgeInsets.all(32.0),
                child: Column(children: [Center(child: Opacity(opacity: 0.6, child: Text("No articles found!")))]),
              );
            case SearchErrorState:
              return const Padding(
                padding: EdgeInsets.all(32.0),
                child: Column(children: [Center(child: Opacity(opacity: 0.6, child: Text("An error occurred!")))]),
              );
            default:
              return const Padding(
                padding: EdgeInsets.all(32.0),
                child: Column(
                  spacing: 16.0,
                  children: [
                    Center(child: CircularProgressIndicator()),
                    Center(child: Opacity(opacity: 0.6, child: Text("Searching..."))),
                  ],
                ),
              );
          }
        },
      ),
    );
  }
}
