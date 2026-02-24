import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:flutter/material.dart';

class CelebrationChapter9View extends StatelessWidget {
  const CelebrationChapter9View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  UiUtils.buildBoldText("Review - My Cooking Champs' Year",color:  MyColor.purpleNavy, fontSize:23.0),
                  hsized20,
                  Row(
                    children: [
                      SizedBox(width:80,),
                      Expanded(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildText("Over the year we have learnt about Safety in the kitchen...", MyColor.color47A7E0,),
                          hsized8,
                          _buildText("...why we have rules...", MyColor.pink),
                          hsized8,
                          _buildText("...and that food is energy.", MyColor.red1),
                          hsized8,
                          _buildText("We have learnt about hygiene and germs...", MyColor.appTheme,),
                        ],
                      ))
            
                    ],
                  ),
                  hsized10,
            
                  _buildText("...and the importance of keeping our hands clean!", MyColor.darkYellow),
                  hsized10,
                  _buildText("And our teeth strong. We have learnt about our five senses", MyColor.darkGreen,),
            
                  _buildText("And about Balance...", MyColor.grey),
                  _buildText("...and eating a rainbow.", MyColor.darkOrange),
                  hsized20,
                  _buildText("That eating 5 vegetables and 2 fruit a day is the basis of a balanced diet.", MyColor.color47A7E0),
                  hsized10,
                  _buildText("We have learnt about bees and the natural sweet treat that is honey.", MyColor.grey1),
                  hsized10,
            
            
                  Row(
                    children: [
                      SizedBox(width:80,),
                      Expanded(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildText("That a handful of nuts a day keeps us healthy and full of energy, and full of energy.", MyColor.darkPink),
                          hsized20,
                          _buildText("We have learnt that we should only eat a small amount of sugary fatty food occasionally,", MyColor.green),
                          hsized20,
                          _buildText("and we have travelled through kitchens around the world.", MyColor.copperRed),
                        ],
                      ))
            
                    ],
                  ),
            
            
                  hsized100,
                ],
              ),
            ),
            
            Align(
              alignment: Alignment.bottomCenter,
              child:Image.asset(AssetsPath.celebrationChapter9Img),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildText(String text, Color color, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: bold
          ? UiUtils.buildBoldText(text, color: color, fontSize: 18.0)
          : UiUtils.buildMediumText(text, color: color, fontSize: 18.0),
    );
  }
}
