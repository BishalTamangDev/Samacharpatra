import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(SettingInitial()) {
    on<SettingEvent>((event, emit) {});
    on<SettingRefreshEvent>(_settingRefreshEvent);
    on<SettingApiSetupEvent>(_settingApiSetupEvent);
    on<SettingResetSavedListProceedEvent>(_settingResetSavedListEvent);
  }

  // refresh event
  Future<void> _settingRefreshEvent(SettingRefreshEvent event, Emitter<SettingState> emit) async {
    emit(SettingInitial());

    await Future.delayed(const Duration(seconds: 3));

    // fetch data
    // todo :: fetch setting values
    final String apiKey = "12345qwerty";

    emit(SettingLoadedState(apiKey: apiKey));
  }

  // api setup
  Future<void> _settingApiSetupEvent(SettingApiSetupEvent event, Emitter<SettingState> emit) async {
    emit(SettingApiSetupNavigateActionState());
  }

  // reset saved list proceed
  Future<void> _settingResetSavedListEvent(SettingResetSavedListProceedEvent event, Emitter<SettingState> emit) async {
    // todo :: reset saved list
    final bool success = true;
    emit(SettingResetSavedListResponseState(success: success));
  }
}
