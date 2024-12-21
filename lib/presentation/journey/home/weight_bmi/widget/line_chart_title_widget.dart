import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../theme/app_color.dart';
import '../../../../theme/theme_text.dart';
import '../../../../widget/container_widget.dart';
import '../../widget/home_line_chart_widget/home_line_chart_widget.dart';

class LineChartTitleWidget extends StatelessWidget {
  final String title;
  final DateTime minDate;
  final DateTime maxDate;
  final List<Map> listChartData;
  final int selectedX;
  final int spotIndex;
  final double maxY;
  final double minY;
  final Widget Function(double value, TitleMeta meta)? buildLeftTitle;
  final double? horizontalInterval;
  final Function(int x, int spotIndex, DateTime dateTime)? onPressDot;
  final List<LineTooltipItem?> Function(List<LineBarSpot>)? getTooltipItems;

  const LineChartTitleWidget({
    super.key,
    required this.title,
    required this.minDate,
    required this.maxDate,
    required this.listChartData,
    this.buildLeftTitle,
    required this.selectedX,
    required this.maxY,
    required this.minY,
    this.horizontalInterval,
    this.onPressDot,
    required this.spotIndex,
    this.getTooltipItems,
  });

  @override
  Widget build(BuildContext context) {
    return ContainerWidget(
      width: double.maxFinite,
      height: 0.63 * Get.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20.sp, left: 20.sp),
            child: Text(
              title,
              style: textStyle18500().copyWith(
                color: AppColor.black,
              ),
            ),
          ),
          Expanded(
            child: HomeLineChartWidget(
              listChartData: listChartData,
              minDate: minDate,
              maxDate: maxDate,
              buildLeftTitle: buildLeftTitle,
              maxY: maxY,
              minY: minY,
              selectedX: selectedX,
              spotIndex: spotIndex,
              horizontalInterval: horizontalInterval,
              onPressDot: onPressDot,
              getTooltipItems: getTooltipItems,
              buildDot: (
                FlSpot spotValue,
                double doubleValue,
                LineChartBarData lineChartBarDataValue,
                int intValue,
              ) {
                return FlDotCirclePainter(
                  radius: 7.0.sp,
                  color: selectedX == 0 && spotValue.x == lineChartBarDataValue.spots.last.x
                      ? AppColor.gold
                      : selectedX == spotValue.x
                          ? AppColor.gold
                          : AppColor.green,
                  strokeColor: Colors.transparent,
                  strokeWidth: 1,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
