import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controller/app_controller.dart';
import 'filter_widget.dart';

class FilterDateWidget extends StatelessWidget {
  final Function()? onPressed;
  final DateTime startDate;
  final DateTime endDate;

  const FilterDateWidget({
    super.key,
    this.onPressed,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    final appController = Get.find<AppController>();
    return FilterWidget(
      onPressed: onPressed,
      title: '${DateFormat(
        'MMM dd, yyyy',
        appController.currentLocale.languageCode,
      ).format(startDate)} - ${DateFormat(
        'MMM dd, yyyy',
        appController.currentLocale.languageCode,
      ).format(endDate)}',
    );
  }
}
