import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/constant/stringfile.dart/language.dart';
import 'package:cooking_champs/model/static_model/glossary_model.dart';
import 'package:cooking_champs/utils/navigators.dart';
import 'package:cooking_champs/views/kids_learning/Kids_recipe_main_view.dart';
import 'package:cooking_champs/views/kids_learning/about_honeybees/main_honey_activity.dart';
import 'package:cooking_champs/views/kids_learning/glossary_view.dart';
import 'package:cooking_champs/views/kids_learning/kids_recipe_view.dart';
import 'package:cooking_champs/views/kids_learning/quiz_view.dart';
import 'package:flutter/material.dart';

import '../../../model/static_model/quiz_question_model.dart';

List<String> skillList = [];

class HoneyBeeChapter1View extends StatefulWidget {
  const HoneyBeeChapter1View({super.key});

  @override
  State<HoneyBeeChapter1View> createState() => _HoneyBeeChapter1ViewState();
}

class _HoneyBeeChapter1ViewState extends State<HoneyBeeChapter1View> {
  addSkills() {
    setState(() {
      skillList = [
        Languages.of(context)!.activities,
        Languages.of(context)!.recipes,
        Languages.of(context)!.glossary,
        Languages.of(context)!.quizTime
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    addSkills();
    final size = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: MyColor.neonColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Image.asset(AssetsPath.honeyBeeChapter1),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                  top: size.size.height * 0.01, left: 20, right: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      Languages.of(context)!.whatInside,
                      style: semiBoldTextStyle(
                          fontSize: 20.0, color: MyColor.white),
                    ),
                    hsized5,
                    Text(
                      "Honey",
                      style:
                          mediumTextStyle(fontSize: 17.0, color: MyColor.white),
                    ),
                    Text(
                      "The Honeybee",
                      style:
                          mediumTextStyle(fontSize: 17.0, color: MyColor.white),
                    ),
                    Text(
                      "Poem: Busy bees",
                      style:
                          mediumTextStyle(fontSize: 17.0, color: MyColor.white),
                    ),
                    hsized15,
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      alignment: Alignment.bottomLeft,
                      child: Wrap(
                        children: List.generate(skillList.length, (index) {
                          return InkWell(
                            onTap: () {
                              if (index == 0) {
                                CustomNavigators.pushNavigate(const MainHoneyActivityView(), context);
                              } else if (index == 1) {
                                List<KidsRecipeModel> list = [
                                  KidsRecipeModel("Yummy honeyed baby carrots","8.1",MyColor.neonColor,yummyHoneyedBabyCarrotsData()),
                                  KidsRecipeModel("Honey chocolate chip","8.2",MyColor.neonColor, honeyChocolateChipWalnutCookiesData()),
                                  KidsRecipeModel("Yummy Honey ice","8.3",MyColor.neonColor, yummyHoneyIceCreamData()),
                                ];

                                CustomNavigators.pushNavigate(KidsRecipeMainView(recipeList: list,chapter: "8",), context);
                              } else if (index == 2) {
                                addGlossaryList();
                                CustomNavigators.pushNavigate(const GlossaryView(), context);
                              } else if (index == 3) {
                                CustomNavigators.pushNavigate( QuizPage(quizQuestions:beeHoneyQuizQuestions,bgColor: MyColor.neonColor, btnColor: MyColor.white, btnTextColor: MyColor.neonColor, chapter: '8',), context);
                              }
                            },
                            child: btnUI(skillList[index], index),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  addGlossaryList() {
    setState(() {
      glossaryList = [
        GlossaryModel("Pollen", "fine powder on stamen of flowers needed to produce new plants"),
        GlossaryModel("Pollinate", "to take pollen from one plant to another so new plants can grow"),
        GlossaryModel("Proboscis", "a long tube insects use for sucking and in mammals it is a long flexible nose, snout or trunk."),
        GlossaryModel("Nectar", "a sweet liquid made by plants and used by bees to make honey"),
      ];
    });
  }

  btnUI(String title, int index) {
    return Container(
      margin: const EdgeInsets.only(right: 15, top: 15),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      decoration: BoxDecoration(
          color: MyColor.white, borderRadius: BorderRadius.circular(60)),
      child: Text(
        title,
        style: mediumTextStyle(fontSize: 14.0, color: MyColor.neonColor),
      ),
    );
  }
}
