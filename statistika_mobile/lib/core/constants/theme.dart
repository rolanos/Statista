import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      scaffoldBackgroundColor: const Color.fromARGB(255, 245, 248, 248),
      indicatorColor: AppColors.black,
      primaryColor: Colors.black,
      dividerTheme: DividerThemeData(
        color: AppColors.whiteSecondary.withAlpha(75),
        thickness: 0.75,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 4.0,
        shadowColor: Colors.black,
      ),
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Colors.black,
        onPrimary: Colors.white,
        secondary: AppColors.black,
        onSecondary: AppColors.white,
        error: Color.fromARGB(255, 205, 135, 135),
        onError: Color.fromARGB(255, 205, 135, 135),
        surface: AppColors.white,
        onSurface: AppColors.black,
      ),
      textTheme: TextTheme(
        titleLarge: GoogleFonts.roboto(
          color: const Color(0xFF171717),
          fontSize: 24,
        ),
        bodyLarge: GoogleFonts.roboto(
          color: const Color(0xFF404040),
          fontSize: 18,
        ),
        bodyMedium: GoogleFonts.roboto(
          color: const Color(0xFF404040),
          fontSize: 16,
        ),
        bodySmall: GoogleFonts.roboto(
          color: const Color(0xFF404040),
          fontSize: 14,
        ),
        //Мелкие надписи
        labelMedium: GoogleFonts.roboto(
          color: const Color(0xFF525252),
          fontSize: 14,
        ),
        labelSmall: GoogleFonts.roboto(
          color: const Color(0xFF9CA3AF),
          fontSize: 12,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.white,
        selectedIconTheme: const IconThemeData(
          color: AppColors.black,
        ),
        unselectedIconTheme: const IconThemeData(
          color: AppColors.black,
        ),
        selectedLabelStyle: GoogleFonts.roboto(
          color: const Color(0xFF000000),
          fontSize: 12,
        ),
        unselectedLabelStyle: GoogleFonts.roboto(
          color: const Color(0xFF9CA3AF),
          fontSize: 12,
        ),
        selectedItemColor: const Color(0xFF000000),
        unselectedItemColor: const Color(0xFF9CA3AF),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: AppConstants.smallPadding),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.border,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              AppConstants.smallPadding,
            ),
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.border,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              AppConstants.smallPadding,
            ),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.border,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              AppConstants.smallPadding,
            ),
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.border,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              AppConstants.smallPadding,
            ),
          ),
        ),
        hintStyle: GoogleFonts.roboto(
          color: const Color(0xFFADAEBC),
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
          textStyle: WidgetStatePropertyAll(
            GoogleFonts.roboto(
              color: const Color(0xFFFFFFFF),
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
