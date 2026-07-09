import 'package:flutter/material.dart';

class DialogUtiles {
  static void showLoading(
    {required BuildContext context , required String message}
  )
   {
     showDialog(
      barrierDismissible: false,
      context: context, 
      builder: (context) {
       return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(message),
              ),
            ],
          ),
        );
      },
      );
   }
   static void hideLoading({required BuildContext context})
   {
    Navigator.pop(context);
   }
    static void showErrorDialog({
      required BuildContext context,
      String title = "error",
      required String message,
      })
    {
      showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
        title: Text(title),
        content: Text(message.toString()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      );
      }
   );
    }
}