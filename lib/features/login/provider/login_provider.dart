import 'dart:developer';

import 'package:feature_base/common/widgets/custom_toast.dart';
import 'package:flutter/cupertino.dart';
import '../../../common/widgets/debouncing.dart';
import '../../../core/local_storage/local_storage.dart';
import '../../../main.dart';
import '../../../routes/routes_names.dart';
import '../../../service_locator.dart';
import '../data/repository/login_repository.dart';

class LoginProvider extends ChangeNotifier {
  final loginRepository = getIt.get<LoginRepository>();
  final debouncer = Debouncer(milliseconds: 300);
  // final themeVM = getIt<ThemeViewModel>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool loading = false;

  final formKey = GlobalKey<FormState>();

  Future<void> submitButton() async {
    FocusScope.of(navigatorKey.currentContext!).unfocus();
    loading = true;
    notifyListeners();

    try {
      Map<String, String> data = {
        "email": "eve.holt@reqres.in",
        "password": "cityslicka",
      };

      final userModel = await loginRepository.login(data);
      log('userModel=>>$userModel');

      if ((userModel.token ?? '').isNotEmpty) {
        await LocalStorage.instance.saveUserLogin('true');
        await LocalStorage.instance.saveToken(userModel.token ?? '');
        Navigator.pushNamedAndRemoveUntil(
          navigatorKey.currentContext!,
          RoutesName.homeScreen,
          (route) => false,
        );
      } else {
        CustomToast.showToast(userModel.error ?? '');
      }
    } catch (error) {
      log('Cacth==>$error');
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
