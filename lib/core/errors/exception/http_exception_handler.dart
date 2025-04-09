import 'package:samacharpatra/core/errors/failures/failures.dart';

Failure handleHttpException(int statusCode) {
  if (statusCode == 400) {
    return ClientFailure();
  } else if (statusCode == 401 || statusCode == 403) {
    return UnauthorizedApiKeyFailure();
  } else if (statusCode >= 500) {
    return ServerFailure();
  } else {
    return UnknownFailure();
  }
}
