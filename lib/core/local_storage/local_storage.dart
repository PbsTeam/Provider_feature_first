import 'package:flutter/material.dart';
import '../../../service_locator.dart';
import '../../common/widgets/app_storage.dart';
import '../../routes/routes_names.dart';
import 'app_storage_keys.dart';

class LocalStorage {
  // Private constructor
  LocalStorage._privateConstructor();

  // The single instance
  static final LocalStorage _instance = LocalStorage._privateConstructor();

  // Public getter
  static LocalStorage get instance => _instance;

  static final storage = getIt.get<AppStorage>();

  bool isLogin = false;
  String userToken = '';
  String language = 'en';
  bool isDark = false;

  Future<void> init() async {
    isLogin = await storage.get(AppStorageKeys.isLogin) == 'true'
        ? true
        : false;

    userToken = await storage.get(AppStorageKeys.token) ?? '';
    language = await storage.get(AppStorageKeys.language) ?? 'en';
    isDark = await storage.get(AppStorageKeys.theme) == 'true' ? true : false;
  }

  Future<void> saveToken(String token) async {
    userToken = token;
    await storage.save(AppStorageKeys.token, token);
  }

  Future<void> saveUserLogin(String login) async {
    isLogin = login == 'true' ? true : false;

    await storage.save(AppStorageKeys.isLogin, login);
  }

  Future<void> saveAppLanguage(String languageValue) async {
    language = languageValue;

    await storage.save(AppStorageKeys.language, languageValue);
  }

  Future<void> saveAppTheme(String isDarkTheme) async {
    isDark = isDarkTheme == 'true' ? true : false;

    await storage.save(AppStorageKeys.theme, isDarkTheme);
  }

  Future<void> clearAll(BuildContext context) async {
    await storage.clearStorage();
    await init();

    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutesName.loginScreen,
        (route) => false,
      );
    }
  }
}
