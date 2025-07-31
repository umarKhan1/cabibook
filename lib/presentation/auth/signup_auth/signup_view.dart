import 'package:cabibook/logic/auth/auth_form_validation/authformvalidation_cubit.dart';
import 'package:cabibook/logic/auth/auth_form_validation/authformvalidation_state.dart';
import 'package:cabibook/utils/app_string.dart';
import 'package:cabibook/utils/ext.dart';
import 'package:cabibook/widget/app_button_widget.dart';
import 'package:cabibook/widget/custom_phonetextfield.dart';
import 'package:cabibook/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthValidationCubit, AuthFormState>(
      builder: (context, state) {
        final cubit = context.read<AuthValidationCubit>();

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            children: [
              CustomTextField(
                hintText: 'Example@example.com',
                isValid: state.isEmailValid,
                keyboardType: TextInputType.emailAddress,
                onChanged: cubit.onEmailChanged,
              ),
              16.hsb,
              CustomPhoneField(
              isValid: !state.isPhoneTouched || state.isPhoneValid,
                isSignIn: false,
                onChanged: cubit.onPhoneChanged,
              ),
              30.hsb,
              ApplicationButton(
                size: Size(double.infinity, 50.h),
                onPressed: cubit.isFormValid
                    ? () {
                        // handle login
                      }
                    : null,
                child: Text(
                  state.isSignIn
                      ? ApplicationStrings.signInButton
                      : ApplicationStrings.signUpButton,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: context.textTheme.bodyMedium!.color,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
