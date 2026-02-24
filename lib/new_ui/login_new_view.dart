// import 'dart:io';
//
// import 'package:cooking_champs/constant/app_state.dart';
// import 'package:cooking_champs/constant/assets_path.dart';
// import 'package:cooking_champs/constant/my_color.dart';
// import 'package:cooking_champs/constant/my_fonts_style.dart';
// import 'package:cooking_champs/constant/sized_box.dart';
// import 'package:cooking_champs/constant/stringfile.dart/language.dart';
// import 'package:cooking_champs/enums/register_enum.dart';
// import 'package:cooking_champs/model/post_model/login_request_model.dart';
// import 'package:cooking_champs/new_ui/forgot_password.dart';
// import 'package:cooking_champs/new_ui/register_new/register_new_view.dart';
// import 'package:cooking_champs/services/api_services.dart';
// import 'package:cooking_champs/services/user_prefences.dart';
// import 'package:cooking_champs/utils/common_widget.dart';
// import 'package:cooking_champs/utils/keyboardoverlay.dart';
// import 'package:cooking_champs/utils/navigators.dart';
// import 'package:cooking_champs/utils/utility.dart';
// import 'package:cooking_champs/views/dashboard.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
//
// import 'register_new/who_joining_new.dart';
//
// class WelcomeCookingChampsView extends StatefulWidget {
//   const WelcomeCookingChampsView({super.key});
//
//   @override
//   State<WelcomeCookingChampsView> createState() =>
//       _WelcomeCookingChampsViewState();
// }
//
// class _WelcomeCookingChampsViewState extends State<WelcomeCookingChampsView> {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   final FocusNode emailFocusNode = FocusNode();
//   final FocusNode passwordFocusNode = FocusNode();
//
//   bool isPassHide = true;
//   bool isEmailReadOnly = true;
//   bool isPasswordReadOnly = true;
//
//   @override
//   void dispose() {
//     emailController.dispose();
//     emailFocusNode.dispose();
//     passwordFocusNode.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }
//
//   @override
//   void initState() {
//     Utility.getFcm();
//     // TODO: implement initState
//     if (Platform.isIOS) {
//       emailFocusNode.addListener(() {
//         if (emailFocusNode.hasFocus) {
//           KeyboardOverlay.showOverlay(context);
//         } else {
//           KeyboardOverlay.removeOverlay();
//         }
//       });
//       passwordFocusNode.addListener(() {
//         if (passwordFocusNode.hasFocus) {
//           KeyboardOverlay.showOverlay(context);
//         } else {
//           KeyboardOverlay.removeOverlay();
//         }
//       });
//     }
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return CommonScaffold(
//       useSafeArea: false,
//       body: SingleChildScrollView(
//         child: Stack(
//           children: [
//             Image.asset(
//               width: double.infinity,
//               AssetsPath.welcomeBackground,
//               fit: BoxFit.cover,
//             ),
//             // hsized30,
//
//             SafeArea(
//               child: Padding(
//                 padding: const EdgeInsets.only(
//                     top: 20, left: 15, right: 15, bottom: 15),
//                 child: Image.asset(
//                   AssetsPath.welcomeTo,
//                   height: 129,
//                 ),
//               ),
//             ),
//             Container(
//               margin:
//                   EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
//               padding: const EdgeInsets.symmetric(horizontal: 15.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   hsized20,
//                   Text(
//                     'Sign In to Start Your Cooking Adventure!',
//                     style: semiBoldTextStyle(
//                       fontSize: 18.0,
//                       color: Colors.black,
//                     ),
//                   ),
//                   hsized20,
//                   commonTextField(
//                     focusNode: emailFocusNode,
//                     controller: emailController,
//                     labelText: 'Email/Username',
//                     hintText: 'Enter username or email',
//                     textInputAction: TextInputAction.next,
//                     textInputType: TextInputType.emailAddress,
//                     readOnly: isEmailReadOnly,
//                     onTap: () {
//                       setState(() {
//                         isEmailReadOnly = false;
//                       });
//                     },
//                   ),
//                   hsized25,
//                   commonTextField(
//                     focusNode: passwordFocusNode,
//                     controller: passwordController,
//                     labelText: 'Passwords',
//                     hintText: 'Enter password',
//                     textInputAction: TextInputAction.done,
//                     textInputType: TextInputType.text,
//                     readOnly: isPasswordReadOnly,
//                     onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
//                     onTap: () {
//                       setState(() {
//                         isPasswordReadOnly = false;
//                       });
//                     },
//                   ),
//                   hsized10,
//                   Container(
//                     alignment: Alignment.centerRight,
//                     child: GestureDetector(
//                       onTap: () {
//                         CustomNavigators.pushNavigate(
//                             ForgotPasswordNew(), context);
//                       },
//                       child: Text(
//                         "Forgot Password?",
//                         style: mediumTextStyle(
//                           fontSize: 14.0,
//                           color: MyColor.purple,
//                         ).copyWith(
//                           // decoration: TextDecoration.underline,
//                           decorationColor: MyColor.purple,
//                           decorationThickness: 1.5,
//                         ),
//                       ),
//                     ),
//                   ),
//                   hsized25,
//                   commonButton(
//                     text: Languages.of(context)!.login,
//                     onTap: () {
//                       FocusScope.of(context).unfocus();
//                       loginApi();
//                     },
//                     backgroundColor: MyColor.color48335CB2,
//                     textColor: MyColor.white,
//                   ),
//                   hsized15,
//                   Center(
//                     child: RichText(
//                       textAlign: TextAlign.center,
//                       text: TextSpan(
//                         style: mediumTextStyle(
//                             fontSize: 14.0, color: MyColor.black),
//                         children: [
//                           TextSpan(
//                             text: 'New Here? ',
//                             style: semiBoldTextStyle(
//                               fontSize: 14.0,
//                               color: MyColor.grey,
//                             ),
//                           ),
//                           TextSpan(
//                             text: 'Sign up now',
//                             style: semiBoldTextStyle(
//                               fontSize: 14.0,
//                               color: MyColor.color48335CB2,
//                             ),
//                             recognizer: TapGestureRecognizer()
//                               ..onTap = () {
//                                 CustomNavigators.pushNavigate(
//                                     RegisterNewView(), context);
//                               },
//                           ),
//                           TextSpan(
//                             text: ' to create your\nchild’s cooking profile!',
//                             style: semiBoldTextStyle(
//                               fontSize: 14.0,
//                               color: MyColor.grey,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   hsized25,
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   loginApi() async {
//     if (emailController.text.isEmpty || passwordController.text.isEmpty) {
//       Utility.customToast(context, "Please enter both email and password");
//       return;
//     }
//
//     var whoisLogin = await PreferencesServices.getPreferencesData(
//         PreferencesServices.whoIsLogin);
//
//     String fcm =
//         await PreferencesServices.getPreferencesData(PreferencesServices.fcm) ??
//             "";
//
//     bool isValidEmail(String input) {
//       final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
//       return emailRegex.hasMatch(input);
//     }
//
//     String input = emailController.text.trim();
//     final bool inputIsEmail = isValidEmail(input);
//
//     LoginRequestModel loginRequestModel = LoginRequestModel(
//       email: inputIsEmail ? input : null,
//       username: inputIsEmail ? null : input,
//       password: passwordController.text.trim(),
//       fcmToken: fcm,
//       deviceId: AppState.deviceIdStr,
//       deviceType: AppState.devicetype,
//     );
//
//     if (loginRequestModel.password!.isNotEmpty) {
//       try {
//         var onValue =
//             await ApiServices.loginRequest(context, loginRequestModel);
//         if (mounted) {
//           if (onValue.status == true) {
//             print(".......<<<<<<${onValue.data["role"].toString()}");
//             print(">>>>>>>>>>>${onValue.data["sub_role"].toString()}");
//
//             if (onValue.data["role"].toString() == "parent") {
//               if (onValue.data["sub_role"].toString().isEmpty || onValue.data["sub_role"].toString() == "null" ) {
//                 print("parent..........");
//                 PreferencesServices.setPreferencesData(
//                     PreferencesServices.loginType, "parent");
//               } else {
//                 print("individual..........");
//                 PreferencesServices.setPreferencesData(
//                     PreferencesServices.loginType, "individual");
//               }
//             } else {
//               print("child.......");
//               PreferencesServices.setPreferencesData(
//                   PreferencesServices.loginType, "child");
//             }
//
//             // PreferencesServices.setPreferencesData(PreferencesServices.loginType, loginTypeValue);
//
//             if (whoisLogin.toString() == "true") {
//               CustomNavigators.pushRemoveUntil(
//                 DashBoardView(pageIndex: 0),
//                 context,
//               );
//             } else {
//                 CustomNavigators.pushRemoveUntil(
//                   WhoJoiningNew(),
//                   context,
//                 );
//               }
//             } else {
//               Utility.customToast(context, onValue.message ?? "Login failed");
//           }
//         }
//       } catch (e) {
//         debugPrint("Error during login: $e");
//         Utility.customToast(context, "Something went wrong. Please try again.");
//       }
//     }
//   }
// }


import 'dart:io';

import 'package:cooking_champs/constant/app_state.dart';
import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/constant/stringfile.dart/language.dart';
import 'package:cooking_champs/enums/register_enum.dart';
import 'package:cooking_champs/model/post_model/login_request_model.dart';
import 'package:cooking_champs/new_ui/forgot_password.dart';
import 'package:cooking_champs/new_ui/register_new/register_new_view.dart';
import 'package:cooking_champs/services/api_services.dart';
import 'package:cooking_champs/services/user_prefences.dart';
import 'package:cooking_champs/utils/common_widget.dart';
import 'package:cooking_champs/utils/keyboardoverlay.dart';
import 'package:cooking_champs/utils/navigators.dart';
import 'package:cooking_champs/utils/utility.dart';
import 'package:cooking_champs/views/dashboard.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'register_new/who_joining_new.dart';

class WelcomeCookingChampsView extends StatefulWidget {
  const WelcomeCookingChampsView({super.key});

  @override
  State<WelcomeCookingChampsView> createState() =>
      _WelcomeCookingChampsViewState();
}

class _WelcomeCookingChampsViewState extends State<WelcomeCookingChampsView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  bool isPassHide = true;
  bool isEmailReadOnly = true;
  bool isPasswordReadOnly = true;

  @override
  void dispose() {
    emailController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    Utility.getFcm();
    // TODO: implement initState
    if (Platform.isIOS) {
      emailFocusNode.addListener(() {
        if (emailFocusNode.hasFocus) {
          KeyboardOverlay.showOverlay(context);
        } else {
          KeyboardOverlay.removeOverlay();
        }
      });
      passwordFocusNode.addListener(() {
        if (passwordFocusNode.hasFocus) {
          KeyboardOverlay.showOverlay(context);
        } else {
          KeyboardOverlay.removeOverlay();
        }
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isTablet = size.shortestSide > 600;

    return CommonScaffold(
      useSafeArea: false,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(
              width: double.infinity,
              height: size.height,
              AssetsPath.welcomeBackground,
              fit: BoxFit.cover,
            ),
            // hsized30;

            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  top: isTablet ? 40 : 20,
                  left: isTablet ? 25 : 15,
                  right: isTablet ? 25 : 15,
                  bottom: isTablet ? 25 : 15,
                ),
                child: Image.asset(
                  AssetsPath.welcomeTo,
                  height: isTablet ? 150 : 129,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: size.height / (isTablet ? 3.5 : 4),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: isTablet ? 30.0 : 15.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: isTablet ? 30 : 20),
                  Text(
                    'Sign In to Start Your Cooking Adventure!',
                    style: semiBoldTextStyle(
                      fontSize: isTablet ? 24.0 : 18.0,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: isTablet ? 30 : 20),
                  commonTextField(
                    focusNode: emailFocusNode,
                    controller: emailController,
                    labelText: 'Email/Username',
                    hintText: 'Enter username or email',
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.emailAddress,
                    readOnly: isEmailReadOnly,
                    isTablet: isTablet,
                    onTap: () {
                      setState(() {
                        isEmailReadOnly = false;
                      });
                    },
                  ),
                  SizedBox(height: isTablet ? 35 : 25),
                  commonTextField(
                    focusNode: passwordFocusNode,
                    controller: passwordController,
                    labelText: 'Passwords',
                    hintText: 'Enter password',
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.text,
                    readOnly: isPasswordReadOnly,
                    isTablet: isTablet,
                    onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
                    onTap: () {
                      setState(() {
                        isPasswordReadOnly = false;
                      });
                    },
                  ),
                  SizedBox(height: isTablet ? 15 : 10),
                  Container(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        CustomNavigators.pushNavigate(
                            ForgotPasswordNew(), context);
                      },
                      child: Text(
                        "Forgot Password?",
                        style: mediumTextStyle(
                          fontSize: isTablet ? 18.0 : 14.0,
                          color: MyColor.purple,
                        ).copyWith(
                          decorationColor: MyColor.purple,
                          decorationThickness: 1.5,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: isTablet ? 35 : 25),
                  commonButton(
                    text: Languages.of(context)!.login,
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      loginApi();
                    },
                    backgroundColor: MyColor.color48335CB2,
                    textColor: MyColor.white,
                    isTablet: isTablet,
                  ),
                  SizedBox(height: isTablet ? 20 : 15),
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: mediumTextStyle(
                          fontSize: isTablet ? 18.0 : 14.0,
                          color: MyColor.black,
                        ),
                        children: [
                          TextSpan(
                            text: 'New Here? ',
                            style: semiBoldTextStyle(
                              fontSize: isTablet ? 18.0 : 14.0,
                              color: MyColor.grey,
                            ),
                          ),
                          TextSpan(
                            text: 'Sign up now',
                            style: semiBoldTextStyle(
                              fontSize: isTablet ? 18.0 : 14.0,
                              color: MyColor.color48335CB2,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                CustomNavigators.pushNavigate(
                                    RegisterNewView(), context);
                              },
                          ),
                          TextSpan(
                            text: ' to create your\nchild\u0027s cooking profile!',
                            style: semiBoldTextStyle(
                              fontSize: isTablet ? 18.0 : 14.0,
                              color: MyColor.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: isTablet ? 35 : 25),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  loginApi() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Utility.customToast(context, "Please enter both email and password");
      return;
    }

    var whoisLogin = await PreferencesServices.getPreferencesData(
        PreferencesServices.whoIsLogin);

    String fcm =
        await PreferencesServices.getPreferencesData(PreferencesServices.fcm) ??
            "";

    bool isValidEmail(String input) {
      final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
      return emailRegex.hasMatch(input);
    }

    String input = emailController.text.trim();
    final bool inputIsEmail = isValidEmail(input);

    LoginRequestModel loginRequestModel = LoginRequestModel(
      email: inputIsEmail ? input : null,
      username: inputIsEmail ? null : input,
      password: passwordController.text.trim(),
      fcmToken: fcm,
      deviceId: AppState.deviceIdStr,
      deviceType: AppState.devicetype,
    );

    if (loginRequestModel.password!.isNotEmpty) {
      try {
        var onValue =
        await ApiServices.loginRequest(context, loginRequestModel);
        if (mounted) {
          if (onValue.status == true) {
            print(".......<<<<<<${onValue.data["role"].toString()}");
            print(">>>>>>>>>>>${onValue.data["sub_role"].toString()}");

            if (onValue.data["role"].toString() == "parent") {
              if (onValue.data["sub_role"].toString().isEmpty || onValue.data["sub_role"].toString() == "null" ) {
                print("parent..........");
                PreferencesServices.setPreferencesData(
                    PreferencesServices.loginType, "parent");
              } else {
                print("individual..........");
                PreferencesServices.setPreferencesData(
                    PreferencesServices.loginType, "individual");
              }
            } else {
              print("child.......");
              PreferencesServices.setPreferencesData(
                  PreferencesServices.loginType, "child");
            }

            // PreferencesServices.setPreferencesData(PreferencesServices.loginType, loginTypeValue);

            if (whoisLogin.toString() == "true") {
              CustomNavigators.pushRemoveUntil(
                DashBoardView(pageIndex: 0),
                context,
              );
            } else {
              CustomNavigators.pushRemoveUntil(
                WhoJoiningNew(),
                context,
              );
            }
          } else {
            Utility.customToast(context, onValue.message ?? "Login failed");
          }
        }
      } catch (e) {
        debugPrint("Error during login: $e");
        Utility.customToast(context, "Something went wrong. Please try again.");
      }
    }
  }
}
