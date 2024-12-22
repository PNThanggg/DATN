import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common/constants/app_image.dart';
import '../../../../common/util/translation/app_translation.dart';
import '../../../theme/app_color.dart';
import '../../../theme/theme_text.dart';
import '../../../widget/app_image_widget.dart';
import '../../../widget/app_touchable.dart';

class AlarmAddDataButton extends StatelessWidget {
  final Function() onSetAlarm;
  final Function() onAddData;

  const AlarmAddDataButton({
    super.key,
    required this.onSetAlarm,
    required this.onAddData,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppTouchable.common(
            onPressed: () {
              onSetAlarm.call();
            },
            padding: EdgeInsets.symmetric(
              vertical: 12.0.sp,
            ),
            backgroundColor: AppColor.gold,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppImageWidget.asset(
                  path: AppImage.ic_alarm,
                  width: 32.0.sp,
                  height: 32.0.sp,
                  color: AppColor.black,
                ),
                SizedBox(
                  width: 4.0.sp,
                ),
                Text(
                  TranslationConstants.setAlarm.tr,
                  style: textStyle18700().copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0.sp,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 12.0.sp),
        Expanded(
          child: AppTouchable.common(
            onPressed: onAddData,
            padding: EdgeInsets.symmetric(
              vertical: 18.0.sp,
            ),
            backgroundColor: AppColor.primaryColor,
            child: Text(
              '+ ${TranslationConstants.addData.tr}',
              style: textStyle18700().copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16.0.sp,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
