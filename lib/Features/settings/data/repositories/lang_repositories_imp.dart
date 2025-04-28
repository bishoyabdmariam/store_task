import 'package:store_task/Core/utils/app_strings.dart';

import '../../domain/repositories/lang_repositories.dart';
import '../data_sources/lang_local_data_sources.dart';

class LangRepositoriesImp extends LangRepository {
  final LangLocalDataSource langLocalDataSource;

  LangRepositoriesImp({required this.langLocalDataSource});

  @override
  Future<bool> changeLang({required String langCode}) async {
    try {
      return await langLocalDataSource.changeLang(langCode: langCode);
    } on Exception {
      return false;
    }
  }

  @override
  Future<String> getSavedLang() async {
    try {
      return await langLocalDataSource.getSavedLang() ?? AppStrings.englishCode;
    } on Exception {
      return AppStrings.englishCode;
    }
  }
}
