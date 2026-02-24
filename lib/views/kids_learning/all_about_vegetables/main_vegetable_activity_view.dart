import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:cooking_champs/views/kids_learning/Kids_recipe_main_view.dart';
import 'package:cooking_champs/views/kids_learning/all_about_vegetables/vegetable_activity1_view.dart';
import 'package:cooking_champs/views/kids_learning/common_activity_widget.dart';
import 'package:cooking_champs/views/kids_learning/go_to_page_number_view.dart';
import 'package:cooking_champs/views/kids_learning/kids_recipe_view.dart';
import 'package:flutter/material.dart';
import 'vegetable_activity2_view.dart';

class MainVegetableActivityView extends StatelessWidget {
  const MainVegetableActivityView({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonPageView(
      pages: [
      const VegetableActivity1View(),
        const VegetableActivity2View(),
        GoToPageNumberView(text:"In your exercise book draw a plate of vegetables with all the colours of the rainbow", color:MyColor.darkSky, appBarTitle:"Activity 6.3",textColor:MyColor.darkSky),
        GoToPageNumberView(text:"Go to page 202 and colour in your own garden", color:MyColor.darkSky, appBarTitle:"Activity 6.4",textColor:MyColor.darkSky,),
      ],
      initialIndex: 0,
      bottomNavColor: Colors.white, isBottom: false,
    );
  }
}

