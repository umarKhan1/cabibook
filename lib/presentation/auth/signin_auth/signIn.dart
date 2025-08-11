import 'package:cabibook/logic/auth/auth_form_validation/authformvalidation_cubit.dart';
import 'package:cabibook/logic/auth/auth_form_validation/authformvalidation_state.dart';
import 'package:cabibook/presentation/auth/otp_form_view.dart';
import 'package:cabibook/utils/app_string.dart';
import 'package:cabibook/utils/ext.dart';
import 'package:cabibook/utils/log_file.dart';
import 'package:cabibook/widget/app_button_widget.dart';
import 'package:cabibook/widget/custom_phonetextfield.dart';
import 'package:cabibook/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SiginView extends StatefulWidget {
  const SiginView({super.key});

  @override
  State<SiginView> createState() => _SiginViewState();
}

class _SiginViewState extends State<SiginView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthValidationCubit, AuthFormState>(
        builder: (context, state) {
          final cubit = context.read<AuthValidationCubit>();
         
  
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 30),
            child: Column(
              children: [
           
                CustomPhoneField(
           isValid: !state.isPhoneTouched || state.isPhoneValid,
                  isSignIn: true,
                  onChanged: cubit.onPhoneChanged,
                ),
               30.hsb,
              ApplicationButton(
                size: Size(double.infinity, 50.h),
                onPressed: cubit.isFormValid ? () {
               context.push( const OTPScreen());
                } : null,
                child: Text(
                          state.isSignIn
                              ? ApplicationStrings.signInButton
                              : ApplicationStrings.signUpButton,
                        style:  TextStyle(
                            fontSize:15.sp,
                            fontWeight: FontWeight.w600,
                          color: context.textTheme.bodyMedium!.color,
                          ),
                        
                        ),
                )
              ],
            ),
          );
        },
      );

  }
}
