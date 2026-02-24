import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:cooking_champs/views/kids_learning/safety_kitchen_chapter/safty_kitchen_view.dart';
import 'package:flutter/material.dart';

class Chapter11View extends StatefulWidget {
  const Chapter11View({super.key});

  @override
  State<Chapter11View> createState() => _Chapter11ViewState();
}

class _Chapter11ViewState extends State<Chapter11View> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context);
    final  bool isIpad = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      backgroundColor: MyColor.white,
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top:60.0, left: 20, right:0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      radius: 80,
                      onTap: () {
                        setState(() {
                          currentIndex = 0;
                        });
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: isIpad ? 30.0:28,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Knife safety skills",
                      style:mediumTextStyle(fontSize: isIpad ?20.0 :18.0, color: MyColor.black),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:20,top:10),
                        child: Row(
                          children: [
                            Image.asset(AssetsPath.photoroom,height:100,width:100),
                            Expanded(child: Image.asset(AssetsPath.knifeSkill4Img,height:231,width:300)),
                          ],
                        ),
                      ),
                       hsized20,
                      Image.asset(AssetsPath.knifeSkill5Img,height: 240,),
                      hsized30,
                      Padding(
                        padding: const EdgeInsets.only(left:20.0),
                        child: Image.asset(AssetsPath.knifeSkill6Img),
                      ),

                      hsized80
                    ],
                  ),
                ),
              ),
            ],
          ),
          UiUtils.roundedPage()
        ],
      ),
    );
  }
}
