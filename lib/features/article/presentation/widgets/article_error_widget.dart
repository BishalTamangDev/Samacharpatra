import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:samacharpatra/core/business/entities/article_entity.dart';
import 'package:samacharpatra/features/article/presentation/bloc/article_bloc.dart';

class ArticleErrorWidget extends StatelessWidget {
  const ArticleErrorWidget({super.key, required this.article});

  final ArticleEntity article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Article Details"),
        leading: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8.0),
          child: IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back_ios_new)),
        ),
      ),
      body: Center(
        child: Column(
          spacing: 16.0,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red),
            const Opacity(opacity: 0.6, child: Text("Error occurred in fetching article.")),
            OutlinedButton(
              onPressed: () => context.read<ArticleBloc>().add(ArticleFetchEvent(article)),
              child: const Text("Retry"),
            ),
          ],
        ),
      ),
    );
  }
}
