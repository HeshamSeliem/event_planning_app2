import 'package:event_plan_app_3/l10n/app_localizations.dart';
import 'package:event_plan_app_3/provider/app_language_provider.dart';
import 'package:event_plan_app_3/provider/app_theme_provider.dart';
import 'package:event_plan_app_3/provider/events_list_priovider.dart';
import 'package:event_plan_app_3/provider/user_provider.dart';
import 'package:event_plan_app_3/ui/HomeScreen/widgets/custom_eleveted-button.dart';
import 'package:event_plan_app_3/ui/HomeScreen/widgets/language_buttom_sheet.dart';
import 'package:event_plan_app_3/ui/HomeScreen/widgets/theme_buttom_sheet.dart';
import 'package:event_plan_app_3/ui/auth/log%20in/login_screen.dart';
import 'package:event_plan_app_3/utiles/app_colors.dart';
import 'package:event_plan_app_3/utiles/app_styles.dart';
import 'package:event_plan_app_3/utiles/asset_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.height;
    var languagePrivider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    var eventListProvider = Provider.of<EventsListPriovider>(context);
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: height * .2,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(70)),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadiusGeometry.only(
                      topRight: Radius.circular(50),
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                    child: Image.asset(
                      AssetManager.h,
                      width: width * .14,
                      height: height * .12,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                // this comes from firestore
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(userProvider.currentUser?.name ?? "loading", style: AppStyles.bold24white),
                        Text(
                          userProvider.currentUser?.email ?? "loading",
                          style: AppStyles.bold16both,
                          //  maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.language,
                  style: AppStyles.bold20secendary(context),
                ),
                SizedBox(height: height * 0.02),
                InkWell(
                  onTap: () {
                    showLanguageButtomSheet();
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.primaryLight),
                    ),
                    child: Row(
                      children: [
                        Text(
                          languagePrivider.enSelected
                              ? AppLocalizations.of(context)!.english
                              : AppLocalizations.of(context)!.arabic,
                          style: AppStyles.bold20primary(context),
                        ),
                        Spacer(flex: 1),
                        Icon(
                          Icons.arrow_drop_down,
                          size: 30,
                          color: AppColors.primaryLight,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: height * 0.02), //Theme buttom sheet
                Text(
                  AppLocalizations.of(context)!.theme,
                  style: AppStyles.bold20secendary(context),
                ),
                SizedBox(height: height * 0.02),
                InkWell(
                  onTap: () {
                    showThemeButtomSheet();
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.primaryLight),
                    ),
                    child: Row(
                      children: [
                        Text(
                          themeProvider.isDarkMode()
                              ? AppLocalizations.of(context)!.dark
                              : AppLocalizations.of(context)!.light,
                          style: AppStyles.bold20primary(context),
                        ),
                        Spacer(flex: 1),
                        Icon(
                          Icons.arrow_drop_down,
                          size: 30,
                          color: AppColors.primaryLight,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          // logout button\
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomElevetedButton(
              onTapped: (){
                // log out functionalitybb
                //refresh the list of events
                eventListProvider.eventsList = [];
                Navigator.popAndPushNamed(context, LoginScreen.routeName);
              },
              color: AppColors.redColor,
              text: AppLocalizations.of(context)!.logout,
              style: AppStyles.bold20dark.copyWith(
                color: AppColors.whiteColors,
              ),
              prefexIcon: Icon(
                Icons.logout,
                size: 25,
                color: AppColors.whiteColors,
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  void showLanguageButtomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => LanguageButtomSheet(),
    );
  }

  void showThemeButtomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ThemeButtomSheet(),
    );
  }
}
