import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/utils/navigators.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:flutter/material.dart';

class CelebrationActivity3View extends StatelessWidget {
  const CelebrationActivity3View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              hsized45,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(padding: EdgeInsets.only(bottom:25),
                      child: UiUtils.hygieneAppBar(()=> CustomNavigators.popNavigate(context),text: "Activity 10.3",color:MyColor.black)),
                  UiUtils.bookReadGirl(MyColor.purpleNavy, AssetsPath.bookReadImg, true)
                ],
              ),
              UiUtils.buildBoldText("Party Time!",color:  MyColor.purpleNavy, fontSize:23.0),
              hsized10,

              Align(
                  alignment: Alignment.center,
                  child: Image.asset(AssetsPath.celebrationActivity3Img,)),

              hsized20,

              UiUtils.buildSemiBoldText("What you have to do.",color:  MyColor.black),
              hsized5,
              UiUtils.buildSteps([
                "Complete Final Quiz",
                "In class with your teacher make a date for Cooking Champs Certificate Day.",
                "In class make your invitations.",
                "Invite parents and special friends.",
                "In pairs select your favourite food from the book or your favourite family celebration recipe.",
                "The day before your Cooking Champs Certificate day prepare your recipe and bring to class for your celebration.",
                "Teacher hands out certificates and everyone celebrates together!"
              ]),

              hsized100,
            ],
          ),
        ),
      ),
    );
  }

}
