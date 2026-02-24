import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:flutter/material.dart';

class NutsChapter4View extends StatelessWidget {
  const NutsChapter4View({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: MyColor.white,
      body:SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal:20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UiUtils.buildBoldText("Nuts are good for you so try to eat 30 grams of nuts a day. I wonder how many nuts that is.",color:MyColor.red1,fontSize:16.0),

            hsized20,
            UiUtils.buildFunFact(title:"Fun Fact", fact: "Brazil nut trees grow up to 200 feet high deep in South America’s Amazon Forest. Their giant branches and flowers provide habitat and food for lots of forest creatures. One tree can produce more than 115 kilos (or 250 pounds) of nuts a year."),
            hsized20,
            UiUtils.buildBoldText("NUTS and More Nuts!",fontSize:25.0,color:MyColor.copperRed),
            hsized20,
            Image.asset(AssetsPath.nutsChapter4Img,height:450,),
            hsized100
          
          ],
        ),
      ),
    );
  }
}
