import 'package:event_plan_app_3/l10n/app_localizations.dart';
import 'package:event_plan_app_3/models/event_model.dart';
import 'package:event_plan_app_3/provider/events_list_priovider.dart';
import 'package:event_plan_app_3/provider/user_provider.dart';
import 'package:event_plan_app_3/ui/HomeScreen/tabs/homeTab/widgets/horesontal_list_view_category.dart';
import 'package:event_plan_app_3/ui/HomeScreen/tabs/homeTab/widgets/vertical_list_widget.dart';
import 'package:event_plan_app_3/ui/HomeScreen/widgets/custom_text_field.dart';
import 'package:event_plan_app_3/utiles/app_colors.dart';
import 'package:event_plan_app_3/utiles/app_styles.dart';
import 'package:event_plan_app_3/utiles/asset_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoveTab extends StatefulWidget {
   LoveTab({super.key});

  @override
  State<LoveTab> createState() => _LoveTabState();
}

class _LoveTabState extends State<LoveTab> {
 //List<EventModel> favouriteList = [];
 void initState() {
    super.initState();
    // ✅ صح - بتتنادى مرة واحدة بس عند فتح الشاشة
    Future.microtask(() {
      var userProvider = Provider.of<UserProvider>(context,listen: false);
      Provider.of<EventsListPriovider>(context, listen: false)
          .getFavouriteList(userId: userProvider.currentUser!.id);
    });
  }
  @override
  Widget build(BuildContext context) {
   var favouriteProvider = Provider.of<EventsListPriovider>(context);
    
     
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryLight,
      ),
      
      body: Padding(
        padding: const EdgeInsets.only(left: 16,right: 16,bottom: 16,top: 50),
        child: Column(
          children: [
            CustomTextField(
              writtenStyle: AppStyles.bold14primary.copyWith(
                fontSize: 18
              ),
              hintText: AppLocalizations.of(context)!.search_Event,
              hintStyle: AppStyles.bold14primary,
              prefixIcon: Image(image: AssetImage(AssetManager.searchIcon)),
              borderColor: AppColors.primaryLight,
            ),
            const SizedBox(height: 8,),
           
            
            Expanded(
              child:
              favouriteProvider.favouriteList.isEmpty 
               ? Center(child: Text("No Events Favourite"))
               :
               ListView.separated(
                padding: EdgeInsets.all(0),
                itemBuilder: (context, index) => VerticalListWidget(
                  eventModel: favouriteProvider.favouriteList[index]
                  ), //VerticalListWidget(),
                 separatorBuilder: (context, index) => SizedBox(height: 5,),
                  itemCount: favouriteProvider.favouriteList.length
                  ),
            )
          ],
        ),
      )
    );
  }
}