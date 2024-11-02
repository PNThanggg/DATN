import 'package:flutter/material.dart';

abstract class AppColor {
  AppColor._();

  static Color black = Colors.black;
  static Color white = Colors.white;

  static Color primary = const Color(0xFF42C83C);

  static Color lightBackground = const Color(0xFFF2F2F2);
  static Color darkBackground = const Color(0xFF0D0C0C);

  static Color lightGrey = const Color(0xFFBEBEBE);
  static Color darkGrey = const Color(0xFF343434);

  static Color defaultText = const Color(0xFFDADADA);
  static Color secondText = const Color(0xFF797979);
}
