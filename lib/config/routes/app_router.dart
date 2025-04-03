import 'package:go_router/go_router.dart';
import 'package:samacharpatra/features/article/presentation/pages/article_page.dart';
import 'package:samacharpatra/features/independent_pages/main_page.dart';
import 'package:samacharpatra/features/independent_pages/page_not_found_page.dart';
import 'package:samacharpatra/features/onboarding/pages/onboarding_page.dart';
import 'package:samacharpatra/features/setting/presentation/pages/api_key_setup_page.dart';

class AppRouter {
  static final GoRouter goRouter = GoRouter(
    initialLocation: '/main',
    routes: [
      GoRoute(path: '/main', builder: (context, state) => MainPage()),
      GoRoute(path: '/initial', builder: (context, state) => PageNotFoundPage()),
      GoRoute(path: '/onboarding', builder: (context, state) => OnboardingPage()),
      GoRoute(path: '/article/:id', builder: (context, state) => ArticlePage()),
      GoRoute(
        path: '/setting',
        builder: (context, state) => PageNotFoundPage(),
        routes: [GoRoute(path: '/api-key-setup', builder: (context, state) => ApiKeySetupPage())],
      ),
    ],
    errorBuilder: (context, state) => PageNotFoundPage(),
  );
}
