import 'package:flutter/material.dart';

class HomeConnectionWidget extends StatefulWidget {
  const HomeConnectionWidget({super.key});

  @override
  State<HomeConnectionWidget> createState() => _HomeConnectionWidgetState();
}

class _HomeConnectionWidgetState extends State<HomeConnectionWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.signal_wifi_statusbar_connected_no_internet_4, color: Colors.red),
            const SizedBox(height: 16.0),
            const Opacity(opacity: 0.7, child: Text("Check your network connection")),
            const SizedBox(height: 12.0),
            OutlinedButton(onPressed: () {}, child: const Text("Try Again")),
          ],
        ),
      ),
    );
  }
}
