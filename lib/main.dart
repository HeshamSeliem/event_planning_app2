import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_plan_app_3/firebase_options.dart';
import 'package:event_plan_app_3/l10n/app_localizations.dart';
import 'package:event_plan_app_3/provider/app_category_provider.dart';
import 'package:event_plan_app_3/provider/app_language_provider.dart';
import 'package:event_plan_app_3/provider/app_theme_provider.dart';
import 'package:event_plan_app_3/provider/bottomNavProvider.dart';
import 'package:event_plan_app_3/provider/date_picker_provider.dart';
import 'package:event_plan_app_3/provider/events_list_priovider.dart';
import 'package:event_plan_app_3/provider/user_provider.dart';
import 'package:event_plan_app_3/ui/HomeScreen/home_screen.dart';
import 'package:event_plan_app_3/ui/HomeScreen/tabs/homeTab/add%20event/add_event_screen.dart';
import 'package:event_plan_app_3/ui/auth/log%20in/login_screen.dart';
import 'package:event_plan_app_3/ui/auth/register_screen.dart';
import 'package:event_plan_app_3/utiles/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
   //await FirebaseFirestore.instance.disableNetwork(); // to integrate with firebase fire stor offline
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AppLanguageProvider(),),
      ChangeNotifierProvider(create: (context) => AppThemeProvider(),),
      ChangeNotifierProvider(create: (context) => Bottomnavprovider()),
      ChangeNotifierProvider(create: (context) => AppCategoryProvider()),
      ChangeNotifierProvider(create: (context) => DatePickerProvider()),
      ChangeNotifierProvider(create: (context) => EventsListPriovider()),
       ChangeNotifierProvider(create: (context) => UserProvider())
    ],
    child: const MyApp())
    )
    ;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.routeName,
      routes: {
        HomeScreen.routeName : (context) => HomeScreen(),
        LoginScreen.routeName : (context) => LoginScreen(),
        RegisterScreen.routeName : (context) => RegisterScreen(),
        AddEventScreen.routeName : (context) => AddEventScreen(),

      },
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.appTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(languageProvider.appLanguage),
    );
  }
}
