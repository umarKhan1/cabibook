import 'package:cabibook/logic/auth/auth_form_validation/authformvalidation_cubit.dart';
import 'package:cabibook/logic/auth/auth_tab_cubit.dart';
import 'package:cabibook/presentation/auth/signin_auth/signIn.dart';
import 'package:cabibook/presentation/auth/signup_auth/signup_view.dart';
import 'package:cabibook/utils/ext.dart';
import 'package:cabibook/utils/images_const.dart';
import 'package:cabibook/utils/social_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Container(
            height: 370.h,
            width: double.infinity,
            color: context.primaryColor,
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              ApplicationImageConst.loginbackground,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 270.h,
            ),
          ),

          Positioned(
            top: 100.h,
            right: 130.w,
            child: Center(
              child: Image.asset(
                ApplicationImageConst.logo,
                fit: BoxFit.cover,
                width: 120.w,
                height: 70.h,
              ),
            ),
          ),
          Align(
            child: SingleChildScrollView(
              child: Container(
                width: 343.w,
                padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BlocBuilder<AuthTabCubitTab, AuthCubitTabEnum>(
                      builder: (context, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _TabButton(
                              title: 'Sign Up',
                              isActive: state == AuthCubitTabEnum.signUp,
                              onTap: () {
                                context.read<AuthTabCubitTab>().showSignUp();
                                context.read<AuthValidationCubit>().setSignIn(
                                  false,
                                );
                              },
                            ),
                            _TabButton(
                              title: 'Sign In',
                              isActive: state == AuthCubitTabEnum.signIn,
                              onTap: () {
                                context.read<AuthTabCubitTab>().showSignIn();
                                context.read<AuthValidationCubit>().setSignIn(
                                  true,
                                );
                              },
                            ),
                          ],
                        );
                      },
                    ),
                    10.hsb,
                    Divider(
                      height: 1,
                      thickness: 1.5,
                      color: Colors.grey.withValues(alpha: 0.5),
                    ),
                    BlocBuilder<AuthTabCubitTab, AuthCubitTabEnum>(
                      builder: (context, state) {
                        return state == AuthCubitTabEnum.signUp
                            ? const SignupView()
                            : const SiginView();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          KeyboardVisibilityBuilder(
            builder: (context, keyboardVisible) {
              return keyboardVisible
                  ? const SizedBox()
                  : Align(
                      alignment: Alignment.bottomCenter,
                      child: SafeArea(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 5.h),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: SocialButton(
                                  onPressed: () {
                                    // Facebook login logic
                                  },
                                  icon: Icons.facebook_outlined,
                                  label: 'Connect with Facebook',
                                  backgroundColor: const Color(
                                    0xFF1877F2,
                                  ), // Facebook Blue
                                ),
                              ),
                              10.hsb,
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: SocialButton(
                                  onPressed: () {
                                    // Google login logic
                                  },
                                  icon: Icons.g_mobiledata,
                                  label: 'Connect with Google',
                                  backgroundColor: Colors.red,
                                ),
                              ),
                              12.hsb,
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Text.rich(
                                  TextSpan(
                                    text:
                                        'By clicking start, you agree to our ',
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Colors.black87,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Terms and Conditions',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  final String title;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
                color: isActive ? Colors.black : Colors.grey,
              ),
            ),
            SizedBox(height: 4.h),
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              height: 3.h,
              width: isActive ? 40.w : 0,
              color: context.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
