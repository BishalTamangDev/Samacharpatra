import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_bloc.dart';

class HomeUnauthorizedApiKeyWidget extends StatelessWidget {
  const HomeUnauthorizedApiKeyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 140.0,
        child: Column(
          spacing: 16.0,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red),
            const Opacity(
              opacity: 0.6,
              child: Text("Your API key is invalid. Update it and try again.", style: TextStyle(height: 1.4)),
            ),
            ElevatedButton(
              onPressed: () => context.read<HomeBloc>().add(HomeApiSetupNavigateEvent()),
              child: const Text("Update API Key"),
            ),
          ],
        ),
      ),
    );
  }
}
