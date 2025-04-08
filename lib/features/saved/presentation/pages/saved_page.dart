import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samacharpatra/features/saved/presentation/bloc/saved_bloc.dart';

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
                switch (state.runtimeType) {
                  case SavedLoadingState:
                    return Column(children: List.generate(3, (index) => LoadingArticleWidget()));
                  case SavedLoadedState:
                    final currentState = state as SavedLoadedState;
                    return Text("${currentState.articles}");
                  case SavedEmptyState:
                    return SizedBox(
                      height: MediaQuery.of(context).size.height - 140,
                      child: const Column(
                        spacing: 16.0,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.hourglass_empty_outlined, color: Colors.red),
                          Opacity(opacity: 0.6, child: Text("You haven't saved any article yet!")),
                        ],
                      ),
                    );
                  case SavedErrorState:
                    return SizedBox(
                      height: MediaQuery.of(context).size.height - 140,
                      child: Column(
                        spacing: 16.0,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline_rounded, color: Colors.red),
                          const Opacity(opacity: 0.6, child: Text("An error occurred!")),
                          OutlinedButton(
                            onPressed: () => context.read<SavedBloc>().add(SavedFetchEvent()),
                            child: const Text("Retry"),
                          ),
                        ],
                      ),
                    );
                  default:
                    return CircularProgressIndicator();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
