import 'dart:math';

import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  Size get mediaQuerySize => MediaQuery.of(this).size;
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

extension IntegerListExtension on List<int> {
  int getMax() {
    if (isNotEmpty) {
      var maxValue = first;
      for (var value in this) {
        maxValue = max(maxValue, value);
      }
      return maxValue;
    } else {
      return 0;
    }
  }
}
