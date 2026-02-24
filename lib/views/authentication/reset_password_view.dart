// import 'package:cooking_champs/constant/assets_path.dart';
// import 'package:cooking_champs/constant/dimen.dart';
// import 'package:cooking_champs/constant/my_color.dart';
// import 'package:cooking_champs/constant/my_fonts_style.dart';
// import 'package:cooking_champs/constant/sized_box.dart';
// import 'package:cooking_champs/constant/stringfile.dart/language.dart';
// import 'package:cooking_champs/model/post_model/reset_pass_request.dart';
// import 'package:cooking_champs/new_ui/login_new_view.dart';
// import 'package:cooking_champs/services/api_services.dart';
// import 'package:cooking_champs/utils/all_dialogs.dart';
// import 'package:cooking_champs/utils/navigators.dart';
// import 'package:cooking_champs/utils/ui_utils.dart';
// import 'package:cooking_champs/utils/utility.dart';
// import 'package:cooking_champs/views/authentication/login_view.dart';
// import 'package:cooking_champs/widgets/change_password_popup.dart';
// import 'package:cooking_champs/widgets/global_button.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// class ResetPasswordView extends StatefulWidget {
//   final String? email;
//   const ResetPasswordView({super.key, this.email});
//
//   @override
//   State<ResetPasswordView> createState() => _ResetPasswordViewState();
// }
//
// class _ResetPasswordViewState extends State<ResetPasswordView> {
//   final formKey = GlobalKey<FormState>();
//
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController confirmPassController = TextEditingController();
//
//   dynamic isFocusColor = '';
//   bool isPassHide = true;
//   bool isConPassHide = true;
//   bool isValidate = false;
//   String newPassError = "";
//   String newConPassError = "";
//   String passwordImage = AssetsPath.hideEyeIc;
//   String conPasswordImage = AssetsPath.hideEyeIc;
//
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         leadingWidth: size.width * 0.09,
//         leading: InkWell(
//           radius: 50,
//           onTap: () {
//             Navigator.pop(context);
//             setState(() {});
//           },
//           child: Padding(
//             padding: const EdgeInsets.only(left: 20),
//             child: const Icon(
//               Icons.arrow_back_ios_new,
//               color: MyColor.black,
//               size: 20,
//             ),
//           ),
//         ),
//         title: Text(Languages.of(context)!.resetPassword,
//             style: mediumTextStyle(fontSize: 18.0, color: MyColor.black)),
//         centerTitle: false,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   hsized20,
//                   titleText(Languages.of(context)!.newPassword.toString(),
//                       newPassError),
//                   SizedBox(
//                     height: size.height * 0.01,
//                   ),
//                   commonTextField(
//                       passwordController,
//                       Languages.of(context)!.enterpassword.toString(),
//                       TextInputAction.done,
//                       TextInputType.text,
//                       "Password",
//                       isPassHide),
//                   SizedBox(
//                     height: size.height * 0.03,
//                   ),
//                   titleText(
//                       Languages.of(context)!.confirmnewPassword.toString(),
//                       newConPassError),
//                   SizedBox(
//                     height: size.height * 0.01,
//                   ),
//                   commonTextField(
//                       confirmPassController,
//                       Languages.of(context)!.enterpassword.toString(),
//                       TextInputAction.done,
//                       TextInputType.text,
//                       "Con Password",
//                       isConPassHide),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(bottom: 30.0, left: 10, right: 10),
//               child: GlobalButton(
//                   Languages.of(context)!.submit.toString(),
//                   MyColor.appTheme,
//                   MyColor.appTheme,
//                   btnSize55,
//                   double.infinity,
//                   submitOnTap,
//                   55,
//                   5,
//                   0,
//                   mediumTextStyle(fontSize: 16.0, color: MyColor.white)),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   titleText(String title, String error) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Row(
//           children: [
//             Text(Languages.of(context)!.newPassword.toString(),
//                 style: regularTextStyle(fontSize: 15.0, color: MyColor.black)),
//             Text(" *",
//                 style: regularTextStyle(fontSize: 15.0, color: MyColor.red)),
//           ],
//         ),
//         UiUtils.errorText(error)
//       ],
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
//   void submitOnTap() {
//     setState(() {
//       isValidate = true;
//       if (passwordController.text.trim().isEmpty) {
//         isValidate = false;
//         newPassError = Languages.of(context)!.atleast5;
//       }
//       if (confirmPassController.text.trim().isEmpty) {
//         isValidate = false;
//         newConPassError = Languages.of(context)!.atleast5;
//       }
//       if (confirmPassController.text != passwordController.text) {
//         isValidate = false;
//         newConPassError = Languages.of(context)!.newConPAssNotMatch;
//       }
//     });
//
//     if (isValidate) {
//       newConPassError = "";
//       newPassError = "";
//       Future.delayed(Duration.zero, resetPassword);
//     }
//   }
//
//   resetPassword() async {
//     ResetPasswordRequest resetPasswordRequest = ResetPasswordRequest(
//         email: widget.email,
//         newPassword: passwordController.text,
//         newPasswordConfirmation: confirmPassController.text);
//     await ApiServices.resetPassword(context, resetPasswordRequest)
//         .then((onValue) {
//       Utility.customToast(context, onValue.message ?? "");
//       if (onValue.status == true) {
//         AllDialogs.customDialog(
//             context,
//             ChangePasswordPopup(
//               title: Languages.of(context)!.passwordchanged,
//               des: Languages.of(context)!.yourpasswordhasbeensuccessfullyreset,
//               img: AssetsPath.passwordChangeImg,
//               btnName: Languages.of(context)!.gotoLogin.toString(),
//               onTap: () {
//                 // CustomNavigators.pushRemoveUntil(LoginView(), context);
//                 CustomNavigators.pushRemoveUntil(WelcomeCookingChampsView(), context);
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
import 'package:cooking_champs/model/post_model/reset_pass_request.dart';
import 'package:cooking_champs/new_ui/login_new_view.dart';
import 'package:cooking_champs/services/api_services.dart';
import 'package:cooking_champs/utils/all_dialogs.dart';
import 'package:cooking_champs/utils/navigators.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:cooking_champs/utils/utility.dart';
import 'package:cooking_champs/views/authentication/login_view.dart';
import 'package:cooking_champs/widgets/change_password_popup.dart';
import 'package:cooking_champs/widgets/global_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResetPasswordView extends StatefulWidget {
  final String? email;
  const ResetPasswordView({super.key, this.email});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final formKey = GlobalKey<FormState>();

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  dynamic isFocusColor = '';
  bool isPassHide = true;
  bool isConPassHide = true;
  bool isValidate = false;
  String newPassError = "";
  String newConPassError = "";
  String passwordImage = AssetsPath.hideEyeIc;
  String conPasswordImage = AssetsPath.hideEyeIc;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final bool isTablet = size.shortestSide > 600;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leadingWidth: size.width * (isTablet ? 0.12 : 0.09),
        leading: InkWell(
          radius: 50,
          onTap: () {
            Navigator.pop(context);
            setState(() {});
          },
          child: Padding(
            padding: EdgeInsets.only(left: isTablet ? 1 : 20),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: MyColor.black,
              size: isTablet ? 24 : 20,
            ),
          ),
        ),
        title: Text(
          Languages.of(context)!.resetPassword,
          style: mediumTextStyle(
            fontSize: isTablet ? 22.0 : 18.0,
            color: MyColor.black,
          ),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? 40.0 : 20.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: isTablet ? 40 : 20),

                  // New Password Title
                  titleText(
                    Languages.of(context)!.newPassword.toString(),
                    newPassError,
                    isTablet: isTablet,
                  ),

                  SizedBox(height: size.height * (isTablet ? 0.02 : 0.01)),

                  // New Password TextField
                  commonTextField(
                    passwordController,
                    Languages.of(context)!.enterpassword.toString(),
                    TextInputAction.done,
                    TextInputType.text,
                    "Password",
                    isPassHide,
                    isTablet: isTablet,
                  ),

                  SizedBox(height: size.height * (isTablet ? 0.04 : 0.03)),

                  // Confirm Password Title
                  titleText(
                    Languages.of(context)!.confirmnewPassword.toString(),
                    newConPassError,
                    isTablet: isTablet,
                  ),

                  SizedBox(height: size.height * (isTablet ? 0.02 : 0.01)),

                  // Confirm Password TextField
                  commonTextField(
                    confirmPassController,
                    Languages.of(context)!.enterpassword.toString(),
                    TextInputAction.done,
                    TextInputType.text,
                    "Con Password",
                    isConPassHide,
                    isTablet: isTablet,
                  ),
                ],
              ),
            ),

            // Submit Button
            Padding(
              padding: EdgeInsets.only(
                bottom: isTablet ? 50.0 : 30.0,
                left: isTablet ? 20 : 10,
                right: isTablet ? 20 : 10,
              ),
              child: GlobalButton(
                Languages.of(context)!.submit.toString(),
                MyColor.appTheme,
                MyColor.appTheme,
                isTablet ? btnSize55 * 1.3 : btnSize55,
                double.infinity,
                submitOnTap,
                isTablet ? 55 * 1.2 : 55,
                5,
                0,
                mediumTextStyle(
                  fontSize: isTablet ? 18.0 : 16.0,
                  color: MyColor.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget titleText(String title, String error, {bool isTablet = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              Languages.of(context)!.newPassword.toString(),
              style: regularTextStyle(
                fontSize: isTablet ? 18.0 : 15.0,
                color: MyColor.black,
              ),
            ),
            Text(
              " *",
              style: regularTextStyle(
                fontSize: isTablet ? 18.0 : 15.0,
                color: MyColor.red,
              ),
            ),
          ],
        ),
        UiUtils.errorText(error)
      ],
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

  /// Confirm Password hide show..................
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
  Widget suffixIconSet(String type, bool isTablet) {
    return Padding(
      padding: EdgeInsets.only(
        top: isTablet ? 6 : 4,
        bottom: isTablet ? 6 : 4,
        left: isTablet ? 10 : 7,
        right: isTablet ? 10 : 7,
      ),
      child: type == "Password" || type == "Con Password"
          ? GestureDetector(
        onTap: type == "Password" ? hideShowPass : hideShowConfPass,
        child: SvgPicture.asset(
          type == "Password" ? passwordImage : conPasswordImage,
          width: isTablet ? 24 : 20,
          height: isTablet ? 24 : 20,
        ),
      )
          : SizedBox(
        height: isTablet ? 14 : 10,
        width: isTablet ? 14 : 10,
      ),
    );
  }

  Widget commonTextField(
      TextEditingController controller,
      String labelText,
      TextInputAction textInputAction,
      TextInputType textInputType,
      String type,
      bool hidePass, {
        bool isTablet = false,
      }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: isFocusColor == type ? MyColor.liteOrange : MyColor.grayLite,
          width: isTablet ? 1.5 : 1.0,
        ),
        color: MyColor.white,
        borderRadius: BorderRadius.all(
          Radius.circular(isTablet ? 16 : 12),
        ),
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(
        isTablet ? 16 : 12,
        isTablet ? 8 : 5,
        0,
        isTablet ? 18 : 15,
      ),
      height: isTablet ? 65 : 55,
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
        textInputAction: textInputAction,
        style: regularTextStyle(
          fontSize: isTablet ? 16.0 : 14.0,
          color: MyColor.black,
        ),
        decoration: InputDecoration(
          suffixIcon: suffixIconSet(type, isTablet),
          border: InputBorder.none,
          hintText: labelText,
          hintStyle: regularTextStyle(
            fontSize: isTablet ? 16.0 : 14.0,
            color: MyColor.grayLite1,
          ),
          counter: const Offstage(),
          isDense: true,
          contentPadding: EdgeInsets.only(
            top: isTablet ? 14 : 10,
          ),
        ),
        maxLines: 1,
        cursorColor: MyColor.black,
      ),
    );
  }

  void submitOnTap() {
    setState(() {
      isValidate = true;
      if (passwordController.text.trim().isEmpty) {
        isValidate = false;
        newPassError = Languages.of(context)!.atleast5;
      }
      if (confirmPassController.text.trim().isEmpty) {
        isValidate = false;
        newConPassError = Languages.of(context)!.atleast5;
      }
      if (confirmPassController.text != passwordController.text) {
        isValidate = false;
        newConPassError = Languages.of(context)!.newConPAssNotMatch;
      }
    });

    if (isValidate) {
      newConPassError = "";
      newPassError = "";
      Future.delayed(Duration.zero, resetPassword);
    }
  }

  resetPassword() async {
    ResetPasswordRequest resetPasswordRequest = ResetPasswordRequest(
      email: widget.email,
      newPassword: passwordController.text,
      newPasswordConfirmation: confirmPassController.text,
    );

    await ApiServices.resetPassword(context, resetPasswordRequest)
        .then((onValue) {
      Utility.customToast(context, onValue.message ?? "");
      if (onValue.status == true) {
        AllDialogs.customDialog(
          context,
          ChangePasswordPopup(
            title: Languages.of(context)!.passwordchanged,
            des: Languages.of(context)!.yourpasswordhasbeensuccessfullyreset,
            img: AssetsPath.passwordChangeImg,
            btnName: Languages.of(context)!.gotoLogin.toString(),
            onTap: () {
              CustomNavigators.pushRemoveUntil(WelcomeCookingChampsView(), context);
            },
          ),
        );
      }
    });
  }
}