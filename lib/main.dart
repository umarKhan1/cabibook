
import 'package:cabibook/logic/auth/auth_form_validation/authformvalidation_cubit.dart';
import 'package:cabibook/logic/auth/auth_tab_cubit.dart';
import 'package:cabibook/logic/map_cubit/google_map_cubit.dart';
import 'package:cabibook/logic/onboarding_cubit.dart/onboarding_cubit.dart';
import 'package:cabibook/logic/permission_handler/permission_handler_cubit_cubit.dart';
import 'package:cabibook/logic/rider_cubit/ridercubit_cubit.dart';
import 'package:cabibook/logic/splash_cubit.dart';
import 'package:cabibook/presentation/dashboard/dashboard_view.dart';
import 'package:cabibook/presentation/splashview.dart';
import 'package:cabibook/utils/app_string.dart';
import 'package:cabibook/utils/themedata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
   await dotenv.load(fileName: './.env');
   debugPrint('⚙️ Loaded GOOGLE_API_KEY=${dotenv.env['GOOGLE_API_KEY']}');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
             BlocProvider(create: (_) => MapCubit()..initLocation()),
BlocProvider<RideCubit>(
            create: (context) => RideCubit()// Example distance
          ),
          BlocProvider<SplashCubit>(
            create: (context) => SplashCubit()..start(),
          ),
          BlocProvider<OnboardingCubit>(
            create: (context) => OnboardingCubit(totalPages: 3),
          ),
          BlocProvider<AuthValidationCubit>(
            create: (context) => AuthValidationCubit(),
          ),
          
          BlocProvider<AuthTabCubitTab>(
            create: (context) => AuthTabCubitTab(),
          ),

          BlocProvider<PermissionCubit>(
            create: (context) => PermissionCubit(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: ApplicationStrings.appName,
          theme: AppTheme.lightTheme,
          home:  ApplicationDashboardView(),
        ),
      ),
    );
  }
}
