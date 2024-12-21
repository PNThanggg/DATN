import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../theme/app_color.dart';
import '../../../theme/theme_text.dart';
import '../../../widget/app_touchable.dart';

class InsightTile extends StatelessWidget {
  const InsightTile({
    super.key,
    required this.imagePath,
    required this.title,
    required this.onTap,
  });

  final String imagePath;
  final String title;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return AppTouchable.common(
      onPressed: onTap,
      margin: EdgeInsets.symmetric(horizontal: 17.0.sp, vertical: 12.0.sp).copyWith(bottom: 0),
      padding: EdgeInsets.symmetric(horizontal: 30.0.sp, vertical: 28.0.sp),
      width: Get.width,
      child: Row(
        children: [
          Image.asset(
            imagePath,
            width: 50.0.sp,
          ),
          SizedBox(
            width: 14.0.sp,
          ),
          Text(
            title,
            style: textStyle20700().copyWith(
              color: AppColor.black,
            ),
          ),
        ],
      ),
    );
  }
}
