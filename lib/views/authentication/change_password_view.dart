// import 'package:cooking_champs/constant/assets_path.dart';
// import 'package:cooking_champs/constant/dimen.dart';
// import 'package:cooking_champs/constant/my_color.dart';
// import 'package:cooking_champs/constant/my_fonts_style.dart';
// import 'package:cooking_champs/constant/sized_box.dart';
// import 'package:cooking_champs/constant/stringfile.dart/language.dart';
// import 'package:cooking_champs/model/post_model/change_pass_model.dart';
// import 'package:cooking_champs/services/api_services.dart';
// import 'package:cooking_champs/utils/all_dialogs.dart';
// import 'package:cooking_champs/utils/navigators.dart';
// import 'package:cooking_champs/utils/ui_utils.dart';
// import 'package:cooking_champs/views/dashboard.dart';
// import 'package:cooking_champs/widgets/change_password_popup.dart';
// import 'package:cooking_champs/widgets/global_button.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:touch_ripple_effect/touch_ripple_effect.dart';
//
// class ChangePasswordView extends StatefulWidget {
//   const ChangePasswordView({super.key});
//
//   @override
//   State<ChangePasswordView> createState() => _ChangePasswordViewState();
// }
//
// class _ChangePasswordViewState extends State<ChangePasswordView> {
//   TextEditingController newPasswordController = TextEditingController();
//   TextEditingController confirmNewPassController = TextEditingController();
//
//   dynamic isFocusColor = '';
//
//   String newPassError = "";
//   String newConPassError = "";
//
//   bool isPassHide = true;
//   bool isConPassHide = true;
//   bool isValidate = false;
//
//   String passwordImage = AssetsPath.hideEyeIc;
//   String conPasswordImage = AssetsPath.hideEyeIc;
//
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         leadingWidth: 0,
//         automaticallyImplyLeading: false,
//         backgroundColor: MyColor.yellowF6F1E1,
//         surfaceTintColor: MyColor.yellowF6F1E1,
//         title: Padding(
//           padding: const EdgeInsets.only(left: 0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               TouchRippleEffect(
//                 borderRadius: BorderRadius.circular(30),
//                 rippleColor: Colors.white,
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//                 child: const Icon(
//                   Icons.arrow_back_ios,
//                   size: 30,
//                   color: Colors.black,
//                 ),
//               ),
//               Text(
//                 Languages.of(context)!.changePassword,
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w500,
//                   fontFamily: Fonts.beVietnamProRegular,
//                   color: MyColor.black,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     hsized10,
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             Text(Languages.of(context)!.newPassword.toString(),
//                                 style: regularTextStyle(
//                                     fontSize: 15.0, color: MyColor.black)),
//                             Text(" *",
//                                 style: regularTextStyle(
//                                     fontSize: 15.0, color: MyColor.red)),
//                           ],
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: size.height * 0.01,
//                     ),
//                     commonTextField(
//                         newPasswordController,
//                         Languages.of(context)!.enterpassword.toString(),
//                         TextInputAction.done,
//                         TextInputType.text,
//                         "Password",
//                         isPassHide),
//                     UiUtils.errorText(newPassError),
//                     SizedBox(
//                       height: size.height * 0.02,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             Text(
//                                 Languages.of(context)!
//                                     .confirmnewPassword
//                                     .toString(),
//                                 style: regularTextStyle(
//                                     fontSize: 15.0, color: MyColor.black)),
//                             Text(" *",
//                                 style: regularTextStyle(
//                                     fontSize: 15.0, color: MyColor.red)),
//                           ],
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: size.height * 0.01,
//                     ),
//                     commonTextField(
//                         confirmNewPassController,
//                         Languages.of(context)!.enterpassword.toString(),
//                         TextInputAction.done,
//                         TextInputType.text,
//                         "Con Password",
//                         isConPassHide),
//                     UiUtils.errorText(newConPassError)
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           Container(
//               margin: const EdgeInsets.only(bottom: 30, right: 20, left: 20),
//               child: GlobalButton(
//                   Languages.of(context)!.savePassword.toString(),
//                   MyColor.appTheme,
//                   MyColor.appTheme,
//                   btnSize55,
//                   double.infinity,
//                   checkValidation,
//                   55,
//                   5,
//                   0,
//                   mediumTextStyle(fontSize: 16.0, color: MyColor.white))),
//         ],
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
//   /// Password hide show..................
//   void hideShowConfPass() {
//     isConPassHide = !isConPassHide;
//     if (isConPassHide) {
//       conPasswordImage = AssetsPath.eyeIc;
//     } else {
//       conPasswordImage = AssetsPath.hideEyeIc;
//     }
//     setState(() {});
//   }
//
//   /// set Suffix icon............
//   suffixIconSet(String type) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 4, bottom: 4, left: 7, right: 7),
//       child: type == "Password" || type == "Con Password"
//           ? GestureDetector(
//               onTap: type == "Password" ? hideShowPass : hideShowConfPass,
//               child: SvgPicture.asset(
//                 type == "Password" ? passwordImage : conPasswordImage,
//               ))
//           : const SizedBox(height: 10, width: 10),
//     );
//   }
//
//   commonTextField(
//       TextEditingController controller,
//       String labelText,
//       TextInputAction textInputAction,
//       TextInputType textInputType,
//       String type,
//       bool hidePass) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(
//             color:
//                 isFocusColor == type ? MyColor.liteOrange : MyColor.grayLite),
//         color: MyColor.white,
//         borderRadius: const BorderRadius.all(Radius.circular(12)),
//       ),
//       alignment: Alignment.center,
//       padding: const EdgeInsets.fromLTRB(12, 5, 0, 15),
//       height: 55,
//       child: TextField(
//         obscureText:
//             type == "Password" || type == "Con Password" ? hidePass : false,
//         textCapitalization: TextCapitalization.sentences,
//         onTap: () {
//           if (mounted) {
//             setState(() {
//               isFocusColor = type;
//             });
//           }
//         },
//         buildCounter: (BuildContext context,
//                 {required int currentLength,
//                 int? maxLength,
//                 required bool isFocused}) =>
//             null,
//         controller: controller,
//         onTapOutside: (v) {
//           FocusManager.instance.primaryFocus!.unfocus();
//         },
//         textInputAction: TextInputAction.next,
//         style: regularTextStyle(fontSize: 14.0, color: MyColor.black),
//         decoration: InputDecoration(
//           suffixIcon: suffixIconSet(type),
//           border: InputBorder.none,
//           hintText: labelText,
//           hintStyle: regularTextStyle(fontSize: 14.0, color: MyColor.grayLite1),
//           counter: const Offstage(),
//           isDense: true,
//           // this will remove the default content padding
//           contentPadding: const EdgeInsets.only(
//             top: 10,
//           ),
//         ),
//         maxLines: 1,
//         cursorColor: MyColor.black,
//       ),
//     );
//   }
//
//   checkValidation() {
//     isValidate = false;
//     newPassError = "";
//     newConPassError = "";
//
//     String newPass = newPasswordController.text.trim();
//     String conPass = confirmNewPassController.text.trim();
//
//     if (newPass.isEmpty) {
//       isValidate = true;
//       newPassError = Languages.of(context)!
//           .atleast5; // You might want to update this message
//     } else if (newPass.length < 6) {
//       isValidate = true;
//       newPassError = Languages.of(context)!
//           .passwordLength6; // <- Add this key in your language file
//     }
//
//     if (conPass.isEmpty) {
//       isValidate = true;
//       newConPassError = Languages.of(context)!.atleast5;
//     } else if (conPass.length < 6) {
//       isValidate = true;
//       newConPassError = Languages.of(context)!
//           .passwordLength6; // <- Add this key in your language file
//     }
//
//     if (newPass != conPass) {
//       isValidate = true;
//       newConPassError = Languages.of(context)!.newConPAssNotMatch;
//     }
//
//     if (!isValidate) {
//       Future.delayed(Duration.zero, changePassword);
//     }
//
//     setState(() {});
//   }
//
//   changePassword() async {
//     ChangePasswordModel changePasswordModel = ChangePasswordModel(
//         newPassword: newPasswordController.text,
//         newPasswordConfirmation: confirmNewPassController.text);
//     await ApiServices.changePassword(context, changePasswordModel)
//         .then((onValue) {
//       if (onValue.status == true) {
//         // Utility.customToast(context, onValue.message??"");
//         AllDialogs.customDialog(
//             context,
//             ChangePasswordPopup(
//               title: Languages.of(context)!.passwordchanged,
//               des: Languages.of(context)!.yourpasswordhasbeensuccessfullyreset,
//               img: AssetsPath.passwordChangeImg,
//               btnName: Languages.of(context)!.gotoHome.toString(),
//               onTap: () {
//                 CustomNavigators.pushRemoveUntil(
//                     DashBoardView(
//                       pageIndex: 0,
//                     ),
//                     context);
//               },
//             ));
//       }
//     });
//   }
// }


import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/dimen.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/constant/stringfile.dart/language.dart';
import 'package:cooking_champs/model/post_model/change_pass_model.dart';
import 'package:cooking_champs/services/api_services.dart';
import 'package:cooking_champs/utils/all_dialogs.dart';
import 'package:cooking_champs/utils/navigators.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:cooking_champs/views/dashboard.dart';
import 'package:cooking_champs/widgets/change_password_popup.dart';
import 'package:cooking_champs/widgets/global_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPassController = TextEditingController();

  dynamic isFocusColor = '';

  String newPassError = "";
  String newConPassError = "";

  bool isPassHide = true;
  bool isConPassHide = true;
  bool isValidate = false;

  String passwordImage = AssetsPath.hideEyeIc;
  String conPasswordImage = AssetsPath.hideEyeIc;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final bool isIpad = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        automaticallyImplyLeading: false,
        backgroundColor: MyColor.yellowF6F1E1,
        surfaceTintColor: MyColor.yellowF6F1E1,
        title: Padding(
          padding: const EdgeInsets.only(left: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TouchRippleEffect(
                borderRadius: BorderRadius.circular(30),
                rippleColor: Colors.white,
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  size: isIpad ? 36 : 30,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: isIpad ? 15 : 10),
              Text(
                Languages.of(context)!.changePassword,
                style: TextStyle(
                  fontSize: isIpad ? 28.0 : 18.0,
                  fontWeight: FontWeight.w500,
                  fontFamily: Fonts.beVietnamProRegular,
                  color: MyColor.black,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: isIpad ? 80 : 56,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(isIpad ? 25.0 : 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: isIpad ? 20 : 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                Languages.of(context)!.newPassword.toString(),
                                style: regularTextStyle(
                                    fontSize: isIpad ? 22.0 : 15.0,
                                    color: MyColor.black
                                ),
                              ),
                              Text(
                                " *",
                                style: regularTextStyle(
                                    fontSize: isIpad ? 22.0 : 15.0,
                                    color: MyColor.red
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * (isIpad ? 0.02 : 0.01)),
                      commonTextField(
                        newPasswordController,
                        Languages.of(context)!.enterpassword.toString(),
                        TextInputAction.done,
                        TextInputType.text,
                        "Password",
                        isPassHide,
                        isIpad,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: isIpad ? 10 : 5),
                        child: UiUtils.errorText(newPassError),
                      ),
                      SizedBox(height: size.height * (isIpad ? 0.04 : 0.02)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                Languages.of(context)!.confirmnewPassword.toString(),
                                style: regularTextStyle(
                                    fontSize: isIpad ? 22.0 : 15.0,
                                    color: MyColor.black
                                ),
                              ),
                              Text(
                                " *",
                                style: regularTextStyle(
                                    fontSize: isIpad ? 22.0 : 15.0,
                                    color: MyColor.red
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * (isIpad ? 0.02 : 0.01)),
                      commonTextField(
                        confirmNewPassController,
                        Languages.of(context)!.enterpassword.toString(),
                        TextInputAction.done,
                        TextInputType.text,
                        "Con Password",
                        isConPassHide,
                        isIpad,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: isIpad ? 10 : 5),
                        child: UiUtils.errorText(newConPassError),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              bottom: isIpad ? 40 : 30,
              right: isIpad ? 30 : 20,
              left: isIpad ? 30 : 20,
              top: isIpad ? 20 : 0,
            ),
            child: GlobalButton(
              Languages.of(context)!.savePassword.toString(),
              MyColor.appTheme,
              MyColor.appTheme,
              isIpad ? btnSize55 * 1.3 : btnSize55,
              double.infinity,
              checkValidation,
              isIpad ? 70 : 55,
              isIpad ? 8 : 5,
              0,
              mediumTextStyle(
                  fontSize: isIpad ? 22.0 : 16.0,
                  color: MyColor.white
              ),
            ),
          ),
        ],
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

  /// Password hide show..................
  void hideShowConfPass() {
    isConPassHide = !isConPassHide;
    if (isConPassHide) {
      conPasswordImage = AssetsPath.eyeIc;
    } else {
      conPasswordImage = AssetsPath.hideEyeIc;
    }
    setState(() {});
  }

  /// set Suffix icon............
  Widget suffixIconSet(String type, bool isIpad) {
    return Padding(
      padding: EdgeInsets.only(
        top: isIpad ? 8 : 4,
        bottom: isIpad ? 8 : 4,
        left: isIpad ? 10 : 7,
        right: isIpad ? 10 : 7,
      ),
      child: type == "Password" || type == "Con Password"
          ? GestureDetector(
        onTap: type == "Password" ? hideShowPass : hideShowConfPass,
        child: SvgPicture.asset(
          type == "Password" ? passwordImage : conPasswordImage,
          height: isIpad ? 28 : 20,
          width: isIpad ? 28 : 20,
        ),
      )
          : SizedBox(height: isIpad ? 15 : 10, width: isIpad ? 15 : 10),
    );
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
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            color: isFocusColor == type ? MyColor.liteOrange : MyColor.grayLite
        ),
        color: MyColor.white,
        borderRadius: BorderRadius.all(Radius.circular(isIpad ? 16 : 12)),
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(
        isIpad ? 16 : 12,
        isIpad ? 8 : 5,
        0,
        isIpad ? 20 : 15,
      ),
      height: isIpad ? 70 : 55,
      child: TextField(
        obscureText:
        type == "Password" || type == "Con Password" ? hidePass : false,
        textCapitalization: TextCapitalization.sentences,
        onTap: () {
          if (mounted) {
            setState(() {
              isFocusColor = type;
            });
          }
        },
        buildCounter: (BuildContext context,
            {required int currentLength,
              int? maxLength,
              required bool isFocused}) =>
        null,
        controller: controller,
        onTapOutside: (v) {
          FocusManager.instance.primaryFocus!.unfocus();
        },
        textInputAction: TextInputAction.next,
        style: regularTextStyle(
            fontSize: isIpad ? 20.0 : 14.0,
            color: MyColor.black
        ),
        decoration: InputDecoration(
          suffixIcon: suffixIconSet(type, isIpad),
          border: InputBorder.none,
          hintText: labelText,
          hintStyle: regularTextStyle(
              fontSize: isIpad ? 20.0 : 14.0,
              color: MyColor.grayLite1
          ),
          counter: const Offstage(),
          isDense: true,
          contentPadding: EdgeInsets.only(
            top: isIpad ? 18 : 10,
            bottom: isIpad ? 5 : 0,
          ),
        ),
        maxLines: 1,
        cursorColor: MyColor.black,
      ),
    );
  }

  checkValidation() {
    isValidate = false;
    newPassError = "";
    newConPassError = "";

    String newPass = newPasswordController.text.trim();
    String conPass = confirmNewPassController.text.trim();

    if (newPass.isEmpty) {
      isValidate = true;
      newPassError = Languages.of(context)!.atleast5;
    } else if (newPass.length < 6) {
      isValidate = true;
      newPassError = Languages.of(context)!.passwordLength6;
    }

    if (conPass.isEmpty) {
      isValidate = true;
      newConPassError = Languages.of(context)!.atleast5;
    } else if (conPass.length < 6) {
      isValidate = true;
      newConPassError = Languages.of(context)!.passwordLength6;
    }

    if (newPass != conPass) {
      isValidate = true;
      newConPassError = Languages.of(context)!.newConPAssNotMatch;
    }

    if (!isValidate) {
      Future.delayed(Duration.zero, changePassword);
    }

    setState(() {});
  }

  changePassword() async {
    ChangePasswordModel changePasswordModel = ChangePasswordModel(
        newPassword: newPasswordController.text,
        newPasswordConfirmation: confirmNewPassController.text);
    await ApiServices.changePassword(context, changePasswordModel)
        .then((onValue) {
      if (onValue.status == true) {
        AllDialogs.customDialog(
            context,
            ChangePasswordPopup(
              title: Languages.of(context)!.passwordchanged,
              des: Languages.of(context)!.yourpasswordhasbeensuccessfullyreset,
              img: AssetsPath.passwordChangeImg,
              btnName: Languages.of(context)!.gotoHome.toString(),
              onTap: () {
                CustomNavigators.pushRemoveUntil(
                    DashBoardView(
                      pageIndex: 0,
                    ),
                    context);
              },
            ));
      }
    });
  }
}