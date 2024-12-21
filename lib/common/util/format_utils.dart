import 'package:datn/common/extensions/string_extension.dart';
import 'package:flutter/services.dart';

class InchesFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    final newValueText = newValue.text;
    if (newValueText.length >= 4) {
      return oldValue;
    }
    final oldNumber = oldValue.text.toInt;
    final newNumber = newValue.text.toInt;
    if (oldNumber == newNumber) {
      String value = oldValue.text.substring(0, oldValue.text.length - 2);
      if (value.isNotEmpty) {
        value = '$value"';
      }
      return newValue.copyWith(
        text: value,
        selection: TextSelection.collapsed(
          offset: value.length,
        ),
      );
    }

    int value = newValue.text.toInt;
    String newText = '$value"';

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(
        offset: newText.length,
      ),
    );
  }
}

class FeetFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    final newValueText = newValue.text;
    if (newValueText.length >= 3) {
      return oldValue;
    }
    final oldNumber = oldValue.text.toInt;
    final newNumber = newValue.text.toInt;
    if (oldNumber == newNumber && oldValue.text != newValue.text) {
      String value = oldValue.text.substring(0, oldValue.text.length - 2);
      if (value.isNotEmpty) {
        value = '$value\'';
      }
      return newValue.copyWith(
        text: value,
        selection: TextSelection.collapsed(
          offset: value.length,
        ),
      );
    }

    int value = newValue.text.toInt;

    String newText = '$value\'';

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(
        offset: newText.length,
      ),
    );
  }
}
