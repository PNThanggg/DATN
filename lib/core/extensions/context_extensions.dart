import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  // Get the theme
  ThemeData get theme => Theme.of(this);

  // Get the text theme
  TextTheme get textTheme => Theme.of(this).textTheme;

  // Get the size of the screen
  Size get screenSize => MediaQuery.of(this).size;

  // Get the height of the screen
  double get height => MediaQuery.of(this).size.height;

  // Get the width of the screen
  double get width => MediaQuery.of(this).size.width;
}
