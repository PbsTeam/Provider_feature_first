import 'package:flutter/material.dart';
import '../../../core/constants/image_constants.dart';
import '../data/repository/splash_repository.dart';

class SplashUI extends StatefulWidget {
  const SplashUI({super.key});

  @override
  State<SplashUI> createState() => _SplashUIState();
}

class _SplashUIState extends State<SplashUI> {
  SplashRepo splashService = SplashRepo();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      splashService.isLogin(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              ImageConstants.possibilityLogo,
              width: size.width * 0.9,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
