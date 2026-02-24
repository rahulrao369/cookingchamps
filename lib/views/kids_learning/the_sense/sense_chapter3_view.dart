import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:flutter/material.dart';

class SenseChapter3View extends StatelessWidget {
  const SenseChapter3View({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal:20.0),
        child:Column(
          children: [
            UiUtils.buildBoldText("When we are in the kitchen it’s really important to use all of our senses.",color:MyColor.darkYellow,fontSize:20.0),
            hsized10,
            UiUtils.buildRegularText("Do you know how many senses we have?",color:MyColor.black,fontSize:18.0),
            hsized10,
            UiUtils.buildBoldText("There are 5 Senses and we must use them all in the kitchen!",color:MyColor.red1,fontSize:16.0),
            hsized30,
            Image.asset(AssetsPath.senseChapterImg)
          ],
        ),
      ),
    );
  }
}
