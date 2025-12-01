import 'dart:developer';

import 'package:feature_base/common/exceptions/theme_exception.dart';
import 'package:feature_base/core/constants/color_constants.dart';
import 'package:feature_base/core/theme/theme_provider.dart';
import 'package:feature_base/features/login/provider/login_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/widgets/app_textform_field.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/loader_widget.dart';
import '../../../core/constants/image_constants.dart';
import '../../../core/constants/string_constants.dart';
import '../../../core/localization/l10n/app_localizations.dart';
import '../../../core/localization/localization_provider.dart';
import '../../../core/utils/validations/validations.dart';

class LoginUI extends StatelessWidget {
  const LoginUI({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    var loginProvider = context.read<LoginProvider>();

    return Scaffold(
      body: Center(
        child: Form(
          key: loginProvider.formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    ImageConstants.possibilityLogo,
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),

                  SizedBox(height: 25),
                  Text(
                    localization.welcomeBack,
                    style: context.theme.textTheme.titleMedium!.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        localization.loginHere,
                        style: context.theme.textTheme.titleMedium!.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: ColorConstants.blue,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Icon(Icons.arrow_forward, color: ColorConstants.blue),
                    ],
                  ),

                  SizedBox(height: 40),

                  AppTextFormField(
                    hintText: localization.pleaseEnterEmail,
                    prefixIcon: Icon(Icons.email, color: ColorConstants.blue),
                    onChanged: (email) {
                      loginProvider.debouncer.run(() {
                        loginProvider.formKey.currentState!.validate();
                      });
                    },
                    validator: (email) {
                      if ((email ?? '').isEmpty) {
                        return localization.pleaseEnterEmail;
                      } else if (!Validations.isValidEmail(email ?? '')) {
                        return localization.pleaseEnterAValidEmail;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  AppTextFormField(
                    hintText: localization.pleaseEnterPassword,
                    prefixIcon: Icon(
                      Icons.lock_rounded,
                      color: ColorConstants.blue,
                    ),
                    onChanged: (password) {
                      loginProvider.debouncer.run(() {
                        loginProvider.formKey.currentState!.validate();
                      });
                    },
                    validator: (pass) {
                      if ((pass ?? '').isEmpty) {
                        return localization.pleaseEnterPassword;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 40),
                  context.watch<LoginProvider>().loading
                      ? Center(child: Loader())
                      : CustomButton(
                          title: localization.login,
                          onTap: () async {
                            if (loginProvider.formKey.currentState!
                                .validate()) {
                              await loginProvider.submitButton();
                            }
                          },
                        ),
                  const SizedBox(height: 30),

                  /// Change Language
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        localization.changeLanguage,
                        style: context.theme.textTheme.titleMedium!.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Consumer<LocalizationProvider>(
                        builder: (context, localizationProvider, _) {
                          return OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: ColorConstants.blue),
                            ),
                            onPressed: () =>
                                showLanguageBottomSheet(context, localization),
                            child: Text(
                              localizationProvider.locale.languageCode == 'en'
                                  ? StringConstants.english
                                  : StringConstants.hindi,
                              style: TextStyle(color: ColorConstants.blue),
                            ),
                          );
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// Change Theme
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        localization.changeTheme,
                        style: context.theme.textTheme.titleMedium!.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Consumer<ThemeProvider>(
                        builder: (context, theme, _) {
                          return CupertinoSwitch(
                            value: theme.isDarkTheme,
                            activeTrackColor: ColorConstants.blue,
                            onChanged: (value) {
                              theme.toggleTheme(value);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showLanguageBottomSheet(
    BuildContext context,
    AppLocalizations localization,
  ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final localizationBloc = context.read<LocalizationProvider>();
        final currentLocale = localizationBloc.locale;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                localization.changeLanguage,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text("English"),
                trailing: currentLocale.languageCode == 'en'
                    ? const Icon(Icons.check, color: Colors.blue)
                    : null,
                onTap: () {
                  localizationBloc.setLocale(Locale('en'));

                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("हिंदी"),
                trailing: currentLocale.languageCode == 'hi'
                    ? const Icon(Icons.check, color: Colors.blue)
                    : null,
                onTap: () {
                  localizationBloc.setLocale(Locale('hi'));
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
