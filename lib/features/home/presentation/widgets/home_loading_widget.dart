import 'package:flutter/material.dart';

import '../../../../shared/widgets/loading_article_widget.dart';

class HomeLoadingWidget extends StatelessWidget {
  const HomeLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(child: Column(children: List.generate(3, (index) => const LoadingArticleWidget())));
  }
}
