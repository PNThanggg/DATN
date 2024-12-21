import 'package:get/get.dart';

import '../../../presentation/journey/home/food_scanner/food_scanner_controller.dart';

class FoodScannerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FoodScannerController());
  }
}