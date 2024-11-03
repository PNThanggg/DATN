import 'dart:math';

extension DoubleExtension on double {
  double roundDouble(int places) {
    num mod = pow(10.0, places);
    return ((this * mod).round().toDouble() / mod);
  }
}
