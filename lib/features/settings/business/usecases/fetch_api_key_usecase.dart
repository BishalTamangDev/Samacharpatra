import 'package:samacharpatra/features/settings/data/repositories/setting_repository_impl.dart';

class FetchApiKeyUseCase {
  final SettingRepositoryImpl settingRepository;

  FetchApiKeyUseCase(this.settingRepository);

  Future<String> call() async {
    return await settingRepository.fetchApiKey();
  }
}
