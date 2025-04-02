import 'package:flutter/material.dart';

class AppTheme {
  // light theme
  static final lightTheme = ThemeData(
    canvasColor: Colors.grey[100],
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.red,
      primary: Colors.red,
      onPrimary: Colors.white,
      brightness: Brightness.light,
      surface: Colors.grey.shade100,
      secondary: Colors.grey.shade300,
    ),
    useMaterial3: false,
    textTheme: textTheme,

    // app bar
    appBarTheme: AppBarTheme(elevation: 1, backgroundColor: Colors.red, foregroundColor: Colors.white),
  );

  // dart theme
  static final darkTheme = ThemeData(
    canvasColor: Colors.black,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: Colors.red,
      primary: Colors.red,
      onPrimary: Colors.white,
      surface: Colors.grey.shade900,
      secondary: Colors.grey.shade800,
    ),
    useMaterial3: false,
    textTheme: textTheme,

    // app bar
    appBarTheme: AppBarTheme(backgroundColor: Colors.black),
  );

  // text theme
  static TextTheme textTheme = TextTheme(
    // display
    displayLarge: TextStyle(fontFamily: 'Roboto'),
    displayMedium: TextStyle(fontFamily: 'Roboto'),
    displaySmall: TextStyle(fontFamily: 'Roboto'),

    // headline
    headlineLarge: TextStyle(fontFamily: 'Roboto'),
    headlineMedium: TextStyle(fontFamily: 'Roboto'),
    headlineSmall: TextStyle(fontFamily: 'Roboto'),

    // title
    titleLarge: TextStyle(fontFamily: 'Roboto'),
    titleMedium: TextStyle(fontFamily: 'Roboto'),
    titleSmall: TextStyle(fontFamily: 'Roboto'),

    // body
    bodyLarge: TextStyle(fontFamily: 'Roboto'),
    bodyMedium: TextStyle(fontFamily: 'Roboto'),
    bodySmall: TextStyle(fontFamily: 'Roboto'),

    // label
    labelLarge: TextStyle(fontFamily: 'Roboto'),
    labelSmall: TextStyle(fontFamily: 'Roboto'),
    labelMedium: TextStyle(fontFamily: 'Roboto'),
  );
}
