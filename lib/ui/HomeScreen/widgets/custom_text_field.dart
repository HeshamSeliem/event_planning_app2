import 'package:event_plan_app_3/utiles/app_colors.dart';
import 'package:event_plan_app_3/utiles/app_styles.dart';
import 'package:flutter/material.dart';
typedef myValidator = String? Function(String?)?;
class CustomTextField extends StatelessWidget {
   CustomTextField({
    this.borderColor,
     this.hintText,
    this.labelText,
     this.hintStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.writtenStyle,
    this.obSecure = false,
    this.maxLines= 1,
    this.validator,
    this.controller,
    this.keyboardType = TextInputType.text
    });
Color? borderColor;
String? hintText;
String? labelText;
TextStyle? hintStyle;
TextStyle? writtenStyle;
Widget? prefixIcon;
Widget? suffixIcon;
int maxLines;
bool obSecure;
myValidator validator;
TextEditingController? controller;
TextInputType keyboardType;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      validator: validator,
      maxLines: maxLines,
      obscureText: obSecure,
      style: writtenStyle ?? AppStyles.bold20dark,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        hintStyle: hintStyle ?? AppStyles.bold16gray,
        labelStyle: hintStyle ?? AppStyles.bold16gray,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: borderColor ?? AppColors.greyColor,
            width: 2
          )
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: borderColor ?? AppColors.greyColor,
            width: 2
          )
        ),
       errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: AppColors.redColor,
            width: 2
          )
        ), 
         focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: AppColors.redColor,
            width: 2
          )
        ), 
      ),
    );
  }
}