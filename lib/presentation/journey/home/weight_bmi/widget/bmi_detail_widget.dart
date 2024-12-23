import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../common/constants/app_image.dart';
import '../../../../../common/util/translation/app_translation.dart';
import '../../../../../domain/enum/bmi_type.dart';
import '../../../../theme/app_color.dart';
import '../../../../theme/theme_text.dart';
import '../../../../widget/app_image_widget.dart';
import '../../../../widget/app_touchable.dart';

class BMIDetailWidget extends StatelessWidget {
  final String date;
  final String time;
  final int bmi;
  final int weight;
  final int height;
  final BMIType bmiType;
  final Function() onEdit;
  final Function() onDelete;

  const BMIDetailWidget({
    super.key,
    required this.date,
    required this.time,
    required this.bmi,
    required this.weight,
    required this.height,
    required this.bmiType,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return AppTouchable(
      onPressed: onEdit,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImage.ic_box_2),
            fit: BoxFit.fill,
          ),
        ),
        padding: EdgeInsets.all(14.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: textStyle14500().copyWith(color: AppColor.black),
                ),
                Text(
                  time,
                  style: textStyle14500().copyWith(color: AppColor.black),
                ),
                Text(
                  '${TranslationConstants.bmi.tr}: $bmi',
                  style: textStyle18500().copyWith(color: AppColor.black),
                )
              ],
            ),
            Column(
              children: [
                RichText(
                  text: TextSpan(
                    text: '$weight',
                    style: textStyle30600().copyWith(
                      color: AppColor.black,
                    ),
                    children: [
                      TextSpan(
                        text: 'kg',
                        style: textStyle14500().copyWith(color: AppColor.black),
                      )
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: '$height',
                    style: textStyle30600().copyWith(color: AppColor.black),
                    children: [
                      TextSpan(
                        text: 'cm',
                        style: textStyle14500().copyWith(color: AppColor.black),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: bmiType.color,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  padding: EdgeInsets.all(6.sp),
                  child: Text(
                    bmiType.bmiName,
                    style: textStyle20600().copyWith(
                      color: AppColor.white,
                      fontSize: 16.0.sp,
                    ),
                  ),
                ),
                AppTouchable(
                  width: 40.0.sp,
                  height: 40.0.sp,
                  onPressed: onDelete,
                  child: AppImageWidget.asset(
                    path: AppImage.ic_del,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
