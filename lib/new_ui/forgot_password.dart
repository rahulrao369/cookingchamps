import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/model/post_model/login_request_model.dart';
import 'package:cooking_champs/services/api_services.dart';
import 'package:cooking_champs/utils/common_widget.dart';
import 'package:cooking_champs/views/verification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constant/stringfile.dart/language.dart';
import '../utils/navigators.dart';
import 'forgot_password_waiting_otp.dart';

class ForgotPasswordNew extends StatefulWidget {
  const ForgotPasswordNew({super.key});

  @override
  State<ForgotPasswordNew> createState() => _ForgotPasswordNewState();
}

class _ForgotPasswordNewState extends State<ForgotPasswordNew> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
     final bool isIpad = MediaQuery.of(context).size.width > 600;
    return CommonScaffold(
        appBar: commonAppBar(
            context: context,
            title: Languages.of(context)!.forgotPassword,
            centerTitle: false),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                hsized50,
                SvgPicture.asset(
                  AssetsPath.emailRounded,
                  width: isIpad ? 100 : 50,
                  height: isIpad ? 100 : 50,
                ),
                hsized10,
                Text(
                    "Don't worry.\nEnter your email, and we'll send you a one-time  (OTP) to reset your password",
                    style: mediumTextStyle(
                        fontSize: isIpad ? 24.0 :20.0, color: MyColor.color000000)),
                hsized30,
                commonTextField(
                  controller: emailController,
                  labelText: 'Email',
                  hintText: 'Enter email',
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.emailAddress,
                  isTablet: isIpad
                ),
                hsized25,
                commonButton(
                  text: 'Continue',
                  onTap: () {
                    forgotPassApi();

                  },
                  backgroundColor: MyColor.color48335CB2,
                  textColor: MyColor.white,
                  isTablet: isIpad
                ),
              ],
            ),
          ),
        ));
  }
  forgotPassApi()async{
    LoginRequestModel forgotPass = LoginRequestModel(email: emailController.text.toString());

    await ApiServices.forgotPassword(context, forgotPass).then((onValue){
      if(mounted){
        if(onValue.status == true){
          CustomNavigators.pushNavigate(
              ForgotPasswordWaitingOtp(email:emailController.text.toString(),), context);
          // CustomNavigators.pushNavigate(OtpVerificationView(email:emailController.text.toString()), context);
        }
      }
    });
  }
}


