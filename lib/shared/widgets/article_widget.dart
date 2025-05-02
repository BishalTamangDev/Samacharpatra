import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samacharpatra/core/business/entities/article_entity.dart';
import 'package:samacharpatra/core/data/source/local/local_service.dart';
import 'package:samacharpatra/features/article/presentation/bloc/article_bloc.dart';
import 'package:samacharpatra/features/home/presentation/bloc/home_bloc.dart';
import 'package:samacharpatra/features/saved/presentation/bloc/saved_bloc.dart';

import '../../core/constants/article_status_enum.dart';
import '../../core/utils/article_status_util.dart';

class ArticleWidget extends StatefulWidget {
  const ArticleWidget({super.key, required this.articleEntity, this.isForSavedArticle = false});

  final ArticleEntity articleEntity;

  final bool isForSavedArticle;

  @override
  State<ArticleWidget> createState() => _ArticleWidgetState();
}

class _ArticleWidgetState extends State<ArticleWidget> {
  // variables
  bool? _saved;

  // function
  // initial article status check
  Future<void> _checkArticleStatus() async {
    final response = await LocalService.getInstance().isSaved(widget.articleEntity.url!);
    if (!mounted) return;
    setState(() {
      _saved = response;
    });
  }

  // toggle article status
  Future<void> _toggleArticleStatus() async {
    if (_saved == null) return;
    final String task = _saved! ? 'delete' : 'save';

    final ArticleStatusEnum status = await toggleArticleStatus(task: task, article: widget.articleEntity);

    switch (status) {
      case ArticleStatusEnum.error:
      case ArticleStatusEnum.unknown:
        break;
      case ArticleStatusEnum.alreadySaved:
      case ArticleStatusEnum.saved:
        if (!mounted) return;
        setState(() {
          _saved = true;
        });
        if (!widget.isForSavedArticle) {
          context.read<SavedBloc>().add(SavedFetchEvent());
        }
        break;
      case ArticleStatusEnum.deleted:
      case ArticleStatusEnum.alreadyDeleted:
        if (!mounted) return;

        setState(() {
          _saved = false;
        });
        if (!widget.isForSavedArticle) {
          context.read<SavedBloc>().add(SavedFetchEvent());
        }
    }
  }

  @override
  void initState() {
    super.initState();

    // check article status
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkArticleStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final String title = widget.articleEntity.title ?? '-';
    final Map<String, dynamic> source = widget.articleEntity.source ?? {};
    final String sourceName = source['name'] ?? '-';
    final String urlToImage = widget.articleEntity.urlToImage ?? '';

    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        context.read<ArticleBloc>().add(ArticleFetchEvent(widget.articleEntity));
        context.read<HomeBloc>().add(HomeViewArticleNavigateEvent(widget.articleEntity));
      },
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              color: Theme.of(context).colorScheme.secondary,
              child:
                  urlToImage == ''
                      ? Image.asset('assets/images/newspaper.jpg', fit: BoxFit.cover)
                      : CachedNetworkImage(
                        imageUrl: urlToImage,
                        fit: BoxFit.cover,
                        placeholder: (context, url) {
                          return FutureBuilder(
                            future: Future.delayed(const Duration(seconds: 5)),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState != ConnectionState.done) {
                                return const Center(child: CircularProgressIndicator());
                              } else {
                                return Image.asset('assets/images/newspaper.jpg', fit: BoxFit.cover);
                              }
                            },
                          );
                        },
                        errorWidget:
                            (context, url, error) => Image.asset('assets/images/newspaper.jpg', fit: BoxFit.cover),
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
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600, height: 1.5),
                      ),
                    ),

                    // save article
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: _toggleArticleStatus,
                        child:
                            _saved == null || !_saved!
                                ? const Icon(Icons.bookmark_border_rounded)
                                : const Icon(Icons.bookmark_rounded),
                      ),
                    ),
                  ],
                ),

                // source
                if (sourceName != '-')
                  Opacity(opacity: 0.7, child: Text(sourceName, style: Theme.of(context).textTheme.bodyMedium)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
