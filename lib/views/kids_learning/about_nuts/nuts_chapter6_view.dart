import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:flutter/material.dart';

class NutsChapter6View extends StatelessWidget {
  const NutsChapter6View({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: MyColor.white,
      body:SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal:20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UiUtils.buildBoldText("Where do nuts grow?",fontSize:20.0,color: MyColor.copperRed),

            hsized10,
            Image.asset(AssetsPath.nutsChapter6Img),

            hsized20,
            UiUtils.buildFunFact(title:"Fun Fact", fact: "Peanuts are not a nut! They are actually part of the legume family like lentils and chickpeas."),

            hsized20,
            UiUtils.buildMediumText("Nuts grow on trees.",color: MyColor.red1,fontSize: 16.0),
            Image.asset(AssetsPath.dividerLineImg),

           hsized8,
            UiUtils.buildNormalText("A nut is a dry fruit with one or two seeds. When it’s ready to eat the shell becomes very hard. They are very good for you. In a balanced diet you would eat about 30 grams of nuts (about a handful) every day."),
            hsized20,
            UiUtils.buildJokeSection("Q. What is crazy and walks along the sides of buildings?", "A. A walnut. HE! HE!",image: "Boy"),
            hsized100

          ],
        ),
      ),
    );
  }
}
