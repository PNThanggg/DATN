import 'package:flutter/material.dart';

import 'app_color.dart';

abstract class AppTheme {
  AppTheme._();

  static const String _fontFamily = "Poppins";

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    primaryColor: AppColor.primaryColor,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColor.background,
    fontFamily: _fontFamily,
  );
}
