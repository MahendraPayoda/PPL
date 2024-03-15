import 'package:flutter/material.dart';
import 'package:payoda/common/app_colors.dart';
import 'package:payoda/router/app_router.dart';

class Themes {
  static const TextTheme _lightTextTheme = TextTheme(
    displayLarge: TextStyle(
        color: AppColors.lightTextColor, fontSize: 57, fontWeight: FontWeight.normal, fontFamily: 'Manrope'),
    displayMedium: TextStyle(
        color: AppColors.lightTextColor, fontSize: 45, fontWeight: FontWeight.normal, fontFamily: 'Manrope'),
    displaySmall: TextStyle(
        color: AppColors.lightTextColor, fontSize: 36, fontWeight: FontWeight.normal, fontFamily: 'Manrope'),
    headlineLarge: TextStyle(
        color: AppColors.lightTextColor, fontSize: 32, fontWeight: FontWeight.normal, fontFamily: 'Manrope'),
    headlineMedium: TextStyle(
        color: AppColors.lightTextColor, fontSize: 28, fontWeight: FontWeight.normal, fontFamily: 'Manrope'),
    headlineSmall: TextStyle(
        color: AppColors.lightTextColor, fontSize: 24, fontWeight: FontWeight.normal, fontFamily: 'Manrope'),
    titleLarge: TextStyle(
        color: AppColors.lightTextColor, fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Manrope'),
    titleMedium: TextStyle(
        color: AppColors.lightTextColor, fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Manrope'),
    titleSmall: TextStyle(
        color: AppColors.lightTitleColor, fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Manrope'),
    labelLarge: TextStyle(
        color: AppColors.lightTextColor, fontSize: 14, fontWeight: FontWeight.normal, fontFamily: 'Manrope'),
    labelMedium: TextStyle(
        color: AppColors.lightTextColor, fontSize: 12, fontWeight: FontWeight.bold, fontFamily: 'Manrope'),
    labelSmall: TextStyle(
        color: AppColors.lightTextColor, fontSize: 11, fontWeight: FontWeight.normal, fontFamily: 'Manrope'),
    bodyLarge: TextStyle(
        color: AppColors.lightTextColor, fontSize: 16, fontWeight: FontWeight.normal, fontFamily: 'Manrope'),
    bodyMedium: TextStyle(
        color: AppColors.lightTextColor, fontSize: 14, fontWeight: FontWeight.normal, fontFamily: 'Manrope'),
    bodySmall: TextStyle(
        color: AppColors.lightTextColor, fontSize: 12, fontWeight: FontWeight.normal, fontFamily: 'Manrope'),
  );
  static final TextTheme _darkTextTheme = TextTheme(
    displayLarge: const TextStyle(
        color: AppColors.darkTextColor, fontSize: 57, fontWeight: FontWeight.normal, fontFamily: 'Manrope'),
    displayMedium: const TextStyle(
        color: AppColors.darkTextColor, fontSize: 45, fontWeight: FontWeight.normal, fontFamily: 'Manrope'),
    displaySmall: const TextStyle(
        color: AppColors.darkTextColor, fontSize: 36, fontWeight: FontWeight.normal, fontFamily: 'Manrope'),
    headlineLarge: const TextStyle(
        color: AppColors.darkTextColor, fontSize: 32, fontWeight: FontWeight.normal, fontFamily: 'Manrope'),
    headlineMedium: const TextStyle(
        color: AppColors.darkTextColor, fontSize: 28, fontWeight: FontWeight.normal, fontFamily: 'Manrope'),
    headlineSmall: const TextStyle(
        color: AppColors.darkTextColor, fontSize: 24, fontWeight: FontWeight.normal, fontFamily: 'Manrope'),
    titleLarge: const TextStyle(
        color: AppColors.darkTextColor, fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Manrope'),
    titleMedium: const TextStyle(
        color: AppColors.darkTextColor, fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Manrope'),
    titleSmall: const TextStyle(
        color: AppColors.darkTitleColor, fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Manrope'),
    labelLarge: const TextStyle(
        color: AppColors.darkTextColor, fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Manrope'),
    labelMedium: const TextStyle(
        color: AppColors.darkTextColor, fontSize: 12, fontWeight: FontWeight.bold, fontFamily: 'Manrope'),
    labelSmall: const TextStyle(
        color: AppColors.darkTextColor, fontSize: 11, fontWeight: FontWeight.normal, fontFamily: 'Manrope'),
    bodyLarge: const TextStyle(
        color: AppColors.darkTextColor, fontSize: 16, fontWeight: FontWeight.normal, fontFamily: 'Manrope'),
    bodyMedium: const TextStyle(
        color: AppColors.darkTextColor, fontSize: 14, fontWeight: FontWeight.normal, fontFamily: 'Manrope'),
    bodySmall: const TextStyle(
        color: AppColors.darkTextColor, fontSize: 12, fontWeight: FontWeight.normal, fontFamily: 'Manrope'),
  );

  static ThemeData darkTheme = ThemeData(
      appBarTheme: const AppBarTheme(backgroundColor: AppColors.darkScaffoldBackground),
      primaryColor: AppColors.darkPrimary,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkScaffoldBackground,
      textTheme: _darkTextTheme,
      iconTheme: const IconThemeData(color: AppColors.darkPrimaryIconColor),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkFillBackground,
        errorBorder: OutlineInputBorder(
          gapPadding: 0,
          borderSide: const BorderSide(
            color: AppColors.darkWarningTextColor,
            width: 1.0, //Border width
          ),
          borderRadius: BorderRadius.circular(12.0), // Border radius
        ),
        focusedErrorBorder: OutlineInputBorder(
          gapPadding: 0,
          borderSide: const BorderSide(
              color: AppColors.darkWarningTextColor, // Focused border color (#181636)
              width: 1.0),
          borderRadius: BorderRadius.circular(12.0), // Border radius
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.darkBorderMuteColor, // Border color (#E1ECFC)
            width: 1.0, // Border width
          ),
          borderRadius: BorderRadius.circular(12.0), // Border radius
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.darkBorderMuteColor, // Focused border color (#181636)
            width: 1.0, // Border width
          ),
          borderRadius: BorderRadius.circular(12.0), // Border radius
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.darkBorderMuteColor, // Focused border color (#181636)
            width: 1.0, // Border width
          ),
          borderRadius: BorderRadius.circular(12.0), // Border radius
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.darkBorderMuteColor, // Focused border color (#181636)
            width: 1.0, // Border width
          ),
          borderRadius: BorderRadius.circular(12.0), // Border radius
        ),
        hintStyle: _darkTextTheme.bodyMedium,
        labelStyle: _darkTextTheme.bodyMedium,
        isDense: true,
        contentPadding: const EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.darkFillBackground,
        circularTrackColor: AppColors.darkFillBackground,
        linearTrackColor: AppColors.darkFillBackground,
      ),
      colorScheme: const ColorScheme.dark(background: AppColors.darkFillBackground)
          .copyWith(background: AppColors.darkFillBackground));

  static ThemeData lightTheme = ThemeData(
      appBarTheme: const AppBarTheme(backgroundColor: AppColors.lightScaffoldBackground),
      primaryColor: AppColors.lightPrimary,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightScaffoldBackground,
      textTheme: _lightTextTheme,
      iconTheme: const IconThemeData(color: AppColors.lightPrimaryIconColor),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightFillBackground,
        errorBorder: OutlineInputBorder(
          gapPadding: 0,
          borderSide: const BorderSide(
            color: AppColors.lightWarningTextColor, // Focused border color (#181636)
            width: 1.0, // Border width
          ),
          borderRadius: BorderRadius.circular(12.0), // Border radius
        ),
        focusedErrorBorder: OutlineInputBorder(
          gapPadding: 0,
          borderSide: const BorderSide(
            color: AppColors.lightWarningTextColor, // Focused border color (#181636)
            width: 1.0, // Border width
          ),
          borderRadius: BorderRadius.circular(12.0), // Border radius
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.lightBorderMuteColor, // Border color (#E1ECFC)
            width: 1.0, // Border width
          ),
          borderRadius: BorderRadius.circular(12.0), // Border radius
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.lightBorderMuteColor, // Focused border color (#181636)
            width: 1.0, // Border width
          ),
          borderRadius: BorderRadius.circular(12.0), // Border radius
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.lightBorderMuteColor, // Focused border color (#181636)
            width: 1.0, // Border width
          ),
          borderRadius: BorderRadius.circular(12.0), // Border radius
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.lightBorderMuteColor, // Focused border color (#181636)
            width: 1.0, // Border width
          ),
          borderRadius: BorderRadius.circular(12.0), // Border radius
        ),
        hintStyle: _lightTextTheme.bodyMedium,
        labelStyle: _lightTextTheme.bodyMedium,
        isDense: true,
        contentPadding: const EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.lightFillBackground,
        circularTrackColor: AppColors.lightFillBackground,
        linearTrackColor: AppColors.lightFillBackground,
      ),
      backgroundColor: AppColors.lightFillBackground);
}

bool isDarkMode() {
  if (Theme.of(AppRouter.navigatorKey.currentState!.context).brightness == Brightness.dark) {
    return true;
  } else {
    return false;
  }
}

Color setColor({required Color light, required Color dark}) {
  if (Theme.of(AppRouter.navigatorKey.currentState!.context).brightness == Brightness.dark) {
    return dark;
  } else {
    return light;
  }
}

TextTheme textTheme() {
  return Theme.of(AppRouter.navigatorKey.currentState!.context).textTheme;
}

class ThemeService {}
