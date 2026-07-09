import 'package:event_plan_app_3/l10n/app_localizations.dart';
import 'package:event_plan_app_3/provider/app_language_provider.dart';
import 'package:event_plan_app_3/utiles/app_colors.dart';
import 'package:event_plan_app_3/utiles/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageButtomSheet extends StatelessWidget {
  const LanguageButtomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var languagePrivider = Provider.of<AppLanguageProvider>(context,listen: true);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: ()
            {
               languagePrivider.changeAppLanguage("en");
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.english,style:
                languagePrivider.enSelected ?
                AppStyles.bold20primary(context) :
                 AppStyles.bold20dark,
                 ),
                languagePrivider.enSelected ? Icon(Icons.check,color: AppColors.primaryLight,size: 25,)
                : const SizedBox()
              ],
            )
            //: Text(AppLocalizations.of(context)!.english,style: AppStyles.bold20primary,),
          ),
          SizedBox(height: height * 0.02,),
          InkWell(
            onTap: (){
              languagePrivider.changeAppLanguage("ar");
            },
            child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.arabic,style:
                languagePrivider.arSelected ?
                 AppStyles.bold20primary(context)
                 : AppStyles.bold20dark
                 ),
                 languagePrivider.arSelected ? Icon(Icons.check,color: AppColors.primaryLight,size: 25,)
                : const SizedBox()
              ],
            ))
        ],
      ),
    );
  }
}