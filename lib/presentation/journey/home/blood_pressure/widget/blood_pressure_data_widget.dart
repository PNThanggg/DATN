import 'package:datn/domain/enum/blood_pressure_type.dart';
import 'package:datn/presentation/journey/home/blood_pressure/widget/systolic_diastolic_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../common/constants/app_image.dart';
import '../../../../controller/app_controller.dart';
import '../../../../theme/app_color.dart';
import '../../../../theme/theme_text.dart';
import '../../../../widget/app_image_widget.dart';
import '../../../../widget/app_touchable.dart';
import '../../../../widget/container_widget.dart';
import '../../widget/home_bar_chart_widget/home_bar_chart.dart';
import '../blood_pressure_controller.dart';

class BloodPressureDataWidget extends GetView<BloodPressureController> {
  const BloodPressureDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final AppController appController = Get.find<AppController>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 16.sp,
        ),
        Obx(
          () => SystolicDiastolicWidget(
            systolicMin: controller.sysMin.value,
            systolicMax: controller.sysMax.value,
            diastolicMin: controller.diaMin.value,
            diastolicMax: controller.diaMax.value,
          ),
        ),
        SizedBox(
          height: 16.sp,
        ),
        ContainerWidget(
          padding: EdgeInsets.all(7.sp).copyWith(top: 10.sp),
          height: 0.63 * Get.width,
          width: double.maxFinite,
          child: Obx(
            () => HomeBarChart(
              minDate: controller.chartMinDate.value,
              maxDate: controller.chartMaxDate.value,
              listChartData: controller.bloodPressureChartData,
              currentSelected: controller.chartXValueSelected.value,
              onSelectChartItem: controller.onSelectedBloodPress,
              groupIndexSelected: controller.chartGroupIndexSelected.value,
              minY: 10,
              maxY: 350,
              horizontalInterval: 50,
            ),
          ),
        ),
        AppTouchable(
          onPressed: controller.onEdit,
          child: Container(
            width: Get.width,
            height: 0.24 * Get.width,
            padding: EdgeInsets.all(14.sp).copyWith(top: 24.sp),
            decoration: const BoxDecoration(
              image: DecorationImage(fit: BoxFit.fill, image: AssetImage(AppImage.ic_box)),
            ),
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat(
                          'MMM dd, yyyy',
                          appController.currentLocale.languageCode,
                        ).format(
                          DateTime.fromMillisecondsSinceEpoch(controller.bloodPressSelected.value.dateTime!),
                        ),
                        style: textStyle14500().copyWith(
                          color: AppColor.black,
                        ),
                      ),
                      Text(
                        DateFormat('hh:mm a', appController.currentLocale.languageCode).format(
                          DateTime.fromMillisecondsSinceEpoch(controller.bloodPressSelected.value.dateTime!),
                        ),
                      )
                    ],
                  ),
                  FittedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${controller.bloodPressSelected.value.systolic}',
                          style: textStyle30600().copyWith(
                            color: AppColor.black,
                          ),
                        ),
                        Text(
                          '${controller.bloodPressSelected.value.diastolic}',
                          style: textStyle30600().copyWith(
                            color: AppColor.black,
                          ),
                        )
                      ],
                    ),
                  ),
                  FittedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: controller.bloodPressSelected.value.bloodType.color,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          padding: EdgeInsets.all(6.sp),
                          child: Text(
                            controller.bloodPressSelected.value.bloodType.name,
                            style: textStyle20600().copyWith(
                              color: AppColor.white,
                            ),
                          ),
                        ),
                        AppTouchable(
                          width: 40.0.sp,
                          height: 40.0.sp,
                          onPressed: controller.onPressDeleteData,
                          child: AppImageWidget.asset(
                            path: AppImage.ic_del,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
