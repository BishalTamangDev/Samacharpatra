import 'package:flutter/material.dart';

class SearchNetworkIssueWidget extends StatelessWidget {
  const SearchNetworkIssueWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.0),
        child: Column(
          spacing: 16.0,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.network_locked_outlined, color: Colors.red),
            const Opacity(opacity: 0.6, child: Text("Please check your network connection.")),
            OutlinedButton(onPressed: () {}, child: const Text("Try Again")),
          ],
        ),
      ),
    );
  }
}
