abstract class LangRepository {
  Future<bool> changeLang({required String langCode});

  Future<String> getSavedLang();
}
