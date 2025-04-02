import 'package:flutter/material.dart';

class CustomAlertDialogWidget extends StatelessWidget {
  const CustomAlertDialogWidget({
    super.key,
    required this.title,
    required this.description,
    required this.option1,
    required this.option2,
    required this.option1CallBack,
    required this.option2CallBack,
  });

  final String title;
  final String description;
  final String option1;
  final String option2;
  final VoidCallback option1CallBack;
  final VoidCallback option2CallBack;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600)),
      content: Opacity(opacity: 0.6, child: Text(description)),
      actionsPadding: const EdgeInsets.only(right: 16.0, bottom: 16.0),
      actions: [
        OutlinedButton(onPressed: option1CallBack, child: Text(option1)),
        OutlinedButton(onPressed: option2CallBack, child: Text(option2)),
      ],
    );
  }
}
