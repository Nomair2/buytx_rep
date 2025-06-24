import 'package:flutter/material.dart';
import 'package:buytx/core/configs/theme/app_colors.dart';

class AppText {
  static const lightText = TextTheme(
    titleLarge: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 40,
      color: AppColors.lightPrimary,
    ),
    titleMedium: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 24,
      color: AppColors.black,
    ),
    bodyLarge: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: AppColors.lightPrimary,
    ),
    bodySmall: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: AppColors.black,
    ),
    labelMedium: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: AppColors.backgroundCategories,
    ),
    bodyMedium: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: AppColors.lightBackground,
    ),
    displaySmall: TextStyle(
      fontWeight: FontWeight.w300,
      fontSize: 16,
      color: Colors.black,
    ),
  );

  static const darkText = TextTheme(
    titleLarge: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 40,
      color: AppColors.darkPrimary,
    ),
    titleMedium: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 24,
      color: AppColors.lightBackground,
    ),
    bodyLarge: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: AppColors.darkPrimary,
    ),
    labelMedium: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: AppColors.lightBackground,
    ),
    bodySmall: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: AppColors.lightBackground,
    ),
    bodyMedium: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: AppColors.lightBackground,
    ),
    displaySmall: TextStyle(
      fontWeight: FontWeight.w300,
      fontSize: 16,
      color: Colors.white,
    ),
  );
}
