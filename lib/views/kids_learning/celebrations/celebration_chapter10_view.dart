import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:flutter/material.dart';

class CelebrationChapter10View extends StatelessWidget {
  const CelebrationChapter10View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              UiUtils.buildBoldText("We have learnt about cooking tools, cooking techniques and cooking words as well as completing heaps of quizzes.",color:  MyColor.purpleNavy, fontSize:23.0),
              hsized30,

              Align(
                  alignment: Alignment.center,
                  child: Image.asset(AssetsPath.celebrationChapter10Img,height:250,)),

              hsized20,

              UiUtils.buildMediumText("Now it is time to celebrate!",color:  MyColor.darkOrange),
              hsized20,
              UiUtils.buildNormalText("Next year we will learn more about food from around the world, germs, hygiene and the digestive system, the new upside down food pyramid, about food groups, and more tasty recipes and lots more riddles, rhymes, poems, jokes and fun facts!"),


              hsized30,

              UiUtils.buildNormalText("Now you have your first year certificate – try the recipes at home with your parents and friends and remember to:"),

              hsized20,
              Image.asset(AssetsPath.celebrationChapter10Img2,height:55.0,),

              hsized100,
            ],
          ),
        ),
      ),
    );
  }

}
