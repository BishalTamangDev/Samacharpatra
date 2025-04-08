part of 'theme_bloc.dart';

@immutable
sealed class ThemeEvent {}

// fetch theme
final class ThemeFetchEvent extends ThemeEvent {}

// update theme
final class ThemeUpdateEvent extends ThemeEvent {
  final ThemeSourceEnum themeSource;
  final bool darkMode;

  ThemeUpdateEvent({required this.themeSource, required this.darkMode});
}
