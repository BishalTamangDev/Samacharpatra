import 'package:flutter/material.dart';

class LoadingArticleWidget extends StatelessWidget {
  const LoadingArticleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // image
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.8)),
        ),

        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10.0,
            children: [
              // title
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.8),
                ),
                height: 10.0,
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.8),
                ),
                height: 10.0,
                width: MediaQuery.of(context).size.width / 1.5,
              ),

              // source
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.8),
                ),
                height: 10.0,
                width: MediaQuery.of(context).size.width / 5,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
