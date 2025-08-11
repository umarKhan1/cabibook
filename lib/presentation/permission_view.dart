import 'package:cabibook/logic/permission_handler/permission_handler_cubit_cubit.dart';
import 'package:cabibook/logic/permission_handler/permission_handler_cubit_state.dart' hide LocationPermissionDenied;
import 'package:cabibook/presentation/dashboard/dashboard_view.dart';
import 'package:cabibook/utils/app_string.dart';
import 'package:cabibook/utils/ext.dart';
import 'package:cabibook/utils/images_const.dart';
import 'package:cabibook/widget/app_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PermissionGateView extends StatelessWidget {
  const PermissionGateView({super.key});
void showCupertinoPermissionDialog(BuildContext context) {
  showCupertinoDialog(
    context: context,
    builder: (_) => CupertinoAlertDialog(
      title: const Text(ApplicationStrings.permissionRequired),
      content: const Text(
        ApplicationStrings.locationPermissionDenied,
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () => context.pop(context),
          child: const Text('Cancel'),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
            context.read<PermissionCubit>().openSettings();
          },
          child: const Text('Open Settings'),
        ),
      ],
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<PermissionCubit, PermissionState>(
        listener: (context, state) {
          if (state is LocationPermissionGranted) {
            context.push( ApplicationDashboardView());
          }

          if (state is LocationPermissionDenied && state.permanently) {
            showCupertinoPermissionDialog(context);  }
        },
        builder: (context, state) {
          return Column(
            children: <Widget>[
              100.hsb,
              Image.asset(
                ApplicationImageConst.permissionGate,
                width: double.infinity,
                height: 200.h,
                fit: BoxFit.cover,
              ),
              100.hsb,
              Text(
                ApplicationStrings.hiNiceToMeetYou,
                style: TextStyle(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w900,
                  color: context.textTheme.bodyLarge!.color,
                ),
              ),
              30.hsb,
              SizedBox(
                width: 250.w,
                child: Text(
                  ApplicationStrings.allowNotifications,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: context.textTheme.bodyLarge!.color,
                  ),
                ),
              ),
              50.hsb,
              ApplicationButton(
                size: Size(300.w, 50.h),
                onPressed: () {
                  context.read<PermissionCubit>().requestLocationPermission();
                },
                child: Text(
                  ApplicationStrings.enableLocation,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: context.textTheme.bodyMedium!.color,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
