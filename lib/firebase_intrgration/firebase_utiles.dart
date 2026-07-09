import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_plan_app_3/models/event_model.dart';
import 'package:event_plan_app_3/models/my_user.dart';

class FirebaseUtiles {
  
   static CollectionReference<EventModel> getEventCollection({required String userUid}){  // only to get collection to make the code more refactored
      
      return getUserCopllection().doc(userUid)
      .collection(EventModel.collectionName).
     withConverter<EventModel>(
      fromFirestore: (snapshot, options) => EventModel.fromJson(snapshot.data()!),
       toFirestore:(eventModel, _) => eventModel.toJson(),
       );
   }
   static Future<void> addEventToFirebase(EventModel eventModel,String uid)async{

    var collection = getEventCollection(userUid: uid);
    var docRef = collection.doc();
    eventModel.id = docRef.id;     // to generate the id automaticlly
    await docRef.set(eventModel);
     print("Document ID: ${docRef.id}");
   }
     // add user functionallity
      
    static CollectionReference<MyUser> getUserCopllection()
      {
        return FirebaseFirestore.instance.collection(MyUser.collectionName)
        .withConverter<MyUser>(
          fromFirestore: (snapshot, options) => MyUser.fromJson(snapshot.data()!),
           toFirestore: (myUser, _) => myUser.toJson(),
           );
      }
      // add user to firestore
      // collection   => document => set
     static Future<void> addUserToForestore(MyUser myUser)
      {
        return getUserCopllection().doc(myUser.id).set(myUser);
      }
       
      static Future<MyUser?> readUserFromFirestore(String id)
      async {
         var querySnapshot = await getUserCopllection().doc(id).get();
        return querySnapshot.data();
       }
}