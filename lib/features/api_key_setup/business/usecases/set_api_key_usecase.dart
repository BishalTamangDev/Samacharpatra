import 'package:samacharpatra/features/api_key_setup/data/repositories/api_key_repository_impl.dart';

class SetApiKeyUseCase {
  final ApiKeyRepositoryImpl apiKeyRepository;

  SetApiKeyUseCase(this.apiKeyRepository);

  Future<bool> call(String apiKey) async {
    return await apiKeyRepository.setApiKey(apiKey);
  }
}
