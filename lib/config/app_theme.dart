import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData light() {
    return ThemeData(
      primaryColor: AppColors.primaryColor,
      secondaryHeaderColor: AppColors.secondaryColor,
      scaffoldBackgroundColor:  AppColors.background,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.black),
        bodyMedium: TextStyle(color: Colors.black),
      ), colorScheme: ColorScheme.light(
        surface: AppColors.background,
        onSurface: Colors.black,
        background:  AppColors.background,
        onBackground: Colors.black,
        primary: AppColors.primaryColor,
        secondary: AppColors.secondaryColor,
        tertiary: AppColors.tertiary,
        outline: AppColors.outline,
      ),
    );
  }

  static ThemeData dark() {
    return ThemeData(
      primaryColor: AppColors.primaryColor,
      secondaryHeaderColor: AppColors.secondaryColor,
      scaffoldBackgroundColor:  AppColors.background,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.black),
        bodyMedium: TextStyle(color: Colors.black),
      ), colorScheme: ColorScheme.light(
      surface:  AppColors.background,
      onSurface: Colors.black,
      background:  AppColors.background,
      onBackground: Colors.black,
      primary: AppColors.primaryColor,
      secondary: AppColors.secondaryColor,
      tertiary: AppColors.tertiary,
      outline: AppColors.outline,
    ),
    );
  }
}