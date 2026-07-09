import 'package:event_plan_app_3/utiles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  static  TextStyle bold14primary = GoogleFonts.inter(
    fontSize: 14,
    color: AppColors.primaryLight,
    fontWeight: FontWeight.bold
  );
  
  static  TextStyle bold16gray = GoogleFonts.inter(
    fontSize: 16,
    color: AppColors.greyColor,
    fontWeight: FontWeight.bold
  );
  static  TextStyle bold20dark = GoogleFonts.inter(
    fontSize: 20,
    color: AppColors.darkColors,
    fontWeight: FontWeight.bold
  );
  static  TextStyle bold16dark = GoogleFonts.inter(
    fontSize: 16,
    color: AppColors.darkColors,
    fontWeight: FontWeight.bold
  );
  static  TextStyle bold20primary(BuildContext context){
    return GoogleFonts.inter(
    fontSize: 20,
    color: AppColors.primaryLight,
    fontWeight: FontWeight.bold
  );
  }
  static  TextStyle bold16both = GoogleFonts.inter(
    fontSize: 16,
    color: AppColors.whiteColors,
    fontWeight: FontWeight.bold
  );
  static  TextStyle bold24white = GoogleFonts.inter(
    fontSize: 24,
    color: AppColors.whiteColors,
    fontWeight: FontWeight.bold
  );
  static TextStyle regular14white(BuildContext context) {
  return GoogleFonts.inter(
    fontSize: 14,
    color: Theme.of(context).colorScheme.primary,
    fontWeight: FontWeight.bold,
  );
}
static  TextStyle regular14whiteInDarkTheme = GoogleFonts.inter(
    fontSize: 14,
    color: AppColors.whiteColors,
    fontWeight: FontWeight.w400
  );
  static  TextStyle bold20secendary(BuildContext context){
    return GoogleFonts.inter(
    fontSize: 20,
    color: Theme.of(context).colorScheme.primaryFixed,
    fontWeight: FontWeight.bold
  );
  }
}
