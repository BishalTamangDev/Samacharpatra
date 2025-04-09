import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samacharpatra/features/search/presentation/bloc/search_bloc.dart';

class SearchApiKeyNotSetWidget extends StatelessWidget {
  const SearchApiKeyNotSetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          spacing: 16.0,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red),
            const Opacity(opacity: 0.6, child: Text("You haven't set your API key.")),
            OutlinedButton(
              onPressed: () => context.read<SearchBloc>().add(SearchApiSetupNavigateEvent()),
              child: const Text("Setup Now"),
            ),
          ],
        ),
      ),
    );
  }
}
