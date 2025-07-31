import 'package:cabibook/logic/splash_cubit.dart';
import 'package:cabibook/presentation/onboarding/onboarding.dart';
import 'package:cabibook/utils/app_string.dart';
import 'package:cabibook/utils/ext.dart';
import 'package:cabibook/utils/images_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state == SplashState.completed) {
           context.pushReplacement( const OnboardingView());
          }
        },
        child: Scaffold(
          backgroundColor: context.primaryColor,
          body:Stack(
            children: [
              Center(
                child: Image.asset(
                  ApplicationImageConst.splashbackground,
            
                ),
              ),
              const Center(
                child: Text(ApplicationStrings.appName,
                    style: TextStyle(
                      fontSize:40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ],
          ),
        ),
      );
  }
}
