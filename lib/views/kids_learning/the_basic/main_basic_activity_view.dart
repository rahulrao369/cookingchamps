import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/views/kids_learning/go_to_page_number_view.dart';
import 'package:cooking_champs/views/kids_learning/the_basic/basic_activity1_view.dart';
import 'package:cooking_champs/views/kids_learning/the_basic/basic_activity3_view.dart';
import 'package:cooking_champs/views/kids_learning/the_basic/basic_activity4_view.dart';
import 'package:flutter/material.dart';
import 'package:cooking_champs/views/kids_learning/common_activity_widget.dart';

class MainBasicActivityView extends StatelessWidget {
  const MainBasicActivityView({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonPageView(
      pages: [
        const BasicActivity1View(),
        GoToPageNumberView(text: "Draw the tools you need for your favorite recipe.", color: MyColor.appTheme, appBarTitle: "Activity 4.2",textColor:MyColor.appTheme,),
        const BasicActivity3View(),
        const BasicActivity4View(),
      ],
      initialIndex: 0,
      bottomNavColor: Colors.white, isBottom: false,
    );
  }
}