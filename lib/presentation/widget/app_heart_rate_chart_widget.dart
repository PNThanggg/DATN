import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../common/util/disable_glow_behavior.dart';
import '../theme/app_color.dart';

class AppHeartRateChartWidget extends StatelessWidget {
  final List<Map>? listChartData;
  final DateTime? minDate;
  final DateTime? maxDate;
  final double? selectedX;
  final Function(double x, DateTime dateTime)? onPressDot;

  const AppHeartRateChartWidget({
    super.key,
    required this.listChartData,
    required this.minDate,
    required this.maxDate,
    this.selectedX,
    this.onPressDot,
  });

  LineChartBarData generateLineChartBarData() {
    List<FlSpot> listFlSpot = [];
    for (final item in listChartData!) {
      listFlSpot.add(
        FlSpot(
          (minDate!.difference(item['date']!).inDays.toDouble()).abs() + 1,
          item['value'].toDouble(),
        ),
      );
    }
    listFlSpot.sort((a, b) => a.x.compareTo(b.x));
    return LineChartBarData(
      isCurved: true,
      color: AppColor.black,
      barWidth: 1,
      isStrokeCapRound: true,
      dotData: FlDotData(
          show: true,
          getDotPainter: (spotValue, doubleValue, lineChartBarDataValue, intValue) {
            Color color = AppColor.primaryColor;
            if (spotValue.y < 60) {
              color = AppColor.violet;
            } else if (spotValue.y > 100) {
              color = AppColor.red;
            } else {
              color = AppColor.green;
            }
            return FlDotCirclePainter(
              radius: 7.0.sp,
              color: (selectedX ?? 0) == 0 && spotValue.x == listFlSpot.last.x
                  ? AppColor.gold
                  : selectedX == spotValue.x
                      ? AppColor.gold
                      : color,
              strokeColor: Colors.transparent,
              strokeWidth: 1,
            );
          }),
      belowBarData: BarAreaData(show: false),
      spots: listFlSpot,
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    TextStyle style = TextStyle(
      color: AppColor.black,
      fontWeight: FontWeight.w500,
      fontSize: 12.0.sp,
    );
    Widget text = const SizedBox.shrink();
    DateTime dateTime = DateTime(minDate!.year, minDate!.month, minDate!.day);
    while (!dateTime.isAfter(maxDate!)) {
      if (dateTime.difference(minDate!).inDays + 1 == value.toInt()) {
        for (final item in listChartData!) {
          if (dateTime.isAtSameMomentAs(item['date'])) {
            text = Text(DateFormat('dd/MM').format(dateTime), style: style);
            break;
          }
        }
        break;
      }
      dateTime = dateTime.add(const Duration(days: 1));
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10.0.sp,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    TextStyle style = TextStyle(
      color: AppColor.black,
      fontWeight: FontWeight.w400,
      fontSize: 12.0.sp,
    );
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

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 40.0.sp,
      );

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  LineTouchData get lineTouchData1 => LineTouchData(
      enabled: false,
      handleBuiltInTouches: false,
      touchCallback: (flTouchEvent, touchResponse) {
        if ((touchResponse?.lineBarSpots ?? []).isNotEmpty) {
          final value = touchResponse?.lineBarSpots![0].x;
          DateTime dateTime = minDate!.add(Duration(days: (value ?? 1).toInt() - 1));
          if (onPressDot != null) {
            onPressDot!(value!, dateTime);
          }
        }
      },
      getTouchedSpotIndicator: (LineChartBarData barData, List<int> indicators) {
        return indicators.map((int index) {
          var lineColor = barData.gradient?.colors.first ?? barData.color;
          if (barData.dotData.show) {
            lineColor = Colors.transparent;
          }
          const lineStrokeWidth = 4.0;
          final flLine = FlLine(color: lineColor, strokeWidth: lineStrokeWidth);
          final dotData = FlDotData(
            getDotPainter: (spot, percent, bar, index) => FlDotCirclePainter(
              radius: 7.0.sp,
              color: Colors.transparent,
              strokeColor: Colors.transparent,
            ),
          );

          return TouchedSpotIndicatorData(flLine, dotData);
        }).toList();
      });

  FlGridData get gridData => const FlGridData(
        drawHorizontalLine: true,
        drawVerticalLine: false,
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Colors.transparent),
          left: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      );

  List<LineChartBarData> get lineBarsData1 => [
        generateLineChartBarData(),
      ];

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const DisableGlowBehavior(),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(top: 12.0.sp),
        scrollDirection: Axis.horizontal,
        child: Container(
          width: (maxDate!.difference(minDate!).inDays + 2) * 40.0.sp,
          constraints: BoxConstraints(minWidth: Get.width / 7 * 6),
          child: LineChart(
            LineChartData(
              lineTouchData: lineTouchData1,
              gridData: gridData,
              titlesData: titlesData1,
              borderData: borderData,
              lineBarsData: lineBarsData1,
              minX: 0,
              maxX: maxDate!.difference(minDate!).inDays + 2,
              maxY: 251,
              minY: 40,
            ),
          ),
        ),
      ),
    );
  }
}
