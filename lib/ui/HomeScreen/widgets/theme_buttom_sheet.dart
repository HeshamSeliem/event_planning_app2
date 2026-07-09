import 'package:event_plan_app_3/l10n/app_localizations.dart';
import 'package:event_plan_app_3/provider/app_language_provider.dart';
import 'package:event_plan_app_3/provider/app_theme_provider.dart';
import 'package:event_plan_app_3/utiles/app_colors.dart';
import 'package:event_plan_app_3/utiles/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeButtomSheet extends StatelessWidget {
  const ThemeButtomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<AppThemeProvider>(context, listen: true);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () {
              themeProvider.changeAppTheme(ThemeMode.light);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.light,
                  style: themeProvider.isDarkMode()
                      ? AppStyles.bold20secendary(context)
                      : AppStyles.bold20primary(context),
                ),
                themeProvider.isDarkMode()
                    ? const SizedBox()
                    : Icon(
                        Icons.check,
                        color: AppColors.primaryLight,
                        size: 25,
                      ),
              ],
            ),
            //: Text(AppLocalizations.of(context)!.english,style: AppStyles.bold20primary,),
          ),
          SizedBox(height: height * 0.02),
          InkWell(
            onTap: () {
              themeProvider.changeAppTheme(ThemeMode.dark);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.dark,
                  style: themeProvider.isDarkMode()
                      ? AppStyles.bold20primary(context)
                      : AppStyles.bold20dark,
                ),
                themeProvider.isDarkMode()
                    ? Icon(Icons.check, color: AppColors.primaryLight, size: 25)
                    : const SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
