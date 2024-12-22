import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common/util/translation/app_translation.dart';
import '../../../../domain/enum/alarm_type.dart';
import '../../../../domain/model/alarm_model.dart';
import '../../../theme/app_color.dart';
import '../../../theme/theme_text.dart';
import '../../../widget/app_button.dart';
import '../../../widget/app_week_days_picker.dart';
import 'alarm_dialog_controller.dart';

class AlarmDialog extends GetView<AlarmDialogController> {
  AlarmDialog({
    super.key,
    this.alarmModel,
    this.onPressCancel,
    this.onPressSave,
    this.alarmType,
  }) {
    if (alarmModel != null) {
      controller.alarmModel.value = alarmModel!;
    } else {
      controller.alarmModel.value = controller.alarmModel.value.copyWith(
        type: alarmType,
        time: DateTime.now(),
      );
    }
    controller.validate();
  }

  final AlarmModel? alarmModel;
  final void Function()? onPressCancel;
  final void Function(AlarmModel)? onPressSave;
  final AlarmType? alarmType;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 24.0.sp,
          ),
          AppWeekdaysPicker(
            initialWeekDays: controller.alarmModel.value.alarmDays,
            enableSelection: true,
            onSelectedWeekdaysChanged: controller.onSelectedWeekDaysChanged,
          ),
          SizedBox(
            height: 24.0.sp,
          ),
          SizedBox(
            height: 160.0.sp,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time,
              initialDateTime: DateTime(
                0,
                0,
                0,
                controller.alarmModel.value.time!.hour,
                controller.alarmModel.value.time!.minute,
              ),
              use24hFormat: true,
              onDateTimeChanged: controller.onTimeChange,
            ),
          ),
          SizedBox(
            height: 24.0.sp,
          ),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  onPressed: () {
                    controller.reset();
                    if (onPressCancel != null) {
                      onPressCancel!();
                    } else {
                      Get.back();
                    }
                  },
                  color: AppColor.red,
                  padding: EdgeInsets.symmetric(
                    vertical: 12.0.sp,
                  ),
                  radius: 10.0.sp,
                  child: Text(
                    TranslationConstants.cancel.tr,
                    textAlign: TextAlign.center,
                    style: textStyle24700().copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.0.sp),
              Expanded(
                child: AppButton(
                  onPressed: controller.isValid.value
                      ? () {
                          final alarmModel = controller.alarmModel.value;
                          controller.reset();
                          if (onPressSave != null) {
                            onPressSave!(alarmModel);
                          }
                        }
                      : null,
                  color: controller.isValid.value ? AppColor.primaryColor : AppColor.gray,
                  radius: 10.0.sp,
                  padding: EdgeInsets.symmetric(
                    vertical: 12.0.sp,
                  ),
                  child: Text(
                    TranslationConstants.save.tr,
                    textAlign: TextAlign.center,
                    style: textStyle24700().copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0.sp,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      );
    });
  }
}
