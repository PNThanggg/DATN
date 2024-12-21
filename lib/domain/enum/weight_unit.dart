import '../../common/util/convert_utils.dart';

enum WeightUnit {
  kg,
  lb,
}

extension WeightUnitExtension on WeightUnit {
  String get label {
    switch (this) {
      case WeightUnit.kg:
        return "kg";
      case WeightUnit.lb:
        return "lb";
    }
  }

  int get id {
    switch (this) {
      case WeightUnit.kg:
        return 0;
      case WeightUnit.lb:
        return 1;
    }
  }

  double convertToUnit(double value) {
    switch (this) {
      case WeightUnit.kg:
        return ConvertUtils.convertLbToKg(value);
      case WeightUnit.lb:
        return ConvertUtils.convertKgToLb(value);
    }
  }
}

class WeightUnitEnum {
  static WeightUnit getWeightUnitById(int? id) {
    if (id == null) {
      return WeightUnit.kg;
    } else {
      return WeightUnit.values.firstWhere((element) => element.id == id, orElse: () => WeightUnit.kg);
    }
  }
}
