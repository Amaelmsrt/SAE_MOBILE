import 'package:flutter/services.dart';

class DecimalInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, 
    TextEditingValue newValue,
  ) {
    String newText = newValue.text.replaceAll(',', '.');
    final List<String> decimalSplit = newText.split('.');
    final int decimalCount = decimalSplit.length - 1;
    final bool isDigitOnly = isNumeric(newText);
    if (decimalCount > 1 || 
        (decimalCount == 1 && decimalSplit.last.length > 2) ||
        !isDigitOnly) {
      return oldValue;
    }
    return TextEditingValue(
      text: newText,
      selection: newValue.selection,
    );
  }

  bool isNumeric(String str) {
    if(str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }
}