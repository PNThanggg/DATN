import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../theme/app_color.dart';
import '../../../../theme/theme_text.dart';
import '../../../../widget/container_widget.dart';
import '../../widget/home_bar_chart_widget/home_bar_chart.dart';
import '../blood_sugar_controller.dart';
import 'blood_sugar_detail_widget.dart';
import 'statistical_widget.dart';

class BloodSugarDataWidget extends GetWidget<BloodSugarController> {
  const BloodSugarDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.sp),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 12.sp,
            ),
            Obx(
              () => BloodSugarStatisticalWidget(
                average: controller.rxAverage.value,
                min: controller.rxMin.value,
                max: controller.rxMax.value,
              ),
            ),
            SizedBox(
              height: 12.sp,
            ),
            ContainerWidget(
              height: 0.63 * Get.width,
              width: double.maxFinite,
              padding: EdgeInsets.all(7.sp).copyWith(top: 10.sp),
              child: Obx(
                () => HomeBarChart(
                  minDate: controller.chartMinDate.value,
                  maxDate: controller.chartMaxDate.value,
                  listChartData: controller.chartListData.value,
                  currentSelected: controller.chartXSelected.value,
                  onSelectChartItem: controller.onSelectedBloodPress,
                  groupIndexSelected: controller.chartGroupIndexSelected.value,
                  minY: controller.chartMinValue.value,
                  maxY: controller.chartMaxValue.value,
                  buildLeftTitle: _buildLeftTitle,
                  horizontalInterval: 13,
                ),
              ),
            ),
            const BloodSugarDetailWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildLeftTitle(double value, TitleMeta meta) {
    String text;
    if (controller.chartLeftTitleList.contains(value)) {
      text = '${value.toInt()}';
    } else {
      return const SizedBox();
    }

    return FittedBox(
      child: Text(
        text,
        style: textStyle12400().copyWith(
          color: AppColor.black,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
