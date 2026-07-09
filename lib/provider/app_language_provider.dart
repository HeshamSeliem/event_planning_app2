import 'package:flutter/material.dart';

class AppLanguageProvider extends ChangeNotifier{
  String appLanguage = "en";
  bool enSelected= true;
  bool arSelected = false;
   void changeAppLanguage(String newLanguage)
   {
    if(appLanguage == newLanguage)
    {
      return;
    }
    else{
          appLanguage = newLanguage;
          enSelected = "en" == newLanguage;
          arSelected = "ar" == newLanguage;
    }
    notifyListeners();
   }
}