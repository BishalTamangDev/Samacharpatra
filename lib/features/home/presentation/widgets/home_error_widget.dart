import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_bloc.dart';

class HomeErrorWidget extends StatelessWidget {
  const HomeErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 140,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red),
            const SizedBox(height: 16.0),
            const Opacity(opacity: 0.6, child: Text("An error occurred!")),
            const SizedBox(height: 12.0),
            OutlinedButton(
              onPressed: () => context.read<HomeBloc>().add(HomeFetchEvent()),
              child: const Text("Try Again"),
            ),
          ],
        ),
      ),
    );
  }
}
