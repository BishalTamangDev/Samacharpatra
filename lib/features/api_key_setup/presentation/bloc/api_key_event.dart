part of 'api_key_bloc.dart';

@immutable
sealed class ApiKeyEvent {}

// fetch initial
final class ApiKeyFetchEvent extends ApiKeyEvent {}

// set api key
final class ApiKeySetEvent extends ApiKeyEvent {
  final String apiKey;

  ApiKeySetEvent(this.apiKey);
}

// delete api key
final class ApiKeyDeleteEvent extends ApiKeyEvent {
  ApiKeyDeleteEvent();
}
