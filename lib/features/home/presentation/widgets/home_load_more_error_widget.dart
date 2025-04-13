import 'package:flutter/material.dart';

class HomeLoadMoreErrorWidget extends StatelessWidget {
  const HomeLoadMoreErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(width: 1.0, color: Theme.of(context).colorScheme.secondary)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: const Column(
          spacing: 16.0,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.error_outline, color: Colors.red),
            Opacity(opacity: 0.6, child: Text("Error occurred in loading more articles.")),
          ],
        ),
      ),
    );
  }
}
