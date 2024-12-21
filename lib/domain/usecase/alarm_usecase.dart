import 'dart:convert';

import 'package:datn/common/util/extensions/datetime_extension.dart';
import 'package:datn/domain/enum/alarm_type.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../common/util/app_notification_local.dart';
import '../../common/util/translation/app_translation.dart';
import '../../data/local_repository.dart';
import '../model/alarm_model.dart';

class AlarmUseCase {
  final LocalRepository localRepository;

  const AlarmUseCase({required this.localRepository});

  Future<void> addAlarm(AlarmModel alarmModel) async {
    _addAlarmNotification(alarmModel);

    await localRepository.addAlarm(alarmModel);
  }

  Future<void> removeAlarm(AlarmModel alarmModel) async {
    for (int i = 0; i < alarmModel.alarmDays!.length; i++) {
      if (alarmModel.alarmDays![i]) {
        final notiId = alarmModel.id.hashCode + i + 1;
        await AppNotificationLocal.cancelScheduleNotification(notiId);
      }
    }
    await localRepository.removeAlarm(alarmModel);
  }

  Future<void> updateAlarm(AlarmModel alarmModel) async {
    await localRepository.updateAlarm(alarmModel);
    for (int i = 0; i < alarmModel.alarmDays!.length; i++) {
      final notiId = alarmModel.id.hashCode + i + 1;
      await AppNotificationLocal.cancelScheduleNotification(notiId);
    }
    _addAlarmNotification(alarmModel);
    AppNotificationLocal.cancelScheduleNotification(alarmModel.id.hashCode);
  }

  Future<List<AlarmModel>> getAlarms() async {
    return localRepository.getAlarms();
  }

  void _addAlarmNotification(AlarmModel alarmModel) async {
    for (int index = 0; index < alarmModel.alarmDays!.length; index++) {
      final bool isSelected = alarmModel.alarmDays![index];
      if (isSelected) {
        final int weekday = index + 1;
        final currentTimeZone = await FlutterTimezone.getLocalTimezone();
        final currentLocation = tz.getLocation(currentTimeZone);
        final DateTime tzNow = tz.TZDateTime.now(
          tz.getLocation(currentTimeZone),
        );
        final nextWeekDay = tzNow.next(weekday);
        final scheduledDate = tz.TZDateTime(
          currentLocation,
          nextWeekDay.year,
          nextWeekDay.month,
          nextWeekDay.day,
          alarmModel.time!.hour,
          alarmModel.time!.minute,
        );
        final androidBitMap = await AppNotificationLocal.getImageBytes(
          alarmModel.type!.icon,
        );
        final payload = {
          "type": "alarm",
          "route": alarmModel.type!.notificationRoute,
        };
        AppNotificationLocal.setupNotification(
          title: TranslationConstants.trackYourHealth.tr,
          content: alarmModel.type!.trNotiDes,
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
