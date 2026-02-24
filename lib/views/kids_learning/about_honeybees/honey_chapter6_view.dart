import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:flutter/material.dart';

class HoneyChapter6View extends StatelessWidget {
  const HoneyChapter6View({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal:20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UiUtils.buildBoldText("Magic of turning nectar into honey",color: MyColor.neonColor,fontSize:20.0),

            hsized10,
            UiUtils.buildNormalText("After the honeybees collect the nectar they store it in their tummies and that’s where the nectar changes and becomes honey.",fontSize:16.0),

            hsized15,
            UiUtils.buildNormalText("When they return to the beehive the honeybees regurgitate the honey into the beeswax comb that they also make.",fontSize:16.0),

            hsized15,
            UiUtils.buildNormalText("Finally, they flap their wings to fan the honey to dry away the water and we are left with the wonderful thick honey.",fontSize:16.0),

            hsized15,
            UiUtils.buildNormalText("When the honey comb is full they cap it with beeswax.",fontSize:16.0),

           hsized15,
            UiUtils.buildNormalText("During the winter the bees eat the honey they have made and stored.",fontSize:16.0),

            Image.asset(AssetsPath.honeyChapter6Img,height:230,),

            hsized10,
            UiUtils.buildFunFact(title:"Fun Fact", fact:"Sealed honey does not spoil, even after thousands of years! WOW! In 2003 in Georgia, archaeologists discovered honey vessels containing the world’s oldest honey! It was 5,500 years old! WOW!"),

            hsized100

          ],
        ),
      ),
    );
  }
}
