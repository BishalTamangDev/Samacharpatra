import 'package:flutter/material.dart';
import 'package:samacharpatra/config/routes/app_router.dart';
import 'package:samacharpatra/config/theme/app_theme.dart';

class Samacharpatra extends StatelessWidget {
  const Samacharpatra({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.goRouter,
      title: "Samacharpatra - News App",
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
    );
  }
}
