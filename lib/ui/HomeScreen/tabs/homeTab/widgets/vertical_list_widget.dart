import 'package:event_plan_app_3/models/event_model.dart';
import 'package:event_plan_app_3/provider/events_list_priovider.dart';
import 'package:event_plan_app_3/provider/user_provider.dart';
import 'package:event_plan_app_3/utiles/app_colors.dart';
import 'package:event_plan_app_3/utiles/app_styles.dart';
import 'package:event_plan_app_3/utiles/asset_manager.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class VerticalListWidget extends StatelessWidget {
   VerticalListWidget({super.key,required this.eventModel});
  EventModel eventModel;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var eventFavouriteProvider = Provider.of<EventsListPriovider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    return Container(
            margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            height: height * .3,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(eventModel.image),
              fit: BoxFit.fill)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      //margin: EdgeInsets.only(left: 10,top: 5),
                      width: width * .1,
                      height: height * .06,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.whiteColors
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("${eventModel.date.day}",style: AppStyles.regular14white(context),),
                          Text("${DateFormat('MMM').format(eventModel.date)}",style: AppStyles.regular14white(context),),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      height: height * .06,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.whiteColors
                      ),
                      child: Row(
                        children: [
                          Text(eventModel.title,style: AppStyles.bold16both.copyWith(
                            color: AppColors.darkColors
                          ),),
                          Spacer(),
                          InkWell(
                            onTap: (){
                              // update favourite function
                               eventFavouriteProvider.updateIsFavourite(eventModel, userId: userProvider.currentUser!.id);
                              // eventFavouriteProvider.changeFavouriteIcon(eventModel);
                            },
                            child: Image.asset(
                              eventModel.isFavorite?
                              AssetManager.selectedHeart
                              :AssetManager.unSelectedHeart,
                              width: width* .1,)),
                        ],
                      ),
                    )
                     
                  ],
                ),
              ),
            );
  }
}