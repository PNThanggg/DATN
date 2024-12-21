import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common/constants/app_image.dart';
import '../../../../common/util/translation/app_translation.dart';
import '../../../theme/app_color.dart';
import '../../../widget/app_container.dart';
import '../../../widget/app_header.dart';
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
            decoration: BoxDecoration(
              color: AppColor.primaryColor,
              boxShadow: [
                BoxShadow(
                  color: const Color(0x40000000),
                  offset: Offset(0, 4.0.sp),
                  blurRadius: 4.0.sp,
                ),
              ],
            ),
            titleStyle: const TextStyle(color: AppColor.white),
            leftWidget: BackButton(
              color: AppColor.white,
              onPressed: () => Get.back(),
            ),
            rightWidget: Obx(
              () => controller.isExporting.value
                  ? Padding(
                      padding: EdgeInsets.all(4.0.sp),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColor.primaryColor,
                          strokeWidth: 3.0.sp,
                        ),
                      ),
                    )
                  : ExportButton(
                      titleColor: AppColor.primaryColor,
                      onPressed: controller.onExportData,
                    ),
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
              padding: EdgeInsets.symmetric(horizontal: 17.sp),
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
                    height: paddingBottom + 16.sp,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
