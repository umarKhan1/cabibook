import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension NavigationExtension on BuildContext {
  void pushNamed(String routeName, {Object? arguments}) {
    Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }
  void pushReplacementNamed(String routeName, {Object? arguments}) {
    Navigator.of(this).pushReplacementNamed(routeName, arguments: arguments);
  }

  void push(Widget page) {
    Navigator.of(this).push(
      MaterialPageRoute<Widget>(builder: (_) => page),
    );
  }
  void pushReplacement(Widget page) {
    Navigator.of(this).pushReplacement(
      MaterialPageRoute<Widget>(builder: (_) => page),
    );
  }

  void pop<T extends Object?>([T? result]) {
    Navigator.of(this).pop(result);
  }
}

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;
  Color get primaryColor => colorScheme.primary;
  Color get secondaryColor => colorScheme.secondary;
  Color get surfaceColor => colorScheme.surface;
}

extension SizedBoxHeightExtension on num {
  SizedBox get hsb => SizedBox(height: h);
  SizedBox get wsb => SizedBox(width: w);
}
