import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samacharpatra/core/business/entities/article_entity.dart';
import 'package:samacharpatra/features/home/presentation/bloc/home_bloc.dart';

class ArticleWidget extends StatefulWidget {
  const ArticleWidget({super.key, required this.articleEntity});

  final ArticleEntity articleEntity;

  @override
  State<ArticleWidget> createState() => _ArticleWidgetState();
}

class _ArticleWidgetState extends State<ArticleWidget> {
  // variables
  bool? _offlinePresence;

  // function
  // save or un-save article
  _setOfflinePresence(bool present) {
    setState(() {
      _offlinePresence = present;
    });
  }

  @override
  void initState() {
    super.initState();
    _offlinePresence = widget.articleEntity.saved;
  }

  @override
  Widget build(BuildContext context) {
    final String title = widget.articleEntity.title ?? '';
    final Map<String, dynamic> source = widget.articleEntity.source ?? {};
    final String sourceName = source['name'] ?? '';
    final String urlToImage = widget.articleEntity.urlToImage ?? '';

    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () => context.read<HomeBloc>().add(HomeViewArticleNavigateEvent(widget.articleEntity)),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              color: Theme.of(context).colorScheme.secondary,
              child: CachedNetworkImage(
                imageUrl: urlToImage,
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Image.asset('assets/images/newspaper.jpg', fit: BoxFit.cover),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              spacing: 16.0,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 6.0,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // title
                    Expanded(
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),

                    // save article
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        if (_offlinePresence != null) {
                          _setOfflinePresence(!_offlinePresence!);
                        }
                      },
                      child:
                          _offlinePresence == null || !_offlinePresence!
                              ? Icon(Icons.bookmark_border_rounded)
                              : Icon(Icons.bookmark_rounded),
                    ),
                  ],
                ),

                // source
                if (sourceName != '')
                  Opacity(opacity: 0.7, child: Text(sourceName, style: Theme.of(context).textTheme.bodyMedium)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
