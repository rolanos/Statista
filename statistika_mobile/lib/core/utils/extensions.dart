import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension StringNullableExtension on String? {
  String? get asDate => DateTime.tryParse(this ?? '').toString();
}

extension DateTimeExtension on DateTime {
  String toFormattedString() {
    var result = '';
    if (day > 9) {
      result += '$day.';
    } else {
      result += '0$day.';
    }
    if (month > 9) {
      result += '$month.';
    } else {
      result += '0$month.';
    }
    result += year.toString();
    return result;
  }
}
