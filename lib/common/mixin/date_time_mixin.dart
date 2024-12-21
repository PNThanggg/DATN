import 'package:datn/common/extensions/date_time_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../presentation/controller/app_controller.dart';
import '../../presentation/theme/app_color.dart';

mixin DateTimeMixin {
  Rx<DateTime> filterStartDate = DateTime.now().update(day: 1).obs;
  Rx<DateTime> filterEndDate = DateTime.now().update(hour: 23, minute: 59, second: 59).obs;

  Future<TimeOfDay?> onSelectTime({
    required BuildContext context,
    required TimeOfDay initialTime,
    TimePickerEntryMode? mode,
    Color? primaryColor,
  }) {
    return showTimePicker(
      context: context,
      initialTime: initialTime,
      initialEntryMode: mode ?? TimePickerEntryMode.dialOnly,
      builder: (context, child) => Theme(
        data: ThemeData(
          colorScheme: ColorScheme.light(
            onPrimary: AppColor.white,
            primary: primaryColor ?? AppColor.primaryColor,
          ),
        ),
        child: child!,
      ),
    );
  }

  Future<DateTime?> onSelectDate({
    required BuildContext context,
    required DateTime initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    DatePickerEntryMode? mode,
    Locale? locale,
    Color? primaryColor,
  }) {
    return showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      locale: locale ?? Get.find<AppController>().currentLocale,
      builder: (context, Widget? child) => Theme(
        data: ThemeData(
          colorScheme: ColorScheme.light(
            onPrimary: AppColor.white,
            primary: primaryColor ?? AppColor.primaryColor,
          ),
        ),
        child: child!,
      ),
    );
  }

  Future<DateTimeRange?> onSelectDateRange({
    required BuildContext context,
    required DateTimeRange initialDateRange,
    DateTime? firstDate,
    DateTime? lastDate,
    Locale? locale,
    Color? primaryColor,
  }) {
    return showDateRangePicker(
      context: context,
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime.now(),
      initialDateRange: initialDateRange,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      locale: locale ?? Get.find<AppController>().currentLocale,
      builder: (context, Widget? child) => Theme(
        data: ThemeData(
          colorScheme: ColorScheme.light(
            onPrimary: AppColor.white,
            primary: primaryColor ?? AppColor.primaryColor,
          ),
        ),
        child: child!,
      ),
    );
  }

  Future onPressDateRange(BuildContext context, {Function()? callback}) async {
    DateTimeRange? result = await onSelectDateRange(
        context: context,
        initialDateRange: DateTimeRange(
          start: filterStartDate.value,
          end: filterEndDate.value,
        ));
    if (result != null) {
      filterStartDate.value = DateTime(result.start.year, result.start.month, result.start.day);
      filterEndDate.value = DateTime(result.end.year, result.end.month, result.end.day, 23, 59, 59);
      callback?.call();
    }
  }
}
