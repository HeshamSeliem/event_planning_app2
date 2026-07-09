import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FlutterTost {

   static toastMsg(String msg)
   {
   return Fluttertoast.showToast(
  msg: msg,
  toastLength: Toast.LENGTH_LONG,
  gravity: ToastGravity.BOTTOM,
  backgroundColor: Colors.green,
  textColor: Colors.white,
  fontSize: 16,
);
   }
}