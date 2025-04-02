import 'package:flutter/material.dart';

import '../../../../shared/widgets/loading_article_widget.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Saved Articles")),
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
