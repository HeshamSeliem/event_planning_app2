import 'package:event_plan_app_3/dialog%20utiles/dialog_utiles.dart';
import 'package:event_plan_app_3/firebase_intrgration/firebase_utiles.dart';
import 'package:event_plan_app_3/flutter%20toast/flutter_tost.dart';
import 'package:event_plan_app_3/l10n/app_localizations.dart';
import 'package:event_plan_app_3/provider/user_provider.dart';
import 'package:event_plan_app_3/ui/HomeScreen/home_screen.dart';
import 'package:event_plan_app_3/ui/HomeScreen/tabs/homeTab/home_tab.dart';
import 'package:event_plan_app_3/ui/HomeScreen/widgets/custom_eleveted-button.dart';
import 'package:event_plan_app_3/ui/HomeScreen/widgets/custom_text_field.dart';
import 'package:event_plan_app_3/ui/auth/register_screen.dart';
import 'package:event_plan_app_3/utiles/app_colors.dart';
import 'package:event_plan_app_3/utiles/app_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:event_plan_app_3/utiles/asset_manager.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "login_screen";
   LoginScreen({super.key});
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.width;
    return Scaffold(
      // appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: height * .1,
          horizontal: width * .04,
        ),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(AssetManager.logo),
                // email text field
                CustomTextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                   validator: (email) {
                      if (email == null || email.trim().isEmpty) {
                        return 'Please enter your email';
                      }
              
                      final emailRegex = RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      );
              
                      if (!emailRegex.hasMatch(email.trim())) {
                        return 'Please enter a valid email';
                      }
              
                      return null;
                    },
                  hintText: AppLocalizations.of(context)!.email,
                  prefixIcon: Icon(Icons.email),
                ),
                SizedBox(height: height * .04),
                // password text field
                CustomTextField(
                  controller: passwordController,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "please enter password";
                      }
                      if (value.length < 6) {
                        return "password should be more than 6 characters ";
                      }
                      
                      if (!RegExp(r'[0-9]').hasMatch(value)) {
                        return 'Password must contain a number';
                      }
                      return null;
                    },
                  hintText: AppLocalizations.of(context)!.password,
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: Icon(Icons.visibility_off),
                  obSecure: true,
                ),
                SizedBox(height: height * .04),
                // forget password button
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        AppLocalizations.of(context)!.forget_password,
                        textAlign: TextAlign.end,
                        style: AppStyles.bold14primary.copyWith(
                          decoration: TextDecoration.underline,
                          fontSize: 17,
                          decorationColor: AppColors.primaryLight,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * .04),
                // log in eleveted button
                CustomElevetedButton(
                  onTapped: ()
                  {
                       onLogIn(context);
                  },
                  text: AppLocalizations.of(context)!.login,
                  style: AppStyles.bold24white.copyWith(fontSize: 20),
                  color: AppColors.primaryLight,
                ),
                SizedBox(height: height * .04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.donnot_have_account,
                      style: AppStyles.bold20secendary(context).copyWith(fontSize: 16),
                    ),
                    TextButton(
                      // create account routing
                      onPressed: () {
                        Navigator.pushNamed(context, RegisterScreen.routeName);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.create_account,
                        style: AppStyles.bold14primary.copyWith(
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * .04),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: AppColors.primaryLight,
                        thickness: 2,
                        indent: 10,
                        endIndent: 10,
                      ),
                    ),
                    Text(AppLocalizations.of(context)!.or,
                    style: AppStyles.bold14primary.copyWith(fontSize: 18),),
                    Expanded(
                      child: Divider(
                        color: AppColors.primaryLight,
                        thickness: 2,
                        indent: 10,
                        endIndent: 10,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * .04,),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.primaryLight
                    ),
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: CustomElevetedButton(
                    // log in with google
                    onTapped: (){
                      
                    },
                    prefexIcon: Image.asset(AssetManager.googleLogo),
                    text: AppLocalizations.of(context)!.login_with_google,
                     style: AppStyles.bold20primary(context),
                      color: AppColors.whiteColors
                      ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  void onLogIn(BuildContext context) async{
    if(formKey.currentState?.validate() == true)
    {
     // log in functionality
     DialogUtiles.showLoading(context: context, message: "loading...");
     try {
  final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: emailController.text,
    password: passwordController.text
  );
     var user =await FirebaseUtiles.readUserFromFirestore(credential.user?.uid ?? "");
     if(user == null) // user log in auth but not on firestore
     {
      return;
     } 
    var userProvider = Provider.of<UserProvider>(
        context,
        listen: false,
      );
   userProvider.updateUser(user);
  DialogUtiles.hideLoading(context: context);
  print("user logged in succefully");
  print("the user id : ${credential.user?.uid}");
  FlutterTost.toastMsg("you logged in succefully");
  Navigator.pushReplacementNamed(context, HomeScreen.routeName);
}
//  on FirebaseAuthException catch (e) {
//   if (e.code == 'user-not-found') {
//     print('No user found for that email.');
//   } else if (e.code == 'wrong-password') {
//     print('Wrong password provided for that user.');
//   }
  //    }
        catch(e)
{ 
   DialogUtiles.hideLoading(context: context);
   print(e.toString());
   DialogUtiles.showErrorDialog(context: context, message: e.toString());

}
      
    }
  }
}
