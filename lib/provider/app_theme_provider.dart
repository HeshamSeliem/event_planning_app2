import 'package:flutter/material.dart';

class AppThemeProvider extends ChangeNotifier{
  ThemeMode appTheme = ThemeMode.light;

   void changeAppTheme(ThemeMode theme)
   {
    if(theme == appTheme)
    {
      return;
    }
    else{
      appTheme = theme;
    }
    notifyListeners();
   }
    // function only to set dark theme
     bool isDarkMode()
     {
      return appTheme == ThemeMode.dark;
     }

}