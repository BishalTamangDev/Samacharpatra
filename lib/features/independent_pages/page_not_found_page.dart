import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PageNotFoundPage extends StatelessWidget {
  const PageNotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            spacing: 16.0,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Opacity(opacity: 0.6, child: Text("Page Not Found", style: Theme.of(context).textTheme.titleMedium)),
              OutlinedButton(onPressed: () => context.pop(), child: const Text("Go Back")),
            ],
          ),
        ),
      ),
    );
  }
}
