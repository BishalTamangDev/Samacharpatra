import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_bloc.dart';

class HomeNetworkIssueWidget extends StatelessWidget {
  const HomeNetworkIssueWidget({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 140,
        child: Column(
          spacing: 16.0,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.network_wifi_1_bar_rounded, color: Colors.red),
            Opacity(opacity: 0.6, child: Text(message)),
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
