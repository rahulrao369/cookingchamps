import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/views/kids_learning/go_to_page_number_view.dart';
import 'package:cooking_champs/views/kids_learning/the_basic/basic_activity1_view.dart';
import 'package:cooking_champs/views/kids_learning/the_basic/basic_activity3_view.dart';
import 'package:cooking_champs/views/kids_learning/the_basic/basic_activity4_view.dart';
import 'package:cooking_champs/views/kids_learning/the_sense/sense_activity1_view.dart';
import 'package:cooking_champs/views/kids_learning/the_sense/sense_activity2_view.dart';
import 'package:flutter/material.dart';
import 'package:cooking_champs/views/kids_learning/common_activity_widget.dart';

class MainSenseActivityView extends StatelessWidget {
  const MainSenseActivityView({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonPageView(
      pages: [
        const SenseActivity1View(),
         const SenseActivity2View(isTaste:false,),
         const SenseActivity2View(isTaste:true,),
      ],
      initialIndex: 0,
      bottomNavColor: Colors.white, isBottom: false,
    );
  }
}