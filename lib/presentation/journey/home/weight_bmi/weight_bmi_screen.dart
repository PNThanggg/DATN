import 'package:datn/presentation/journey/home/weight_bmi/weight_bmi_controller.dart';
import 'package:datn/presentation/journey/home/weight_bmi/widget/bmi_detail_widget.dart';
import 'package:datn/presentation/journey/home/weight_bmi/widget/line_chart_title_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../common/constants/app_image.dart';
import '../../../../common/util/translation/app_translation.dart';
import '../../../../domain/enum/bmi_type.dart';
import '../../../controller/app_controller.dart';
import '../../../theme/app_color.dart';
import '../../../theme/theme_text.dart';
import '../../../widget/app_container.dart';
import '../../../widget/app_header.dart';
import '../../../widget/filter/filter_date_widget.dart';
import '../widget/alarm_add_data_button.dart';
import '../widget/empty_widget.dart';

class WeightBMIScreen extends GetView<WeightBMIController> {
  const WeightBMIScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    final AppController appController = Get.find<AppController>();

    return AppContainer(
      child: Column(
        children: [
          AppHeader(
            title: TranslationConstants.weightAndBMI.tr,
            decoration: BoxDecoration(
              color: AppColor.green,
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
              onPressed: Get.back,
            ),
            extendWidget: Obx(
              () => FilterDateWidget(
                startDate: controller.filterStartDate.value,
                endDate: controller.filterEndDate.value,
                onPressed: () => controller.onPressDateRange(
                  context,
                  callback: controller.filterWeightBMI,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Obx(
                    () {
                      if (controller.bmiList.isNotEmpty) {
                        return SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.sp).copyWith(top: 16.sp),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                LineChartTitleWidget(
                                  title: '${TranslationConstants.weight.tr} (${controller.weightUnit.value.name})',
                                  minDate: controller.chartMinDate.value,
                                  maxDate: controller.chartMaxDate.value,
                                  listChartData: controller.weightChartListData,
                                  buildLeftTitle: _buildLeftTitleWeightChart,
                                  horizontalInterval: 50,
                                  selectedX: controller.chartSelectedX.value,
                                  spotIndex: controller.spotIndex.value,
                                  getTooltipItems: _getToolTipItems,
                                  onPressDot: (value, spotIndex, dateTime) {
                                    controller.chartSelectedX.value = value;
                                    controller.spotIndex.value = spotIndex;
                                    controller.currentBMI.value = controller.bmiList[spotIndex];
                                  },
                                  maxY: 300,
                                  minY: 10,
                                ),
                                Obx(
                                  () => BMIDetailWidget(
                                    date: DateFormat(
                                      'MMM dd, yyyy',
                                      appController.currentLocale.languageCode,
                                    ).format(DateTime.now()),
                                    time: DateFormat('hh:mm a', appController.currentLocale.languageCode)
                                        .format(DateTime.now()),
                                    bmi: controller.currentBMI.value.bmi ?? 0,
                                    weight: controller.currentBMI.value.weightKg.toInt(),
                                    height: controller.currentBMI.value.heightCm.toInt(),
                                    bmiType: controller.currentBMI.value.type,
                                    onEdit: controller.onEditBMI,
                                    onDelete: controller.onDeleteBMI,
                                  ),
                                ),
                                LineChartTitleWidget(
                                  title: TranslationConstants.bmi.tr,
                                  minDate: controller.chartMinDate.value,
                                  maxDate: controller.chartMaxDate.value,
                                  listChartData: controller.bmiChartListData,
                                  maxY: 50,
                                  minY: 5,
                                  buildLeftTitle: _buildLeftTitleBMIChart,
                                  getTooltipItems: _getToolTipItems,
                                  onPressDot: (value, spotIndex, date) {
                                    controller.chartSelectedX.value = value;
                                    controller.spotIndex.value = spotIndex;
                                    controller.currentBMI.value = controller.bmiList[spotIndex];
                                  },
                                  selectedX: controller.chartSelectedX.value,
                                  spotIndex: controller.spotIndex.value,
                                ),
                                SizedBox(
                                  height: 16.sp,
                                )
                              ],
                            ),
                          ),
                        );
                      } else {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.sp),
                          child: EmptyWidget(
                            imagePath: AppImage.weight_scale_lottie,
                            message: TranslationConstants.addYourRecordToSeeStatistics.tr,
                            imageWidth: 0.37 * Get.width,
                          ),
                        );
                      }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.sp,
                  ).copyWith(
                    bottom: 16.sp,
                  ),
                  child: AlarmAddDataButton(
                    onSetAlarm: controller.onSetAlarm,
                    onAddData: controller.onAddData,
                  ),
                ),
              ],
            ),
          ),
          Obx(
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
                    titleColor: AppColor.green,
                    onPressed: controller.exportData,
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeftTitleBMIChart(double value, TitleMeta mate) {
    String text;
    switch (value.toInt()) {
      case 10:
        text = '10';
        break;
      case 15:
        text = '15';
        break;
      case 20:
        text = '20';
        break;
      case 25:
        text = '25';
        break;
      case 30:
        text = '30';
        break;
      case 35:
        text = '35';
        break;
      case 40:
        text = '40';
        break;
      case 45:
        text = '45';
        break;
      default:
        return const SizedBox.shrink();
    }

    return Text(
      text,
      style: textStyle12500().copyWith(color: AppColor.black),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildLeftTitleWeightChart(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 50:
        text = '50';
        break;
      case 100:
        text = '100';
        break;
      case 150:
        text = '150';
        break;
      case 200:
        text = '200';
        break;
      case 250:
        text = '250';
        break;
      default:
        return const SizedBox.shrink();
    }

    return Text(
      text,
      style: textStyle12500().copyWith(color: AppColor.black),
      textAlign: TextAlign.center,
    );
  }

  List<LineTooltipItem?> _getToolTipItems(List<LineBarSpot> lineBarSpots) {
    return lineBarSpots.map((lineBarSpot) {
      final bmiMap = controller.bmiChartListData[lineBarSpot.spotIndex];
      final int bmi = bmiMap["value"];
      final BMIType bmiType = BMITypeEnum.getBMITypeByValue(bmi);
      return LineTooltipItem(
        bmiType.bmiName,
        const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      );
    }).toList();
  }
}