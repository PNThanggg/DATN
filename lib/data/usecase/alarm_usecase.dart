import 'dart:convert';

import 'package:datn/core/core.dart';
import 'package:datn/data/enum/alarm_type.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:timezone/timezone.dart' as tz;

import '../model/alarm_model.dart';
import 'local_repository.dart';

class AlarmUseCase {
  AlarmUseCase._();

  static Future<void> addAlarm(AlarmModel alarmModel) async {
    _addAlarmNotification(alarmModel);

    await LocalRepository.addAlarm(alarmModel);
  }

  static Future<void> removeAlarm(AlarmModel alarmModel) async {
    for (int i = 0; i < alarmModel.alarmDays!.length; i++) {
      if (alarmModel.alarmDays![i]) {
        final notiId = alarmModel.id.hashCode + i + 1;
        await AppNotificationLocal.cancelScheduleNotification(notiId);
      }
    }

    await LocalRepository.removeAlarm(alarmModel);
  }

  static Future<void> updateAlarm(AlarmModel alarmModel) async {
    await LocalRepository.updateAlarm(alarmModel);
    for (int i = 0; i < alarmModel.alarmDays!.length; i++) {
      final notiId = alarmModel.id.hashCode + i + 1;
      await AppNotificationLocal.cancelScheduleNotification(notiId);
    }
    _addAlarmNotification(alarmModel);
    AppNotificationLocal.cancelScheduleNotification(alarmModel.id.hashCode);
  }

  static Future<List<AlarmModel>> getAlarms() async {
    return LocalRepository.getAlarms();
  }

  static void _addAlarmNotification(AlarmModel alarmModel) async {
    for (int index = 0; index < alarmModel.alarmDays!.length; index++) {
      final bool isSelected = alarmModel.alarmDays![index];
      if (isSelected) {
        final int weekday = index + 1;
        final currentTimeZone = await FlutterTimezone.getLocalTimezone();
        final currentLocation = tz.getLocation(currentTimeZone);
        final DateTime tzNow = tz.TZDateTime.now(tz.getLocation(currentTimeZone));
        final nextWeekDay = tzNow.next(weekday);
        final scheduledDate = tz.TZDateTime(
          currentLocation,
          nextWeekDay.year,
          nextWeekDay.month,
          nextWeekDay.day,
          alarmModel.time.hour,
          alarmModel.time.minute,
        );
        final androidBitMap = await AppNotificationLocal.getImageBytes(
          alarmModel.type.icon,
        );
        final payload = {
          "type": "alarm",
          "route": alarmModel.type.notificationRoute,
        };

        AppNotificationLocal.setupNotification(
          title: TranslationConstants.trackYourHealth.tr,
          content: alarmModel.type.trNotiDes,
          scheduleDateTime: scheduledDate,
          notiId: alarmModel.id.hashCode + index + 1,
          matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
          largeIcon: androidBitMap,
          payload: jsonEncode(payload),
        );
      }
    }
  }
}
