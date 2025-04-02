import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:samacharpatra/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) => runApp(const Samacharpatra()));
}
