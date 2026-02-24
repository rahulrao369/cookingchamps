import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:flutter/material.dart';

class HoneyChapter7View extends StatelessWidget {
  const HoneyChapter7View({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal:20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UiUtils.buildBoldText("Honeybee Language",color: MyColor.neonColor,fontSize:20.0),

            hsized15,
            Image.asset(AssetsPath.honeyChapter7Img),
            UiUtils.buildMediumText("The Waggle Dance",color: MyColor.darkPink,fontSize:16.0),
            hsized5,
            Image.asset(AssetsPath.dividerLineImg,color: MyColor.darkPink,),

            hsized15,
            UiUtils.buildParagraph("In the hive the honeybee does a special dance called"," the waggle dance."," They waggle their abdomen in a figure eight pattern.  The further away the flowers the longer the bee does the waggle dance!"),

            hsized20,
            UiUtils.buildFunFact(title:"Fun Fact", fact:"Scientists have found that Honeybees talk to each other! WOW! They tell each other where they have found flowers and nectar."),

            hsized100
            
          ],
        ),
      ),
    );
  }
}
