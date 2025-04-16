import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension StringNullableExtension on String? {
  String? get asDate => DateTime.tryParse(this ?? '').toString();
}

