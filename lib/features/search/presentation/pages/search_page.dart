import 'package:flutter/material.dart';

import '../../../../shared/widgets/loading_article_widget.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: false,
            elevation: 1,
            toolbarHeight: 80.0,
            backgroundColor: Theme.of(context).colorScheme.surface,
            title: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
              height: 40.0,
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                  prefixIcon: Icon(Icons.search_rounded),
                  border: InputBorder.none,
                  hintText: "Search article",
                  fillColor: Theme.of(context).colorScheme.secondary,
                  filled: true,
                  suffixIcon: Icon(Icons.close),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(child: Column(children: List.generate(3, (index) => LoadingArticleWidget()))),
        ],
      ),
    );
  }
}
