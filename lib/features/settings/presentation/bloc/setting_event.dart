part of 'setting_bloc.dart';

@immutable
sealed class SettingEvent {}

// refresh
final class SettingFetchEvent extends SettingEvent {}

// api setup
final class SettingApiSetupEvent extends SettingEvent {}

// reset saved list :: proceed
final class SettingResetSavedListProceedEvent extends SettingEvent {}

// delete saved articles
final class SettingDeleteSavedArticlesEvent extends SettingEvent {}
