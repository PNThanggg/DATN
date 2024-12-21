import 'package:flutter/material.dart';

import '../../../../../theme/app_color.dart';
import '../../../../../theme/theme_text.dart';

class ChartLeftTitleWidget extends StatelessWidget {
  final double value;

  const ChartLeftTitleWidget({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
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
      case 300:
        text = '300';
        break;
      default:
        return const SizedBox.shrink();
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
