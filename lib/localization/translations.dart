import 'dart:async';

import 'package:flutter/material.dart';
import 'package:payoda/localization/en.dart';
import 'package:payoda/localization/hi.dart';
import 'package:payoda/router/app_router.dart';

class AppTranslations {
  static final AppTranslations _singleton = AppTranslations._internal();

  factory AppTranslations() {
    return _singleton;
  }

  AppTranslations._internal() {
    _localizedStrings = {};
    _locale = const Locale('en', 'US');
  }

  static AppTranslations of(BuildContext context) {
    return Localizations.of<AppTranslations>(context, AppTranslations)!;
  }

  late Locale _locale;
  late Map<String, String> _localizedStrings;

  static const List<Locale> supportedLocales = [Locale('en', 'US'), Locale('hi', 'IN')];

  Locale get locale => _locale;

  static const LocalizationsDelegate<AppTranslations> delegate = _AppTranslationsDelegate();

  Future<void> load(Locale locale) async {
    final String langCode = locale.languageCode;
    switch (langCode) {
      case 'hi':
        _locale = const Locale('hi', 'IN');
        _localizedStrings = hi();
        break;
      default:
        _locale = const Locale('en', 'US');
        _localizedStrings = en();
    }
  }

  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }
}

extension TranslatableText on String {
  String tr() {
    return AppTranslations.of(AppRouter.navigatorKey.currentState!.context).translate(this);
  }
}

class _AppTranslationsDelegate extends LocalizationsDelegate<AppTranslations> {
  const _AppTranslationsDelegate();

  @override
  bool isSupported(Locale locale) => AppTranslations.supportedLocales.contains(locale);

  @override
  Future<AppTranslations> load(Locale locale) async {
    final appTranslations = AppTranslations();
    await appTranslations.load(locale);
    return appTranslations;
  }

  @override
  bool shouldReload(_AppTranslationsDelegate old) => false;
}
