import 'package:feature_base/core/constants/color_constants.dart';
import 'package:feature_base/main.dart';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

class CustomToast {
  CustomToast._();
  static CustomToast? _instance;
  static CustomToast get instance => _instance ??= CustomToast._();

  static showToast(String message, {Color? bgColor, Color? textColor}) {
    return Flushbar(
      safeArea: false,
      flushbarPosition: FlushbarPosition.TOP,
      padding: EdgeInsets.only(top: 50, bottom: 15, left: 20, right: 20),
      duration: Duration(seconds: 3),
      message: message,
      backgroundColor: bgColor ?? ColorConstants.black,
      messageColor: ColorConstants.white,
      flushbarStyle: FlushbarStyle.GROUNDED,
    )..show(navigatorKey.currentContext!);
  }
}
