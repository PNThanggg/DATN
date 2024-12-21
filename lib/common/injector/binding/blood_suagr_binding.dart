import 'package:get/get.dart';

import '../../../domain/usecase/alarm_usecase.dart';
import '../../../domain/usecase/blood_sugar_usecase.dart';
import '../../../presentation/journey/home/blood_sugar/add_blood_sugar_dialog/add_blood_sugar_controller.dart';
import '../../../presentation/journey/home/blood_sugar/blood_sugar_controller.dart';
import '../app_di.dart';

class BloodSugarBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      BloodSugarController(
        getIt<BloodSugarUseCase>(),
        getIt<AlarmUseCase>(),
      ),
    );

    Get.put(
      AddBloodSugarController(
        getIt<BloodSugarUseCase>(),
      ),
    );
  }
}
