import 'package:cooking_champs/views/kids_learning/celebrations/celebration_activity1_view.dart';
import 'package:cooking_champs/views/kids_learning/celebrations/celebration_activity2_view.dart';
import 'package:cooking_champs/views/kids_learning/celebrations/celebration_activity3_view.dart';
import 'package:cooking_champs/views/kids_learning/common_activity_widget.dart';
import 'package:flutter/material.dart';

class MainCelebrationActivityView extends StatelessWidget {
  const MainCelebrationActivityView({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonPageView(
      pages: [
        const CelebrationActivity1View(),
        CelebrationActivity2View(),
        CelebrationActivity3View(),
      ],
      initialIndex: 0,
      bottomNavColor: Colors.white, isBottom: false,
    );
  }
}



