import 'package:datn/common/extensions/date_time_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../presentation/controller/app_controller.dart';

mixin AddDateTimeMixin {
  RxString stringBloodPrDate = "".obs;
  RxString stringBloodPrTime = "".obs;
  DateTime bloodPressureDate = DateTime.now();

  Future onSelectAddDate(DateTime? value) async {
    if (value != null) {
      bloodPressureDate = bloodPressureDate.update(
        year: value.year,
        month: value.month,
        day: value.day,
      );
      updateDateTimeString(bloodPressureDate);
    }
  }

  void updateDateTimeString(DateTime? dateTime) {
    if (dateTime != null) {
      stringBloodPrTime.value = DateFormat(
        'h:mm a',
        Get.find<AppController>().currentLocale.languageCode,
      ).format(dateTime);
      stringBloodPrDate.value = DateFormat(
        'MMM dd, yyyy',
        Get.find<AppController>().currentLocale.languageCode,
      ).format(dateTime);
    }
  }

  Future onSelectAddTime(TimeOfDay? value) async {
    if (value != null) {
      bloodPressureDate = bloodPressureDate.update(
        hour: value.hour,
        minute: value.minute,
      );
      updateDateTimeString(bloodPressureDate);
    }
  }
}
