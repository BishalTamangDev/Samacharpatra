part of 'theme_bloc.dart';

@immutable
sealed class ThemeState {}

// initial state
final class ThemeInitial extends ThemeState {}

final class ThemeLoadedState extends ThemeState {
  final ThemeSourceEnum themeSource;
  final bool darkMode;
  final ThemeMode themeMode;

  ThemeLoadedState({required this.themeSource, required this.darkMode, required this.themeMode});
}

// action state
@immutable
sealed class ThemeActionState extends ThemeState {}
