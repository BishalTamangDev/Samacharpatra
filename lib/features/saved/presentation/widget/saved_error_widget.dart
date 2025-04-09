import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/saved_bloc.dart';

class SavedErrorWidget extends StatelessWidget {
  const SavedErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 140,
      child: Column(
        spacing: 16.0,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline_rounded, color: Colors.red),
          const Opacity(opacity: 0.6, child: Text("An error occurred!")),
          OutlinedButton(
            onPressed: () => context.read<SavedBloc>().add(SavedFetchEvent()),
            child: const Text("Try Again"),
          ),
        ],
      ),
    );
  }
}
