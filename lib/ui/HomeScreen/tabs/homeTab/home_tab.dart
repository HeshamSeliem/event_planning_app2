import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_plan_app_3/firebase_intrgration/firebase_utiles.dart';
import 'package:event_plan_app_3/l10n/app_localizations.dart';
import 'package:event_plan_app_3/models/event_model.dart';
import 'package:event_plan_app_3/provider/events_list_priovider.dart';
import 'package:event_plan_app_3/provider/user_provider.dart';
import 'package:event_plan_app_3/ui/HomeScreen/tabs/homeTab/widgets/horesontal_list_view_category.dart';
import 'package:event_plan_app_3/ui/HomeScreen/tabs/homeTab/widgets/vertical_list_widget.dart';
import 'package:event_plan_app_3/utiles/app_colors.dart';
import 'package:event_plan_app_3/utiles/app_styles.dart';
import 'package:event_plan_app_3/utiles/asset_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  bool isTapped = false;
  //  List<String> categories(BuildContext context) { return[
  //     AppLocalizations.of(context)!.all,
  //     AppLocalizations.of(context)!.sports,
  //     AppLocalizations.of(context)!.meeting,
  //     AppLocalizations.of(context)!.holiday,
  //     AppLocalizations.of(context)!.reading,
  //     AppLocalizations.of(context)!.eating,
  //     AppLocalizations.of(context)!.gaming,
  //   ];}
    List<EventModel> filteredEvents = [];
  late EventsListPriovider eventsListPriovider;
   // @override
// void initState() {
//   super.initState();

//   WidgetsBinding.instance.addPostFrameCallback((_) {
//     Provider.of<UserProvider>(
//       context,
//       listen: false,
//     ).loadUser();
//   });
// }
  @override
  Widget build(BuildContext context) {

    var userProvider = Provider.of<UserProvider>(context);
    eventsListPriovider = Provider.of<EventsListPriovider>(context);
    eventsListPriovider.getCategories(context);
    if(eventsListPriovider.eventsList.isEmpty)
    {
    eventsListPriovider.getFilteredEvents(userId: userProvider.currentUser!.id);
    }
   
   
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
  
    // جربها
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * 0.1,
        //backgroundColor: AppColors.primaryLight,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.welcomeMessage,
              style: AppStyles.regular14whiteInDarkTheme,
            ),
            Text(
              userProvider.currentUser?.name ?? "error",
              style: AppStyles.bold24white,
            ),
            Row(
              children: [
                Image.asset(AssetManager.unSelectedMap, width: 20, height: 20),
                const SizedBox(width: 5),
                Text(
                  AppLocalizations.of(context)!.cairo,
                  style: AppStyles.regular14whiteInDarkTheme,
                ),
                const SizedBox(width: 5),
                Text(
                  AppLocalizations.of(context)!.egypt,
                  style: AppStyles.regular14whiteInDarkTheme,
                ),
              ],
            ),
          ],
        ),
        actions: [
          Image.asset(AssetManager.sunIcon, width: 24, height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              alignment: Alignment.center,
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.whiteColors,
              ),
              child: Text(
                AppLocalizations.of(context)!.en,
                style: AppStyles.regular14white(context),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: height * .09,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                SizedBox(
                  height: height * .06,
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        SizedBox(width: width * .02),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                       eventsListPriovider.changeSelectedIndex(index,userId: userProvider.currentUser!.id);
                      },
                      child: HoresontalListViewCategory(
                        onTap: eventsListPriovider.selectedIndex == index,
                        categories: eventsListPriovider.categories,
                        index: index,
                      ),
                    ),
                    itemCount: eventsListPriovider.categories.length,
                  ),
                ),
              ],
            ),
          ),
          // body list content
               

          eventsListPriovider.eventsList.isEmpty ?
           Center(child: Text("No Events Added" ,style: AppStyles.bold24white.copyWith(color: AppColors.darkColors),))
          
         
          :Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => VerticalListWidget(
                eventModel: eventsListPriovider.eventsList[index],
              ),
              itemCount:eventsListPriovider.eventsList.length,
              ),
          )
          
        ],
      ),
    );
  }
  //  void filterList(int index){
  //    filteredEvents =
  //   eventsListPriovider.eventsList[index].eventName == "all"
  //       ? eventsListPriovider.eventsList
  //       : eventsListPriovider.eventsList
  //           .where((event) =>
  //               event.eventName == categories(context)[selectedIndex])
  //           .toList();
  //  }
}
