// ignore_for_file: use_build_context_synchronously

import 'package:cabibook/logic/auth/auth_form_validation/auth_otp_form_vaildation.dart';
import 'package:cabibook/logic/permission_handler/permission_handler_cubit_cubit.dart';
import 'package:cabibook/presentation/dashboard/dashboard_view.dart';
import 'package:cabibook/presentation/permission_view.dart';
import 'package:cabibook/utils/app_string.dart';
import 'package:cabibook/utils/ext.dart';
import 'package:cabibook/utils/log_file.dart';
import 'package:cabibook/widget/app_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OTPCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 195.h,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  color: context.primaryColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 23.r,
                        ),
                        onPressed: () => context.pop(),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        ApplicationStrings.otpTitle,
                        style: TextStyle(
                          fontSize: 34.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        ApplicationStrings.otpDescription,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 60.h),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: BlocBuilder<OTPCubit, String>(
                    builder: (context, state) {
                      return OtpTextField(
                        numberOfFields: 4,
                        fieldWidth: 55.w,
                        borderWidth: 3.w,
                        margin: EdgeInsets.symmetric(horizontal: 12.w),
                        showFieldAsBox: false,
                        textStyle: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w800,
                          color: context.textTheme.bodyLarge!.color,
                        ),
                        focusedBorderColor: context.primaryColor,
                        cursorColor: context.primaryColor,
                        borderColor: Colors.grey.shade400,
                        onCodeChanged: (code) {
                          context.read<OTPCubit>().updateOTP(code);
                        },
                        onSubmit: (code) {
                          context.read<OTPCubit>().updateOTP(code);
                        },
                      );
                    },
                  ),
                ),

                SizedBox(height: 70.h),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: BlocBuilder<OTPCubit, String>(
                    builder: (context, otp) {
                      return SizedBox(
                        width: double.infinity,
                        child: ApplicationButton(
                          size: Size(double.infinity, 50.h),
                          onPressed: otp.length == 4
                              ? () async {


                                  final hasPermission = await context
                                      .read<PermissionCubit>()
                                      .checkLocationPermission();

                                  if (hasPermission) {
                                    context.pushReplacement(
                                       ApplicationDashboardView(),
                                    );
                                  } else {
                                    context.pushReplacement(
                                      const PermissionGateView(),
                                    );
                                  }
                                }
                              : null,
                          child: Text(
                            'Verify Now',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: context.textTheme.bodyMedium!.color,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
