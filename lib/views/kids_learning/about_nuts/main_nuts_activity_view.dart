import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/views/kids_learning/about_nuts/nuts_activity1_view.dart';
import 'package:cooking_champs/views/kids_learning/about_nuts/nuts_activity2_view.dart';
import 'package:cooking_champs/views/kids_learning/common_activity_widget.dart';
import 'package:cooking_champs/views/kids_learning/go_to_page_number_view.dart';
import 'package:flutter/material.dart';

class MainNutsActivityView extends StatelessWidget {
  const MainNutsActivityView({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonPageView(
      pages: [
        const NutsActivity1View(),
        NutsActivity2View(),
        GoToPageNumberView(text:"Go to page 204 to colour in your Nuts over Nuts illustration", color:MyColor.copperRed, appBarTitle:"Activity 9.3",textColor:MyColor.copperRed,),
      ],
      initialIndex: 0,
      bottomNavColor: Colors.white, isBottom: false,
    );
  }
}


