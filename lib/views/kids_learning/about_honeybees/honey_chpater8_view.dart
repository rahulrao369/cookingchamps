import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:flutter/material.dart';

class HoneyChapter8View extends StatelessWidget {
  const HoneyChapter8View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UiUtils.buildBoldText("What’s all the fuss about Honeybees?",
                      color: MyColor.neonColor, fontSize: 20.0),
                  hsized15,
                buildParagraph(
                  "Honeybees",
                        " are very important",
                    " to the life cycle of plants.",
                    " They are the best pollinators in the insect world!  While collecting their nectar they spread pollen from flower to flower.",

                ),
                  hsized20,
                  UiUtils.buildParagraph(
                      "It’s called ",
                      " pollination",
                      "  Pollination is how the flower on fruit and vegetable plants changes to fruit or vegetables.",
                      color: MyColor.pink),
                  hsized20,
                  UiUtils.buildNormalText("Without honeybees to pollinate our fruit trees and vegetable plants they would never bear fruit."),
                  hsized20,
                  UiUtils.buildNormalText("That is why Honeybees are very important and we must take extra care of them!"),
                ],
              ),
            ),
            hsized20,
            Image.asset(AssetsPath.honeyChapter8Img),
            hsized100
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
