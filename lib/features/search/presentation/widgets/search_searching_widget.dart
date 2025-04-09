import 'package:flutter/material.dart';

class SearchSearchingWidget extends StatelessWidget {
  const SearchSearchingWidget({super.key, required this.searchTitle});

  final String searchTitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          spacing: 16.0,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [const CircularProgressIndicator(), Opacity(opacity: 0.6, child: Text("Searching for $searchTitle"))],
        ),
      ),
    );
  }
}
