import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/business/entities/article_entity.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key, required this.article});

  final ArticleEntity article;

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  // variable
  final String title =
      "Larry Fink Says Bitcoin Could Replace the Dollar as the World's Reserve Currency Because of National Debt";
  final String description =
      "With America's national debt sitting comfortably over the \$36.2 trillion mark, BlackRock CEO Larry Fink is warning the burden could one day be the reason the dollar is dethroned as the reserve currency of the world.\n From a report: He argues that decentralize…";
  final String content =
      "As long as everyday people can't go into a marketplace and effortlessly, ubiquitously use it, that's not gonna happen.\r\nEven if it did become the world's currency, imagine the power consumption neede… [+111 chars]";
  final String author = "msmash";
  final String sourceName = "Slashdot.org";

  // variables
  bool? _offlinePresence;

  // function
  // save or un-save article
  void _setOfflinePresence(bool present) {
    setState(() {
      _offlinePresence = present;
    });
  }

  // check if the article is available offline
  void _checkOfflinePresence() {
    final bool present = true;
    _setOfflinePresence(present);
  }

  @override
  void initState() {
    debugPrint("Article page :: ${widget.article.url}");
    super.initState();
    _checkOfflinePresence();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: false,
            pinned: false,
            expandedHeight: MediaQuery.of(context).size.width * (9 / 16),
            flexibleSpace: FlexibleSpaceBar(
              background: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  color: Theme.of(context).colorScheme.secondary,
                  child: CachedNetworkImage(
                    imageUrl: widget.article.urlToImage!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Image.asset('assets/images/newspaper.jpg', fit: BoxFit.cover),
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
                  spacing: 8.0,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.article.title ?? '-',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(height: 1.2),
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
                          _offlinePresence == null
                              ? Icon(Icons.bookmark_border_rounded)
                              : _offlinePresence!
                              ? Icon(Icons.bookmark_rounded)
                              : Icon(Icons.bookmark_border_rounded),
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

              // read more
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    debugPrint("Read More");
                  },
                  child: Text(
                    "Read More",
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.blueAccent),
                  ),
                ),
              ),

              const SizedBox(height: 16.0),

              // author
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(spacing: 6.0, children: [Icon(Icons.edit, size: 16.0), Text("$author, $sourceName")]),
              ),
              const SizedBox(height: 80.0),
            ]),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint("Share");
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(Icons.share, color: Theme.of(context).colorScheme.onPrimary),
      ),
    );
  }
}
