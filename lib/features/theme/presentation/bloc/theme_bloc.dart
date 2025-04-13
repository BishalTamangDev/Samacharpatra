import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:samacharpatra/core/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial()) {
    on<ThemeEvent>((event, emit) {});
    on<ThemeFetchEvent>(_themeFetchEvent);
    on<ThemeUpdateEvent>(_themeUpdateEvent);
  }

  // fetch theme data
  Future<void> _themeFetchEvent(ThemeFetchEvent event, Emitter<ThemeState> emit) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String themeSourceStr = prefs.getString('theme_source') ?? ThemeSourceEnum.system.label;
      final bool darkMode = prefs.getBool('dark_mode') ?? false;

      final ThemeSourceEnum themeSource = ThemeSourceEnum.fromLabel(themeSourceStr);

      final ThemeMode themeMode =
          (themeSource == ThemeSourceEnum.system)
              ? ThemeMode.system
              : darkMode
              ? ThemeMode.dark
              : ThemeMode.light;

      emit(ThemeLoadedState(themeSource: themeSource, darkMode: darkMode, themeMode: themeMode));
    } catch (e, stackTrace) {
      debugPrint("Error fetching theme data :: $e\n$stackTrace");
    }
  }

  // update theme data
  Future<void> _themeUpdateEvent(ThemeUpdateEvent event, Emitter<ThemeState> emit) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      // set theme source
      await prefs.setString('theme_source', event.themeSource.label);

      // set dark mode
      await prefs.setBool('dark_mode', event.darkMode);

      ThemeMode? themeMode =
          (event.themeSource == ThemeSourceEnum.system)
              ? ThemeMode.system
              : event.darkMode
              ? ThemeMode.dark
              : ThemeMode.light;

      emit(ThemeLoadedState(themeSource: event.themeSource, darkMode: event.darkMode, themeMode: themeMode));
    } catch (e, stackTrace) {
      debugPrint("Error updating theme :: $e\n$stackTrace");
    }
  }
}
