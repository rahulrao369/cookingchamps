// import 'package:cooking_champs/constant/app_state.dart';
// import 'package:cooking_champs/constant/assets_path.dart';
// import 'package:cooking_champs/constant/dimen.dart';
// import 'package:cooking_champs/constant/my_color.dart';
// import 'package:cooking_champs/constant/my_fonts_style.dart';
// import 'package:cooking_champs/constant/sized_box.dart';
// import 'package:cooking_champs/constant/stringfile.dart/language.dart';
// import 'package:cooking_champs/enums/register_enum.dart';
// import 'package:cooking_champs/model/post_model/login_request_model.dart';
// import 'package:cooking_champs/services/api_services.dart';
// import 'package:cooking_champs/services/user_prefences.dart';
// import 'package:cooking_champs/utils/navigators.dart';
// import 'package:cooking_champs/utils/utility.dart';
// import 'package:cooking_champs/views/authentication/forgot_password_view.dart';
// import 'package:cooking_champs/views/authentication/register_view.dart';
// import 'package:cooking_champs/views/dashboard.dart';
// import 'package:cooking_champs/widgets/global_button.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// class LoginView extends StatefulWidget {
//   const LoginView({super.key});
//
//   @override
//   State<LoginView> createState() => _LoginViewState();
// }
//
// class _LoginViewState extends State<LoginView> {
//   // <<<<<<<Controller >>>>>>
//
//   TextEditingController fullNameController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//
//   String loginType = "kid";
//
//   bool isPassHide = true;
//   String isFocusColor = "";
//
//   String passwordImage = AssetsPath.hideEyeIc;
//   String conPasswordImage = AssetsPath.hideEyeIc;
//   @override
//   void initState() {
//     Utility.getId();
//     Utility.getFcm();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Stack(
//               children: [
//                 SizedBox(
//                   width: size.width,
//                   height: size.height,
//                   child: Image.asset(
//                     AssetsPath.loginbackground,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     SizedBox(
//                       height: size.height * 0.20,
//                     ),
//                     Image.asset(
//                       width: size.width * 0.46,
//                       height: size.height * 0.15,
//                       AssetsPath.antapanta,
//                       fit: BoxFit.contain,
//                     ),
//                     hsized20,
//                     Padding(
//                       padding: const EdgeInsets.only(left: 15),
//                       child: Text(
//                         Languages.of(context)!.youArea,
//                         textAlign: TextAlign.center,
//                         style: mediumTextStyle(
//                             fontSize: 16.0, color: MyColor.black),
//                       ),
//                     ),
//                     hsized20,
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         InkWell(
//                           onTap: () {
//                             setState(() {
//                               loginType = RegisterType.roleKids.value;
//                             });
//                           },
//                           child: Container(
//                             height: 79,
//                             width: size.width * 0.40,
//                             decoration: BoxDecoration(
//                                 color: loginType == "kid"
//                                     ? MyColor.appTheme
//                                     : MyColor.colorD6D2DB,
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(12))),
//                             child: Column(
//                               children: [
//                                 hsized10,
//                                 Image.asset(
//                                   AssetsPath.kids,
//                                   height: 35,
//                                 ),
//                                 Text(
//                                   "Kid",
//                                   style: mediumTextStyle(
//                                       fontSize: 16.0,
//                                       color: loginType == "kid"
//                                           ? MyColor.white
//                                           : MyColor.appTheme),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         InkWell(
//                           onTap: () {
//                             setState(() {
//                               loginType = RegisterType.roleParent.value;
//                             });
//                           },
//                           child: Container(
//                             height: 79,
//                             width: size.width * 0.40,
//                             decoration: BoxDecoration(
//                                 color: loginType == "parent"
//                                     ? MyColor.appTheme
//                                     : MyColor.colorD6D2DB,
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(12))),
//                             child: Column(
//                               children: [
//                                 hsized10,
//                                 Image.asset(
//                                   AssetsPath.parents,
//                                   height: 35,
//                                 ),
//                                 Text(
//                                   "Parent",
//                                   style: mediumTextStyle(
//                                       fontSize: 16.0,
//                                       color: loginType == "parent"
//                                           ? MyColor.white
//                                           : MyColor.appTheme),
//                                 )
//                               ],
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                     // Row(
//                     //   mainAxisAlignment: MainAxisAlignment.center,
//                     //   children: [
//                     //     InkWell(
//                     //       onTap: () {
//                     //         setState(() {
//                     //           loginType = RegisterType.roleParent.value;
//                     //         });
//                     //         print("loginType>>>>>>${loginType}");
//                     //       },
//                     //       child: Row(
//                     //         children: [
//                     //           Text(
//                     //             Languages.of(context)!.parent,
//                     //             style: mediumTextStyle(
//                     //                 fontSize: 16.0, color: MyColor.black),
//                     //           ),
//                     //           SizedBox(
//                     //             width: 5,
//                     //           ),
//                     //           Icon(
//                     //               loginType == RegisterType.roleParent.value
//                     //                   ? Icons.radio_button_checked
//                     //                   : Icons.radio_button_off,
//                     //               size: 22)
//                     //         ],
//                     //       ),
//                     //     ),
//                     //     SizedBox(
//                     //       width: 20,
//                     //     ),
//                     //     InkWell(
//                     //       onTap: () {
//                     //         setState(() {
//                     //           loginType = RegisterType.roleKids.value;
//                     //         });  print("loginType>>>>>>${loginType}");
//                     //       },
//                     //       child: Row(
//                     //         children: [
//                     //           Text(
//                     //             Languages.of(context)!.kids,
//                     //             style: mediumTextStyle(
//                     //                 fontSize: 16.0, color: MyColor.black),
//                     //           ),
//                     //           SizedBox(
//                     //             width: 5,
//                     //           ),
//                     //           Icon(
//                     //               loginType == RegisterType.roleKids.value
//                     //                   ? Icons.radio_button_checked
//                     //                   : Icons.radio_button_off,
//                     //               size: 22)
//                     //         ],
//                     //       ),
//                     //     )
//                     //   ],
//                     // ),
//                     SizedBox(
//                       height: size.height * 0.02,
//                     ),
//                     loginType == RegisterType.roleKids.value
//                         ? commonTextField(
//                             fullNameController,
//                             Languages.of(context)!.username.toString(),
//                             TextInputAction.next,
//                             TextInputType.text,
//                             "Email",
//                             false)
//                         : commonTextField(
//                             fullNameController,
//                             Languages.of(context)!.full.toString(),
//                             TextInputAction.next,
//                             TextInputType.text,
//                             "Email",
//                             false),
//                     commonTextField(
//                         passwordController,
//                         Languages.of(context)!.password.toString(),
//                         TextInputAction.done,
//                         TextInputType.text,
//                         "Password",
//                         isPassHide),
//                     SizedBox(
//                       height: size.height * 0.02,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 15.0),
//                       child: GlobalButton(
//                           Languages.of(context)!.login.toString(),
//                           MyColor.appTheme,
//                           MyColor.appTheme,
//                           btnSize55,
//                           double.infinity,
//                           checkValidation,
//                           34,
//                           5,
//                           0,
//                           mediumTextStyle(
//                               fontSize: 16.0, color: MyColor.white)),
//                     ),
//                     SizedBox(
//                       height: size.height * 0.03,
//                     ),
//                     InkWell(
//                       radius: 50,
//                       onTap: forgotPassOnTap,
//                       child: Text(Languages.of(context)!.forgotPassword,
//                           style: mediumTextStyle(
//                               fontSize: 14.0, color: MyColor.liteGray)),
//                     ),
//                     SizedBox(
//                       height: size.height * 0.01,
//                     ),
//                     Wrap(
//                       children: [
//                         Text(Languages.of(context)!.donthaveanacco,
//                             style: mediumTextStyle(
//                                 fontSize: 14.0, color: MyColor.liteGray)),
//                         InkWell(
//                           radius: 50,
//                           onTap: registerOnTap,
//                           child: Text(Languages.of(context)!.signUp,
//                               style: mediumTextStyle(
//                                   fontSize: 14.0, color: MyColor.appTheme)),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   /// Password hide show..................
//   void hideShowPass() {
//     isPassHide = !isPassHide;
//     if (isPassHide) {
//       passwordImage = AssetsPath.eyeIc;
//     } else {
//       passwordImage = AssetsPath.hideEyeIc;
//     }
//     setState(() {});
//   }
//
//   /// set Suffix icon............
//   suffixIconSet(String type) {
//     return type == "Password"
//         ? GestureDetector(
//             onTap: hideShowPass,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: SvgPicture.asset(
//                 passwordImage,
//               ),
//             ))
//         : const SizedBox(height: 10, width: 10);
//   }
//
//   commonTextField(
//       TextEditingController controller,
//       String labelText,
//       TextInputAction textInputAction,
//       TextInputType textInputType,
//       String type,
//       bool hidePass) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Card(
//         elevation: 0,
//         shadowColor: isFocusColor == type ? MyColor.liteOrange : MyColor.yellow,
//         color: MyColor.white,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(34.0),
//           side: BorderSide.none,
//         ),
//         child: TextFormField(
//           obscureText:
//               type == "Password" || type == "Con Password" ? hidePass : false,
//           onTap: () {},
//           onTapOutside: (v) {
//             FocusManager.instance.primaryFocus!.unfocus();
//           },
//           buildCounter: (BuildContext context,
//                   {required int currentLength,
//                   int? maxLength,
//                   required bool isFocused}) =>
//               null,
//           controller: controller,
//           textInputAction: textInputAction,
//           keyboardType: textInputType,
//           style: regularTextStyle(fontSize: 14.0, color: MyColor.black),
//           decoration: InputDecoration(
//             suffixIcon: suffixIconSet(type),
//             enabledBorder: const OutlineInputBorder(
//               borderRadius: BorderRadius.all(Radius.circular(34)),
//               borderSide: BorderSide(color: MyColor.liteOrange, width: 0.1),
//             ),
//             focusedBorder: const OutlineInputBorder(
//               borderRadius: BorderRadius.all(Radius.circular(34)),
//               borderSide: BorderSide(color: MyColor.liteOrange, width: 2.0),
//             ),
//             disabledBorder: const OutlineInputBorder(
//               borderRadius: BorderRadius.all(Radius.circular(34)),
//               borderSide: BorderSide(
//                   color: Color.fromARGB(255, 199, 152, 124), width: 2.0),
//             ),
//             hintStyle:
//                 regularTextStyle(fontSize: 15.0, color: MyColor.liteGray),
//             labelText: labelText,
//             alignLabelWithHint: true,
//           ),
//           maxLines: 1,
//           cursorColor: MyColor.black,
//         ),
//       ),
//     );
//   }
//
//   checkValidation() {
//     print("ssssdasdfsadfsed");
//     if (fullNameController.text.trim().isEmpty) {
//       loginType == RegisterType.roleKids.value
//           ? Utility.customToast(context, "Please enter userName")
//           : Utility.customToast(context, "Please enter email");
//     } else if (passwordController.text.trim().isEmpty) {
//       Utility.customToast(context, "Please enter password");
//     } else {
//       loginApi();
//     }
//   }
//
//   loginApi() async {
//     String fcm =
//         await PreferencesServices.getPreferencesData(PreferencesServices.fcm) ??
//             "";
//     print("loginType>>>>>>${loginType}");
//
//     print("RegisterType.roleKids.value>>>>>>${RegisterType.roleKids.value}");
//     // Create the login request model based on login type
//     LoginRequestModel loginRequestModel = LoginRequestModel(
//       username: loginType == RegisterType.roleKids.value
//           ? fullNameController.text
//           : null,
//       email: loginType != RegisterType.roleKids.value
//           ? fullNameController.text
//           : null,
//       password: passwordController.text,
//       fcmToken: fcm,
//       deviceId: AppState.deviceIdStr,
//       deviceType: AppState.devicetype,
//     );
//
//     print("devicetype>>>>>>${AppState.devicetype}");
//     if (loginRequestModel.password!.isNotEmpty) {
//       try {
//         var onValue =
//             await ApiServices.loginRequest(context, loginRequestModel);
//         if (mounted) {
//           if (onValue.status == true) {
//             CustomNavigators.pushReplacementNavigate(
//                 DashBoardView(
//                   pageIndex: 0,
//                 ),
//                 context);
//           }
//         }
//       } catch (e) {
//         debugPrint("Error during login: $e");
//       }
//     }
//   }
//
//   void forgotPassOnTap() {
//     CustomNavigators.pushNavigate(const ForgotPasswordView(), context);
//   }
//
//   void registerOnTap() {
//     CustomNavigators.pushNavigate(RegisterView(), context);
//   }
// }

import 'package:cooking_champs/constant/app_state.dart';
import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/dimen.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/stringfile.dart/language.dart';
import 'package:cooking_champs/enums/register_enum.dart';
import 'package:cooking_champs/model/post_model/login_request_model.dart';
import 'package:cooking_champs/services/api_services.dart';
import 'package:cooking_champs/services/user_prefences.dart';
import 'package:cooking_champs/utils/navigators.dart';
import 'package:cooking_champs/utils/utility.dart';
import 'package:cooking_champs/views/authentication/forgot_password_view.dart';
import 'package:cooking_champs/views/authentication/register_view.dart';
import 'package:cooking_champs/views/dashboard.dart';
import 'package:cooking_champs/widgets/global_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // <<<<<<<Controller >>>>>>
  TextEditingController fullNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String loginType = "kid";

  bool isPassHide = true;
  String isFocusColor = "";

  String passwordImage = AssetsPath.hideEyeIc;
  String conPasswordImage = AssetsPath.hideEyeIc;

  @override
  void initState() {
    Utility.getId();
    Utility.getFcm();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final bool isIpad = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              // SizedBox(
              //   width: size.width,

              //   height: size.height,
              //   child: Image.asset(
              //     AssetsPath.loginbackground,
              //     fit: BoxFit.cover,
              //   ),
              // ),
              Positioned.fill(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: size.height * (isIpad ? 0.12 : 0.20)),
                    Image.asset(
                      width: isIpad ? size.width * 0.25 : size.width * 0.46,
                      height: isIpad ? size.height * 0.08 : size.height * 0.15,
                      AssetsPath.antapanta,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: isIpad ? 40 : 20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: isIpad ? 30 : 15),
                      child: Text(
                        Languages.of(context)!.youArea,
                        textAlign: TextAlign.center,
                        style: mediumTextStyle(
                          fontSize: isIpad ? 28.0 : 16.0, // iPad ke liye bada
                          color: MyColor.black,
                        ),
                      ),
                    ),
                    SizedBox(height: isIpad ? 40 : 20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: isIpad ? 50 : 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(right: isIpad ? 15 : 10),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    loginType = RegisterType.roleKids.value;
                                  });
                                },
                                child: Container(
                                  height: isIpad ? 120 : 79,
                                  decoration: BoxDecoration(
                                    color: loginType == "kid"
                                        ? MyColor.appTheme
                                        : MyColor.colorD6D2DB,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(isIpad ? 20 : 12),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        AssetsPath.kids,
                                        height: isIpad ? 55 : 35,
                                      ),
                                      SizedBox(height: isIpad ? 10 : 3),
                                      Text(
                                        "Kid",
                                        style: mediumTextStyle(
                                          fontSize: isIpad ? 24.0 : 16.0, // iPad ke liye bada
                                          color: loginType == "kid"
                                              ? MyColor.white
                                              : MyColor.appTheme,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: isIpad ? 15 : 10),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    loginType = RegisterType.roleParent.value;
                                  });
                                },
                                child: Container(
                                  height: isIpad ? 120 : 79,
                                  decoration: BoxDecoration(
                                    color: loginType == "parent"
                                        ? MyColor.appTheme
                                        : MyColor.colorD6D2DB,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(isIpad ? 20 : 12),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        AssetsPath.parents,
                                        height: isIpad ? 55 : 35,
                                      ),
                                      SizedBox(height: isIpad ? 10 : 3),
                                      Text(
                                        "Parent",
                                        style: mediumTextStyle(
                                          fontSize: isIpad ? 24.0 : 16.0, // iPad ke liye bada
                                          color: loginType == "parent"
                                              ? MyColor.white
                                              : MyColor.appTheme,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * (isIpad ? 0.05 : 0.02)),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: isIpad ? 80 : 15),
                      child: Column(
                        children: [
                          loginType == RegisterType.roleKids.value
                              ? commonTextField(
                            fullNameController,
                            Languages.of(context)!.username.toString(),
                            TextInputAction.next,
                            TextInputType.text,
                            "Email",
                            false,
                            isIpad,
                          )
                              : commonTextField(
                            fullNameController,
                            Languages.of(context)!.full.toString(),
                            TextInputAction.next,
                            TextInputType.text,
                            "Email",
                            false,
                            isIpad,
                          ),
                          commonTextField(
                            passwordController,
                            Languages.of(context)!.password.toString(),
                            TextInputAction.done,
                            TextInputType.text,
                            "Password",
                            isPassHide,
                            isIpad,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * (isIpad ? 0.05 : 0.02)),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: isIpad ? 80 : 15),
                      child: GlobalButton(
                        Languages.of(context)!.login.toString(),
                        MyColor.appTheme,
                        MyColor.appTheme,
                        isIpad ? btnSize55 * 1.5 : btnSize55, // iPad ke liye bada
                        double.infinity,
                        checkValidation,
                        isIpad ? 55 : 34, // iPad ke liye bada
                        isIpad ? 12 : 5, // iPad ke liye bada
                        0,
                        mediumTextStyle(
                          fontSize: isIpad ? 26.0 : 16.0, // iPad ke liye bada
                          color: MyColor.white,
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * (isIpad ? 0.06 : 0.03)),
                    InkWell(
                      radius: 50,
                      onTap: forgotPassOnTap,
                      child: Text(
                        Languages.of(context)!.forgotPassword,
                        style: mediumTextStyle(
                          fontSize: isIpad ? 22.0 : 14.0, // iPad ke liye bada
                          color: MyColor.liteGray,
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * (isIpad ? 0.03 : 0.01)),
                    Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        Text(
                          Languages.of(context)!.donthaveanacco,
                          style: mediumTextStyle(
                            fontSize: isIpad ? 22.0 : 14.0, // iPad ke liye bada
                            color: MyColor.liteGray,
                          ),
                        ),
                        InkWell(
                          radius: 50,
                          onTap: registerOnTap,
                          child: Text(
                            Languages.of(context)!.signUp,
                            style: mediumTextStyle(
                              fontSize: isIpad ? 22.0 : 14.0, // iPad ke liye bada
                              color: MyColor.appTheme,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: isIpad ? 60 : 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Password hide show..................
  void hideShowPass() {
    isPassHide = !isPassHide;
    if (isPassHide) {
      passwordImage = AssetsPath.eyeIc;
    } else {
      passwordImage = AssetsPath.hideEyeIc;
    }
    setState(() {});
  }

  /// set Suffix icon............
  Widget suffixIconSet(String type, bool isIpad) {
    return type == "Password"
        ? GestureDetector(
      onTap: hideShowPass,
      child: Padding(
        padding: EdgeInsets.all(isIpad ? 12.0 : 8.0),
        child: SvgPicture.asset(
          passwordImage,
          height: isIpad ? 32 : 20, // iPad ke liye bada
          width: isIpad ? 32 : 20, // iPad ke liye bada
        ),
      ),
    )
        : SizedBox(height: isIpad ? 15 : 10, width: isIpad ? 15 : 10);
  }

  Widget commonTextField(
      TextEditingController controller,
      String labelText,
      TextInputAction textInputAction,
      TextInputType textInputType,
      String type,
      bool hidePass,
      bool isIpad,
      ) {
    return Padding(
      padding: EdgeInsets.only(bottom: isIpad ? 30 : 8),
      child: Card(
        elevation: 0,
        shadowColor: isFocusColor == type ? MyColor.liteOrange : MyColor.yellow,
        color: MyColor.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(isIpad ? 50.0 : 34.0), // iPad ke liye bada
          side: BorderSide.none,
        ),
        child: TextFormField(
          obscureText: type == "Password" ? hidePass : false,
          onTap: () {},
          onTapOutside: (v) {
            FocusManager.instance.primaryFocus!.unfocus();
          },
          buildCounter: (BuildContext context,
              {required int currentLength,
                int? maxLength,
                required bool isFocused}) =>
          null,
          controller: controller,
          textInputAction: textInputAction,
          keyboardType: textInputType,
          style: regularTextStyle(
            fontSize: isIpad ? 24.0 : 14.0, // iPad ke liye bada
            color: MyColor.black,
          ),
          decoration: InputDecoration(
            suffixIcon: suffixIconSet(type, isIpad),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(isIpad ? 50 : 34), // iPad ke liye bada
              ),
              borderSide: BorderSide(color: MyColor.liteOrange, width: 0.1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(isIpad ? 50 : 34), // iPad ke liye bada
              ),
              borderSide: BorderSide(color: MyColor.liteOrange, width: 2.0),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(isIpad ? 50 : 34), // iPad ke liye bada
              ),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 199, 152, 124),
                width: 2.0,
              ),
            ),
            hintStyle: regularTextStyle(
              fontSize: isIpad ? 24.0 : 15.0, // iPad ke liye bada
              color: MyColor.liteGray,
            ),
            labelText: labelText,
            labelStyle: regularTextStyle(
              fontSize: isIpad ? 24.0 : 15.0, // iPad ke liye bada
              color: MyColor.liteGray,
            ),
            alignLabelWithHint: true,
            contentPadding: EdgeInsets.symmetric(
              horizontal: isIpad ? 25 : 15, // iPad ke liye bada
              vertical: isIpad ? 22 : 12, // iPad ke liye bada
            ),
          ),
          maxLines: 1,
          cursorColor: MyColor.black,
        ),
      ),
    );
  }

  checkValidation() {
    print("ssssdasdfsadfsed");
    if (fullNameController.text.trim().isEmpty) {
      loginType == RegisterType.roleKids.value
          ? Utility.customToast(context, "Please enter userName")
          : Utility.customToast(context, "Please enter email");
    } else if (passwordController.text.trim().isEmpty) {
      Utility.customToast(context, "Please enter password");
    } else {
      loginApi();
    }
  }

  loginApi() async {
    String fcm =
        await PreferencesServices.getPreferencesData(PreferencesServices.fcm) ??
            "";
    print("loginType>>>>>>${loginType}");

    print("RegisterType.roleKids.value>>>>>>${RegisterType.roleKids.value}");
    // Create the login request model based on login type
    LoginRequestModel loginRequestModel = LoginRequestModel(
      username: loginType == RegisterType.roleKids.value
          ? fullNameController.text
          : null,
      email: loginType != RegisterType.roleKids.value
          ? fullNameController.text
          : null,
      password: passwordController.text,
      fcmToken: fcm,
      deviceId: AppState.deviceIdStr,
      deviceType: AppState.devicetype,
    );

    print("devicetype>>>>>>${AppState.devicetype}");
    if (loginRequestModel.password!.isNotEmpty) {
      try {
        var onValue =
        await ApiServices.loginRequest(context, loginRequestModel);
        if (mounted) {
          if (onValue.status == true) {
            CustomNavigators.pushReplacementNavigate(
              DashBoardView(
                pageIndex: 0,
              ),
              context,
            );
          }
        }
      } catch (e) {
        debugPrint("Error during login: $e");
      }
    }
  }

  void forgotPassOnTap() {
    CustomNavigators.pushNavigate(const ForgotPasswordView(), context);
  }

  void registerOnTap() {
    CustomNavigators.pushNavigate(RegisterView(), context);
  }
}