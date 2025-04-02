import 'package:flutter/material.dart';
import 'package:samacharpatra/shared/widgets/loading_article_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Top Headlined in US")),
      backgroundColor: Theme.of(context).canvasColor,
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
