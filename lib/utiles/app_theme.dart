import 'package:event_plan_app_3/utiles/app_colors.dart';
import 'package:event_plan_app_3/utiles/app_styles.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.whiteColors,
   colorScheme:  ColorScheme.light(
      primary: AppColors.primaryLight,
      secondary: AppColors.darkColors,
      primaryFixed: AppColors.primaryLight
    ),
    canvasColor: AppColors.primaryLight,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryLight,
      elevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: Colors.transparent,
      selectedItemColor: AppColors.whiteColors,
      unselectedItemColor: AppColors.whiteColors,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedLabelStyle: AppStyles.bold16both,
      unselectedLabelStyle: AppStyles.bold16both
    ),
    // floating action buttom light
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
        side: BorderSide(
          color: AppColors.whiteColors,
          width: 6
        )
      )
    ),
     bottomAppBarTheme: BottomAppBarThemeData(
      color: AppColors.primaryLight
     )
  );
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.darkColors,
    colorScheme:  ColorScheme.dark(
      primary: AppColors.darkColors,
      secondary: AppColors.whiteColors,
      primaryFixed: AppColors.whiteColors
    ),
    canvasColor: AppColors.darkColors,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkColors,
      elevation: 0,
    ),
     bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: Colors.transparent,
      selectedItemColor: AppColors.whiteColors,
      unselectedItemColor: AppColors.whiteColors,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedLabelStyle: AppStyles.bold16both,
      unselectedLabelStyle: AppStyles.bold16both,
    ),
    // floating action buttom dark
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.darkColors,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
        side: BorderSide(
          color: AppColors.whiteColors,
          width: 6
        )
      )
    ),
    bottomAppBarTheme: BottomAppBarThemeData(
      color: AppColors.darkColors
    )
  );
}
