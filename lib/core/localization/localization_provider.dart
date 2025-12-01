import 'package:flutter/material.dart';
import '../local_storage/local_storage.dart';

class LocalizationProvider extends ChangeNotifier {
  LocalizationProvider() {
    final language = LocalStorage.instance.language.isNotEmpty
        ? Locale(LocalStorage.instance.language)
        : Locale('en');
    setLocale(language);
  }

  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  Future<void> setLocale(Locale locale) async {
    _locale = locale;
    await LocalStorage.instance.saveAppLanguage(locale.languageCode);

    notifyListeners();
  }
}
