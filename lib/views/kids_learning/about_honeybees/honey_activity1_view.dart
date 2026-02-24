import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:flutter/material.dart';

class HoneyActivity1View extends StatelessWidget {
  const HoneyActivity1View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [

            hsized45,
            Padding(
              padding: const EdgeInsets.only(bottom:20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  UiUtils.hygieneAppBar(()=> Navigator.pop(context),text: "Activity 8.1",color:MyColor.black),

                  UiUtils.bookReadGirl(MyColor.neonColor,AssetsPath.readBookBoy, true)
                ],
              ),
            ),


            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    UiUtils.buildBoldText("In your exercise book draw your own cave painting of bees making honey.",
                        color: MyColor.neonColor, fontSize: 20.0),

                    hsized20,
                    Image.asset(AssetsPath.honeyActivity1Img),
                    hsized10,
                    UiUtils.buildNormalText("Cave paintings in Valencia Spain showing honey hunting from 8,000 years ago! WOW!"),
                    hsized100

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildParagraph( String highlight,String prefix,String highlight1, String suffix) {
    return RichText(
      text: TextSpan(
        style: regularTextStyle(fontSize:16.0,color:MyColor.black),
        children: [
          TextSpan(text: highlight,style:boldTextStyle(fontSize:16.0, color:MyColor.blue)),
          TextSpan(text: prefix),
          TextSpan(
              text: highlight1,
              style: boldTextStyle(fontSize:16.0, color:MyColor.brownColor)),
          TextSpan(text: suffix),
        ],
      ),
    );
  }
}
