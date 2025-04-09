// general types
// network failure
// server/ api failure
// data failure
// auth failure
// local storage failure
// logic/ validation failure
// unknown failure

// abstract class
abstract class Failure {}

// network failure :: internet & timeout
final class NetworkFailure extends Failure {
  final String message;

  NetworkFailure(this.message);
}

// server/ api failure :: client || server [4xx, 5xx]
final class ServerFailure extends Failure {}

final class ClientFailure extends ServerFailure {}

// data failure :: json parsing, type mismatch, invalid or empty data
final class DataFailure extends Failure {}

// auth failure :: invalid credential, token expired, unauthorized access
final class AuthFailure extends Failure {}

final class ApiKeyNotSetFailure extends AuthFailure {}

final class UnauthorizedApiKeyFailure extends AuthFailure {}

// local storage failure
final class LocalStorageFailure extends Failure {}

// logic || validation failure :: invalid input, required filed missing & operation not allowed
final class LogicFailure extends Failure {}

// unknown failure
final class UnknownFailure extends Failure {}
