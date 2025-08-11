import 'package:cabibook/utils/images_const.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class CenterPin extends StatelessWidget {
  const CenterPin({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Center(
        child: Lottie.asset(ApplicationImageConst.lottieAnimation, width: 150, height: 150, fit: BoxFit.cover),
      ),
    );
  }
}
