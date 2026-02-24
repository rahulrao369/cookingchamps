import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/new_ui/let_create_your_kid.dart';
import 'package:cooking_champs/new_ui/membership_new.dart';
import 'package:cooking_champs/utils/common_widget.dart';
import 'package:cooking_champs/utils/navigators.dart';
import 'package:cooking_champs/views/dashboard.dart';
import 'package:flutter/material.dart';

class KidProfileNew extends StatefulWidget {
  const KidProfileNew({super.key});

  @override
  State<KidProfileNew> createState() => _KidProfileNewState();
}

class _KidProfileNewState extends State<KidProfileNew> {
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
        useSafeArea: false,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AssetsPath.kidsProfileBg,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 15,
            right: 15,
            child: SafeArea(
              child: Column(
                children: [
                  commonButton(
                    text: "Create Profile",
                    onTap: () {
                      CustomNavigators.pushNavigate(
                        LetCreateYourKid(check: false),
                        context,
                      );
                    },
                    backgroundColor: MyColor.color48335CB2,
                    textColor: MyColor.white,
                  ),
                  hsized15,
                  GestureDetector(
                    onTap: () {
                      CustomNavigators.pushNavigate(
                          DashBoardView(pageIndex: 0), context);
                    },
                    child: Text(
                      "Do This Later",
                      style: mediumTextStyle(
                          fontSize: 16.0, color: MyColor.appTheme),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),


    );
  }
}
