import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme/app_color.dart';
import '../../../theme/theme_text.dart';
import '../../../widget/app_image_widget.dart';

class EmptyWidget extends StatelessWidget {
  final String imagePath;
  final double imageWidth;
  final String message;

  const EmptyWidget({
    super.key,
    required this.imagePath,
    required this.message,
    required this.imageWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppImageWidget.asset(
          path: imagePath,
          width: imageWidth,
        ),
        SizedBox(
          height: 8.0.sp,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.sp),
          child: Text(
            message,
            style: textStyle20700().copyWith(
              color: AppColor.black,
              fontWeight: FontWeight.w600,
              fontSize: 16.0.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
