import 'package:flutter/material.dart';

class SearchErrorWidget extends StatelessWidget {
  const SearchErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(32.0),
        child: Column(
          spacing: 16.0,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.red),
            Opacity(opacity: 0.6, child: Text("An error occurred!")),
          ],
        ),
      ),
    );
  }
}
