import 'package:flutter/material.dart';

abstract class AppColor {
  AppColor._();


  static const Color white = Colors.white;
  static const Color black = Colors.black;

  static const backgroundColor = Color(0xFFF8F8F8);

  static const primaryColor = Color(0xFFE6593D);
  static const secondColor = Color(0xFFFF907A);

  static const defaultTextColor = Color(0xFF211F26);
  static const secondTextColor = Color(0xFF65636D);
  static const whiteTextColor = white;
  static const blackTextColor = black;
  static const buttonTextColor = primaryColor;

  static const borderColor = Color(0xFFD5D3DB);

  static const gray = Color(0xFFCECECE);
  static const gray2 = Color(0xFFA6A6A6);
  static const lightGray = Color(0xFFECECEC);
  static const grayText = Color(0xFF6D6D6D);
  static const grayText2 = Color(0xFFA5A5A5);
  static const background = Color(0xFFF5F5F5);
  static const red = Color(0xFFFF6464);
  static Color? red50 = Colors.red[50];
  static Color? red600 = Colors.red[600];
  static const lightRed = Color(0xFFFF0000);
  static const green = Color(0xFF0B8C10);
  static Color? green50 = Colors.green[50];
  static const gold = Color(0xFFFFC700);
  static const violet = Color(0xFFCF71FB);
  static const deepViolet = Color(0xFF8C52EB);
  static const lightOrange = Color(0xffFF9900);
  static const orange = Color(0xffFF7033);
  static Color? orange50 = Colors.orange[50];
  static const blue98EB = Color(0xff5298EB);
  static const transparent = Colors.transparent;
  static const yellow = Color(0xffF8C646);
}
