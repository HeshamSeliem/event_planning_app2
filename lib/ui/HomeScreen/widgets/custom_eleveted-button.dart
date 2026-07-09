import 'package:event_plan_app_3/l10n/app_localizations.dart';
import 'package:event_plan_app_3/utiles/app_colors.dart';
import 'package:event_plan_app_3/utiles/app_styles.dart';
import 'package:flutter/material.dart';

class CustomElevetedButton extends StatelessWidget {
  CustomElevetedButton({
    required this.onTapped,
    required this.text,
    required this.style,
    required this.color,
    this.prefexIcon,
  });
  Function onTapped;
  Color color;
  String text;
  TextStyle style;
  Widget? prefexIcon;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.height;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(vertical: height * .022),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(12),
        ),
      ),
      // log out functionality
      onPressed: () {
        onTapped();
      },
      child: 
      prefexIcon != null ?
       Row(
        children: [
          SizedBox(width: width * .08),
          prefexIcon ?? SizedBox(),
          SizedBox(width: width * .02),
          Text(text, style: style,
          ),
        ],
      )
      : Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text, style: style,
          ),
        ],
      )
    );
  }
}
