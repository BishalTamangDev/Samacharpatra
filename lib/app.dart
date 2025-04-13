import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samacharpatra/config/routes/app_router.dart';
import 'package:samacharpatra/config/theme/app_theme.dart';
import 'package:samacharpatra/features/api_key_setup/presentation/bloc/api_key_bloc.dart';
import 'package:samacharpatra/features/article/presentation/bloc/article_bloc.dart';
import 'package:samacharpatra/features/home/presentation/bloc/home_bloc.dart';
import 'package:samacharpatra/features/saved/presentation/bloc/saved_bloc.dart';
import 'package:samacharpatra/features/search/presentation/bloc/search_bloc.dart';
import 'package:samacharpatra/features/theme/presentation/bloc/theme_bloc.dart';

import 'features/settings/presentation/bloc/setting_bloc.dart';

class Samacharpatra extends StatefulWidget {
  const Samacharpatra({super.key});

  @override
  State<Samacharpatra> createState() => _SamacharpatraState();
}

class _SamacharpatraState extends State<Samacharpatra> {
  // Theme state
  ThemeMode? _themeMode;

  // Update theme function
  void _updateTheme(ThemeMode newThemeMode) {
    setState(() {
      _themeMode = newThemeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Setting Bloc
        BlocProvider(create: (context) => SettingBloc()..add(SettingFetchEvent())),

        // api key bloc
        BlocProvider(create: (context) => ApiKeyBloc()),

        // Theme Bloc
        BlocProvider(create: (context) => ThemeBloc()..add(ThemeFetchEvent())),

        // home
        BlocProvider(create: (context) => HomeBloc()..add(HomeFetchEvent())),

        // saved
        BlocProvider(create: (context) => SavedBloc()..add(SavedFetchEvent())),

        // search
        BlocProvider(create: (context) => SearchBloc()),

        // article
        BlocProvider(create: (context) => ArticleBloc()),
      ],
      child: BlocListener<ThemeBloc, ThemeState>(
        listener: (context, state) {
          if (state is ThemeLoadedState) {
            _updateTheme(state.themeMode);
          }
        },
        child:
            _themeMode == null
                ? const Center(child: CircularProgressIndicator())
                : Builder(
                  builder: (context) {
                    return MaterialApp.router(
                      routerConfig: AppRouter.goRouter,
                      title: "Samacharpatra - News App",
                      debugShowCheckedModeBanner: false,
                      themeMode: _themeMode,
                      theme: AppTheme.lightTheme,
                      darkTheme: AppTheme.darkTheme,
                    );
                  },
                ),
      ),
    );
  }
}
