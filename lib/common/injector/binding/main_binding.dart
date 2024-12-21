import 'package:get/get.dart';

import '../../../domain/usecase/alarm_usecase.dart';
import '../../../presentation/journey/alarm/alarm_controller.dart';
import '../../../presentation/journey/alarm/widgets/alarm_add_button_controller.dart';
import '../../../presentation/journey/alarm/widgets/alarm_dialog_controller.dart';
import '../../../presentation/journey/home/home_controller.dart';
import '../../../presentation/journey/insight/insight_controller.dart';
import '../../../presentation/journey/main/main_controller.dart';
import '../app_di.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MainController());
    Get.put(HomeController());
    Get.put(InsightController());
    Get.put(
      AlarmController(
        alarmUseCase: getIt.get<AlarmUseCase>(),
      ),
    );
    Get.put(AlarmAddButtonController());
    Get.put(AlarmDialogController());
  }
}
