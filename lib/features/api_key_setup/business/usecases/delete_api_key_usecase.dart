import 'package:samacharpatra/features/api_key_setup/data/repositories/api_key_repository_impl.dart';

class DeleteApiKeyUseCase {
  final ApiKeyRepositoryImpl apiKeyRepository;

  DeleteApiKeyUseCase(this.apiKeyRepository);

  Future<bool> call() async {
    return await apiKeyRepository.deleteApiKey();
  }
}
