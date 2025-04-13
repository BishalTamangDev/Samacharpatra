import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:samacharpatra/features/onboarding/widgets/onboarding_option_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/scroll_behaviour/custom_scroll_behaviour.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  // variables
  int _currentIndex = 0;
  late PageController _pageController;

  final List<Map<String, dynamic>> _features = [
    {
      'title': 'Explore Articles',
      'description':
          'Browse through a collection of informative and engaging articles. Stay updated with the latest content at your fingertips.',
      'image': 'assets/icons/newspaper.png',
      'type': 'png',
    },
    {
      'title': 'Search Articles',
      'description':
          'Quickly find the articles you need with our powerful search feature. Just type in a keyword and discover relevant content instantly.',
      'image': 'assets/icons/search.png',
      'type': 'png',
    },
    {
      'title': 'Save for Later',
      'description':
          'Bookmark your favorite articles and access them anytime, even offline. Never lose track of valuable content.',
      'image': 'assets/icons/save.png',
      'type': 'png',
    },
    {
      'title': 'Personalized Themes',
      'description':
          'Customize your reading experience with device-based or custom themes. Enjoy reading in your preferred style.',
      'image': 'assets/icons/theme.png',
      'type': 'png',
    },
    {
      'title': 'GET STARTED NOW',
      'description': "You're one step behind exploring new things.",
      'image': 'assets/icons/get_started.png',
      'type': 'png',
    },
  ];

  // functions
  // next page
  Future<void> _nextPage() async {
    _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.linear);
    if (_currentIndex == _features.length - 1) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('onboarding_screen_shown', true);
      if (!mounted) return;
      context.pushReplacement('/main');
    } else {
      if (!mounted) return;
      setState(() {
        _currentIndex++;
      });
    }
  }

  // set page
  void _setPage(newIndex) {
    if (!mounted) return;
    setState(() {
      _currentIndex = newIndex;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ScrollConfiguration(
              behavior: CustomScrollBehaviour(),
              child: PageView(
                physics: const AlwaysScrollableScrollPhysics(),
                controller: _pageController,
                onPageChanged: (newIndex) => _setPage(newIndex),
                children:
                    _features
                        .map(
                          (feature) => OnboardingOptionWidget(
                            title: feature['title'],
                            description: feature['description'],
                            type: feature['type'],
                            image: feature['image'],
                          ),
                        )
                        .toList(),
              ),
            ),
            // actions
            Positioned(
              bottom: 0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SmoothPageIndicator(
                            controller: _pageController,
                            count: _features.length,
                            effect: ScaleEffect(
                              activeDotColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.6),
                              dotHeight: 5.0,
                              dotWidth: 5.0,
                              scale: 4,
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: _nextPage,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: CircleAvatar(
                          radius: 24.0,
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          child: Icon(Icons.arrow_right_alt, color: Theme.of(context).colorScheme.onPrimary),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
