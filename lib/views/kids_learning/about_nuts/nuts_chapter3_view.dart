import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:flutter/material.dart';

class NutsChapter3View extends StatelessWidget {
  const NutsChapter3View({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: MyColor.copperRed,
      body:SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal:20.0),
        child: Column(
          children: [
            hsized100,
            Image.asset(AssetsPath.nutsChapter3Img)
          ],
        ),
      ),
    );
  }
}
