part of 'setting_bloc.dart';

@immutable
sealed class SettingEvent {}

// refresh
final class SettingRefreshEvent extends SettingEvent {}

// api setup
final class SettingApiSetupEvent extends SettingEvent {}

// reset saved list :: proceed
final class SettingResetSavedListProceedEvent extends SettingEvent {}
