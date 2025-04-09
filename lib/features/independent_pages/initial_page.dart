import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  // functions
  void _checkData() async {
    final prefs = await SharedPreferences.getInstance();
    final bool onboardingShown = prefs.getBool('onboarding_screen_shown') ?? false;
    if (!mounted) return;
    if (onboardingShown) {
      context.pushReplacement('/main');
    } else {
      context.pushReplacement('/onboarding');
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkData();
      FlutterNativeSplash.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
