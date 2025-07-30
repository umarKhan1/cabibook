import 'package:cabibook/utils/app_color.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: ApplicationColors.lightPrimary,
    scaffoldBackgroundColor: ApplicationColors.lightBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: ApplicationColors.lightSurface,
      foregroundColor: ApplicationColors.lightText,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: ApplicationColors.lightText,
        fontFamily: 'Gilroy',
      ),
      bodyMedium: TextStyle(
        color: ApplicationColors.lightSecondaryText,
        fontFamily: 'Gilroy',
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: ApplicationColors.lightPrimary,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: ApplicationColors.darkPrimary,
    scaffoldBackgroundColor: ApplicationColors.darkBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: ApplicationColors.darkSurface,
      foregroundColor: ApplicationColors.darkText,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: ApplicationColors.darkText,
        fontFamily: 'Gilroy',
      ),
      bodyMedium: TextStyle(
        color: ApplicationColors.darkSecondaryText,
        fontFamily: 'Gilroy',
      ),
    ),
    colorScheme: const ColorScheme.dark(
      primary: ApplicationColors.darkPrimary,
      surface: ApplicationColors.darkSurface,
    ),
  );
}
