import 'package:flutter/material.dart';
import 'package:store_task/Config/locale/app_localizations.dart';

extension TranslateExtension on String {
  String translate(BuildContext context) {
    // Use AppLocalizations to get the translation, fallback to the original string if null
    return AppLocalizations.of(context)?.translate(this) ?? this;
  }
}
