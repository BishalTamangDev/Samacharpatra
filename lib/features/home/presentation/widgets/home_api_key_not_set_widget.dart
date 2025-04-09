import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samacharpatra/features/home/presentation/bloc/home_bloc.dart';

class HomeApiKeyNotSetWidget extends StatelessWidget {
  const HomeApiKeyNotSetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 140.0,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            spacing: 16.0,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red),
              const Opacity(opacity: 0.6, child: Text("You haven't set your API key.")),
              OutlinedButton(
                onPressed: () => context.read<HomeBloc>().add(HomeApiSetupNavigateEvent()),
                child: const Text("Setup Now"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
