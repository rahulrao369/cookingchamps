import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:flutter/material.dart';

class NutsChapter2View extends StatelessWidget {
  const NutsChapter2View({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal:20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UiUtils.buildBoldText("What’s a nut?",fontSize:20.0,color:MyColor.copperRed),
           hsized5,
            UiUtils.buildNormalText("A nut is a dry fruit with one or two seeds When it’s ready to eat the shell becomes very hard. Even though nuts are pretty small they contain heaps of goodness and are one of the healthiest treats you can eat. So what’s so good about nuts?",fontSize:16.0),
           hsized20,
            Image.asset(AssetsPath.nutsChapter2Img1),
            hsized20,
            UiUtils.buildMediumText("They are a great energy food because"),
            UiUtils.buildNormalText("They contain:-"),
            UiUtils.buildBulletPoints([
              " Protein and nutrients to make you big and strong",
              "fibre to keep your digestive system working well",
              "healthy fats"
            ]),

            hsized20,
            Image.asset(AssetsPath.wowImg,height:60,)
            //UiUtils.buildBoldText("WOW!",color: MyColor.green,fontSize:40.0)

         
          ],
        ),
      ),
    );
  }
}
