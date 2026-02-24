import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:flutter/material.dart';

class VegetableActivity5View extends StatelessWidget {
  const VegetableActivity5View({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
          hsized45,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(padding: EdgeInsets.only(bottom:30),
                  child: UiUtils.hygieneAppBar(()=> Navigator.pop(context), text:"Activity 6.6",color:MyColor.black),),

                UiUtils.bookReadGirl(MyColor.darkSky,AssetsPath.readBookImg1, true)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
