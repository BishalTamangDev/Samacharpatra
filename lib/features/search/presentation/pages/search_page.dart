import 'package:flutter/material.dart';

import '../../../../shared/widgets/loading_article_widget.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search Articles")),
      body: SingleChildScrollView(
        child: ListView.builder(
          itemCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, state) => LoadingArticleWidget(),
        ),
      ),
    );
  }
}
