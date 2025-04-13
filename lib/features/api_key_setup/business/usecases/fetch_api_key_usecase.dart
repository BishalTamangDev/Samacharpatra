import 'package:dartz/dartz.dart';
import 'package:samacharpatra/core/errors/failures/failures.dart';
import 'package:samacharpatra/features/api_key_setup/data/repositories/api_key_repository_impl.dart';

class FetchApiKeyUseCase {
  final ApiKeyRepositoryImpl apiKeyRepository;

  FetchApiKeyUseCase(this.apiKeyRepository);

  Future<Either<Failure, String>> call() async {
    return await apiKeyRepository.fetchApiKey();
  }
}
