import 'package:intl/intl.dart';

extension IntExtensions on int {
  int getMillisecondDateFormat(String formatPattern) {
    final stringDate = DateFormat(formatPattern).format(DateTime.fromMillisecondsSinceEpoch(this));
    return DateFormat(formatPattern).parse(stringDate).millisecondsSinceEpoch;
  }
}
