import 'package:feature_base/core/theme/app_dark_theme.dart';
import 'package:feature_base/core/theme/theme_provider.dart';
import 'package:feature_base/features/home/data/repository/hom_respository.dart';
import 'package:feature_base/features/login/provider/login_provider.dart';
import 'package:feature_base/routes/routes.dart';
import 'package:feature_base/routes/routes_names.dart';
import 'package:feature_base/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/local_storage/local_storage.dart';
import 'core/localization/l10n/app_localizations.dart';
import 'core/localization/localization_provider.dart';
import 'core/theme/app_light_theme.dart';
import 'features/home/provider/home_provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  serviceLocator();
  await LocalStorage.instance.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(
          create: (_) =>
              HomeProvider(homeRepository: getIt.get<HomeRepository>()),
        ),
        ChangeNotifierProvider(create: (_) => LocalizationProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return Consumer<LocalizationProvider>(
            builder: (context, localizationProvider, _) {
              return GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
                child: MaterialApp(
                  title: 'Feature Structure',
                  debugShowCheckedModeBanner: false,
                  navigatorKey: navigatorKey,
                  localizationsDelegates:
                      AppLocalizations.localizationsDelegates,
                  supportedLocales: AppLocalizations.supportedLocales,
                  locale: localizationProvider.locale,
                  themeMode: themeProvider.themeMode,
                  theme: AppLightTheme.theme,
                  darkTheme: AppDarkTheme.theme,
                  initialRoute: RoutesName.splashScreen,
                  onGenerateRoute: Routes.generateRoute,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
