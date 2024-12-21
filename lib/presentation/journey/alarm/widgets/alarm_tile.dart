import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../../domain/model/alarm_model.dart';
import '../../../../../common/constants/app_image.dart';
import '../../../../common/util/translation/app_translation.dart';
import '../../../theme/theme_text.dart';
import '../../../widget/app_touchable.dart';
import '../../../widget/app_week_days_picker.dart';

class AlarmTile extends StatelessWidget {
  const AlarmTile({
    super.key,
    required this.alarmModel,
    this.onTap,
    this.onDeleteTap,
  });

  final void Function(AlarmModel)? onTap;
  final void Function(AlarmModel)? onDeleteTap;
  final AlarmModel alarmModel;

  @override
  Widget build(BuildContext context) {
    return AppTouchable.common(
      margin: EdgeInsets.symmetric(
        vertical: 8.0.sp,
        horizontal: 16.0.sp,
      ),
      onPressed: () {
        if (onTap != null) onTap!(alarmModel);
      },
      padding: EdgeInsets.symmetric(
        horizontal: 12.sp,
        vertical: 8.sp,
      ),
      width: Get.width,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    TranslationConstants.remindToRecord.tr,
                    style: textStyle12400(),
                  ),
                  SizedBox(
                    height: 4.sp,
                  ),
                  Text(
                    alarmModel.type == null ? "Unknown" : alarmModel.type.toString().split(".")[1].tr,
                    style: textStyle16500(),
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    DateFormat(DateFormat.HOUR24_MINUTE).format(alarmModel.time!),
                    style: textStyle30600(),
                  ),
                  SizedBox(height: 20.sp),
                  AppTouchable(
                    onPressed: () {
                      if (onDeleteTap != null) onDeleteTap!(alarmModel);
                    },
                    child: SvgPicture.asset(AppImage.ic_del),
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: 14.sp,
          ),
          AppWeekdaysPicker(
            enableSelection: false,
            initialWeekDays: alarmModel.alarmDays,
          ),
        ],
      ),
    );
  }
}
