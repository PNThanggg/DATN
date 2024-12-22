import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common/constants/app_image.dart';
import '../../../../common/util/translation/app_translation.dart';
import '../../../theme/app_color.dart';
import '../../../theme/theme_text.dart';
import '../../../widget/app_container.dart';
import '../../../widget/app_header.dart';
import '../../../widget/app_touchable.dart';
import '../../../widget/filter/filter_date_widget.dart';
import '../widget/alarm_add_data_button.dart';
import '../widget/empty_widget.dart';
import 'blood_pressure_controller.dart';
import 'widget/blood_pressure_data_widget.dart';

class BloodPressureScreen extends GetView<BloodPressureController> {
  const BloodPressureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    final double paddingBottom = MediaQuery.of(context).padding.bottom;

    return AppContainer(
      child: Column(
        children: [
          AppHeader(
            title: TranslationConstants.bloodPressure.tr,
            decoration: const BoxDecoration(
              color: AppColor.primaryColor,
            ),
            titleStyle: const TextStyle(color: AppColor.white),
            leftWidget: BackButton(
              color: AppColor.white,
              onPressed: () => Get.back(),
            ),
            extendWidget: Obx(
              () => FilterDateWidget(
                startDate: controller.filterStartDate.value,
                endDate: controller.filterEndDate.value,
                onPressed: () => controller.onPressDateRange(
                  context,
                  callback: controller.filterBloodPressure,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.sp),
              child: Column(
                children: [
                  Expanded(
                    child: Obx(
                      () => controller.bloodPressures.isNotEmpty
                          ? const SingleChildScrollView(
                              physics: NeverScrollableScrollPhysics(),
                              child: BloodPressureDataWidget(),
                            )
                          : EmptyWidget(
                              imagePath: AppImage.ic_blood_pressure2,
                              imageWidth: 168.sp,
                              message: TranslationConstants.addYourRecordToSeeStatistics.tr,
                            ),
                    ),
                  ),
                  AlarmAddDataButton(
                    onSetAlarm: controller.onSetAlarm,
                    onAddData: controller.onAddData,
                  ),
                  SizedBox(
                    height: 12.0.sp,
                  ),
                  Obx(
                    () => controller.bloodPressures.isNotEmpty
                        ? AppTouchable.common(
                            onPressed: controller.isExporting.value ? null : controller.onExportData,
                            padding: EdgeInsets.symmetric(
                              vertical: 16.0.sp,
                            ),
                            backgroundColor: AppColor.green,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: controller.isExporting.value
                                      ? SizedBox(
                                          width: 20.0.sp,
                                          height: 20.0.sp,
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeCap: StrokeCap.round,
                                              strokeWidth: 3.0.sp,
                                            ),
                                          ),
                                        )
                                      : Text(
                                          TranslationConstants.export.tr,
                                          textAlign: TextAlign.center,
                                          style: textStyle18700().copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.0.sp,
                                            color: Colors.white,
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                  SizedBox(
                    height: paddingBottom + 12.sp,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
