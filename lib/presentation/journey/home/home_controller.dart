import 'package:get/get.dart';

import '../../../common/constants/app_route.dart';

class HomeController extends GetxController {
  void onPressHeartBeat() async {
    Get.toNamed(AppRoute.heartBeatScreen);
  }

  void onPressBloodPressure() async {
    Get.toNamed(AppRoute.bloodPressureScreen);
  }

  void onPressWeightAndBMI() async {
    Get.toNamed(AppRoute.weightBMI);
  }

  void onPressFoodScanner() async {
    Get.toNamed(AppRoute.foodScanner);
  }
}
