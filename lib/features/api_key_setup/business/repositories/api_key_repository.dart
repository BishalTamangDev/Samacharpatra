import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures/failures.dart';

abstract class ApiKeyRepository {
  // fetch api key
  Future<Either<Failure, String>> fetchApiKey();

  // set api key
  Future<bool> setApiKey(String apiKey);

  // delete api key
  Future<bool> deleteApiKey();
}
