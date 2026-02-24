import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/views/kids_learning/about_honeybees/honey_activity1_view.dart';
import 'package:cooking_champs/views/kids_learning/common_activity_widget.dart';
import 'package:cooking_champs/views/kids_learning/go_to_page_number_view.dart';
import 'package:flutter/material.dart';

class MainHoneyActivityView extends StatelessWidget {
  const MainHoneyActivityView({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonPageView(
      pages: [
        const HoneyActivity1View(),
        GoToPageNumberView(text:"Go to page 203 to Colour in your honeybees illustration.", color:MyColor.neonColor, appBarTitle:"Activity 8.2",textColor:MyColor.neonColor,),
        ],
      initialIndex: 0,
      bottomNavColor: Colors.white, isBottom: false,
    );
  }
}

