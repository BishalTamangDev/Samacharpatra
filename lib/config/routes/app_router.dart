import 'package:go_router/go_router.dart';
import 'package:samacharpatra/features/independent_pages/main_page.dart';
import 'package:samacharpatra/features/independent_pages/page_not_found.dart';

class AppRouter {
  static final GoRouter goRouter = GoRouter(
    initialLocation: '/',
    routes: [GoRoute(path: '/', builder: (context, state) => MainPage())],
    errorBuilder: (context, state) => PageNotFound(),
  );
}
