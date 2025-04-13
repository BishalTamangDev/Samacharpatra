import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samacharpatra/features/settings/business/usecases/delete_saved_articles_usecase.dart';
import 'package:samacharpatra/features/settings/business/usecases/fetch_api_key_usecase.dart';
import 'package:samacharpatra/features/settings/data/repositories/setting_repository_impl.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(SettingInitial()) {
    // on<SettingEvent>((event, emit) {});
    on<SettingFetchEvent>(_settingFetchEvent);
    on<SettingApiSetupEvent>(_settingApiSetupEvent);
    on<SettingDeleteSavedArticlesEvent>(_settingDeleteSavedArticlesEvent);
  }

  // refresh event
  Future<void> _settingFetchEvent(SettingFetchEvent event, Emitter<SettingState> emit) async {
    emit(SettingInitial());

    final SettingRepositoryImpl settingRepository = SettingRepositoryImpl();
    final FetchApiKeyUseCase fetchApiKeyUseCase = FetchApiKeyUseCase(settingRepository);

    final apiKey = await fetchApiKeyUseCase.call();

    emit(SettingLoadedState(apiKey));
  }

  // api setup
  Future<void> _settingApiSetupEvent(SettingApiSetupEvent event, Emitter<SettingState> emit) async {
    emit(SettingApiSetupNavActionState());
  }

  // delete saved articles
  Future<void> _settingDeleteSavedArticlesEvent(SettingDeleteSavedArticlesEvent event, Emitter<SettingState> emit) async {
    final SettingRepositoryImpl settingRepository = SettingRepositoryImpl();
    final DeleteSavedArticlesUseCase deleteSavedArticlesUseCase = DeleteSavedArticlesUseCase(settingRepository);
    final bool response = await deleteSavedArticlesUseCase.call();

    emit(SettingDeleteSavedArticlesRespActionState(response));
  }
}
