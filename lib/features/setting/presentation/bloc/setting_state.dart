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

  SettingLoadedState({required this.apiKey});
}

// navigate to api setup page
final class SettingApiSetupNavigateActionState extends SettingActionState {}

// reset saved list
final class SettingResetSavedListResponseState extends SettingActionState {
  final bool success;

  SettingResetSavedListResponseState({required this.success});
}
