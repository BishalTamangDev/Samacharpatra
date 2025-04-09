import 'package:flutter/material.dart';

class SavedEmptyWidget extends StatelessWidget {
  const SavedEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 140,
      child: const Column(
        spacing: 16.0,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.hourglass_empty_outlined, color: Colors.red),
          Opacity(opacity: 0.6, child: Text("You haven't saved any article yet!")),
        ],
      ),
    );
  }
}
