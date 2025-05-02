import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:samacharpatra/core/utils/date_time_utils.dart';
import 'package:samacharpatra/features/article/presentation/bloc/article_bloc.dart';
import 'package:samacharpatra/features/article/presentation/widgets/article_error_widget.dart';
import 'package:samacharpatra/features/article/presentation/widgets/article_loading_widget.dart';
import 'package:samacharpatra/features/saved/presentation/bloc/saved_bloc.dart';
import 'package:samacharpatra/shared/widgets/custom_snackbar_widget.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/business/entities/article_entity.dart';
import '../../../../core/constants/article_status_enum.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key, required this.article});

  final ArticleEntity article;

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  // variables
  bool _saved = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ArticleBloc, ArticleState>(
      listenWhen: (previous, current) => current is ArticleActionState,
      buildWhen: (previous, current) => current is! ArticleActionState,
      listener: (context, state) async {
        if (state is ArticleReadMoreActionState) {
          if (state.response) {
            if (!await launchUrl(state.url)) {
              if (!context.mounted) return;
              showCustomSnackbar(context: context, message: "The link is currently not available.");
            }
          } else {
            showCustomSnackbar(context: context, message: "The link is currently not available.");
          }
        } else if (state is ArticleShareActionState) {
          if (state.response) {
            await Share.share(state.url, subject: state.title);
          } else {
            showCustomSnackbar(
              context: context,
              message: "Cannot share this article! The link is currently now available.",
            );
          }
        } else if (state is ArticleToggleActionState) {
          if (!mounted) return;
          setState(() {
            _saved = state.status == ArticleStatusEnum.saved;
          });
          context.read<SavedBloc>().add(SavedFetchEvent());
        }
      },
      builder: (context, state) {
        switch (state) {
          case ArticleLoadedState():
            return Scaffold(
              appBar: AppBar(
                title: const Text("Article Details"),
                leading: Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                  child: IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back_ios_new)),
                ),
                actionsPadding: const EdgeInsets.only(right: 16.0),
                actions: [
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap:
                        () => context.read<ArticleBloc>().add(
                          ArticleShareEvent(title: widget.article.title ?? '-', url: widget.article.url ?? '-'),
                        ),
                    child: const Icon(Icons.share),
                  ),
                ],
              ),
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    floating: false,
                    pinned: false,
                    expandedHeight: MediaQuery.of(context).size.width * (9 / 16),
                    automaticallyImplyLeading: false,
                    flexibleSpace: FlexibleSpaceBar(
                      background: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Container(
                          color: Theme.of(context).colorScheme.secondary,
                          child:
                              state.article.urlToImage == ''
                                  ? Image.asset('assets/images/newspaper.jpg', fit: BoxFit.cover)
                                  : CachedNetworkImage(
                                    imageUrl: state.article.urlToImage!,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) {
                                      return FutureBuilder(
                                        future: Future.delayed(const Duration(seconds: 3)),
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
                                        (context, url, error) =>
                                            Image.asset('assets/images/newspaper.jpg', fit: BoxFit.cover),
                                  ),
                        ),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      const SizedBox(height: 16.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          spacing: 12.0,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                widget.article.title ?? '-',
                                style: Theme.of(context).textTheme.titleLarge!.copyWith(height: 1.2),
                              ),
                            ),

                            // toggle article
                            InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap:
                                  () => context.read<ArticleBloc>().add(
                                    ArticleToggleEvent(
                                      task: state.status == ArticleStatusEnum.saved ? 'delete' : 'save',
                                      article: state.article,
                                    ),
                                  ),
                              child:
                                  _saved ? const Icon(Icons.bookmark_rounded) : const Icon(Icons.bookmark_border_rounded),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16.0),

                      // description
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Opacity(
                          opacity: 0.8,
                          child: Text(
                            widget.article.description ?? '-',
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(height: 1.4),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16.0),

                      // content
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Opacity(
                          opacity: 0.8,
                          child: Text(
                            widget.article.content ?? '-',
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(height: 1.4),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16.0),

                      // author
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            const Icon(Icons.edit, size: 20.0, color: Colors.red),
                            const SizedBox(width: 8.0),
                            Row(
                              children: [
                                if (state.article.author != null) Text("${state.article.author!}, "),
                                Text("${state.article.source!['name'] ?? '-'}"),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16.0),

                      // date
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          spacing: 8.0,
                          children: [
                            const Icon(Icons.date_range_outlined, size: 20.0, color: Colors.red),
                            Text(DateTimeUtils.getFormattedLocalDateTime(widget.article.publishedAt!)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 80.0),
                    ]),
                  ),
                ],
              ),
              bottomNavigationBar: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    height: 45.0,
                    child: ElevatedButton(
                      onPressed: () => context.read<ArticleBloc>().add(ArticleReadMoreEvent(widget.article.url ?? '-')),
                      child: const Text("Read More"),
                    ),
                  ),
                ),
              ),
            );
          case ArticleErrorState():
            return ArticleErrorWidget(article: state.article);
          case ArticleLoadingState():
          case ArticleInitial():
          default:
            return ArticleLoadingWidget();
        }
      },
    );
  }
}
