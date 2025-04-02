import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        spacing: 12.0,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Page Not Found"),
          ElevatedButton(onPressed: () => context.pop, child: const Text("Go Back")),
        ],
      ),
    );
  }
}
