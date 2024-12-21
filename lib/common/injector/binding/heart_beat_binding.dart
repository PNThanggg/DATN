import 'package:get/get.dart';

import '../../../presentation/journey/home/heart_beat/heart_beat_controller.dart';
import '../../../presentation/journey/home/heart_beat/measure/measure_controller.dart';

class HeartBeatBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HeartBeatController());
  }
}

class MeasureBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MeasureController());
  }
}
