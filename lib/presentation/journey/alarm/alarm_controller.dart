import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../common/mixin/alarm_dialog_mixin.dart';
import '../../../common/util/show_snack_bar.dart';
import '../../../common/util/translation/app_translation.dart';
import '../../../domain/model/alarm_model.dart';
import '../../../domain/usecase/alarm_usecase.dart';

class AlarmController extends GetxController with AlarmDialogMixin {
  final AlarmUseCase alarmUseCase;

  RxList<AlarmModel> alarmList = <AlarmModel>[].obs;

  AlarmController({required this.alarmUseCase});

  @override
  void onInit() {
    alarmUseCase.getAlarms().then((value) => alarmList.value = value);
    super.onInit();
  }

  void onPressDeleteAlarm(alarmModel) async {
    showConfirmDeleteAlarmDialog(Get.context!, alarmModel: alarmModel, onPressConfirm: (alarmModel) async {
      deleteAlarm(alarmModel);
      Get.back();
    });
  }

  void deleteAlarm(AlarmModel alarmModel) async {
    try {
      // final index = alarmList.indexWhere((element) => element.id == alarmModel.id);
      await alarmUseCase.removeAlarm(alarmModel);
      refresh();
      showSnackBar(
        Get.context!,
        subtitle: TranslationConstants.deleteAlarmSuccess.tr,
        type: SnackBarType.success,
      );
    } on Exception catch (_) {
      showSnackBar(
        Get.context!,
        subtitle: TranslationConstants.deleteAlarmFailed.tr,
        type: SnackBarType.error,
      );
    }
  }

  @override
  void refresh() async {
    alarmList.value = await alarmUseCase.getAlarms();
  }

  void addAlarm(AlarmModel alarmModel) async {
    try {
      alarmUseCase.addAlarm(alarmModel);
      refresh();
      showSnackBar(
        Get.context!,
        subtitle: TranslationConstants.addAlarmSuccess.tr,
        type: SnackBarType.success,
      );
    } on Exception catch (_) {
      showSnackBar(
        Get.context!,
        subtitle: TranslationConstants.addAlarmFailed.tr,
        type: SnackBarType.error,
      );
    }
  }

  void updateAlarm(AlarmModel alarmModel) {
    log("updateAlarm.alarmModel.id: ${alarmModel.id}");
    for (final AlarmModel model in alarmList) {
      log("updateAlarm.model: ${model.id}");
    }
    try {
      alarmUseCase.updateAlarm(alarmModel);
      refresh();
      showSnackBar(
        Get.context!,
        subtitle: TranslationConstants.updateAlarmSuccess.tr,
        type: SnackBarType.success,
      );
    } on Exception catch (_) {
      showSnackBar(
        Get.context!,
        subtitle: TranslationConstants.updateAlarmFailed.tr,
        type: SnackBarType.error,
      );
    }
  }

  void onPressEditAlarm(BuildContext context, AlarmModel alarmModel) {
    showEditAlarm(
      context: context,
      alarmModel: alarmModel,
      onPressSave: (alarmModel) {
        updateAlarm(alarmModel);
        Get.back();
      },
    );
  }
}
