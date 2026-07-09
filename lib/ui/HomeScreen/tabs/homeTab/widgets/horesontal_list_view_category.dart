import 'package:event_plan_app_3/l10n/app_localizations.dart';
import 'package:event_plan_app_3/utiles/app_colors.dart';
import 'package:event_plan_app_3/utiles/app_styles.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HoresontalListViewCategory extends StatelessWidget {
   HoresontalListViewCategory({super.key,required this.index,required this.categories,required this.onTap});
 int index;
 List<String> categories;
 final bool onTap;
  @override
  Widget build(BuildContext context) {
  
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return  Container(
                  alignment: Alignment.center,
                width: width * .3,
                height: height * .05,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: AppColors.whiteColors,
                    width: 1
                  ),
                  color: onTap ? AppColors.whiteColors
                  : Colors.transparent
                ),
                child: Text(categories[index],style:
                onTap? AppStyles.bold16both.copyWith(
                  color: AppColors.primaryLight
                )
                : AppStyles.bold16both,)
           );
  }
}