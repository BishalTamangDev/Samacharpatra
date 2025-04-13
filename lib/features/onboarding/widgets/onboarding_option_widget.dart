import 'package:flutter/material.dart';

class OnboardingOptionWidget extends StatelessWidget {
  const OnboardingOptionWidget({
    super.key,
    required this.title,
    required this.description,
    required this.type,
    required this.image,
  });

  final String title;
  final String description;
  final String type;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // image
          if (['png', 'jpg'].contains(type)) Image.asset(image, width: MediaQuery.of(context).size.width / 3),

          const SizedBox(height: 32.0),

          // title
          Text(title, style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold)),

          const SizedBox(height: 8.0),

          // description
          Opacity(
            opacity: 0.5,
            child: Text(
              description,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(height: 1.4),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
