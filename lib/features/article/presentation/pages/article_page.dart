import 'package:flutter/material.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/newspaper.jpg'),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  spacing: 16.0,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      spacing: 8.0,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text(title, style: Theme.of(context).textTheme.titleLarge!.copyWith(height: 1.2))),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              debugPrint("Save Article");
                            },
                            child: Icon(Icons.bookmark_border_rounded),
                          ),
                        ),
                      ],
                    ),

                    // description
                    Opacity(
                      opacity: 0.8,
                      child: Text(description, style: Theme.of(context).textTheme.bodyMedium!.copyWith(height: 1.4)),
                    ),

                    // content
                    Opacity(
                      opacity: 0.8,
                      child: Text(content, style: Theme.of(context).textTheme.bodyMedium!.copyWith(height: 1.4)),
                    ),

                    // read more
                    InkWell(
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

                    // author
                    Row(spacing: 6.0, children: [Icon(Icons.edit, size: 16.0), Text("$author, $sourceName")]),
                  ],
                ),
              ),
            ],
          ),
        ),
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
