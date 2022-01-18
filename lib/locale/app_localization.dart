// a class which loads the translations from json files.
import 'dart:convert';

import 'package:flutter/material.dart';
// core dart lib
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale? locale;
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationDelegate();

  AppLocalizations(this.locale);
  // helper method to keep the code in the widget concise.
  // localization are accessed using n inheritedWidget "of" syntax
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  Map<String, String>? _localizedString;

  Future<bool> load() async {
    String jsonString =
        await rootBundle.loadString('lang/${locale?.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedString = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  String? translate(String key) {
    var localeList = _localizedString;
    if (localeList != null) {
      return localeList[key];
    }
  }
}

//localizationDelegate is a factory for a set of localized resources.
// in this case , the localized string will be gotten in an application object.
class _AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
//this delegate instance will never change (it does not even have fields )
// it can provide  constant constructor.
  const _AppLocalizationDelegate();
  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = new AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

// always returning false.
  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;
}
