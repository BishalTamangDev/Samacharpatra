import 'package:flutter/material.dart';

class HomeMaxPageReachedWidget extends StatelessWidget {
  const HomeMaxPageReachedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border(top: BorderSide(color: Theme.of(context).colorScheme.secondary))),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          spacing: 12.0,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(backgroundColor: Colors.green[100], child: Icon(Icons.check, color: Colors.green[700])),
            const Opacity(opacity: 0.6, child: Text("All caught up!")),
          ],
        ),
      ),
    );
  }
}
