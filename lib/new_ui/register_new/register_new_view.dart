// import 'dart:io';
// import 'package:cooking_champs/constant/app_state.dart';
// import 'package:cooking_champs/constant/assets_path.dart';
// import 'package:cooking_champs/constant/my_color.dart';
// import 'package:cooking_champs/constant/my_fonts_style.dart';
// import 'package:cooking_champs/constant/sized_box.dart';
// import 'package:cooking_champs/constant/stringfile.dart/language.dart';
// import 'package:cooking_champs/enums/register_enum.dart';
// import 'package:cooking_champs/model/post_model/parent_register_model.dart';
// import 'package:cooking_champs/new_ui/login_new_view.dart';
// import 'package:cooking_champs/services/api_services.dart';
// import 'package:cooking_champs/services/user_prefences.dart';
// import 'package:cooking_champs/utils/common_widget.dart';
// import 'package:cooking_champs/utils/keyboardoverlay.dart';
// import 'package:cooking_champs/utils/navigators.dart';
// import 'package:cooking_champs/utils/utility.dart';
// import 'package:country_code_picker/country_code_picker.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// import 'who_joining_new.dart';
//
// class RegisterNewView extends StatefulWidget {
//   const RegisterNewView({super.key});
//
//   @override
//   State<RegisterNewView> createState() => _RegisterNewViewState();
// }
//
// class _RegisterNewViewState extends State<RegisterNewView> {
//   bool isPasswordHidden = true;
//   bool isRepeatPasswordHidden = true;
//   String? passwordError;
//   String? repeatPasswordError;
//   String? emailError;
//   String selectedCountryCode = "+91";
//
//   final FocusNode fullNameFocusNode = FocusNode();
//   final FocusNode lastNameFocusNode = FocusNode();
//   final FocusNode dateOfBirthFocusNode = FocusNode();
//   final FocusNode emailFocusNode = FocusNode();
//   final FocusNode mobileNumberFocusNode = FocusNode();
//   final FocusNode passwordFocusNode = FocusNode();
//   final FocusNode repeatPasswordFocusNode = FocusNode();
//
//   ParentRegisterModel parentRegisterModel = ParentRegisterModel();
//   TextEditingController fullNameController = TextEditingController();
//   TextEditingController lastNameController = TextEditingController();
//   TextEditingController dateOfBirthController = TextEditingController();
//   TextEditingController enterEmailController = TextEditingController();
//   TextEditingController mobileNumberController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController repeatPasswordController = TextEditingController();
//
//   bool isLoading = false;
//   @override
//   void dispose() {
//     Utility.getFcm();
//     fullNameFocusNode.dispose();
//     lastNameFocusNode.dispose();
//     dateOfBirthFocusNode.dispose();
//     emailFocusNode.dispose();
//     mobileNumberFocusNode.dispose();
//     passwordFocusNode.dispose();
//     repeatPasswordFocusNode.dispose();
//     super.dispose();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//
//     if (Platform.isIOS) {
//       List<FocusNode> focusNodes = [
//         fullNameFocusNode,
//         lastNameFocusNode,
//         dateOfBirthFocusNode,
//         emailFocusNode,
//         mobileNumberFocusNode,
//         passwordFocusNode,
//         repeatPasswordFocusNode,
//       ];
//
//       for (var node in focusNodes) {
//         node.addListener(() {
//           if (node.hasFocus) {
//             KeyboardOverlay.showOverlay(context);
//           } else {
//             KeyboardOverlay.removeOverlay();
//           }
//         });
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return CommonScaffold(
//       useSafeArea: false,
//       body: Stack(
//         children: [
//           // 🔒 Fixed background image
//
//           Container(
//             alignment: Alignment.center,
//             width: double.infinity,
//             height: MediaQuery.of(context).size.height / 1.7,
//             color: Colors.red,
//             child: Image.asset(
//               width: double.infinity,
//               AssetsPath.registerBackground,
//               fit: BoxFit.cover,
//             ),
//           ),
//
//           // 🔓 Scrollable form over fixed background
//           SafeArea(
//             child: LayoutBuilder(
//               builder: (context, constraints) {
//                 return SingleChildScrollView(
//                   physics: const BouncingScrollPhysics(),
//                   padding: EdgeInsets.only(
//                     left: 15,
//                     right: 15,
//                     top: 20,
//                     bottom: MediaQuery.of(context).viewInsets.bottom + 20,
//                   ),
//                   child: ConstrainedBox(
//                     constraints: BoxConstraints(
//                       minHeight: constraints.maxHeight,
//                     ),
//                     child: IntrinsicHeight(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("Join the Cooking Champs!",
//                               style: boldTextStyle(
//                                   fontSize: 28.0, color: MyColor.color000000)),
//                           hsized8,
//                           Text(
//                               "Create your child’s cooking profile and unlock a world of fun, learning, and delicious adventures!",
//                               style: regularNormalTextStyleWithoutHeight(
//                                   fontSize: 13.0, color: MyColor.color000000)),
//                           hsized25,
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: commonTextField(
//                                   prefixWidget: null,
//                                   focusNode: fullNameFocusNode,
//                                   controller: fullNameController,
//                                   labelText: 'First Name*',
//                                   hintText: 'Enter first name',
//                                   textInputAction: TextInputAction.next,
//                                   textInputType: TextInputType.name,
//                                   inputFormatters: [
//                                     FilteringTextInputFormatter.allow(
//                                         RegExp(r'[a-zA-Z\s]')),
//                                   ],
//                                 ),
//                               ),
//                               wSized20,
//                               Expanded(
//                                 child: commonTextField(
//                                   prefixWidget: null,
//                                   focusNode: lastNameFocusNode,
//                                   controller: lastNameController,
//                                   labelText: 'Last Name*',
//                                   hintText: 'Enter last name',
//                                   textInputAction: TextInputAction.next,
//                                   textInputType: TextInputType.name,
//                                   inputFormatters: [
//                                     FilteringTextInputFormatter.allow(
//                                         RegExp(r'[a-zA-Z\s]')),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                           hsized20,
//                           GestureDetector(
//                             onTap: () async {
//                               final DateTime? pickedDate = await showDatePicker(
//                                 context: context,
//                                 initialDate: DateTime(2010),
//                                 firstDate: DateTime(1900),
//                                 lastDate: DateTime.now(),
//                               );
//                               if (pickedDate != null) {
//                                 dateOfBirthController.text =
//                                     "${pickedDate.toLocal()}".split(' ')[0];
//                               }
//                             },
//                             child: AbsorbPointer(
//                               child: commonTextField(
//                                 focusNode: dateOfBirthFocusNode,
//                                 controller: dateOfBirthController,
//                                 labelText: 'Date of Birth*',
//                                 hintText: 'YYYY-MM-DD',
//                                 textInputAction: TextInputAction.done,
//                                 textInputType: TextInputType.datetime,
//                               ),
//                             ),
//                           ),
//                           hsized20,
//                           commonTextField(
//                             focusNode: mobileNumberFocusNode,
//                             controller: mobileNumberController,
//                             lenght: 10,
//                             labelText: 'Mobile Number*',
//                             hintText: 'Enter mobile number',
//                             textInputAction: TextInputAction.done,
//                             textInputType: TextInputType.number,
//                            // errorText: mobileError, // ✅ FIXED
//                             prefixWidget: CountryCodePicker(
//                               onChanged: (code) {
//                                 setState(() {
//                                   selectedCountryCode = code.dialCode ?? '+61'; // 🇦🇺 Australia
//                                 });
//                               },
//                               initialSelection: 'AU',
//                               favorite: ['+61', 'AU'],
//                               // alignLeft: true,
//                               // showFlag: false,
//                               padding: EdgeInsets.zero,
//                             ),
//                           ),
//
//
//                           hsized20,
//                           commonTextField(
//                             focusNode: emailFocusNode,
//                             controller: enterEmailController,
//                             labelText: 'Email*',
//                             hintText: 'Enter email',
//                             errorText: emailError,
//                             textInputAction: TextInputAction.done,
//                             textInputType: TextInputType.emailAddress,
//                           ),
//
//                           hsized20,
//                           commonTextField(
//                             focusNode: passwordFocusNode,
//                             controller: passwordController,
//                             labelText: 'Password*',
//                             hintText: 'Enter password',
//                             textInputAction: TextInputAction.done,
//                             textInputType: TextInputType.visiblePassword,
//                             obscureText: isPasswordHidden,
//                             errorText: passwordError,
//                             suffixIcon: IconButton(
//                               icon: Icon(
//                                 isPasswordHidden
//                                     ? Icons.visibility_off
//                                     : Icons.visibility,
//                                 color: MyColor.black,
//                                 size: 20,
//                               ),
//                               onPressed: () {
//                                 setState(() {
//                                   isPasswordHidden = !isPasswordHidden;
//                                 });
//                               },
//                             ),
//                           ),
//                           hsized20,
//                           commonTextField(
//                             focusNode: repeatPasswordFocusNode,
//                             controller: repeatPasswordController,
//                             labelText: 'Repeat Password*',
//                             hintText: 'Repeat password',
//                             textInputAction: TextInputAction.done,
//                             textInputType: TextInputType.visiblePassword,
//                             obscureText: isRepeatPasswordHidden,
//                             errorText: repeatPasswordError,
//                             suffixIcon: IconButton(
//                               icon: Icon(
//                                 isRepeatPasswordHidden
//                                     ? Icons.visibility_off
//                                     : Icons.visibility,
//                                 color: MyColor.black,
//                                 size: 20,
//                               ),
//                               onPressed: () {
//                                 setState(() {
//                                   isRepeatPasswordHidden =
//                                       !isRepeatPasswordHidden;
//                                 });
//                               },
//                             ),
//                           ),
//                           hsized25,
//                           isLoading
//                               ? const CircularProgressIndicator()
//                               : commonButton(
//                                   text: Languages.of(context)!.register,
//                                   onTap: () async {
//                                     await validateAndRegister();
//                                   },
//                                   backgroundColor: MyColor.color48335CB2,
//                                   textColor: MyColor.white,
//                                 ),
//                           hsized20,
//                           Center(
//                             child: RichText(
//                               textAlign: TextAlign.center,
//                               text: TextSpan(
//                                 style: mediumTextStyle(
//                                     fontSize: 14.0, color: MyColor.black),
//                                 children: [
//                                   TextSpan(
//                                     text: 'Already have an account?  ',
//                                     style: semiBoldTextStyle(
//                                       fontSize: 14.0,
//                                       color: MyColor.grey,
//                                     ),
//                                   ),
//                                   TextSpan(
//                                     text: 'Sign In',
//                                     style: semiBoldTextStyle(
//                                       fontSize: 14.0,
//                                       color: MyColor.color48335CB2,
//                                     ),
//                                     recognizer: TapGestureRecognizer()
//                                       ..onTap = () {
//                                         CustomNavigators.pushNavigate(
//                                             WelcomeCookingChampsView(),
//                                             context);
//                                       },
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           hsized20,
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Future<void> validateAndRegister() async {
//   //   // Validate form
//   //   if (fullNameController.text.trim().isEmpty ||
//   //       lastNameController.text.trim().isEmpty ||
//   //       dateOfBirthController.text.trim().isEmpty ||
//   //       enterEmailController.text.trim().isEmpty ||
//   //       passwordController.text.isEmpty ||
//   //       repeatPasswordController.text.isEmpty) {
//   //     Utility.customToast(context, "Please fill all required fields.");
//   //     return;
//   //   }
//   //
//   //   // if (passwordController.text.length < 5) {
//   //   //   Utility.customToast(context, "Password must be at least 5 characters.");
//   //   //   return;
//   //   // }
//   //   if (passwordController.text.length < 5) {
//   //     setState(() {
//   //       passwordError = "Password must be at least 5 characters.";
//   //     });
//   //     return;
//   //   } else {
//   //     setState(() {
//   //       passwordError = null;
//   //     });
//   //   }
//   //
//   //   // if (passwordController.text != repeatPasswordController.text) {
//   //   //   Utility.customToast(context, "Passwords do not match.");
//   //   //   return;
//   //   // }
//   //   if (passwordController.text != repeatPasswordController.text) {
//   //     setState(() {
//   //       repeatPasswordError = "Passwords do not match.";
//   //     });}
//   //
//   //
//   //   await parentRegister();
//   //
//   //
//   // }
//   Future<void> validateAndRegister() async {
//     setState(() {
//       emailError = null;
//       passwordError = null;
//       repeatPasswordError = null;
//     });
//
//     final email = enterEmailController.text.trim();
//     final password = passwordController.text;
//     final repeatPassword = repeatPasswordController.text;
//     final mobile = mobileNumberController.text.trim();
//     print("Full Name: ${fullNameController.text}");
//     print("Last Name: ${lastNameController.text}");
//     print("DOB: ${dateOfBirthController.text}");
//     print("Email: $email");
//     print("Mobile: $mobile");
//     print("Password: $password");
//     print("Repeat Password: $repeatPassword");
//
//
//     if (fullNameController.text.trim().isEmpty ||
//         lastNameController.text.trim().isEmpty ||
//         dateOfBirthController.text.trim().isEmpty ||
//         email.isEmpty ||
//         mobile.isEmpty ||
//         password.isEmpty ||
//         repeatPassword.isEmpty) {
//       Utility.customToast(context, "Please fill all required fields.");
//       return;
//     }
//
//     final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
//     if (!emailRegex.hasMatch(email)) {
//       setState(() {
//         emailError = "Please enter a valid email address.";
//       });
//       return;
//     }
//
//     final mobileRegex = RegExp(r'^[0-9]{10}$');
//     if (!mobileRegex.hasMatch(mobile)) {
//       Utility.customToast(context, "Please enter a valid 10-digit mobile number.");
//       return;
//     }
//
//     if (password.length < 5) {
//       setState(() {
//         passwordError = "Password must be at least 5 characters.";
//       });
//       return;
//     }
//
//     if (password != repeatPassword) {
//       setState(() {
//         repeatPasswordError = "Passwords do not match.";
//       });
//       return;
//     }
//
//     await parentRegister();
//   }
//
//
//   Future<void> parentRegister() async {
//     String fcm =
//         await PreferencesServices.getPreferencesData(PreferencesServices.fcm) ??
//             "";
//
//     parentRegisterModel = ParentRegisterModel(
//       role: RegisterType.roleParent.value,
//       firstName: fullNameController.text.trim(),
//       mobileNumber: mobileNumberController.text.trim(),
//       countryCode: selectedCountryCode.toString(),
//       lastName: lastNameController.text.trim(),
//       email: enterEmailController.text.trim(),
//       password: passwordController.text,
//       passwordConfirmation: repeatPasswordController.text,
//       fcmToken: fcm,
//       deviceId: AppState.deviceIdStr,
//       deviceType: AppState.devicetype,
//     );
//
//     debugPrint("Registering with deviceType: ${AppState.devicetype}");
//
//     try {
//       var onValue = await ApiServices.registerNew(context, parentRegisterModel);
//       if (mounted) {
//         if (onValue.status == true) {
//           CustomNavigators.pushReplacementNavigate(WhoJoiningNew(), context);
//         } else {
//           Utility.customToast(context, onValue.errors ?? "Registration failed");
//         }
//       }
//     } catch (e) {
//       debugPrint("Error during registration: $e");
//       Utility.customToast(context, "Something went wrong. Please try again.");
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
import 'package:cooking_champs/model/post_model/parent_register_model.dart';
import 'package:cooking_champs/new_ui/login_new_view.dart';
import 'package:cooking_champs/services/api_services.dart';
import 'package:cooking_champs/services/user_prefences.dart';
import 'package:cooking_champs/utils/common_widget.dart';
import 'package:cooking_champs/utils/keyboardoverlay.dart';
import 'package:cooking_champs/utils/navigators.dart';
import 'package:cooking_champs/utils/utility.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'who_joining_new.dart';

class RegisterNewView extends StatefulWidget {
  const RegisterNewView({super.key});

  @override
  State<RegisterNewView> createState() => _RegisterNewViewState();
}

class _RegisterNewViewState extends State<RegisterNewView> {
  bool isPasswordHidden = true;
  bool isRepeatPasswordHidden = true;
  String? passwordError;
  String? repeatPasswordError;
  String? emailError;
  String selectedCountryCode = "+91";

  final FocusNode fullNameFocusNode = FocusNode();
  final FocusNode lastNameFocusNode = FocusNode();
  final FocusNode dateOfBirthFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode mobileNumberFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode repeatPasswordFocusNode = FocusNode();

  ParentRegisterModel parentRegisterModel = ParentRegisterModel();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController enterEmailController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    Utility.getFcm();
    fullNameFocusNode.dispose();
    lastNameFocusNode.dispose();
    dateOfBirthFocusNode.dispose();
    emailFocusNode.dispose();
    mobileNumberFocusNode.dispose();
    passwordFocusNode.dispose();
    repeatPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (Platform.isIOS) {
      List<FocusNode> focusNodes = [
        fullNameFocusNode,
        lastNameFocusNode,
        dateOfBirthFocusNode,
        emailFocusNode,
        mobileNumberFocusNode,
        passwordFocusNode,
        repeatPasswordFocusNode,
      ];

      for (var node in focusNodes) {
        node.addListener(() {
          if (node.hasFocus) {
            KeyboardOverlay.showOverlay(context);
          } else {
            KeyboardOverlay.removeOverlay();
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isTablet = size.shortestSide > 600;

    return CommonScaffold(
      useSafeArea: false,
      body: Stack(
        children: [
          // ✅ Responsive Background Image
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: MediaQuery.of(context).size.height / (isTablet ? 1.5 : 1.7),
            child: Image.asset(
              width: double.infinity,
              AssetsPath.registerBackground,
              fit: BoxFit.cover,
            ),
          ),

          // ✅ Responsive Form
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.only(
                    left: isTablet ? 30 : 15,
                    right: isTablet ? 30 : 15,
                    top: isTablet ? 40 : 20,
                    bottom: MediaQuery.of(context).viewInsets.bottom + (isTablet ? 40 : 20),
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ✅ Responsive Title
                          Text(
                            "Join the Cooking Champs!",
                            style: boldTextStyle(
                                fontSize: isTablet ? 34.0 : 28.0,
                                color: MyColor.color000000
                            ),
                          ),

                          SizedBox(height: isTablet ? 12 : 8),

                          // ✅ Responsive Subtitle
                          Text(
                            "Create your child's cooking profile and unlock a world of fun, learning, and delicious adventures!",
                            style: regularNormalTextStyleWithoutHeight(
                                fontSize: isTablet ? 18.0 : 13.0,
                                color: MyColor.color000000
                            ),
                          ),

                          SizedBox(height: isTablet ? 35 : 25),

                          // ✅ Responsive Row for First & Last Name
                          Row(
                            children: [
                              Expanded(
                                child: commonTextField(
                                  prefixWidget: null,
                                  focusNode: fullNameFocusNode,
                                  controller: fullNameController,
                                  labelText: 'First Name*',
                                  hintText: 'Enter first name',
                                  textInputAction: TextInputAction.next,
                                  textInputType: TextInputType.name,
                                  isTablet: isTablet, // ✅ Pass isTablet
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[a-zA-Z\s]')
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(width: isTablet ? 25 : 20),

                              Expanded(
                                child: commonTextField(
                                  prefixWidget: null,
                                  focusNode: lastNameFocusNode,
                                  controller: lastNameController,
                                  labelText: 'Last Name*',
                                  hintText: 'Enter last name',
                                  textInputAction: TextInputAction.next,
                                  textInputType: TextInputType.name,
                                  isTablet: isTablet, // ✅ Pass isTablet
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[a-zA-Z\s]')
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: isTablet ? 25 : 20),

                          // ✅ Responsive Date of Birth
                          GestureDetector(
                            onTap: () async {
                              final DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime(2010),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              );
                              if (pickedDate != null) {
                                dateOfBirthController.text =
                                "${pickedDate.toLocal()}".split(' ')[0];
                              }
                            },
                            child: AbsorbPointer(
                              child: commonTextField(
                                focusNode: dateOfBirthFocusNode,
                                controller: dateOfBirthController,
                                labelText: 'Date of Birth*',
                                hintText: 'YYYY-MM-DD',
                                textInputAction: TextInputAction.done,
                                textInputType: TextInputType.datetime,
                                isTablet: isTablet, // ✅ Pass isTablet
                              ),
                            ),
                          ),

                          SizedBox(height: isTablet ? 25 : 20),

                          // ✅ Responsive Mobile Number with Country Code
                          commonTextField(
                            focusNode: mobileNumberFocusNode,
                            controller: mobileNumberController,
                            lenght: 10,
                            labelText: 'Mobile Number*',
                            hintText: 'Enter mobile number',
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.number,
                            isTablet: isTablet, // ✅ Pass isTablet
                            prefixWidget: Container(
                              padding: EdgeInsets.only(
                                left: isTablet ? 12 : 8,
                                right: isTablet ? 10 : 6,
                              ),
                              child: CountryCodePicker(
                                onChanged: (code) {
                                  setState(() {
                                    selectedCountryCode = code.dialCode ?? '+91';
                                  });
                                },
                                initialSelection: 'IN',
                                favorite: ['+91', 'IN'],
                                showCountryOnly: false,
                                showOnlyCountryWhenClosed: false,
                                // alignLeft: true,
                                // showFlag: false,
                                padding: EdgeInsets.zero,
                                textStyle: regularTextStyle(
                                  fontSize: isTablet ? 16.0 : 14.0,
                                  color: MyColor.black,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: isTablet ? 25 : 20),

                          // ✅ Responsive Email
                          commonTextField(
                            focusNode: emailFocusNode,
                            controller: enterEmailController,
                            labelText: 'Email*',
                            hintText: 'Enter email',
                            errorText: emailError,
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.emailAddress,
                            isTablet: isTablet, // ✅ Pass isTablet
                          ),

                          SizedBox(height: isTablet ? 25 : 20),

                          // ✅ Responsive Password
                          commonTextField(
                            focusNode: passwordFocusNode,
                            controller: passwordController,
                            labelText: 'Password*',
                            hintText: 'Enter password',
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.visiblePassword,
                            obscureText: isPasswordHidden,
                            errorText: passwordError,
                            isTablet: isTablet, // ✅ Pass isTablet
                            suffixIcon: IconButton(
                              icon: Icon(
                                isPasswordHidden
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: MyColor.black,
                                size: isTablet ? 24 : 20,
                              ),
                              onPressed: () {
                                setState(() {
                                  isPasswordHidden = !isPasswordHidden;
                                });
                              },
                            ),
                          ),

                          SizedBox(height: isTablet ? 25 : 20),

                          // ✅ Responsive Repeat Password
                          commonTextField(
                            focusNode: repeatPasswordFocusNode,
                            controller: repeatPasswordController,
                            labelText: 'Repeat Password*',
                            hintText: 'Repeat password',
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.visiblePassword,
                            obscureText: isRepeatPasswordHidden,
                            errorText: repeatPasswordError,
                            isTablet: isTablet, // ✅ Pass isTablet
                            suffixIcon: IconButton(
                              icon: Icon(
                                isRepeatPasswordHidden
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: MyColor.black,
                                size: isTablet ? 24 : 20,
                              ),
                              onPressed: () {
                                setState(() {
                                  isRepeatPasswordHidden = !isRepeatPasswordHidden;
                                });
                              },
                            ),
                          ),

                          SizedBox(height: isTablet ? 35 : 25),

                          // ✅ Responsive Register Button
                          isLoading
                              ? Center(
                            child: CircularProgressIndicator(
                              color: MyColor.color48335CB2,
                              strokeWidth: isTablet ? 3.0 : 2.0,
                            ),
                          )
                              : commonButton(
                            text: Languages.of(context)!.register,
                            onTap: () async {
                              await validateAndRegister();
                            },
                            backgroundColor: MyColor.color48335CB2,
                            textColor: MyColor.white,
                            isTablet: isTablet, // ✅ Pass isTablet
                          ),

                          SizedBox(height: isTablet ? 30 : 20),

                          // ✅ Responsive Sign In Text
                          Center(
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: mediumTextStyle(
                                  fontSize: isTablet ? 16.0 : 14.0,
                                  color: MyColor.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Already have an account?  ',
                                    style: semiBoldTextStyle(
                                      fontSize: isTablet ? 16.0 : 14.0,
                                      color: MyColor.grey,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Sign In',
                                    style: semiBoldTextStyle(
                                      fontSize: isTablet ? 16.0 : 14.0,
                                      color: MyColor.color48335CB2,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        CustomNavigators.pushNavigate(
                                          WelcomeCookingChampsView(),
                                          context,
                                        );
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: isTablet ? 40 : 20),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> validateAndRegister() async {
    setState(() {
      emailError = null;
      passwordError = null;
      repeatPasswordError = null;
    });

    final email = enterEmailController.text.trim();
    final password = passwordController.text;
    final repeatPassword = repeatPasswordController.text;
    final mobile = mobileNumberController.text.trim();

    if (fullNameController.text.trim().isEmpty ||
        lastNameController.text.trim().isEmpty ||
        dateOfBirthController.text.trim().isEmpty ||
        email.isEmpty ||
        mobile.isEmpty ||
        password.isEmpty ||
        repeatPassword.isEmpty) {
      Utility.customToast(context, "Please fill all required fields.");
      return;
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      setState(() {
        emailError = "Please enter a valid email address.";
      });
      return;
    }

    final mobileRegex = RegExp(r'^[0-9]{10}$');
    if (!mobileRegex.hasMatch(mobile)) {
      Utility.customToast(context, "Please enter a valid 10-digit mobile number.");
      return;
    }

    if (password.length < 5) {
      setState(() {
        passwordError = "Password must be at least 5 characters.";
      });
      return;
    }

    if (password != repeatPassword) {
      setState(() {
        repeatPasswordError = "Passwords do not match.";
      });
      return;
    }

    await parentRegister();
  }

  Future<void> parentRegister() async {
    String fcm =
        await PreferencesServices.getPreferencesData(PreferencesServices.fcm) ??
            "";

    parentRegisterModel = ParentRegisterModel(
      role: RegisterType.roleParent.value,
      firstName: fullNameController.text.trim(),
      mobileNumber: mobileNumberController.text.trim(),
      countryCode: selectedCountryCode.toString(),
      lastName: lastNameController.text.trim(),
      email: enterEmailController.text.trim(),
      password: passwordController.text,
      passwordConfirmation: repeatPasswordController.text,
      fcmToken: fcm,
      deviceId: AppState.deviceIdStr,
      deviceType: AppState.devicetype,
    );

    debugPrint("Registering with deviceType: ${AppState.devicetype}");

    try {
      var onValue = await ApiServices.registerNew(context, parentRegisterModel);
      if (mounted) {
        if (onValue.status == true) {
          CustomNavigators.pushReplacementNavigate(WhoJoiningNew(), context);
        } else {
          Utility.customToast(context, onValue.errors ?? "Registration failed");
        }
      }
    } catch (e) {
      debugPrint("Error during registration: $e");
      Utility.customToast(context, "Something went wrong. Please try again.");
    }
  }
}