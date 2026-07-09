import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerProvider extends ChangeNotifier{

 DateTime? selectedDate;
 String? formatedDate;
  void onDateClock(BuildContext context) async{
   var choosenDate = await showDatePicker(
      context: context,
       firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365))
        );
        if(choosenDate != null)
        {
          selectedDate = choosenDate;
          formatedDate = DateFormat('dd-MMM-yyyy').format(selectedDate!);
         notifyListeners();
        }
}
}