import 'package:flutter/material.dart';
import 'package:buytx/core/configs/theme/app_colors.dart';
import 'package:buytx/core/configs/theme/app_text.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    primaryColor: AppColors.lightPrimary,

    fontFamily: 'Hacen Tunisia',
    scaffoldBackgroundColor: AppColors.lightBackground,
    secondaryHeaderColor: Color(0xff12ADD8),
    colorScheme: ColorScheme.dark(
      onSurface: Color(0xffE8ECE8),
      surfaceContainer: Color(0xffEDE059),
      primaryFixed: AppColors.lightPrimary,
      primaryFixedDim: Colors.grey,
      surface: AppColors.lightBackground,
      onSecondary: Colors.black,
      onBackground: AppColors.lightButton,
      brightness: Brightness.light,
      inversePrimary: Colors.grey,
      primaryContainer: AppColors.lightBackground,
    ),
    textTheme: AppText.lightText,
    // fontFamily: 'CircularStd',
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: AppColors.lightBackground,
      contentTextStyle: TextStyle(color: Colors.white),
    ),
  );

  static final darkTheme = ThemeData(
    fontFamily: 'Hacen Tunisia',
    primaryColor: AppColors.darkPrimary,
    secondaryHeaderColor: Color(0xff12ADD8),
    scaffoldBackgroundColor: AppColors.darkBackground,
    textTheme: AppText.darkText,
    colorScheme: ColorScheme.dark(
      surfaceContainer: Color(0xff00467C).withOpacity(0.35),
      primaryFixed: Colors.white,
      primaryFixedDim: AppColors.darkPrimary,
      onSurface: AppColors.darkBackground,
      surface: AppColors.darkBackground,
      onSecondary: Colors.white,
      onBackground: AppColors.darkButton,
      brightness: Brightness.dark,
      inversePrimary: Colors.white,
      primaryContainer: AppColors.black,
    ),
    // fontFamily: 'CircularStd',
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: AppColors.darkBackground,
      contentTextStyle: TextStyle(color: Colors.white),
    ),
  );
}
