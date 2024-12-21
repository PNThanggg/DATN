import 'package:get/get.dart';

import '../../../domain/usecase/alarm_usecase.dart';
import '../../../domain/usecase/bmi_usecase.dart';
import '../../../presentation/journey/home/weight_bmi/add_weight_bmi/add_weight_bmi_controller.dart';
import '../../../presentation/journey/home/weight_bmi/weight_bmi_controller.dart';
import '../app_di.dart';

class WeightBMIBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      WeightBMIController(
        getIt<BMIUseCase>(),
        getIt<AlarmUseCase>(),
      ),
    );
    Get.put(
      AddWeightBMIController(
        getIt<BMIUseCase>(),
      ),
    );
  }
}
