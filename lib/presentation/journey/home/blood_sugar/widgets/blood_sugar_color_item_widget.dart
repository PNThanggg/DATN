import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../common/constants/app_constant.dart';
import '../../../../../common/constants/app_image.dart';
import '../../../../widget/app_image_widget.dart';

class BloodSugarColorItemWidget extends StatelessWidget {
  final String infoCode;
  final bool isCurrent;

  const BloodSugarColorItemWidget({
    super.key,
    required this.infoCode,
    required this.isCurrent,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        isCurrent
            ? AppImageWidget.asset(
                path: AppImage.ic_down,
                height: 12.sp,
                color: bloodSugarInfoColorMap[infoCode],
              )
            : SizedBox(height: 12.sp),
        SizedBox(height: 4.sp),
        Container(
          height: 12.sp,
          decoration: BoxDecoration(
            color: bloodSugarInfoColorMap[infoCode],
            borderRadius: BorderRadius.circular(8.sp),
          ),
        ),
      ],
    );
  }
}
