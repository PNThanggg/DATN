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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(),
        AppImageWidget.asset(
          path: imagePath,
          width: imageWidth,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 52.sp),
          child: Text(
            message,
            style: textStyle20700().copyWith(
              color: AppColor.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(),
      ],
    );
  }
}
