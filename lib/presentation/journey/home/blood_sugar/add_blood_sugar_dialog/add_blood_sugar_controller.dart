import 'package:datn/common/extensions/date_time_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../../../common/constants/app_constant.dart';
import '../../../../../common/constants/enums.dart';
import '../../../../../common/mixin/add_date_time_mixin.dart';
import '../../../../../common/mixin/date_time_mixin.dart';
import '../../../../../common/util/app_util.dart';
import '../../../../../common/util/convert_utils.dart';
import '../../../../../common/util/show_snack_bar.dart';
import '../../../../../common/util/translation/app_translation.dart';
import '../../../../../domain/model/blood_sugar_model.dart';
import '../../../../../domain/usecase/blood_sugar_usecase.dart';
import '../../../../controller/app_base_controller.dart';
import '../select_state_mixin.dart';

class AddBloodSugarController extends AppBaseController with DateTimeMixin, AddDateTimeMixin, SelectStateMixin {
  final BloodSugarUseCase useCase;

  final RxString rxUnit = BloodSugarUnit.mgdLUnit.obs;
  final RxString rxInformation = TranslationConstants.bloodSugarInforNormal.tr.obs;
  final RxString rxInfoCode = BloodSugarInformationCode.normalCode.obs;
  final Rx<String?> rxInfoContent = bloodSugarInformationMgMap[BloodSugarInformationCode.lowCode].obs;
  final Rx<TextEditingController> textEditController = TextEditingController(text: '80.0').obs;

  AddBloodSugarController(this.useCase);

  void onInitialData({BloodSugarModel? model}) {
    if (!isNullEmpty(model)) {
      rxUnit.value = model!.unit ?? BloodSugarUnit.mgdLUnit;
      rxInfoCode.value = model.infoCode ?? BloodSugarInformationCode.normalCode;
      rxInformation.value = bloodSugarInfoDisplayMap[rxInfoCode.value]!;
      rxInfoContent.value = bloodSugarInformationMgMap[rxInfoCode.value];
      textEditController.value.text = !isNullEmptyFalseOrZero(model.measure) ? model.measure.toString() : '80.0';
      bloodPressureDate = DateTime.fromMillisecondsSinceEpoch(model.dateTime!);
    } else {
      rxUnit.value = BloodSugarUnit.mgdLUnit;
      rxInfoCode.value = BloodSugarInformationCode.normalCode;
      rxInformation.value = TranslationConstants.bloodSugarInforNormal.tr;
      rxInfoContent.value = bloodSugarInformationMgMap[BloodSugarInformationCode.lowCode];
      textEditController.value = TextEditingController(text: '80.0');
      bloodPressureDate = DateTime.now();
    }
    updateDateTimeString(bloodPressureDate);
  }

  @override
  void onInit() {
    onInitialData();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();

    onChangedInformation();
  }

  void onChangedUnit() {
    String value = textEditController.value.text;
    if (rxUnit.value == BloodSugarUnit.mgdLUnit) {
      rxUnit.value = BloodSugarUnit.mmollUnit;
      textEditController.value.text = ConvertUtils.convertMg2MmolL(value).toString();
    } else {
      rxUnit.value = BloodSugarUnit.mgdLUnit;
      textEditController.value.text = ConvertUtils.convertMmolL2MgDl(value).toString();
    }
    onChangedInformation();
  }

  void onChangedInformation() {
    double value = 0;
    Map<String, String> bloodSugarInfoMap = bloodSugarInformationMgMap;
    if (rxUnit.value == BloodSugarUnit.mgdLUnit) {
      value = ConvertUtils.convertMg2MmolL(textEditController.value.text);
    } else {
      value = double.parse(textEditController.value.text);
      bloodSugarInfoMap = bloodSugarInformationMmolMap;
    }

    if (value < 4.0) {
      rxInfoCode.value = BloodSugarInformationCode.lowCode;
    } else if (value >= 4.0 && value < 5.5) {
      rxInfoCode.value = BloodSugarInformationCode.normalCode;
    } else if (value >= 5.5 && value < 7.0) {
      rxInfoCode.value = BloodSugarInformationCode.preDiabetesCode;
    } else {
      rxInfoCode.value = BloodSugarInformationCode.diabetesCode;
    }

    rxInformation.value = bloodSugarInfoDisplayMap[rxInfoCode.value]!;
    rxInfoContent.value = bloodSugarInfoMap[rxInfoCode.value];
  }

  Future<void> onSelectBloodSugarDate() async {
    final result = await onSelectDate(context: context, initialDate: bloodPressureDate);
    onSelectAddDate(result);
  }

  Future<void> onSelectBloodSugarTime() async {
    final DateTime dateTime = bloodPressureDate;
    final TimeOfDay? result = await onSelectTime(
      context: context,
      initialTime: TimeOfDay(
        hour: dateTime.hour,
        minute: dateTime.minute,
      ),
    );
    onSelectAddTime(result);
  }

  Future<void> onSaved({BloodSugarModel? model}) async {
    rxLoadedType.value = LoadedType.start;
    onChangedInformation();
    DateTime now = DateTime.now();
    DateTime dateTime = bloodPressureDate;
    dateTime.update(second: now.second, millisecond: now.millisecond);
    if (!isNullEmpty(model)) {
      model!.stateCode = rxSelectedState.value;
      model.measure = double.parse(textEditController.value.text);
      model.unit = rxUnit.value;
      model.infoCode = rxInfoCode.value;
      model.dateTime = dateTime.millisecondsSinceEpoch;
      await useCase.saveBloodSugarData(model);
      if (context.mounted) {
        showSnackBar(
          context,
          subtitle: TranslationConstants.editDataSuccess.tr,
          type: SnackBarType.success,
        );
      }
    } else {
      model = BloodSugarModel(
        key: const Uuid().v4(),
        stateCode: rxSelectedState.value,
        measure: double.parse(textEditController.value.text),
        unit: rxUnit.value,
        infoCode: rxInfoCode.value,
        dateTime: dateTime.millisecondsSinceEpoch,
      );
      await useCase.saveBloodSugarData(model);

      if (context.mounted) {
        showSnackBar(
          context,
          subtitle: TranslationConstants.addDataSuccess.tr,
          type: SnackBarType.success,
        );
      }
    }

    rxLoadedType.value = LoadedType.finish;
  }

  void onPressAdd(BloodSugarModel? currentBloodSugar) {
    if (rxLoadedType.value == LoadedType.finish) {
      onSaved(model: currentBloodSugar);
      Get.back();
    }
  }

  void onPressed(VoidCallback callback) {
    if (rxLoadedType.value == LoadedType.finish) {
      callback.call();
    }
  }
}
