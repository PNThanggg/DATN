import 'dart:math';

import 'package:datn/common/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/constants/app_constant.dart';
import '../../../../../common/mixin/add_date_time_mixin.dart';
import '../../../../../common/mixin/date_time_mixin.dart';
import '../../../../../common/util/convert_utils.dart';
import '../../../../../common/util/show_snack_bar.dart';
import '../../../../../common/util/translation/app_translation.dart';
import '../../../../../domain/enum/bmi_type.dart';
import '../../../../../domain/enum/height_unit.dart';
import '../../../../../domain/enum/weight_unit.dart';
import '../../../../../domain/model/bmi_model.dart';
import '../../../../../domain/model/user_model.dart';
import '../../../../../domain/usecase/bmi_usecase.dart';
import '../../../../controller/app_controller.dart';
import '../../../../theme/app_color.dart';
import '../../../../widget/app_dialog.dart';
import '../../../../widget/app_dialog_age_widget.dart';
import '../../../../widget/app_dialog_gender_widget.dart';
import '../weight_bmi_controller.dart';
import 'widget/bmi_info_widget.dart';

class AddWeightBMIController extends GetxController with AddDateTimeMixin, DateTimeMixin {
  late BuildContext context;
  final BMIUseCase _bmiUseCase;

  final Rx<WeightUnit> weightUnit = WeightUnit.kg.obs;
  final Rx<HeightUnit> heightUnit = HeightUnit.cm.obs;
  final Rx<BMIType> bmiType = BMIType.normal.obs;
  final TextEditingController cmController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController ftController = TextEditingController();
  final TextEditingController inchController = TextEditingController();
  final AppController _appController = Get.find<AppController>();
  Rx<DateTime> bmiDate = DateTime.now().obs;
  RxBool isLoading = false.obs;
  RxInt bmi = 0.obs;
  final _weightBMIController = Get.find<WeightBMIController>();
  BMIModel currentBMI = BMIModel();
  RxInt age = (Get.find<AppController>().currentUser.value.age ?? 30).obs;
  RxMap gender = AppConstant.listGender
      .firstWhere(
        (element) => element['id'] == Get.find<AppController>().currentUser.value.genderId,
        orElse: () => AppConstant.listGender[0],
      )
      .obs;

  AddWeightBMIController(this._bmiUseCase);

  @override
  void onInit() {
    updateDateTimeString(DateTime.now());
    weightController.text = '65.00';
    cmController.text = "170.0";
    ftController.text = '5\'';
    inchController.text = '7\'';
    caculateBMI();
    weightUnit.value = _weightBMIController.weightUnit.value;
    heightUnit.value = _weightBMIController.heightUnit.value;
    super.onInit();
  }

  void onSelectBMIDate() async {
    final result = await onSelectDate(
      context: context,
      initialDate: bloodPressureDate,
      primaryColor: AppColor.green,
    );
    onSelectAddDate(result);
  }

  void onSelectBMITime() async {
    final result = await onSelectTime(
      context: context,
      initialTime: TimeOfDay(hour: bloodPressureDate.hour, minute: bloodPressureDate.minute),
    );
    onSelectAddTime(result);
  }

  void onSelectWeightUnit() {
    final double weight = weightController.text.toDouble;
    if (weightUnit.value == WeightUnit.kg) {
      weightUnit.value = WeightUnit.lb;
      weightController.text = ConvertUtils.convertKgToLb(weight).toStringAsFixed(2);
    } else {
      weightUnit.value = WeightUnit.kg;
      weightController.text = ConvertUtils.convertLbToKg(weight).toStringAsFixed(2);
    }
  }

  void onSelectHeightUnit() {
    if (heightUnit.value == HeightUnit.cm) {
      heightUnit.value = HeightUnit.ftIn;
      final heightCm = cmController.text.toDouble;
      ftController.text = '${ConvertUtils.convertCmToFeet(heightCm)}\'';
      inchController.text = '${ConvertUtils.convertCmToInches(heightCm)} "';
    } else {
      heightUnit.value = HeightUnit.cm;
      final feet = ftController.text.toInt;
      final inches = inchController.text.toInt;
      cmController.text = ConvertUtils.convertFtAndInToCm(feet, inches).toStringAsFixed(2);
    }
  }

  void onShowInfo() {
    showAppDialog(
      context,
      '',
      '',
      fullContentWidget: const BMIINfoWidget(),
    );
  }

  void onPressedAge() {
    age.value = age.value < 2
        ? 2
        : age.value > 110
            ? 110
            : age.value;
    showAppDialog(
      context,
      TranslationConstants.choseYourAge.tr,
      '',
      hideGroupButton: true,
      widgetBody: AppDialogAgeWidget(
        initialAge: age.value,
        onPressCancel: Get.back,
        onPressSave: (value) {
          Get.back();
          _appController.updateUser(
            UserModel(
              age: value,
              genderId: _appController.currentUser.value.genderId ?? '0',
            ),
          );
          age.value = value;
        },
      ),
    );
  }

  void onPressGender() {
    showAppDialog(
      context,
      TranslationConstants.choseYourAge.tr,
      '',
      hideGroupButton: true,
      widgetBody: AppDialogGenderWidget(
        initialGender: gender,
        onPressCancel: Get.back,
        onPressSave: (value) {
          Get.back();
          if (value == gender.value) {
            return;
          }
          _appController.updateUser(
            UserModel(
              age: _appController.currentUser.value.age ?? 30,
              genderId: value['id'] ?? '0',
            ),
          );
          gender.value = value;
        },
      ),
    );
  }

  double _getWeight() {
    final weight = weightController.text;
    if (weight.isEmpty) {
      weightController.text = '0.0';
    }
    if (weightUnit.value == WeightUnit.kg) {
      return double.parse(weightController.text.isNotEmpty ? weightController.text : '0.0');
    } else {
      return ConvertUtils.convertLbToKg(
        double.parse(weightController.text.isNotEmpty ? weightController.text : '0.0'),
      );
    }
  }

  double _getHeight() {
    if (heightUnit.value == HeightUnit.cm) {
      if (cmController.text.isEmpty) {
        cmController.text = '0.0';
      }
      return ConvertUtils.convertCmToM(
        double.parse(cmController.text.isNotEmpty ? cmController.text : '0.0'),
      );
    } else {
      if (ftController.text.isEmpty) {
        ftController.text = '0\'';
      }
      if (inchController.text.isEmpty) {
        inchController.text = '0\'';
      }
      return ConvertUtils.convertFtAndInchToM(ftController.text.isNotEmpty ? ftController.text.toInt : 0,
          inchController.text.isNotEmpty ? inchController.text.toInt : 0);
    }
  }

  void caculateBMI() {
    double weight = _getWeight();
    double height = _getHeight();

    if (weight != 0 && height != 0) {
      bmi.value = (weight / pow(height, 2)).round();
    }
    bmiType.value = BMITypeEnum.getBMITypeByValue(bmi.value);
  }

  Future<void> addBMI() async {
    isLoading.value = true;
    _weightBMIController.weightUnit.value = weightUnit.value;
    _weightBMIController.heightUnit.value = heightUnit.value;
    _setHeightUnit();
    _setWeightUnit();
    Map? initialGender = AppConstant.listGender.firstWhereOrNull(
      (element) => element['id'] == (_appController.currentUser.value.genderId ?? '0'),
    );
    final DateTime bmiDateTime = DateTime(
      bloodPressureDate.year,
      bloodPressureDate.month,
      bloodPressureDate.day,
      bloodPressureDate.hour,
      bloodPressureDate.minute,
    );
    final BMIModel bmiModel = BMIModel(
      key: bmiDateTime.toIso8601String(),
      weight: _getWeight(),
      weightUnitId: weightUnit.value.id,
      typeId: bmiType.value.id,
      dateTime: bmiDateTime.millisecondsSinceEpoch,
      age: age.value,
      height: _getHeight(),
      heightUnitId: heightUnit.value.id,
      gender: initialGender!['id'] ?? '0',
      bmi: bmi.value,
    );
    await _bmiUseCase.saveBMI(bmiModel);
    isLoading.value = false;

    if (context.mounted) {
      showSnackBar(
        context,
        subtitle: TranslationConstants.addDataSuccess.tr,
        type: SnackBarType.success,
      );
    }

    Get.back(result: true);
  }

  Future<void> _setWeightUnit() async {
    await _bmiUseCase.setWeightUnitId(weightUnit.value.id);
  }

  Future<void> _setHeightUnit() async {
    await _bmiUseCase.setHeightUnitId(heightUnit.value.id);
  }

  void onEdit(BMIModel bmiModel) {
    currentBMI = bmiModel;
    bloodPressureDate = DateTime.fromMillisecondsSinceEpoch(bmiModel.dateTime!);
    updateDateTimeString(bloodPressureDate);
    weightUnit.value = bmiModel.weightUnit;
    if (bmiModel.weightUnit == WeightUnit.kg) {
      weightController.text = '${bmiModel.weightKg}';
    } else {
      weightController.text = '${bmiModel.weightLb}';
    }
    if (bmiModel.heightUnit == HeightUnit.cm) {
      final height = bmiModel.heightCm;
      cmController.text = '$height';
    } else {
      ftController.text = '${bmiModel.heightFT} \'';
      inchController.text = '${bmiModel.heightInches} "';
    }
    bmiType.value = bmiModel.type;
    age.value = bmiModel.age ?? 30;
    gender.value = AppConstant.listGender.firstWhere(
      (element) => element['id'] == bmiModel.gender,
      orElse: () => AppConstant.listGender[0],
    );
    bmi.value = bmiModel.bmi ?? 0;
  }

  Future<void> onSave() async {
    isLoading.value = true;

    currentBMI.weight = _getWeight();
    currentBMI.weightUnitId = weightUnit.value.id;
    currentBMI.typeId = bmiType.value.id;
    final DateTime bmiDateTime = DateTime(
      bloodPressureDate.year,
      bloodPressureDate.month,
      bloodPressureDate.day,
      bloodPressureDate.hour,
      bloodPressureDate.minute,
    );
    currentBMI.dateTime = bmiDateTime.millisecondsSinceEpoch;
    currentBMI.age = age.value;
    currentBMI.height = _getHeight();
    currentBMI.heightUnitId = heightUnit.value.id;
    currentBMI.gender = gender['id'];
    currentBMI.bmi = bmi.value;
    await _bmiUseCase.updateBMI(currentBMI);
    isLoading.value = false;
    if (context.mounted) {
      showSnackBar(
        context,
        subtitle: TranslationConstants.editDataSuccess.tr,
        type: SnackBarType.success,
      );
    }
    Get.back(result: true);
  }
}
