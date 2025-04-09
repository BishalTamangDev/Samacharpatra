import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samacharpatra/features/saved/presentation/bloc/saved_bloc.dart';
import 'package:samacharpatra/features/saved/presentation/widget/saved_empty_widget.dart';
import 'package:samacharpatra/features/saved/presentation/widget/saved_error_widget.dart';

import '../../../../shared/widgets/loading_article_widget.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(floating: true, pinned: false, elevation: 1, title: const Text('Saved Articles')),

          SliverToBoxAdapter(
            child: BlocConsumer<SavedBloc, SavedState>(
              listenWhen: (previous, current) => current is SavedActionState,
              buildWhen: (previous, current) => current is! SavedActionState,
              listener: (context, state) {
                if (state is SavedViewNavigateActionState) {
                  debugPrint("${state.article}");
                }
              },
              builder: (context, state) {
                switch (state) {
                  case SavedLoadedState():
                    return Text("${state.articles}");
                  case SavedEmptyState():
                    return SavedEmptyWidget();
                  case SavedErrorState():
                    return SavedErrorWidget();
                  default:
                    return Column(children: List.generate(3, (index) => LoadingArticleWidget()));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
