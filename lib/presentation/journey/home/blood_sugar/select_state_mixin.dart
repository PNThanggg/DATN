import 'package:get/get.dart';

import '../../../../common/constants/app_constant.dart';

mixin SelectStateMixin {
  RxString rxSelectedState = BloodSugarStateCode.defaultCode.obs;

  void onSelectState(String stateCode) {
    rxSelectedState.value = stateCode.tr;
  }
}