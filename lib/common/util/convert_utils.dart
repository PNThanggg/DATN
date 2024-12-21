class ConvertUtils {
  static const _inchInCm = 2.54;
  static const _libInKg = 0.453592;
  static const _kgInLb = 2.20462;
  static const _ftInCm = 30.48;
  static const _ftInM = 0.3048;
  static const _inchInM = 0.0254;
  static const _mInCM = 100;
  static int convertCmToInches(double cm) {
    int numInches = (cm / _inchInCm).round();
    int inches = numInches % 12;
    return inches;
  }

  static int convertCmToFeet(double cm) {
    int numInches = (cm / _inchInCm).round();
    int feet = numInches ~/ 12;
    return feet;
  }

  static double convertLbToKg(double lb) => lb * _libInKg;

  static double convertKgToLb(double kg) => kg * _kgInLb;

  static double convertFtAndInToCm(int ft, int inch) =>
      (ft * _ftInCm) + (inch * _inchInCm);

  static double convertCmToM(double cm) => cm * 0.01;

  static double convertFtAndInchToM(int ft, int inch) =>
      (ft * _ftInM) + (inch * _inchInM);
  static double convertMToCM(double m) => m * _mInCM;

  /// Blood Sugar
  static double convertMmolL2MgDl(String value) {
    double mmollValue = double.parse(value);
    return (mmollValue * 18).ceilToDouble();
  }

  static double convertMg2MmolL(String value) {
    double mgValue = double.parse(value);
    return (((mgValue / 18) * 10).ceil() / 10);
  }
}
