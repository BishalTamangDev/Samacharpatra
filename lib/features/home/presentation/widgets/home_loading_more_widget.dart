import 'package:flutter/material.dart';

class HomeLoadingMoreWidget extends StatelessWidget {
  const HomeLoadingMoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(width: 1.0, color: Theme.of(context).colorScheme.secondary)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Opacity(
          opacity: 0.4,
          child: Column(
            spacing: 16.0,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: 12.0,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 76.0,
                    height: 12.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  Container(
                    height: 12.0,
                    width: 32.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
              Container(
                height: 12.0,
                width: MediaQuery.of(context).size.width / 1.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              Container(
                height: 12.0,
                width: 90.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
