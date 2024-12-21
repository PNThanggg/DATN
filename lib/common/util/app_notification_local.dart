import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;

class AppNotificationConstants {
  static const int standUpId = 0;
  static const int sleep = 300;
  static const int cye = 100;
  static const int drinkWater = 200;
  static const int quoteId = 500;
}

class AppNotificationLocal {
  static Future<ByteArrayAndroidBitmap> getImageBytes(String imageUrl) async {
    final Uint8List bytes = (await rootBundle.load(imageUrl)).buffer.asUint8List();
    final ByteArrayAndroidBitmap androidBitMap = ByteArrayAndroidBitmap.fromBase64String(
      base64.encode(bytes),
    );
    return androidBitMap;
  }

  static void setupNotification({
    required String title,
    required String content,
    required tz.TZDateTime scheduleDateTime,
    required int notiId,
    String? androidIconPath,
    AndroidBitmap<Object>? largeIcon,
    DateTimeComponents? matchDateTimeComponents,
    String? payload,
  }) async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    flutterLocalNotificationsPlugin.zonedSchedule(
      notiId,
      title,
      content,
      scheduleDateTime,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'blood_pressure_notiId',
          'Blood Pressure Notifications',
          channelDescription: 'Blood Pressure Notifications Des',
          icon: androidIconPath ?? "@mipmap/ic_launcher",
          priority: Priority.high,
          importance: Importance.max,
          largeIcon: largeIcon,
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
          sound: "default",
        ),
      ),
      payload: payload,
      androidScheduleMode: AndroidScheduleMode.exact,
      matchDateTimeComponents: matchDateTimeComponents ?? DateTimeComponents.dayOfMonthAndTime,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
    debugPrint('-------Notification Added with ID: $notiId--------');
  }

  static Future<void> cancelScheduleNotification(int notiId) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin.cancel(notiId);
    debugPrint("-------Notification removed with ID: $notiId-------");
  }

  static onDidReceiveLocalNotification(i1, s1, s2, s3) {}

  static void initNotificationLocal() async {
    if (Permission.notification.isBlank == true) {
      await Permission.notification.request();
    }
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onTapNotification,
    );

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static void onTapNotification(NotificationResponse notificationResponse) {
    final payload = notificationResponse.payload;
    if (payload != null) {
      final data = jsonDecode(payload) as Map<String, dynamic>;
      if (data["route"] != null) {
        Get.toNamed(data["route"] as String);
      }
    }
  }
}
