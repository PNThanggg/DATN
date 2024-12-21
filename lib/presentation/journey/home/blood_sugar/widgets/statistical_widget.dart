import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../common/util/translation/app_translation.dart';
import '../../../../theme/theme_text.dart';
import '../../../../widget/container_widget.dart';

class BloodSugarStatisticalWidget extends StatelessWidget {
  final double average;
  final double min;
  final double max;

  const BloodSugarStatisticalWidget({
    super.key,
    required this.average,
    required this.min,
    required this.max,
  });

  Widget _buildItemWidget({required String title, required double value}) {
    return Expanded(
      child: Column(
        children: [
          Text(title, style: textStyle18400()),
          Text(
            '$value',
            style: textStyle22700(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ContainerWidget(
      padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 20.sp),
      child: Row(
        children: [
          _buildItemWidget(title: TranslationConstants.average.tr, value: average),
          _buildItemWidget(title: TranslationConstants.min.tr, value: min),
          _buildItemWidget(title: TranslationConstants.max.tr, value: max),
        ],
      ),
    );
  }
}
