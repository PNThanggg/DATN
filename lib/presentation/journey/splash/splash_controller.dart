import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/constants/app_constant.dart';
import '../../../common/constants/app_route.dart';
import '../../controller/app_controller.dart';

class SplashController extends GetxController {
  late BuildContext context;
  RxString version = ''.obs;
  final AppController appController = Get.find<AppController>();
  bool isFirstOpenApp = true;

  @override
  void onReady() async {
    super.onReady();

    final prefs = await SharedPreferences.getInstance();
    String? language = prefs.getString('language');
    isFirstOpenApp = prefs.getBool("is_first_open_app") ?? true;
    appController.userLocation.value = prefs.getString("user_location") ?? "US";

    appController.updateLocale(
      AppConstant.availableLocales[int.tryParse(language ?? '') ?? 1],
    );
    await appController.getUser();

    Get.offAndToNamed(AppRoute.mainScreen);
  }
}
