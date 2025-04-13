import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:samacharpatra/core/business/entities/article_entity.dart';
import 'package:samacharpatra/features/article/presentation/pages/article_page.dart';
import 'package:samacharpatra/features/independent_pages/initial_page.dart';
import 'package:samacharpatra/features/independent_pages/main_page.dart';
import 'package:samacharpatra/features/independent_pages/page_not_found_page.dart';
import 'package:samacharpatra/features/onboarding/pages/onboarding_page.dart';

import '../../features/api_key_setup/presentation/pages/api_key_setup_page.dart';

class AppRouter {
  static final GoRouter goRouter = GoRouter(
    initialLocation: '/initial',
    routes: [
      GoRoute(
        path: '/initial',
        pageBuilder: (context, index) {
          return CustomTransitionPage(child: InitialPage(), transitionsBuilder: immediateTransitionBuilder);
        },
      ),
      GoRoute(
        path: '/main',
        pageBuilder: (context, index) {
          return CustomTransitionPage(child: MainPage(), transitionsBuilder: immediateTransitionBuilder);
        },
      ),
      GoRoute(
        path: '/onboarding',
        pageBuilder: (context, index) {
          return CustomTransitionPage(child: OnboardingPage(), transitionsBuilder: immediateTransitionBuilder);
        },
      ),
      GoRoute(
        path: '/article',
        pageBuilder: (context, state) {
          final article = state.extra as ArticleEntity;
          return CustomTransitionPage(
            child: ArticlePage(article: article),
            transitionsBuilder: immediateTransitionBuilder,
          );
        },
      ),
      GoRoute(
        path: '/setting',
        pageBuilder: (context, state) {
          return CustomTransitionPage(child: PageNotFoundPage(), transitionsBuilder: immediateTransitionBuilder);
        },
        routes: [
          GoRoute(
            path: '/api-key-setup',
            pageBuilder: (context, state) {
              return CustomTransitionPage(child: ApiKeySetupPage(), transitionsBuilder: immediateTransitionBuilder);
            },
          ),
        ],
      ),
    ],
    errorPageBuilder: (context, state) {
      return CustomTransitionPage(child: PageNotFoundPage(), transitionsBuilder: immediateTransitionBuilder);
    },
  );
}

Widget immediateTransitionBuilder(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return SlideTransition(position: Tween(begin: Offset.zero, end: Offset.zero).animate(animation), child: child);
}

Widget slideLeftTransitionBuilder(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return SlideTransition(position: Tween(begin: Offset(1, 0), end: Offset.zero).animate(animation), child: child);
}

Widget slideUpTransitionBuilder(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return SlideTransition(position: Tween(begin: Offset(0, 1), end: Offset.zero).animate(animation), child: child);
}
