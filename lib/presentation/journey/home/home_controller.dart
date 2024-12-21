import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/constants/app_route.dart';
import '../../../data/native_bridge.dart';

class HomeController extends GetxController {
  @override
  void onReady() {
    super.onReady();

    _showPopupAddWidget();
  }

  void _showPopupAddWidget() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var flag = pref.getBool("auto_add_home_widget");

    debugPrint("auto_add_home_widget: ${flag.toString()}");

    if (flag == null || flag == false) {
      pref.setBool("auto_add_home_widget", true);
      await NativeBridge.getInstance().homeWidget();
    }
  }

  void onPressHeartBeat() async {
    Get.toNamed(AppRoute.heartBeatScreen);
  }

  void onPressBloodPressure() async {
    Get.toNamed(AppRoute.bloodPressureScreen);
  }

  void onPressBloodSugar() async {
    Get.toNamed(AppRoute.bloodSugar);
  }

  void onPressWeightAndBMI() async {
    Get.toNamed(AppRoute.weightBMI);
  }

  void onPressFoodScanner() async {
    Get.toNamed(AppRoute.foodScanner);
  }

  void onPressChat() {
    Get.toNamed(AppRoute.chatScreen);
  }
}
