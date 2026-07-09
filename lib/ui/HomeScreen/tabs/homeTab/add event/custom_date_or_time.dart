import 'package:event_plan_app_3/l10n/app_localizations.dart';
import 'package:event_plan_app_3/utiles/app_colors.dart';
import 'package:event_plan_app_3/utiles/app_styles.dart';
import 'package:event_plan_app_3/utiles/asset_manager.dart';
import 'package:flutter/material.dart';

class CustomDateOrTime extends StatelessWidget {
   CustomDateOrTime({super.key, required this.eventImage , required this.eventType,required this.chooseDateOrTime,required this.onDateOrTimeTap});
 String eventType;
 String chooseDateOrTime;
  String eventImage;
  Function onDateOrTimeTap;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Image.asset(eventImage),
        SizedBox(width: width * .03,),
        Text(eventType,
        style: AppStyles.bold20dark.copyWith(
          fontSize: 16
        ),),
        Spacer(),
        TextButton(onPressed: ()
        {
          onDateOrTimeTap();
        },
         child: Text(chooseDateOrTime,
         style: AppStyles.bold20dark.copyWith(
          fontSize: 16,
          color: AppColors.primaryLight
         ),)
         )
      ],
    );
  }
}