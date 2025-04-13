import 'package:flutter/material.dart';

void showCustomSnackbar({required BuildContext context, required String message}) {
  final scaffoldMessengerContext = ScaffoldMessenger.of(context);

  if (scaffoldMessengerContext.mounted) scaffoldMessengerContext.hideCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(behavior: SnackBarBehavior.floating, content: Text(message)));
}
