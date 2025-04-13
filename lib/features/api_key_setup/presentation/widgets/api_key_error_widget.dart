import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/api_key_bloc.dart';

class ApiKeyErrorWidget extends StatelessWidget {
  const ApiKeyErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("API Key Setup")),

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            spacing: 16.0,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Opacity(opacity: 0.6, child: Text("Error fetching api key")),
              ElevatedButton(
                onPressed: () => context.read<ApiKeyBloc>().add(ApiKeyFetchEvent()),
                child: const Text("Try Again"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
