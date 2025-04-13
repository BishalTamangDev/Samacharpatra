import 'package:samacharpatra/features/settings/data/repositories/setting_repository_impl.dart';

class DeleteSavedArticlesUseCase {
  final SettingRepositoryImpl settingRepository;

  DeleteSavedArticlesUseCase(this.settingRepository);

  Future<bool> call() async {
    return await settingRepository.deleteSavedArticles();
  }
}
