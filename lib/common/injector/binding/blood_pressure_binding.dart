import 'package:get/get.dart';

import '../../../domain/usecase/alarm_usecase.dart';
import '../../../domain/usecase/blood_pressure_usecase.dart';
import '../../../presentation/journey/home/blood_pressure/add_blood_pressure/add_blood_pressure_controller.dart';
import '../../../presentation/journey/home/blood_pressure/blood_pressure_controller.dart';
import '../app_di.dart';

class BloodPressureBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      BloodPressureController(
        getIt<BloodPressureUseCase>(),
        getIt<AlarmUseCase>(),
      ),
    );

    Get.put(
      AddBloodPressureController(
        getIt<BloodPressureUseCase>(),
      ),
    );
  }
}
