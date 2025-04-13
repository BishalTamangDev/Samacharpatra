part of 'setting_bloc.dart';

@immutable
sealed class SettingState {}

// initial state
final class SettingInitial extends SettingState {}

// action state
@immutable
sealed class SettingActionState extends SettingState {}

// loaded state
final class SettingLoadedState extends SettingState {
  final String apiKey;

  SettingLoadedState(this.apiKey);
}

// navigate to api setup page
final class SettingApiSetupNavActionState extends SettingActionState {}

// response for delete saved articles
final class SettingDeleteSavedArticlesRespActionState extends SettingActionState {
  final bool success;

  SettingDeleteSavedArticlesRespActionState(this.success);
}
