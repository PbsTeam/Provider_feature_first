import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../core/local_storage/local_storage.dart';
import '../../../../routes/routes_names.dart';

class SplashRepo {
  isLogin(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      LocalStorage.instance.isLogin
          ? Navigator.pushNamedAndRemoveUntil(
              context,
              RoutesName.homeScreen,
              (route) => false,
            )
          : Navigator.pushNamedAndRemoveUntil(
              context,
              RoutesName.loginScreen,
              (route) => false,
            );
    });
  }
}
