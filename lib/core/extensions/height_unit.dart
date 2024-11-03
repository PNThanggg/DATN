enum HeightUnit {
  cm,
  ftIn,
}

extension HeightUnitExtension on HeightUnit {
  String get label {
    switch (this) {
      case HeightUnit.cm:
        return "cm";
      case HeightUnit.ftIn:
        return "fit . in";
    }
  }

  int get id {
    switch (this) {
      case HeightUnit.cm:
        return 0;
      case HeightUnit.ftIn:
        return 1;
    }
  }
}

class HeightUnitEnum {
  static HeightUnit getHeightUnitById(int? id) {
    if (id == null) {
      return HeightUnit.cm;
    } else {
      return HeightUnit.values.firstWhere((element) => element.id == id, orElse: () => HeightUnit.cm);
    }
  }
}
