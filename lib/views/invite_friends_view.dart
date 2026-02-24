import 'dart:io';

import 'package:cooking_champs/constant/apiConnectorConstants.dart';
import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/constant/stringfile.dart/language.dart';
import 'package:cooking_champs/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class InviteFriendsView extends StatefulWidget {
  const InviteFriendsView({super.key});

  @override
  State<InviteFriendsView> createState() => _InviteFriendsViewState();
}

class _InviteFriendsViewState extends State<InviteFriendsView> {
  String message = """
  Join Cooking Champs!  

  Hey! I’m inviting you to join **Cooking Champs**, the ultimate cooking experience!  
  Discover delicious recipes, challenge friends, and become a master chef. 🏆👨‍🍳  

  📲 **Download Now:**  
  // Android
  ✅ **Play store:** ${ApiConnectorConstants.androidLink}  
  // iOS
  ✅ **App store:** ${ApiConnectorConstants.iosLink} \nLet’s cook and have fun together! 🎉🍔🥗  """;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: size.width * 0.12,
        automaticallyImplyLeading: false,
        backgroundColor: MyColor.yellowF6F1E1,
        surfaceTintColor: MyColor.yellowF6F1E1,
        leading: InkWell(
          radius: 80,
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: const Icon(
              Icons.arrow_back_ios,
              size: 30,
              color: Colors.black,
            ),
          ),
        ),
        title: Text(Languages.of(context)!.inviteFriends,
            style: mediumTextStyle(fontSize: 18.0, color: MyColor.black)),
        centerTitle: false,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Languages.of(context)!.inviteYourFriendsToCookingChampsDetail,
              style: boldTextStyle(fontSize: 20.0, color: MyColor.black),
            ),
            hsized10,
            Text(
              Languages.of(context)!.shareYourInviteLink,
              style:
                  regularNormalTextStyle(fontSize: 15.0, color: MyColor.black),
            ),
            hsized20,
            Text(
              Languages.of(context)!.shareYourLink,
              style: mediumTextStyle(fontSize: 15.0, color: MyColor.black),
            ),
            hsized10,
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: MyColor.grayLite)),
                    child: Text(
                      "cookingchamps.com/invite?",
                      style:
                          mediumTextStyle(fontSize: 15.0, color: MyColor.black),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () {
                    Utility().copyAppLinks();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: MyColor.appTheme,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Text(
                      Languages.of(context)!.copy,
                      style:
                          mediumTextStyle(fontSize: 16.0, color: MyColor.white),
                    ),
                  ),
                ),
              ],
            ),
            hsized20,
            Text(
              Languages.of(context)!.moreWaysToShare,
              style: mediumTextStyle(fontSize: 15.0, color: MyColor.black),
            ),
            hsized10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /*  socialIconUi(
                    AssetsPath.facebook2, Languages.of(context)!.facebook),*/
                /* SizedBox(
                  width: 20,
                ),*/
                socialIconUi(
                    AssetsPath.whatsapp, Languages.of(context)!.whatsApp),
                SizedBox(
                  width: 20,
                ),
                socialIconUi(AssetsPath.inbox, Languages.of(context)!.message),
              ],
            ),
            hsized30,
            Image.asset(AssetsPath.champs)
          ],
        ),
      ),
    );
  }

  socialIconUi(String img, String name) {
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: () {
          Utility().copyAppLinks();
          setState(() {});
          if (name == Languages.of(context)!.whatsApp) {
            shareToWhatsApp();
            // openWhatsapp(context: context, text: "tette", number: "6566989767");
          } else if (name == Languages.of(context)!.facebook) {
            shareToFacebook();
          } else if (name == Languages.of(context)!.message) {
            shareToMessage();
          }
        },
        child: Container(
          margin: EdgeInsets.only(right: 10),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: MyColor.grayLite)),
          child: Column(
            children: [
              hsized3,
              Image.asset(
                img,
                height: 30,
                width: 30,
              ),
              hsized5,
              Text(
                name,
                style: mediumTextStyle(fontSize: 13.0, color: MyColor.black),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void shareToWhatsApp() async {
    String encodedMessage = Uri.encodeComponent(message);
    var whatsappURlAndroid = "whatsapp://send?text=$encodedMessage";
    var whatsappURLIos = "https://wa.me/?text=${Uri.tryParse(encodedMessage)}";
    Uri whatsappUrl =
        Uri.parse(Platform.isIOS ? whatsappURLIos : whatsappURlAndroid);
    launchApp(whatsappUrl);
  }

  void shareToFacebook() async {
    String encodedMessage = Uri.encodeComponent(message);
    Uri fbMessengerUrl = Uri.parse("fb://facewebmodal/");

    if (await canLaunchUrl(fbMessengerUrl)) {
      await launchUrl(fbMessengerUrl, mode: LaunchMode.externalApplication);
    } else {
      // If Messenger is not installed, open Messenger in the browser
      Uri webUrl = Uri.parse("https://www.messenger.com/");
      if (await canLaunchUrl(webUrl)) {
        await launchUrl(webUrl, mode: LaunchMode.externalApplication);
      } else {
        debugPrint("Facebook Messenger cannot be opened.");
      }
    }
    // Uri facebookUrl = Uri.parse("fb://facewebmodal/?text=trtr");
    // "https://www.facebook.com/sharer/sharer.php?u=$encodedMessage");
    // launchApp(facebookUrl);
  }

  void shareToMessage() async {
    String encodedMessage = Uri.encodeComponent(message);
    Uri messageUrl = Uri.parse("sms:?body=$encodedMessage");
    // "https://www.instagram.com/direct/inbox?text=$encodedMessage");
    launchApp(messageUrl);
  }

  void launchApp(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      Share.share(message);
    }
  }
}
