import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/constant/stringfile.dart/language.dart';
import 'package:cooking_champs/utils/common_widget.dart';
import 'package:cooking_champs/utils/navigators.dart';
import 'package:cooking_champs/views/verification.dart';
import 'package:flutter/material.dart';

class ForgotPasswordWaitingOtp extends StatefulWidget {
  final String  email;
  const ForgotPasswordWaitingOtp({super.key, required this.email});

  @override
  State<ForgotPasswordWaitingOtp> createState() =>
      _ForgotPasswordWaitingOtpState();
}

class _ForgotPasswordWaitingOtpState extends State<ForgotPasswordWaitingOtp> {
  @override
  Widget build(BuildContext context) {
    final bool isIpad = MediaQuery.of(context).size.width > 600;
    return CommonScaffold(
      appBar: commonAppBar(
          context: context,
          title: Languages.of(context)!.forgotPassword,
          centerTitle: false),
      body: Stack(
        children: [
          Container(
              alignment: Alignment.center,
              child: Image.asset(AssetsPath.otpBackground)),
          Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 6,
                left: 15,
                right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Your email is on the way",
                    style: semiBoldTextStyle(
                        fontSize: isIpad ?24.0  :20.0, color: MyColor.color000000)),
                Text(
                    textAlign: TextAlign.center,
                    "Check your email ${widget.email} and follow the instructions to reset your password",
                    style: regularTextStyle(
                        fontSize:isIpad ? 18.0 :15.0, color: MyColor.color000000)),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style:
                        mediumTextStyle(fontSize: isIpad?17.0 :14.0, color: MyColor.black),
                    children: [
                      TextSpan(
                          text: 'Didn’t get it? ',
                          style: regularTextStyle(
                              fontSize: isIpad ? 18.0 :15.0, color: MyColor.color000000)),
                      TextSpan(
                        text: 'Resend OTP',
                        style: semiBoldTextStyle(
                          fontSize: isIpad ? 17.0 :14.0,
                          color: MyColor.purple,
                        ),
                      ),
                    ],
                  ),
                ),
                hsized40,
                commonButton(
                  text: 'Enter OTP',
                  onTap: () {
                    CustomNavigators.pushNavigate(
                        OtpVerificationView(email: widget.email,), context);
                  },
                  backgroundColor: MyColor.color48335CB2,
                  textColor: MyColor.white,
                  isTablet: isIpad
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
