import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../../../common/util/app_notification_local.dart';
import '../../controller/app_controller.dart';

class MainController extends GetxController {
  RxInt currentTab = 0.obs;
  AppController appController = Get.find<AppController>();

  void onPressTab(int index) {
    currentTab.value = index;
  }

  @override
  void onReady() async {
    FlutterLocalNotificationsPlugin().getNotificationAppLaunchDetails().then((details) {
      if (details != null && details.didNotificationLaunchApp && details.notificationResponse != null) {
        AppNotificationLocal.onTapNotification(details.notificationResponse!);
      }
    });

    super.onReady();
  }
}
