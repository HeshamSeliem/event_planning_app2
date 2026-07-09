import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_plan_app_3/models/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  MyUser? currentUser;
   void updateUser(MyUser user)
   {
    currentUser = user;
    notifyListeners();
   }
}
//   Future<void> loadUser() async {
//   try {
//     String uid = FirebaseAuth.instance.currentUser!.uid;

//     print("UID: $uid");

//     var doc = await FirebaseFirestore.instance
//         .collection('users')
//         .doc(uid)
//         .get();

//     print("Document Exists: ${doc.exists}");
//     print(doc.data());

//     currentUser = MyUser.fromJson(doc.data()!);

//     notifyListeners();
//   } catch (e) {
//     print("ERROR: $e");
//   }
//   }
// }