import 'package:datn/core/core.dart';
import 'package:hive/hive.dart';

import '../enum/bmi_type.dart';
import '../hive_config/hive_constants.dart';

part 'bmi_model.g.dart';

@HiveType(typeId: HiveTypeConstants.bmiModel)
class BMIModel extends HiveObject {
  @HiveField(0)
  String? key;
  @HiveField(1)
  double? weight; //unit is kg
  @HiveField(2)
  int? weightUnitId;
  @HiveField(3)
  int? typeId;
  @HiveField(4)
  int? dateTime;
  @HiveField(5)
  int? age;
  @HiveField(6)
  double? height; //unit is m
  @HiveField(7)
  int? heightUnitId;
  @HiveField(8)
  String? gender;
  @HiveField(9)
  int? bmi;

  BMIModel({
    this.key,
    this.weight,
    this.weightUnitId,
    this.typeId,
    this.dateTime,
    this.age,
    this.height,
    this.heightUnitId,
    this.gender,
    this.bmi,
  });

  WeightUnit get weightUnit {
    return WeightUnitEnum.getWeightUnitById(weightUnitId);
  }

  HeightUnit get heightUnit {
    return HeightUnitEnum.getHeightUnitById(heightUnitId);
  }

  BMIType get type => BMITypeEnum.getBMITypeById(typeId);

  ///Use only Weight and BMI screen
  double get weightByCurrentUnit {
    // final id = getIt<LocalRepository>().getWeightUnitId();
    // final currentWeightUnit = WeightUnitEnum.getWeightUnitById(id);
    // final unit = WeightUnitEnum.getWeightUnitById(weightUnitId);
    // if (currentWeightUnit == unit) {
    //   return weight ?? 0.0;
    // } else {
    //   return currentWeightUnit.convertToUnit(weight ?? 0.0).roundDouble(1);
    // }

    return 0.0;
  }

  double get heightCm {
    return ConvertUtils.convertMToCM(height ?? 0.0).roundDouble(1);
  }

  int get heightFT {
    return ConvertUtils.convertCmToFeet(heightCm);
  }

  int get heightInches {
    return ConvertUtils.convertCmToInches(heightCm);
  }

  double get weightKg {
    final unit = WeightUnitEnum.getWeightUnitById(weightUnitId);
    if (unit == WeightUnit.kg) {
      return weight ?? 0.0;
    } else {
      return ConvertUtils.convertLbToKg(weight ?? 0.0).roundDouble(1);
    }
  }

  double get weightLb {
    final unit = WeightUnitEnum.getWeightUnitById(weightUnitId);
    if (unit == WeightUnit.lb) {
      return weight ?? 0.0;
    } else {
      return ConvertUtils.convertKgToLb(weight ?? 0.0).roundDouble(1);
    }
  }
}
