import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:samacharpatra/core/data/source/api/api_service.dart';
import 'package:samacharpatra/features/api_key_setup/business/usecases/delete_api_key_usecase.dart';
import 'package:samacharpatra/features/api_key_setup/business/usecases/fetch_api_key_usecase.dart';
import 'package:samacharpatra/features/api_key_setup/business/usecases/set_api_key_usecase.dart';
import 'package:samacharpatra/features/api_key_setup/data/repositories/api_key_repository_impl.dart';

import '../../../../core/errors/failures/failures.dart';

part 'api_key_event.dart';
part 'api_key_state.dart';

class ApiKeyBloc extends Bloc<ApiKeyEvent, ApiKeyState> {
  ApiKeyBloc() : super(ApiKeyInitial()) {
    on<ApiKeyFetchEvent>(_apiKeyFetchEvent);
    on<ApiKeySetEvent>(_apiKeySetEvent);
    on<ApiKeyDeleteEvent>(_apiKeyDeleteEvent);
  }

  // fetch data
  Future<void> _apiKeyFetchEvent(ApiKeyFetchEvent event, Emitter<ApiKeyState> emit) async {
    final ApiKeyRepositoryImpl apiKeyRepository = ApiKeyRepositoryImpl();
    final FetchApiKeyUseCase fetchApiKeyUseCase = FetchApiKeyUseCase(apiKeyRepository);

    final Either<Failure, String> response = await fetchApiKeyUseCase.call();

    response.fold(
      (failure) {
        emit(ApiKeyErrorState());
      },
      (apiKey) {
        emit(ApiKeyLoadedState(apiKey));
      },
    );
  }

  // set event
  Future<void> _apiKeySetEvent(ApiKeySetEvent event, Emitter<ApiKeyState> emit) async {
    final Either<Failure, bool> response = await ApiService().keyValidityCheck(event.apiKey);

    if (response.isLeft()) {
      emit(ApiKeySetResActionState(response: false, message: "Something went wrong. Please try again later."));
      return;
    }

    final bool isValid = response.getOrElse(() => false);

    if (isValid) {
      final ApiKeyRepositoryImpl apiKeyRepository = ApiKeyRepositoryImpl();
      final SetApiKeyUseCase setApiKeyUseCase = SetApiKeyUseCase(apiKeyRepository);

      final bool success = await setApiKeyUseCase.call(event.apiKey);

      emit(
        ApiKeySetResActionState(
          response: success,
          message: success ? "API key set successfully." : "Couldn't add your API key.",
        ),
      );
    } else {
      emit(ApiKeySetResActionState(response: false, message: "Invalid API key."));
    }
  }

  // delete api key
  Future<void> _apiKeyDeleteEvent(ApiKeyDeleteEvent event, Emitter<ApiKeyState> emit) async {
    final ApiKeyRepositoryImpl apiKeyRepository = ApiKeyRepositoryImpl();
    final DeleteApiKeyUseCase deleteApiKeyUseCase = DeleteApiKeyUseCase(apiKeyRepository);

    final bool response = await deleteApiKeyUseCase.call();

    emit(ApiKeyDeleteResActionState(response));
  }
}
