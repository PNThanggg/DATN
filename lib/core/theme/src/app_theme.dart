import 'package:flutter/material.dart';

import 'app_color.dart';

abstract class AppTheme {
  AppTheme._();

  static const String _fontFamily = "Poppins";

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    primaryColor: AppColor.primary,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColor.lightBackground,
    fontFamily: _fontFamily,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );

  static ThemeData dartTheme = ThemeData(
    useMaterial3: true,
    primaryColor: AppColor.primary,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColor.darkBackground,
    fontFamily: _fontFamily,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );
}
