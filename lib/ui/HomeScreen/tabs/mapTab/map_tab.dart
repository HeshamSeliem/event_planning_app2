import 'package:event_plan_app_3/utiles/app_styles.dart';
import 'package:flutter/material.dart';

class MapTab extends StatelessWidget {
  const MapTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: Text(
          "Map Tab",
          style: AppStyles.bold20primary(context),
        ),
      ),
    );
  }
}