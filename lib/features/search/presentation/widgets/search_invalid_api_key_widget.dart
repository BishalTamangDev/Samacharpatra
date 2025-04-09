import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/search_bloc.dart';

class SearchInvalidApiKeyWidget extends StatelessWidget {
  const SearchInvalidApiKeyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 16.0,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red),
          const Opacity(
            opacity: 0.6,
            child: Text("Your API key is invalid. Update it and try again.", style: TextStyle(height: 1.4)),
          ),
          ElevatedButton(
            onPressed: () => context.read<SearchBloc>().add(SearchApiSetupNavigateEvent()),
            child: const Text("Update API Key"),
          ),
        ],
      ),
    );
  }
}
