import 'package:flutter/material.dart';

import '../../../../shared/widgets/loading_article_widget.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: false,
            elevation: 1,
            // backgroundColor: Theme.of(context).colorScheme.primary,
            title: const Text('Saved Articles'),
          ),
          SliverToBoxAdapter(child: Column(children: List.generate(3, (index) => LoadingArticleWidget()))),
        ],
      ),
    );
  }
}
