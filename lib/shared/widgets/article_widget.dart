import 'package:flutter/material.dart';
import 'package:samacharpatra/features/article/business/entities/article_entity.dart';

class ArticleWidget extends StatefulWidget {
  const ArticleWidget({super.key, required this.articleEntity});

  final ArticleEntity articleEntity;

  @override
  State<ArticleWidget> createState() => _ArticleWidgetState();
}

class _ArticleWidgetState extends State<ArticleWidget> {
  @override
  Widget build(BuildContext context) {
    String title = widget.articleEntity.title ?? 'Hello World!';
    Map<String, dynamic> source = widget.articleEntity.source ?? {};
    String sourceName = source['name'] ?? 'Slashdot.org';

    return Column(
      children: [
        // image
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.8),
              image: DecorationImage(image: AssetImage('assets/images/newspaper.jpg'), fit: BoxFit.cover),
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 8.0, bottom: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // spacing: 8.0,
            children: [
              Row(
                children: [
                  // title
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),

                  // save article
                  IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {
                      debugPrint("Save Article");
                    },
                    icon: Icon(Icons.bookmark_border_rounded),
                  ),
                ],
              ),

              // source
              Opacity(opacity: 0.7, child: Text(sourceName, style: Theme.of(context).textTheme.bodyMedium)),
            ],
          ),
        ),
      ],
    );
  }
}
