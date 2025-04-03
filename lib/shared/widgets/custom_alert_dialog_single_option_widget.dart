import 'package:flutter/material.dart';

class CustomAlertDialogSingleOptionWidget extends StatelessWidget {
  const CustomAlertDialogSingleOptionWidget({
    super.key,
    required this.title,
    required this.description,
    required this.option,
    required this.callBack,
  });

  final String title;
  final String description;
  final String option;
  final VoidCallback callBack;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600)),
      content: Opacity(opacity: 0.6, child: Text(description)),
      actionsPadding: const EdgeInsets.only(right: 16.0, bottom: 16.0),
      actions: [OutlinedButton(onPressed: callBack, child: Text(option))],
    );
  }
}
