import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:samacharpatra/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // preserve native splash screen
  FlutterNativeSplash.preserve(widgetsBinding: WidgetsFlutterBinding.ensureInitialized());

  // load .env file
  await dotenv.load(fileName: '.env');

  // app orientation
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const Samacharpatra());
}
