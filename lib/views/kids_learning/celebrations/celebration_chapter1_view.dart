import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/constant/stringfile.dart/language.dart';
import 'package:cooking_champs/model/static_model/glossary_model.dart';
import 'package:cooking_champs/model/static_model/quiz_question_model.dart';
import 'package:cooking_champs/utils/navigators.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:cooking_champs/views/kids_learning/celebrations/main_celebration_activity.dart';
import 'package:cooking_champs/views/kids_learning/glossary_view.dart';
import 'package:cooking_champs/views/kids_learning/quiz_view.dart';
import 'package:flutter/material.dart';

List<String> skillList = [];

class CelebrationChapter1View extends StatefulWidget {
  const CelebrationChapter1View({super.key});

  @override
  State<CelebrationChapter1View> createState() => _CelebrationChapter1ViewState();
}

class _CelebrationChapter1ViewState extends State<CelebrationChapter1View> {
  addSkills() {
    setState(() {
      skillList = [
        Languages.of(context)!.activities,
        Languages.of(context)!.superQuiz
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    addSkills();
    final size = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: MyColor.purpleNavy,
      body: Column(
        children: [

          hsized20,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Image.asset(AssetsPath.celebrationChapter1View),
          ),

          hsized20,
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
                    UiUtils.buildMediumText("Celebrations around the world",fontSize: 17.0, color: MyColor.white),
                    hsized5,
                    UiUtils.buildMediumText("Review - My Cooking Champs’ Year",fontSize: 17.0, color: MyColor.white),
                    hsized5,
                    UiUtils.buildMediumText("Party Time",fontSize: 17.0, color: MyColor.white),


                    hsized15,
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      alignment: Alignment.bottomLeft,
                      child: Wrap(
                        children: List.generate(skillList.length, (index) {
                          return InkWell(
                            onTap: () {
                              if (index == 0) {
                                CustomNavigators.pushNavigate(const MainCelebrationActivityView(), context);
                              }else if (index == 1) {
                                CustomNavigators.pushNavigate( QuizPage(quizQuestions:celebrationQuizQuestions, bgColor: MyColor.purpleNavy, btnColor: MyColor.white, btnTextColor: MyColor.purpleNavy, chapter: '10',), context);
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
        style: mediumTextStyle(fontSize: 14.0, color: MyColor.purpleNavy),
      ),
    );
  }
}
