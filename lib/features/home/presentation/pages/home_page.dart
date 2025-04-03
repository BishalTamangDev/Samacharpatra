import 'package:flutter/material.dart';
import 'package:samacharpatra/features/article/data/models/article_model.dart';
import 'package:samacharpatra/shared/widgets/loading_article_widget.dart';

import '../../../../shared/widgets/article_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(floating: true, pinned: false, elevation: 1, title: const Text('Top Headlines in the US')),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ArticleWidget(articleEntity: ArticleModel.fromJson({}).toEntity()),
                ArticleWidget(articleEntity: ArticleModel.fromJson({}).toEntity()),
                ArticleWidget(articleEntity: ArticleModel.fromJson({}).toEntity()),
              ],
            ),
          ),
          SliverToBoxAdapter(child: Column(children: List.generate(3, (index) => LoadingArticleWidget()))),
        ],
      ),
    );
  }
}
