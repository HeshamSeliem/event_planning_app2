
import 'package:event_plan_app_3/firebase_intrgration/firebase_utiles.dart';
import 'package:event_plan_app_3/flutter%20toast/flutter_tost.dart';
import 'package:event_plan_app_3/l10n/app_localizations.dart';
import 'package:event_plan_app_3/models/event_model.dart';
import 'package:event_plan_app_3/provider/app_category_provider.dart';
import 'package:event_plan_app_3/provider/date_picker_provider.dart';
import 'package:event_plan_app_3/provider/events_list_priovider.dart';
import 'package:event_plan_app_3/provider/user_provider.dart';
import 'package:event_plan_app_3/ui/HomeScreen/tabs/homeTab/add%20event/custom_date_or_time.dart';
import 'package:event_plan_app_3/ui/HomeScreen/widgets/custom_eleveted-button.dart';
import 'package:event_plan_app_3/ui/HomeScreen/widgets/custom_text_field.dart';
import 'package:event_plan_app_3/utiles/app_colors.dart';
import 'package:event_plan_app_3/utiles/app_styles.dart';
import 'package:event_plan_app_3/utiles/asset_manager.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
//import 'package:event_plan_app_3/utiles/asset_manager.dart';


class AddEventScreen extends StatefulWidget {
   AddEventScreen({super.key});

  static const String routeName = 'add event';

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  var formKey = GlobalKey<FormState>();
  // DateTime? selectedDate;
  // String? formatedDate; // from provider save the date
  TimeOfDay? selectedTime;
  String? formatedTime; // save the time
  var titleController = TextEditingController(); // save the title
  var descreptionController = TextEditingController(); // save the descreption
  String selectedImage = ""; // save the image url
  String selectedEvent = "";
  @override 
  Widget build(BuildContext context) {
    List<String> categories = [
      AppLocalizations.of(context)!.sports,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.reading,
      AppLocalizations.of(context)!.eating,
      AppLocalizations.of(context)!.gaming,
    ];

    List<String> categoriesImage = [
      AssetManager.sportBg,
      AssetManager.meetingBg,
      AssetManager.holidayBg,
      AssetManager.bookBg,
      AssetManager.eatingBg,
      AssetManager.gamingBg,
    ];

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    int listViewIndex = 0;
    var categoryProvider = Provider.of<AppCategoryProvider>(context);
    var datePickerProvider = Provider.of<DatePickerProvider>(context);
    //var eventsListProvider = Provider.of<EventsListPriovider>(context);
    selectedImage = categoriesImage[categoryProvider.selectedIndex]; // save the url name
    selectedEvent = categories[categoryProvider.selectedIndex]; // save the event name 
    print("selected image : ${selectedImage}");
     print("selected event : ${selectedEvent}");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        leading: Icon(
          Icons.arrow_back,
          color: AppColors.primaryLight,
        ),
        title: Text(
          AppLocalizations.of(context)!.create_event,
          style: AppStyles.bold20primary(context),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * .04,
          vertical: height * .01

        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16)
                ),
                child: Image.asset(
                  selectedImage,
                ),
              ),
              SizedBox(height: height * .01),
              SizedBox(
                height: height * .06,
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      SizedBox(width: width * .02),
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      //listViewIndex =index;
                      categoryProvider.changeIndex(index);
                    },
                    child: horesontalListView(
                      isTapped: categoryProvider.selectedIndex == index,
                      height: height,
                      width: width,
                      index: index,
                     // categories: categories,
                     category: categories[index]
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * .02,),
              // i will create aform to validate it 

             Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(AppLocalizations.of(context)!.title,
              style: AppStyles.bold20dark,),
              SizedBox(height: height * .02,),
              CustomTextField(
                controller: titleController,
                // validator functionality
                validator: (text) {
                  if(text == null || text.isEmpty)
                  {
                    return AppLocalizations.of(context)!.please_enter_event_title; //not valid
                  }
                  return null; // valid
                },
                prefixIcon: Image.asset(AssetManager.editIcon),
                hintText: AppLocalizations.of(context)!.event_title,
              ),
              SizedBox(height: height * .02,),
               Text(AppLocalizations.of(context)!.description,
              style: AppStyles.bold20dark,),
               SizedBox(height: height * .02,),
                CustomTextField(
                  controller: descreptionController,
                  validator: (text) {
                    if(text == null || text.isEmpty)
                    {
                      return AppLocalizations.of(context)!.please_enter_event_descrprtion;//invalid
                    }
                    return null ; //valid
                  },
                  hintText: AppLocalizations.of(context)!.event_description,
                  maxLines: 3,
                ),
              SizedBox(height: height * .02,),
              // date candidate
              CustomDateOrTime(
                eventType:AppLocalizations.of(context)!.event_date,
                eventImage: AssetManager.dateIcon,
                chooseDateOrTime: datePickerProvider.selectedDate == null ? AppLocalizations.of(context)!.choose_date
                : datePickerProvider.formatedDate!,
                onDateOrTimeTap: (){
                  datePickerProvider.onDateClock(context);
                },
              ),
              // time candle picker
              CustomDateOrTime(
                eventType: AppLocalizations.of(context)!.event_time,
                eventImage: AssetManager.timeIcon,
                chooseDateOrTime:selectedTime == null ? AppLocalizations.of(context)!.choose_time
                : formatedTime!,
                onDateOrTimeTap: (){
                  onTimeClick();
                 
                },
              ),
              SizedBox(height: height * .01,),
              Text(AppLocalizations.of(context)!.location,
              style: AppStyles.bold16dark,),
              SizedBox(height: height * .01,),
               Container(
                height: height * .08,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: BoxBorder.all(
                    width: 1,
                    color: AppColors.primaryLight
                  )
                ),
                child: Row(
                  children: [
                     SizedBox(width: width * .02,),
                    Image.asset(AssetManager.locationIcon),
                    SizedBox(width: width * .02,),
                    Text(AppLocalizations.of(context)!.choose_event_location,
                    style: AppStyles.bold16dark,),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios_outlined)
                  ],
                ),
               ),
               SizedBox(height: height * .02,),
               CustomElevetedButton(
                onTapped: (){
                  onAddEventClick();
                  // Navigator.pop(context);
                },
                 text: AppLocalizations.of(context)!.add_event,
                  style: AppStyles.bold16dark.copyWith(
                    color: AppColors.whiteColors
                  ),
                   color: AppColors.primaryLight
                   )

              ],
             ))
            ],
          ),
        ),
      ),
    );
  }

  Widget horesontalListView({
    required bool isTapped,
    required dynamic height,
    required dynamic width,
    required int index,
    //required List<String> categories,
    required String category
  }) {
    return Container(
      alignment: Alignment.center,
      width: width * .3,
      height: height * .05,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: isTapped
              ? AppColors.whiteColors
              : AppColors.primaryLight,
        ),
        color: isTapped
            ? AppColors.primaryLight
            : AppColors.whiteColors,
      ),
      child: Text(
       // categories[index],
       category,
        style: AppStyles.bold16both.copyWith(
          color: isTapped
              ? AppColors.whiteColors
              : AppColors.primaryLight,
        ),
      ),
    );
  }

  void onAddEventClick() async {
  if (formKey.currentState?.validate() == true) {
    try {
      final dateProvider = context.read<DatePickerProvider>();

      EventModel eventModel = EventModel(
        eventName: selectedEvent,
        image: selectedImage,
        title: titleController.text,
        descreption: descreptionController.text,
        date: dateProvider.selectedDate!,
        time: formatedTime!,
      );
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      await FirebaseUtiles.addEventToFirebase(eventModel,userProvider.currentUser!.id);
      // events provider 
      var eventsListPriovider = context.read<EventsListPriovider>();
         eventsListPriovider.getAllEvents(userId: userProvider.currentUser!.id);  // to refresh all events on list
         Navigator.pop(context);
      FlutterTost.toastMsg("Event Added Successfully");
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Failed to add event",
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }
}

//   void onDateClock() async{
//    var choosenDate = await showDatePicker(
//       context: context,
//        firstDate: DateTime.now(),
//         lastDate: DateTime.now().add(Duration(days: 365))
//         );
//         if(choosenDate != null)
//         {
//           selectedDate = choosenDate;
//           formatedDate = DateFormat('dd-MM-yyyy').format(selectedDate!);
        
//         }
//   }
    void onTimeClick()
    async{
     var choosenTime =await showTimePicker(
        context: context,
         initialTime: TimeOfDay.now()
         );
         if(choosenTime != null)
         {
         selectedTime = choosenTime;
        formatedTime = selectedTime!.format(context);
         setState(() {
           
         });
         }
    }
 }