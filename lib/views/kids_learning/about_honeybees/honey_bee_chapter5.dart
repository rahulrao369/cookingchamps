import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:cooking_champs/views/kids_learning/quiz_view.dart';
import 'package:flutter/material.dart';

import '../../../constant/assets_path.dart';

class HoneyBeeChapter5 extends StatefulWidget {
  const HoneyBeeChapter5({super.key});

  @override
  State<HoneyBeeChapter5> createState() => _HoneyBeeChapter5State();
}

class _HoneyBeeChapter5State extends State<HoneyBeeChapter5> {
  final EdgeInsets _defaultPadding =
      const EdgeInsets.only(left: 20, right: 20, top: 5);

  Widget _buildSongText(String text, {double fontSize = 15.0, Color? color}) {
    return UiUtils.buildBoldText(
      text,
      fontSize: fontSize,
      color: color ?? MyColor.pink,
      textAlign: TextAlign.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: MyColor.colorE5FFF0,
      body: Padding(
        padding: EdgeInsets.only(left: 40, right: 20, top: size.height * 0.1),
        child: SizedBox(
          height: size.height * 0.8,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: CustomPaint(
                  painter: ExactCurvePainter(),
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: size.height * 0.05, top: 10),
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 20, bottom: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _buildSongText("Busy Bees",
                              fontSize: 23.0, color: MyColor.green),
                          hsized8,
                          _buildSongText(
                              "In the Beehive, There’s a miracle taking place, While Queen Bee lays thousands of eggs at extraordinary pace."),
                          hsized10,
                          _buildSongText(
                              "Busy Bees, Like Basanti and Bess Fly back and forth from East to West."),
                          hsized13,
                          _buildSongText(
                              "With long proboscis, (That’s posh for nose) They suck up nectar, much like a hose."),
                          hsized10,
                          _buildSongText(
                              "Buzzing about, Spreading pollen from flower to flower, They’ll labour like this for hours and hours."),
                          hsized10,
                          _buildSongText(
                              "Back in the hive, Fanning it dry they’re looking ever so funny As they’re flapping their wings turning nectar to honey."),
                          hsized10,
                          _buildSongText(
                              "The drones they just watch on, Doing very little work, I think life for those boys is one big perk!"),
                          hsized10,
                          _buildSongText(
                              "It’s the busy girl bees Like Basanti and Bess, Bimbi and Bhoo, Who do all the work, no joking, it’s true!"),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Image.asset(
                  AssetsPath.bookReadImg,
                  height: 210,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
