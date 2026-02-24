import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/utils/navigators.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:flutter/material.dart';

class CelebrationActivity2View extends StatelessWidget {
  const CelebrationActivity2View({super.key});

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
                      child: UiUtils.hygieneAppBar(()=> CustomNavigators.popNavigate(context),text: "Activity 10.2",color:MyColor.black)),
                  UiUtils.bookReadGirl(MyColor.purpleNavy, AssetsPath.bookReadImg, true)
                ],
              ),
              UiUtils.buildBoldText("Extension Food memories",color:  MyColor.purpleNavy, fontSize:23.0),


              hsized10,

              UiUtils.buildNormalText("This activity involves sharing stories about your favourite meals with family remembering special occasions and identifying different foods.",color:  MyColor.black,fontSize:16.0),
              UiUtils.buildSemiBoldText("You will need:",color:  MyColor.black),
              hsized5,
              UiUtils.buildBulletPoints([
                "Large pieces of paper for each child",
                "Coloured pencils, textas, crayons ",
              ]),

              hsized10,
              UiUtils.buildStepsNormal([
                "In class share your memories of favourite celebration food. Talk about-  How the food smelt Where you were during the meal How you felt after they ate the meal How many of the meals were vegetable or fruit based How many were meat How many were sweets",
                " Then as a group identify the ingredients that go into the different meals.",
                "Draw a picture of your family and yourself enjoying a favourite meal or food. Draw all the different things that make up the meal and share the picture with your class."
              ],bottomPadding:15),

              hsized100,
            ],
          ),
        ),
      ),
    );
  }

}
