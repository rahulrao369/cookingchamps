import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/constant/stringfile.dart/language.dart';
import 'package:cooking_champs/model/static_model/glossary_model.dart';
import 'package:cooking_champs/model/static_model/quiz_question_model.dart';
import 'package:cooking_champs/utils/navigators.dart';
import 'package:cooking_champs/views/kids_learning/Kids_recipe_main_view.dart';
import 'package:cooking_champs/views/kids_learning/about_fruit/fruit_activity1_view.dart';
import 'package:cooking_champs/views/kids_learning/glossary_view.dart';
import 'package:cooking_champs/views/kids_learning/kids_recipe_view.dart';
import 'package:cooking_champs/views/kids_learning/quiz_view.dart';
import 'package:flutter/material.dart';

List<String> skillList = [];

class FruitChapter1View extends StatefulWidget {
  const FruitChapter1View({super.key});

  @override
  State<FruitChapter1View> createState() => _FruitChapter1ViewState();
}

class _FruitChapter1ViewState extends State<FruitChapter1View> {
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
      backgroundColor: MyColor.darkPink,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Image.asset(AssetsPath.fruitChapter1Img),
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
                      "All about fruit",
                      style:
                          mediumTextStyle(fontSize: 17.0, color: MyColor.white),
                    ),
                    Text(
                      "My Fruit Alphabet",
                      style:
                          mediumTextStyle(fontSize: 17.0, color: MyColor.white),
                    ),
                    hsized15,
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      alignment: Alignment.bottomLeft,
                      child: Wrap(
                        children: List.generate(skillList.length, (index) {
                          return InkWell(
                            onTap: () {
                              if (index == 0) {
                                CustomNavigators.pushNavigate(
                                    FruitActivity1View(), context);
                              } else if (index == 1) {
                                List<KidsRecipeModel> recipeList = [
                                  KidsRecipeModel(
                                      "Fruit Kebabs",
                                      "7.1",
                                      MyColor.darkPink,
                                      fruitKebabsData()),
                                  KidsRecipeModel(
                                      "Fruit Icy Poles",
                                      "7.2",
                                      MyColor.darkPink,
                                      fruitIcyPolesData()),
                                  KidsRecipeModel(
                                      "Banana Palm tree",
                                      "7.3",
                                      MyColor.darkPink,
                                      fruitArtData()),
                                ];
                                CustomNavigators.pushNavigate(
                                    KidsRecipeMainView(
                                      recipeList: recipeList,
                                      chapter: "7",
                                    ),
                                    context);
                              } else if (index == 2) {
                                addGlossaryList();
                                CustomNavigators.pushNavigate(
                                    GlossaryView(), context);
                              } else if (index == 3) {
                                CustomNavigators.pushNavigate(
                                    QuizPage(
                                        quizQuestions:fruitQuizQuestions,
                                        bgColor: MyColor.darkPink,
                                        btnColor: MyColor.white,
                                        btnTextColor: MyColor.darkPink, chapter: '7',),
                                    context);
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
        GlossaryModel("Liquid", "not solid, like water"),
        GlossaryModel(
            "Agar Agar", "Tplant substance that turns liquids into jelly"),
      ];
    });
  }

  btnUI(String title, int index) {
    return Container(
      margin: EdgeInsets.only(right: 15, top: 15),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      decoration: BoxDecoration(
          color: MyColor.white, borderRadius: BorderRadius.circular(60)),
      child: Text(
        title,
        style: mediumTextStyle(fontSize: 14.0, color: MyColor.darkPink),
      ),
    );
  }
}
