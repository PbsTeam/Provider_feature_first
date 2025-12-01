import 'package:flutter/material.dart';
import '../features/home/ui/home_ui.dart';
import '../features/login/ui/login_ui.dart';
import '../features/splash/ui/splash_ui.dart';
import 'routes_names.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splashScreen:
        return MaterialPageRoute(builder: (_) => SplashUI());

      case RoutesName.loginScreen:
        return MaterialPageRoute(builder: (_) => LoginUI());

      case RoutesName.homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());

      default:
        return MaterialPageRoute(builder: (_) => SplashUI());
    }
  }
}
