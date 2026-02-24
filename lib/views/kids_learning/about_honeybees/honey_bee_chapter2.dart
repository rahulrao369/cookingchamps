import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import '../../../constant/assets_path.dart';

class HoneyViewChapter2 extends StatelessWidget {
  const HoneyViewChapter2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UiUtils.buildBoldText("Honey",
                fontSize: 20.0, color: MyColor.neonColor),
            hsized5,
            UiUtils.buildBoldText(
                "We love the healthy sweetness of honey but where does it come from?",
                fontSize: 16.0,
                color: MyColor.black),
            hsized25,
            UiUtils.buildParagraph("Honey is all natural and", " honeybees",
                " make it Honeybees are",
                highlightFontSize: 16.0,
                regularFontSize: 16,
                highlight1: " insects.\n",
                prefix1: "They make their honey in a",
                highlight2: " beehive"),
            hsized20,
            UiUtils.buildFunFact(
                title: 'Fun Fact',
                fact:
                    'There are as many as 20,000 to 60,000 honeybees in a hive! Wow!'),
            hsized20,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                columnData(
                    text: "A natural beehive.",
                    image: AssetsPath.honeyBeeChapter2Image2),
                const SizedBox(width: 16),
                columnData(
                    text: "A man made beehive",
                    image: AssetsPath.honeyBeeChapter2Image1)
              ],
            ),
            hsized18,
            UiUtils.buildMediumText(
                "There are three types of honeybees in a beehive:",
                color: MyColor.pink),
            UiUtils.buildBulletPoints([
              "One Queen bee",
              "Workers (female bees) and",
              "Drones (male bees)"
            ]),
            hsized25,
            UiUtils.buildJokeSection(
                "Q. What do you call a bee born in May?", "A. A maybe! He! He!"),

            hsized100
          ],
        ),
      ),
    );
  }

  columnData({required image, required text}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 108,
          ),
          hsized7,
          UiUtils.buildBoldText(text, fontSize: 16.0, color: MyColor.neonColor),
        ],
      ),
    );
  }
}
