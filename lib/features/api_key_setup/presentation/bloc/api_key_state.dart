part of 'api_key_bloc.dart';

@immutable
sealed class ApiKeyState {}

// action state
@immutable
sealed class ApiKeyActionState extends ApiKeyState {}

// initial
final class ApiKeyInitial extends ApiKeyState {}

// loaded state
final class ApiKeyLoadedState extends ApiKeyState {
  final String initialApiKey;

  ApiKeyLoadedState(this.initialApiKey);
}

// error state
final class ApiKeyErrorState extends ApiKeyState {}

// set key response state
final class ApiKeySetResActionState extends ApiKeyActionState {
  final bool response;
  final String message;

  ApiKeySetResActionState({required this.response, required this.message});
}

// delete key response state
final class ApiKeyDeleteResActionState extends ApiKeyActionState {
  final bool response;

  ApiKeyDeleteResActionState(this.response);
}
