import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/util/translation/app_translation.dart';
import '../../presentation/theme/app_color.dart';

class BloodPressureTyeEnum {
  static BloodPressureType getBloodPressureTypeById(int? id) {
    if (id == null) {
      return BloodPressureType.normal;
    } else {
      return BloodPressureType.values.firstWhere(
        (type) => type.id == id,
        orElse: () => BloodPressureType.normal,
      );
    }
  }
}

enum BloodPressureType {
  hypotension,
  normal,
  elevated,
  hypertensionStage1,
  hypertensionStage2,
  hypertensionCrisis,
}

extension BloodPressureTypeExtension on BloodPressureType {
  int get id {
    switch (this) {
      case BloodPressureType.hypotension:
        return 0;
      case BloodPressureType.normal:
        return 1;
      case BloodPressureType.elevated:
        return 2;
      case BloodPressureType.hypertensionStage1:
        return 3;
      case BloodPressureType.hypertensionStage2:
        return 4;
      case BloodPressureType.hypertensionCrisis:
        return 5;
    }
  }

  String get name {
    switch (this) {
      case BloodPressureType.hypotension:
        return TranslationConstants.hypotension.tr;
      case BloodPressureType.normal:
        return TranslationConstants.normal.tr;
      case BloodPressureType.elevated:
        return TranslationConstants.elevated.tr;
      case BloodPressureType.hypertensionStage1:
        return TranslationConstants.hypertensionStage1.tr;
      case BloodPressureType.hypertensionStage2:
        return TranslationConstants.hypertensionStage2.tr;
      case BloodPressureType.hypertensionCrisis:
        return TranslationConstants.hypertensionCrisis.tr;
    }
  }

  String get messageRange {
    switch (this) {
      case BloodPressureType.hypotension:
        return TranslationConstants.systolicRangeOrDiastolicRange.trParams({"sys": "<90", "dia": "<60"});
      case BloodPressureType.normal:
        return TranslationConstants.systolicRangeOrDiastolicRange.trParams({"sys": "90-110", "dia": "60-79"});
      case BloodPressureType.elevated:
        return TranslationConstants.systolicRangeOrDiastolicRange.trParams({"sys": "120-129", "dia": "80-79"});
      case BloodPressureType.hypertensionStage1:
        return TranslationConstants.systolicRangeOrDiastolicRange.trParams({"sys": "130-139", "dia": "80-89"});
      case BloodPressureType.hypertensionStage2:
        return TranslationConstants.systolicRangeOrDiastolicRange.trParams({"sys": "140-180", "dia": "90-120"});
      case BloodPressureType.hypertensionCrisis:
        return TranslationConstants.systolicRangeOrDiastolicRange.trParams({"sys": ">180", "dia": ">120"});
    }
  }

  String get sortMessageRange {
    switch (this) {
      case BloodPressureType.hypotension:
        return TranslationConstants.sysAndDIA.trParams({"sys": "<90", "dia": "<60"});
      case BloodPressureType.normal:
        return TranslationConstants.sysAndDIA.trParams({"sys": "90-110", "dia": "60-79"});
      case BloodPressureType.elevated:
        return TranslationConstants.sysAndDIA.trParams({"sys": "120-129", "dia": "80-79"});
      case BloodPressureType.hypertensionStage1:
        return TranslationConstants.sysAndDIA.trParams({"sys": "130-139", "dia": "80-89"});
      case BloodPressureType.hypertensionStage2:
        return TranslationConstants.sysAndDIA.trParams({"sys": "140-180", "dia": "90-120"});
      case BloodPressureType.hypertensionCrisis:
        return TranslationConstants.sysAndDIA.trParams({"sys": ">180", "dia": ">120"});
    }
  }

  String get message {
    switch (this) {
      case BloodPressureType.hypotension:
        return TranslationConstants.hypotensionMessage.tr;
      case BloodPressureType.normal:
        return TranslationConstants.normalMessage.tr;
      case BloodPressureType.elevated:
        return TranslationConstants.elevatedMessage.tr;
      case BloodPressureType.hypertensionStage1:
        return TranslationConstants.hypertensionStage1Message.tr;
      case BloodPressureType.hypertensionStage2:
        return TranslationConstants.hypertensionStage2Message.tr;
      case BloodPressureType.hypertensionCrisis:
        return TranslationConstants.hypertensionCrisisMessage.tr;
    }
  }

  Color get color {
    switch (this) {
      case BloodPressureType.hypotension:
        return AppColor.primaryColor;
      case BloodPressureType.normal:
        return AppColor.green;
      case BloodPressureType.elevated:
        return AppColor.gold;
      case BloodPressureType.hypertensionStage1:
        return AppColor.lightOrange;
      case BloodPressureType.hypertensionStage2:
        return AppColor.orange;
      case BloodPressureType.hypertensionCrisis:
        return AppColor.lightRed;
    }
  }
}
