import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ArticleLoadingWidget extends StatelessWidget {
  const ArticleLoadingWidget({super.key});

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [const AspectRatio(aspectRatio: 16 / 9, child: BlankWidget()), const CircularProgressIndicator()],
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                spacing: 16.0,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // title
                  Column(
                    spacing: 12.0,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        spacing: 12.0,
                        children: [
                          BlankWidget(width: MediaQuery.of(context).size.width - 84.0),
                          const BlankWidget(width: 40.0),
                        ],
                      ),
                      BlankWidget(width: MediaQuery.of(context).size.width / 1.5),
                    ],
                  ),

                  // description
                  Column(
                    spacing: 12.0,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BlankWidget(),
                      const BlankWidget(),
                      const BlankWidget(),
                      BlankWidget(width: MediaQuery.of(context).size.width / 2),
                    ],
                  ),

                  // content
                  Column(
                    spacing: 12.0,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BlankWidget(),
                      const BlankWidget(),
                      const BlankWidget(),
                      const BlankWidget(),
                      const BlankWidget(),
                      BlankWidget(width: MediaQuery.of(context).size.width / 2),
                    ],
                  ),

                  // author
                  const Row(
                    spacing: 8,
                    children: [BlankWidget(width: 20.0), BlankWidget(width: 50.0), BlankWidget(width: 80.0)],
                  ),

                  // date
                  const Row(spacing: 8, children: [BlankWidget(width: 20.0), BlankWidget(width: 60.0)]),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Padding(padding: EdgeInsets.all(16.0), child: BlankWidget(height: 45.0)),
    );
  }
}

class BlankWidget extends StatelessWidget {
  const BlankWidget({super.key, this.height = 12.0, this.width = double.maxFinite});

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.4,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
