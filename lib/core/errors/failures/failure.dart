abstract class Failure {}

// server failure :: server-side failure
class ServerFailure extends Failure {
  final String message;

  ServerFailure({required this.message});
}

// network failure :: client side failure
class NetworkFailure extends Failure {
  final String message;

  NetworkFailure({required this.message});
}

// client side
class ClientFailure extends Failure {
  final String message;

  ClientFailure({required this.message});
}

// api failure
class ApiFailure extends Failure {
  final String message;

  ApiFailure({required this.message});
}

// unexpected failure
class UnexpectedFailure extends Failure {
  final String message;

  UnexpectedFailure({required this.message});
}
