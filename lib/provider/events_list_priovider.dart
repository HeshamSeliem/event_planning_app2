
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_plan_app_3/firebase_intrgration/firebase_utiles.dart';
import 'package:event_plan_app_3/flutter%20toast/flutter_tost.dart';
import 'package:event_plan_app_3/l10n/app_localizations.dart';
import 'package:event_plan_app_3/models/event_model.dart';
import 'package:flutter/foundation.dart';
import 'package:event_plan_app_3/utiles/asset_manager.dart';
import 'package:flutter/material.dart';

class EventsListPriovider extends ChangeNotifier{
  int selectedIndex = 0;
  List<EventModel> eventsList = [];
  List<String> categories = [];
 
 List<EventModel> favouriteList=[];
  String favouriteIcon = AssetManager.unSelectedHeart;
  void getCategories(BuildContext context) {
  final localizations = AppLocalizations.of(context)!;

  categories = [
    localizations.all,
    localizations.sports,
    localizations.meeting,
    localizations.holiday,
    localizations.reading,
    localizations.eating,
    localizations.gaming,
  ];
}
  void getAllEvents({required String userId})
   async{
    print("on start on function");
    QuerySnapshot<EventModel> querySnapshot = await  FirebaseUtiles.getEventCollection(userUid: userId).get();
   eventsList =
    querySnapshot.docs.map(
      (doc){ var data = doc.data().toJson();
    data['id'] = doc.id;
    return EventModel.fromJson(data);
   }).toList();
    notifyListeners();
    //eventsList = querySnapshot.docs;
        print("on end on function");
    
   }
   void changeSelectedIndex(int index , {required String userId})
   {
      selectedIndex = index;
      getFilteredEvents(userId: userId);
     // notifyListeners();
   }
   //todo: filter the list 
   void getFilteredEvents({required String userId}) async {
  QuerySnapshot<EventModel> querySnapshot;

  if (categories[selectedIndex] == 'All') {
    querySnapshot =
        await FirebaseUtiles.getEventCollection(userUid: userId).get();
  } else {
    querySnapshot = await FirebaseUtiles.getEventCollection(userUid: userId)
        .where(
          'eventName',
          isEqualTo: categories[selectedIndex],
        )
        .get();
  }

  eventsList =
      querySnapshot.docs.map(
      (doc){ var data = doc.data().toJson();
    data['id'] = doc.id;
    return EventModel.fromJson(data);
   }).toList();
      // to sort the list 
       eventsList.sort(
          (a, b) => a.date.compareTo(b.date),
            );
  notifyListeners();
}
  //  void getFilteredEvents()
  //  async{
    
  //   QuerySnapshot<EventModel> querySnapshot = await  FirebaseUtiles.getEventCollection()
  //   .where('eventName',isEqualTo: categories[selectedIndex]).get();
    
  //   eventsList =
  //   querySnapshot.docs.map((doc) => doc.data()).toList();

  // //   eventsList = eventsList.where((event) {
  // //              return event.eventName == categories[selectedIndex];
  // //  }).toList();
  //   notifyListeners();
  //   //eventsList = querySnapshot.docs;
    
  //  }

   void updateIsFavourite(EventModel eventModel, {required String userId})
   {
     FirebaseUtiles.getEventCollection(userUid: userId).doc(eventModel.id).
     update({'isFavorite' : !eventModel.isFavorite}).timeout(
      Duration(milliseconds: 500),onTimeout: () {
         print("event updated succefuly");
         FlutterTost.toastMsg("Event updated Successfully");
      }
         ,);
      // untill now the change doesnot be real-time
      //to change now we update the lists depebing on selectedindex
      selectedIndex == 0 ?
      getAllEvents(userId: userId)
      :getFilteredEvents(userId: userId);
      getFavouriteList(userId: userId);    // important trick
      notifyListeners();
   }
   void changeFavouriteIcon(EventModel event)
   {
  event.isFavorite = !event.isFavorite;
  notifyListeners();
} 
// my solution but i fount the better on love tab
 void getFavouriteList({required String userId})
async {
    var querySnapshot = await FirebaseUtiles.getEventCollection(userUid: userId)
    .where("isFavorite", isEqualTo: true).get();
     favouriteList = querySnapshot.docs.map(
      (doc){ var data = doc.data().toJson();
    data['id'] = doc.id;
    return EventModel.fromJson(data);
   }).toList();
     notifyListeners();
 }
}