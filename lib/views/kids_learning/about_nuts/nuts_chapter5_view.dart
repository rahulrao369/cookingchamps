import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:flutter/material.dart';

class NutsChapter5View extends StatelessWidget {
  const NutsChapter5View({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: MyColor.white,
      body:SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal:20.0),
        child: Column(
          children: [
               Image.asset(AssetsPath.nutsChapter5Img,height:700,),

            hsized40,
            UiUtils.buildFunFact(title:"Fun Fact", fact: "Peanuts are not a nut! They are actually part of the legume family like lentils and chickpeas."),


            hsized100

          ],
        ),
      ),
    );
  }
}
