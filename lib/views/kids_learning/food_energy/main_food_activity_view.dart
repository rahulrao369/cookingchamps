import 'package:cooking_champs/views/kids_learning/common_activity_widget.dart';
import 'package:cooking_champs/views/kids_learning/food_energy/food_activity1_view.dart';
import 'package:cooking_champs/views/kids_learning/food_energy/food_activity2_view.dart';
import 'package:cooking_champs/views/kids_learning/food_energy/food_activity2a_view.dart';
import 'package:cooking_champs/views/kids_learning/food_energy/food_activity3_view.dart';
import 'package:flutter/material.dart';

class MainFoodActivityView extends StatelessWidget {
  const MainFoodActivityView({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonPageView(
      pages: const [
        FoodActivity1View(),
        FoodActivity2View(),
        FoodActivity2AView(),
        FoodActivity3View(isActivity:false,),
        FoodActivity3View(isActivity:true,),
      ],
      initialIndex: 0,
      bottomNavColor: Colors.white, isBottom: false,
    );
  }
}