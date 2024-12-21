import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../common/util/disable_glow_behavior.dart';
import '../../../../../domain/model/bar_chart_data_model.dart';
import '../../../../theme/app_color.dart';
import 'chart_title_widget/chart_bottom_title_widget.dart';
import 'chart_title_widget/chart_left_title_widget.dart';

class HomeBarChart extends StatelessWidget {
  final DateTime maxDate;
  final DateTime minDate;

  ///
  /// {
  ///   "fromY": 10,
  ///   "toY": 12,
  ///   "date": milisecond
  /// }
  ///
  final List<Map> listChartData;
  final Function(int x, int groupIndex) onSelectChartItem;
  final int currentSelected;
  final double? minY;
  final double? maxY;
  final double? horizontalInterval;
  final int groupIndexSelected;
  final Widget Function(double value, TitleMeta meta)? buildLeftTitle;

  const HomeBarChart({
    super.key,
    required this.maxDate,
    required this.minDate,
    required this.listChartData,
    required this.onSelectChartItem,
    required this.currentSelected,
    required this.groupIndexSelected,
    this.minY,
    this.maxY,
    this.horizontalInterval,
    this.buildLeftTitle,
  });

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const DisableGlowBehavior(),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(top: 12.0.sp),
        scrollDirection: Axis.horizontal,
        child: Container(
          width: (maxDate.difference(minDate).inDays + 2) * 40.0.sp,
          constraints: BoxConstraints(minWidth: Get.width / 7 * 6),
          child: BarChart(
            BarChartData(
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                getDrawingHorizontalLine: (value) => FlLine(
                  color: AppColor.gray2,
                  strokeWidth: 1.sp,
                ),
                horizontalInterval: horizontalInterval,
              ),
              minY: minY,
              maxY: maxY,
              alignment: BarChartAlignment.spaceAround,
              borderData: FlBorderData(
                show: false,
              ),
              barTouchData: barTouchData,
              titlesData: titlesData,
              barGroups: barGroups,
            ),
            swapAnimationDuration: const Duration(milliseconds: 200),
          ),
        ),
      ),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30.sp,
            getTitlesWidget: (value, meta) => ChartBottomTitleWidget(
              minDate: minDate,
              maxDate: maxDate,
              listChartData: listChartData,
              value: value,
              meta: meta,
            ),
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            getTitlesWidget: buildLeftTitle ?? _buildLeftTitle,
            showTitles: true,
            interval: 1,
            reservedSize: 16.0.sp,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchCallback: (event, response) =>
            onSelectChartItem(response?.spot?.spot.x.toInt() ?? 0, response?.spot?.touchedRodDataIndex ?? 0),
        touchTooltipData: BarTouchTooltipData(
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8.sp,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  List<BarChartGroupData> get barGroups => listChartData.map((e) {
        final values = e['values'] as List<BarChartDataModel>;

        return BarChartGroupData(
          x: e['dateTime'],
          barRods: _getBarChartRodData(values, e['dateTime']),
        );
      }).toList();

  Widget _buildLeftTitle(double value, TitleMeta meta) {
    return ChartLeftTitleWidget(value: value);
  }

  List<BarChartRodData> _getBarChartRodData(List<BarChartDataModel> charData, int key) {
    final chartRodDataList = <BarChartRodData>[];
    for (int i = 0; i < charData.length; i++) {
      final data = charData[i];
      chartRodDataList.add(
        BarChartRodData(
          toY: data.toY,
          fromY: data.fromY,
          color: currentSelected == key && groupIndexSelected == i ? AppColor.yellow : AppColor.green,
        ),
      );
    }
    return chartRodDataList;
  }
}
