import 'package:cooking_champs/constant/sized_box.dart';
import 'package:flutter/material.dart';

import '../../../constant/assets_path.dart';
import '../../../constant/my_color.dart';
import '../../../utils/ui_utils.dart';

class HoneyBeeChapter3 extends StatefulWidget {
  const HoneyBeeChapter3({super.key});

  @override
  State<HoneyBeeChapter3> createState() => _HoneyBeeChapter3State();
}

class _HoneyBeeChapter3State extends State<HoneyBeeChapter3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 11),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UiUtils.buildBoldText("Honeybees’ Work",
                fontSize: 20.0, color: MyColor.neonColor),
            hsized10,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UiUtils.buildBoldText("Queen bee",
                          fontSize: 18.0, color: MyColor.pink),
                      UiUtils.buildRegularText(
                          "The Queen bee’s only job  is to lay the eggs. She lays between 2,000 and 2,500 eggs a day! The Queen bee can live up to six years. She is bigger than the other honeybees and is fed special food called Royal Jelly.",
                          fontSize: 16.0,
                          color: MyColor.black),
                    ],
                  ),
                ),
                Image.asset(
                  AssetsPath.honeyBeeChapter3QueenHoney,
                  height: 208,
                )
              ],
            ),
            hsized35,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  AssetsPath.honeyBeeChapter3WorkerHoney,
                  height: 208,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UiUtils.buildBoldText("Worker bees", fontSize: 18.0, color: MyColor.pink),
                      UiUtils.buildRegularText(
                          "Worker bees are the female honeybees and they do all the work! They are very busy collecting nectar from flowers their whole life. They live between 6 to 8 WEEKS! They suck nectar from flowers with their long tongue that is a bit like a straw, and it is called a proboscis. Only the female honeybees have a stinger and if they bite you they die straight away.",
                          fontSize: 16.0,
                          color: MyColor.black),
                    ],
                  ),
                ),
              ],
            ),
            hsized13,
            UiUtils.buildBoldText("Drones", fontSize: 18.0, color: MyColor.pink),
            UiUtils.buildRegularText(
                "Drones are male honeybees. Their job is to mate with the Queen bee. They don’t have a stinger and they don’t have a long proboscis like the workers they just hang around the bee hive and don’t do much else.",
                fontSize: 16.0,
                color: MyColor.black),

            hsized100
          ],
        ),
      ),
    );
  }
}
