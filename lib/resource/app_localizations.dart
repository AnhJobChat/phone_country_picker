import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum Localize {
  en,
  vi,
}

extension ValueLocalize on Localize {
  String title() {
    switch (this) {
      case Localize.en:
        return 'English';
      case Localize.vi:
        return 'Vietnamese';
      default:
        return this.toString();
    }
  }

  String get languageCode {
    switch (this) {
      case Localize.vi:
        return 'vi';
      case Localize.en:
        return 'en';
      default:
        return this.toString();
    }
  }
}

extension ConvertLocalize on Localize {
  static Localize localize(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return Localize.en;
      case 'vi':
        return Localize.vi;
      default:
        return Localize.en;
    }
  }

  Locale toLocale() {
    switch (this) {
      case Localize.en:
        return Locale('en');
      case Localize.vi:
        return Locale('vi');
      default:
        return Locale('en');
    }
  }
}

class AppLocalizations {
  Locale _locale;

  Locale get locale => _locale;

  Map<String, String> _localizedStrings = {};

  static AppLocalizations _shared;

  static AppLocalizations get shared => _shared;

  AppLocalizations() {
    AppLocalizations._shared ??= this;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  Future<bool> load(Locale locale) async {
    String jsonString = await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map((key, value) => MapEntry(key, value.toString()));
    _locale = locale;
    return true;
  }

  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return Localize.values.map((localize) => localize.languageCode).contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations._shared = null;
    AppLocalizations localizations = AppLocalizations();
    await localizations.load(locale);
    return localizations;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;
}

/// Localize
extension Translate on AppLocalizations {
  String get yourPhoneNumber => this.translate('Your phone number');
}
