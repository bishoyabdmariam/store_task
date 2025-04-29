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

  Future<void> getSavedLang() async {
    emit(const LocaleStateLoading());
    String? storedLocale = await langLocalDataSource.getSavedLang();
    if (storedLocale == null) {
      langLocalDataSource.changeLang(langCode: AppStrings.arabicCode);
      emit(const ChangeLocaleState(locale: Locale(AppStrings.arabicCode)));
      return;
    }
    emit(ChangeLocaleState(locale: Locale(storedLocale)));
  }

  Future<void> changeLang(String langCode) async {
    emit(const LocaleStateLoading());
    await langLocalDataSource.changeLang(langCode: langCode);
    emit(ChangeLocaleState(locale: Locale(langCode)));
  }

  toEnglish() async {
    await changeLang(AppStrings.englishCode);
  }

  toArabic() async {
    await changeLang(AppStrings.arabicCode);
  }
}
