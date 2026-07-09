import 'package:event_plan_app_3/dialog%20utiles/dialog_utiles.dart';
import 'package:event_plan_app_3/firebase_intrgration/firebase_utiles.dart';
import 'package:event_plan_app_3/flutter%20toast/flutter_tost.dart';
import 'package:event_plan_app_3/l10n/app_localizations.dart';
import 'package:event_plan_app_3/models/my_user.dart';
import 'package:event_plan_app_3/provider/user_provider.dart';
import 'package:event_plan_app_3/ui/HomeScreen/home_screen.dart';
import 'package:event_plan_app_3/ui/HomeScreen/widgets/custom_eleveted-button.dart';
import 'package:event_plan_app_3/ui/HomeScreen/widgets/custom_text_field.dart';
import 'package:event_plan_app_3/ui/auth/log%20in/login_screen.dart';
import 'package:event_plan_app_3/utiles/app_colors.dart';
import 'package:event_plan_app_3/utiles/app_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:event_plan_app_3/utiles/asset_manager.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = "register_screen";
  RegisterScreen({super.key});
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var rePasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: AppColors.primaryLight),
        ),
        title: Text(
          AppLocalizations.of(context)!.register,
          style: AppStyles.bold20primary(context),
        ),
        centerTitle: true,
      ),
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
                // name text field
                CustomTextField(
                  controller: nameController,
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your name';
                    }

                    if (value.trim().length < 3) {
                      return 'Name must be at least 3 characters';
                    }

                    return null;
                  },
                  hintText: AppLocalizations.of(context)!.name,
                  prefixIcon: Icon(Icons.person),
                ),
                SizedBox(height: height * .04),
                // email text field
                CustomTextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
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
                  keyboardType: TextInputType.phone,
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "please enter password";
                    }
                    if (value.length < 6) {
                      return "password should be more than 6 characters ";
                    }
                    // if (!RegExp(r'[a-z]').hasMatch(value)) {
                    //   return 'Password must contain a lowercase letter';
                    // }

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
                CustomTextField(
                  keyboardType: TextInputType.phone,
                  controller: rePasswordController,
                  validator: (value) {
                    if (value != passwordController.text) {
                      return "repassword should match the below password";
                    }
                    if (value == null || value.trim().isEmpty) {
                      return "please enter repassword";
                    }
                    if (value.length < 6) {
                      return "password should be more than 6 characters ";
                    }

                    if (!RegExp(r'[0-9]').hasMatch(value)) {
                      return 'Password must contain a number';
                    }
                    return null;
                  },
                  hintText: AppLocalizations.of(context)!.re_password,
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: Icon(Icons.visibility_off),
                  obSecure: true,
                ),
                SizedBox(height: height * .04),
                CustomElevetedButton(
                  onTapped: () {
                    // create account on fire store
                    onRegister(context);
                  },
                  text: AppLocalizations.of(context)!.create_account,
                  style: AppStyles.bold16both,
                  color: AppColors.primaryLight,
                ),
                SizedBox(height: height * .04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.already_have_an_account,
                      style: AppStyles.bold20secendary(
                        context,
                      ).copyWith(fontSize: 16),
                    ),
                    TextButton(
                      // create account routing
                      onPressed: () {
                        Navigator.pushNamed(context, LoginScreen.routeName);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.login,
                        style: AppStyles.bold14primary.copyWith(
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onRegister(BuildContext context) async {
    if (formKey.currentState?.validate() == true) {
      // on register operation
      DialogUtiles.showLoading(context: context, message: "waiting...");
      try {
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );
            // add user to firestore
          MyUser  myUser = MyUser(
            id: credential.user!.uid,
             name: nameController.text, 
             email: emailController.text
             );
           await FirebaseUtiles.addUserToForestore(myUser);
           // update user provider to use it inside the app
           var userProvider = Provider.of<UserProvider>(
           context,
           listen: false,
            );
            userProvider.updateUser(myUser);
            // successed register
            DialogUtiles.hideLoading(context: context);
            FlutterTost.toastMsg("you created an account succefully");
             Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      }
      //  on FirebaseAuthException catch (e) {
      //   if (e.code == 'weak-password') {
      //     print('The password provided is too weak.');
      //   } else if (e.code == 'email-already-in-use') {
      //     print('The account already exists for that email.');
      //   }
     // } 
      catch (e) {
        print(e);
      DialogUtiles.hideLoading(context: context);
      DialogUtiles.showErrorDialog(context: context, message: e.toString());
      }
    }
  }
}
