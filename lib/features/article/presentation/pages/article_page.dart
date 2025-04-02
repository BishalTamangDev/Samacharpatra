import 'package:flutter/material.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Article Details"),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.share))],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Expanded(child: Column(children: [Text("Title"), Text("Description")])),
            Row(
              children: [const Text("Read More"), IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios))],
            ),
          ],
        ),
      ),
    );
  }
}
