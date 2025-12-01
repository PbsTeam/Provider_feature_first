import 'package:flutter/material.dart';
import '../../core/constants/color_constants.dart';

class Loader extends StatelessWidget {
  final Size? size;
  const Loader({super.key, this.size = const Size(30, 30)});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size?.width,
      height: size?.height,
      child: CircularProgressIndicator(color: ColorConstants.blue),
    );
  }
}
