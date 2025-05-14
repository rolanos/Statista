import 'dart:ui';

abstract class AppConstants {
  static const miniPadding = 4.0;
  static const smallPadding = 8.0;
  static const mediumPadding = 16.0;
  static const largePadding = 24.0;

  static const apiErrorFieldName = 'error';
  static const defaultError = 'Что-то пошло не так, попробуйте позже';
}

abstract class AppColors {
  static const gray = Color(0xFF737373);
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF171717);

  static const whiteSecondary = Color(0xFFADAEBC);

  static const border = Color(0xFFE5E5E5);

  static const blueDark = Color.fromARGB(178, 41, 120, 255);
  static const blue = Color(0xFF2979FF);
}
