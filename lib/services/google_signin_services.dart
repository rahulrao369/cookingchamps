import 'package:cooking_champs/constant/app_state.dart';
import 'package:cooking_champs/enums/register_enum.dart';
import 'package:cooking_champs/model/post_model/parent_register_model.dart';
import 'package:cooking_champs/services/api_services.dart';
import 'package:cooking_champs/services/user_prefences.dart';
import 'package:cooking_champs/utils/navigators.dart';
import 'package:cooking_champs/views/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInServices{
  final FirebaseAuth auth = FirebaseAuth.instance;

//Comment
 /* Future<void> googleSignup(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      // Getting users credential
      UserCredential result = await auth.signInWithCredential(authCredential);
      User? user = result.user;
      String firstname = "";
      String lastName = "";
      if (user != null) {
        debugPrint("user....${user.displayName}");
        debugPrint("user....${user.email}");
        debugPrint("user....${user.uid}");
        if(user.displayName != null){
          var name = user.displayName!.split(" ");
          if(name.length > 1){
            firstname = name[0];
            lastName = name[1];
          }

        }

        String fcm = await PreferencesServices.getPreferencesData(PreferencesServices.fcm) ?? "";
        ParentRegisterModel  socialLoginModel = ParentRegisterModel(
            role: RegisterType.roleParent.value,
            firstName: firstname,
            lastName:lastName,
            email: user.email??"",
            loginType:LoginType.loginTypeGoogle.value ,
            fcmToken: fcm,
            deviceId: AppState.deviceIdStr,
            deviceType: AppState.devicetype);

        socialLogin(socialLoginModel,context);
      }  // if result not null we simply call the MaterialpageRoute,
      // for go to the HomePage screen
    }
  }*/

  socialLogin(ParentRegisterModel socialLoginModel,BuildContext context)async {

    await ApiServices.socialLoginRequest(context, socialLoginModel).then((onValue){
      CustomNavigators.pushRemoveUntil(DashBoardView(), context);
    });
  }

}