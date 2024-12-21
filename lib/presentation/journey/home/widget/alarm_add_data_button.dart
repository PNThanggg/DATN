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
          flex: 3,
          child: AppTouchable.common(
            onPressed: () {
              onSetAlarm.call();
            },
            height: 70.0.sp,
            backgroundColor: AppColor.gold,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppImageWidget.asset(
                  path: AppImage.ic_alarm,
                  width: 40.0.sp,
                  color: AppColor.black,
                ),
                Text(
                  TranslationConstants.setAlarm.tr,
                  style: textStyle18700(),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 12.0.sp),
        Expanded(
          flex: 5,
          child: AppTouchable.common(
            onPressed: onAddData,
            height: 70.0.sp,
            backgroundColor: AppColor.primaryColor,
            child: Text(
              '+ ${TranslationConstants.addData.tr}',
              style: textStyle20700(),
            ),
          ),
        ),
      ],
    );
  }
}
