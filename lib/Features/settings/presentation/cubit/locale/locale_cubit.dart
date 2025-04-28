import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_task/Features/settings/data/data_sources/lang_local_data_sources.dart';

import '../../../../../Core/utils/app_strings.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  final LangLocalDataSource langLocalDataSource;

  LocaleCubit({
    required this.langLocalDataSource,
  }) : super(const LocaleStateLoading());

  String currentLangCode = AppStrings.arabicCode;
  Locale locale = const Locale(AppStrings.arabicCode);

  Future<void> getSavedLang() async {
    emit(const LocaleStateLoading());
    String? storedLocale = await langLocalDataSource.getSavedLang();
    if (storedLocale == null) {
      currentLangCode = AppStrings.arabicCode;
      langLocalDataSource.changeLang(langCode: currentLangCode);
      locale = const Locale(AppStrings.arabicCode);
      emit(const ChangeLocaleState(locale: Locale(AppStrings.arabicCode)));
      return;
    }
    currentLangCode = storedLocale;
    locale = Locale(storedLocale);
    emit(ChangeLocaleState(locale: Locale(currentLangCode)));
  }

  Future<void> changeLang(String langCode) async {
    emit(const LocaleStateLoading());
    locale = Locale(langCode);
    await langLocalDataSource.changeLang(langCode: langCode);
    currentLangCode = langCode;
    emit(ChangeLocaleState(locale: Locale(langCode)));
  }

  void toEnglish() {
    changeLang(AppStrings.englishCode);
  }

  void toArabic() {
    changeLang(AppStrings.arabicCode);
  }
}
