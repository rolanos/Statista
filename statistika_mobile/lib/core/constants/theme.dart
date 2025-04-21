import 'package:flutter/material.dart';

import 'app_constants.dart';

class AppTheme {
  static List<BoxShadow> get smallShadows => [
        const BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.07),
          spreadRadius: 3,
          blurRadius: 6,
        ),
      ];

  static ThemeData getTheme() {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFF9FAFB),
      indicatorColor: AppColors.black,
      primaryColor: Colors.black,
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: Color(0xFF171717),
          fontSize: 24,
        ),
        bodyLarge: TextStyle(
          color: Color(0xFF404040),
          fontSize: 18,
        ),
        bodyMedium: TextStyle(
          color: Color(0xFF404040),
          fontSize: 16,
        ),
        bodySmall: TextStyle(
          color: Color(0xFF404040),
          fontSize: 14,
        ),
        //Мелкие надписи
        labelMedium: TextStyle(
          color: Color(0xFF525252),
          fontSize: 14,
        ),
        labelSmall: TextStyle(
          color: Color(0xFF9CA3AF),
          fontSize: 12,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.white,
        selectedIconTheme: IconThemeData(
          color: AppColors.black,
        ),
        unselectedIconTheme: IconThemeData(
          color: AppColors.black,
        ),
        selectedLabelStyle: TextStyle(
          color: Color(0xFF000000),
          fontSize: 12,
        ),
        unselectedLabelStyle: TextStyle(
          color: Color(0xFF9CA3AF),
          fontSize: 12,
        ),
        selectedItemColor: Color(0xFF000000),
        unselectedItemColor: Color(0xFF9CA3AF),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        contentPadding:
            EdgeInsets.symmetric(horizontal: AppConstants.smallPadding),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.border,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              AppConstants.smallPadding,
            ),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.border,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              AppConstants.smallPadding,
            ),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.border,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              AppConstants.smallPadding,
            ),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.border,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              AppConstants.smallPadding,
            ),
          ),
        ),
        hintStyle: TextStyle(
          color: Color(0xFFADAEBC),
          fontSize: 14,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.smallPadding),
            ),
          ),
          textStyle: const WidgetStatePropertyAll(
            TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 16,
            ),
          ),
          padding: const WidgetStatePropertyAll(
              EdgeInsets.all(AppConstants.smallPadding * 1.5)),
          backgroundColor: const WidgetStatePropertyAll(
            Color(
              0xFF171717,
            ),
          ),
        ),
      ),
    );
  }
}
