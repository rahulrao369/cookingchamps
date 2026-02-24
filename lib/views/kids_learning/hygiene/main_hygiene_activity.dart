import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/views/kids_learning/common_activity_widget.dart';
import 'package:cooking_champs/views/kids_learning/go_to_page_number_view.dart';
import 'package:cooking_champs/views/kids_learning/hygiene/hygiene_activity1_view.dart';
import 'package:cooking_champs/views/kids_learning/hygiene/hygiene_activity3_view.dart';
import 'package:cooking_champs/views/kids_learning/hygiene/hygiene_activity4_view.dart';
import 'package:cooking_champs/views/kids_learning/hygiene/hygiene_activity5_view.dart';
import 'package:flutter/material.dart';

class MainHygieneActivityView extends StatelessWidget {
  const MainHygieneActivityView({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonPageView(
      pages: [
        const HygieneActivity1(),
        GoToPageNumberView(text:"Go to page number 199 & Color in the illustration", color:MyColor.darkYellow, appBarTitle:"Activity 3.2"),
        HygieneActivity3View(),
        HygieneActivity4(),
        HygieneActivity5View(),
        GoToPageNumberView(text: "Go to page number 200-201 & Color in the illustration", color:MyColor.darkYellow, appBarTitle:"Activity 3.6")
      ],
      initialIndex: 0,
      bottomNavColor: Colors.white, isBottom: false,
    );
  }
}