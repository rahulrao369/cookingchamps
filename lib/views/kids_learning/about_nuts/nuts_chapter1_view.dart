import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/constant/stringfile.dart/language.dart';
import 'package:cooking_champs/model/static_model/glossary_model.dart';
import 'package:cooking_champs/model/static_model/quiz_question_model.dart';
import 'package:cooking_champs/utils/navigators.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:cooking_champs/views/kids_learning/about_nuts/main_nuts_activity_view.dart';
import 'package:cooking_champs/views/kids_learning/Kids_recipe_main_view.dart';
import 'package:cooking_champs/views/kids_learning/glossary_view.dart';
import 'package:cooking_champs/views/kids_learning/kids_recipe_view.dart';
import 'package:cooking_champs/views/kids_learning/quiz_view.dart';
import 'package:flutter/material.dart';

List<String> skillList = [];

class NutsChapter1View extends StatefulWidget {
  const NutsChapter1View({super.key});

  @override
  State<NutsChapter1View> createState() => _NutsChapter1ViewState();
}

class _NutsChapter1ViewState extends State<NutsChapter1View> {
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
      backgroundColor: MyColor.copperRed,
      body: Column(
        children: [


          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Image.asset(AssetsPath.nutsChapter1Img),
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
                    UiUtils.buildMediumText("What’s a Nut?",fontSize: 17.0, color: MyColor.white),
                    hsized5,
                    UiUtils.buildMediumText("Poem: Nuts over nuts ",fontSize: 17.0, color: MyColor.white),
                    hsized5,
                    UiUtils.buildMediumText("Nuts and more nuts",fontSize: 17.0, color: MyColor.white),


                    hsized15,
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      alignment: Alignment.bottomLeft,
                      child: Wrap(
                        children: List.generate(skillList.length, (index) {
                          return InkWell(
                            onTap: () {
                              if (index == 0) {
                                CustomNavigators.pushNavigate(const MainNutsActivityView(), context);
                              } else if (index == 1) {
                                List<KidsRecipeModel> list = [
                                  KidsRecipeModel("Nut balls","9.1",MyColor.copperRed,nutBallsData()),
                                  KidsRecipeModel("Walnut Coriande","9.2",MyColor.copperRed, walnutCorianderDipData()),
                                ];
                                CustomNavigators.pushNavigate(KidsRecipeMainView(recipeList: list,chapter: "9",), context);

                              } else if (index == 2) {
                                addGlossaryList();
                                CustomNavigators.pushNavigate(const GlossaryView(), context);
                              } else if (index == 3) {
                                CustomNavigators.pushNavigate( QuizPage( quizQuestions:nutsQuizQuestions,bgColor: MyColor.copperRed, btnColor: MyColor.white, btnTextColor: MyColor.copperRed, chapter: '9',), context);
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
        GlossaryModel("Habitat", "the home where an animal or a plant normally lives"),
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
        style: mediumTextStyle(fontSize: 14.0, color: MyColor.copperRed),
      ),
    );
  }
}
