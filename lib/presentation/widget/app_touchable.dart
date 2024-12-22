import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_color.dart';

class AppTouchable extends StatelessWidget {
  final Function()? onPressed;
  final Function()? onLongPressed;
  final Widget? child;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? rippleColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final OutlinedBorder? outlinedBorder;
  final BoxDecoration? decoration;

  const AppTouchable({
    super.key,
    required this.onPressed,
    this.onLongPressed,
    required this.child,
    this.width,
    this.height,
    this.backgroundColor,
    this.foregroundColor,
    this.rippleColor,
    this.padding,
    this.margin,
    this.outlinedBorder,
    this.decoration,
  });

  const AppTouchable.common({
    super.key,
    required this.onPressed,
    this.onLongPressed,
    required this.child,
    this.width,
    this.height,
    this.backgroundColor,
    this.foregroundColor,
    this.rippleColor,
    this.padding,
    this.margin,
    this.outlinedBorder = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ),
    this.decoration = const BoxDecoration(
      color: AppColor.white,
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
      boxShadow: [
        BoxShadow(
          color: Color(0x40000000),
          offset: Offset(0, 0),
          blurRadius: 10,
        ),
      ],
    ),
  });

  const AppTouchable.commonRadius87({
    super.key,
    required this.onPressed,
    this.onLongPressed,
    required this.child,
    this.width,
    this.height,
    this.backgroundColor,
    this.foregroundColor,
    this.rippleColor,
    this.padding,
    this.margin,
    this.outlinedBorder = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(87)),
    ),
    this.decoration = const BoxDecoration(
      color: AppColor.white,
      borderRadius: BorderRadius.all(Radius.circular(87)),
      boxShadow: [
        BoxShadow(
          color: Color(0x40000000),
          offset: Offset(0, 0),
          blurRadius: 10,
        ),
      ],
    ),
  });

  const AppTouchable.commonRadius20({
    super.key,
    required this.onPressed,
    this.onLongPressed,
    required this.child,
    this.width,
    this.height,
    this.backgroundColor,
    this.foregroundColor,
    this.rippleColor,
    this.padding,
    this.margin,
    this.outlinedBorder = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
    ),
    this.decoration = const BoxDecoration(
      color: AppColor.white,
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
      boxShadow: [
        BoxShadow(
          color: Color(0x40000000),
          offset: Offset(0, 0),
          blurRadius: 10,
        ),
      ],
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin ?? EdgeInsets.zero,
      decoration: decoration,
      child: TextButton(
        onPressed: onPressed,
        onLongPress: onLongPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(backgroundColor ?? Colors.transparent),
          overlayColor: WidgetStateProperty.all(
            rippleColor ?? const Color.fromRGBO(204, 223, 242, 0.4),
          ),
          foregroundColor: WidgetStateProperty.all(foregroundColor ?? AppColor.primaryColor),
          shape: WidgetStateProperty.all(
            outlinedBorder ??
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0.sp),
                ),
          ),
          padding: WidgetStateProperty.all(padding ?? EdgeInsets.zero),
          minimumSize: WidgetStateProperty.all(Size.zero),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.standard,
        ),
        child: child ?? const SizedBox.shrink(),
      ),
    );
  }
}
