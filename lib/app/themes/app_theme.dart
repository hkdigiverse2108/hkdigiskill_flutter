import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.textLight,
      background: AppColors.backgroundLight,
      onPrimary: Colors.white,
      onBackground: AppColors.textLight,
    ),
    scaffoldBackgroundColor: AppColors.backgroundLight,
    appBarTheme: AppBarTheme(
      color: AppColors.primary,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontFamily: 'Poppins',
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColors.textLight, fontFamily: 'Poppins'),
      bodyMedium: TextStyle(color: AppColors.textLight, fontFamily: 'Poppins'),
      bodySmall: TextStyle(color: AppColors.textLight, fontFamily: 'Poppins'),
    ),

    fontFamily: 'Poppins',
    // Further customizations as needed
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    colorScheme: ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.textLight,
      background: AppColors.backgroundDark,
      onPrimary: Colors.white,
      onBackground: AppColors.textDark,
    ),
    scaffoldBackgroundColor: AppColors.backgroundDark,
    appBarTheme: AppBarTheme(
      color: AppColors.primary,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontFamily: 'Poppins',
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColors.textDark, fontFamily: 'Poppins'),
      bodyMedium: TextStyle(color: AppColors.textDark, fontFamily: 'Poppins'),
      bodySmall: TextStyle(color: AppColors.textDark, fontFamily: 'Poppins'),
    ),
    fontFamily: 'Poppins',
    // Further customizations as needed
  );
}
