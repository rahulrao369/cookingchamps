// import 'package:cooking_champs/constant/my_color.dart';
// import 'package:cooking_champs/constant/my_fonts_style.dart';
// import 'package:cooking_champs/constant/sized_box.dart';
// import 'package:cooking_champs/constant/stringfile.dart/language.dart';
// import 'package:cooking_champs/model/static_model/quiz_question_model.dart';
// import 'package:cooking_champs/utils/navigators.dart';
// import 'package:cooking_champs/utils/ui_utils.dart';
// import 'package:cooking_champs/views/kids_learning/safety_kitchen_chapter/chapter10_view.dart';
// import 'package:cooking_champs/views/kids_learning/safety_kitchen_chapter/chapter11_view.dart';
// import 'package:cooking_champs/views/kids_learning/safety_kitchen_chapter/safety_kitchen_glossary_view.dart';
// import 'package:cooking_champs/views/kids_learning/safety_kitchen_chapter/chapter1_view.dart';
// import 'package:cooking_champs/views/kids_learning/safety_kitchen_chapter/chapter2_view.dart';
// import 'package:cooking_champs/views/kids_learning/safety_kitchen_chapter/chapter3_view.dart';
// import 'package:cooking_champs/views/kids_learning/safety_kitchen_chapter/chapter4_view.dart';
// import 'package:cooking_champs/views/kids_learning/safety_kitchen_chapter/chapter5_view.dart';
// import 'package:cooking_champs/views/kids_learning/safety_kitchen_chapter/chapter6_view.dart';
// import 'package:cooking_champs/views/kids_learning/safety_kitchen_chapter/chapter7_view.dart';
// import 'package:cooking_champs/views/kids_learning/safety_kitchen_chapter/chapter8_view.dart';
// import 'package:cooking_champs/views/kids_learning/safety_kitchen_chapter/chapter9_view.dart';
// import 'package:cooking_champs/views/kids_learning/quiz_view.dart';
// import 'package:flutter/material.dart';
// import 'safety_kitchen_main_activity_view.dart';
//
// class SafetyKitchenView extends StatefulWidget {
//   const SafetyKitchenView({super.key});
//
//   @override
//   State<SafetyKitchenView> createState() => _SafetyKitchenViewState();
// }
//
// int currentIndex = 0;
// final PageController _pageController = PageController();
//
// class _SafetyKitchenViewState extends State<SafetyKitchenView> {
//   List<Widget> pageList = [
//     Chapter1View(),
//     Chapter2View(),
//     Chapter3View(),
//     Chapter4View(),
//     Chapter5View(),
//     Chapter6View(),
//     Chapter7View(),
//     Chapter8View(),
//     Chapter9View(),
//     Chapter10View(),
//     Chapter11View(),
//   ];
//
//   addSkills() {
//     setState(() {
//       skillList = [
//         Languages.of(context)!.activities,
//         Languages.of(context)!.glossary,
//         Languages.of(context)!.quiz
//       ];
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     addSkills();
//     final size = MediaQuery.of(context);
//
//     return Scaffold(
//       backgroundColor: MyColor.orange,
//       body: Stack(
//         children: [
//           PageView.builder(
//               itemCount: pageList.length,
//               controller: _pageController,
//               onPageChanged: onPageChanged,
//               itemBuilder: (context, int index) {
//                 currentIndex = index;
//                 return Container(child: pageList[currentIndex]);
//               }),
//           currentIndex == 0
//               ? Stack(
//                   children: [
//                     hsized10,
//                     Container(
//                       margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
//                       alignment: Alignment.bottomLeft,
//                       child: Visibility(
//                         visible: currentIndex == 0 ? true : false,
//                         child: Container(
//                           color: MyColor.orange,
//                           child: Wrap(
//                             children: List.generate(skillList.length, (index) {
//                               return InkWell(
//                                 onTap: () {
//                                   if (index == 0) {
//                                     CustomNavigators.pushNavigate(MainSafetyKitchenActivityView(), context);
//                                   }
//                                  else if (index == 1) {
//                                     CustomNavigators.pushNavigate(SafetyKitchenGlossaryView(), context);
//                                   }else if(index == 2){
//                                     CustomNavigators.pushNavigate(QuizPage(quizQuestions:safetyQuizQuestions ,bgColor:MyColor.orange, chapter: '1',), context);
//                                   }
//                                 },
//                                 child: btnUI(skillList[index], index),
//                               );
//                             }),
//                           ),
//                         ),
//                       ),
//                     ),
//                     UiUtils.roundedPage()
//                     // Image.asset(AssetsPath.cornerBg,height:120,width:120,),
//                   ],
//                 )
//               : SizedBox.shrink()
//         ],
//       ),
//       bottomNavigationBar: Container(
//         color: MyColor.white,
//         height: 50,
//         child: Container(
//           alignment: Alignment.center,
//           color: MyColor.white,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               for (int i = 0; i < pageList.length; i++)
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Wrap(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(5.0),
//                           child: Row(
//                             children: [
//                               SizedBox(
//                                 child: UiUtils.indicatorDotsWidget(
//                                     color: currentIndex == i
//                                         ? MyColor.appTheme
//                                         : currentIndex == 2
//                                             ? MyColor.blueLite1
//                                             : const Color.fromARGB(
//                                                 255, 219, 217, 217),
//                                     width: 10),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   btnUI(String title, int index) {
//     return Container(
//       margin: EdgeInsets.only(right: 18, top: 15),
//       padding: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
//       decoration: BoxDecoration(
//           color: MyColor.white, borderRadius: BorderRadius.circular(60)),
//       child: Text(
//         title,
//         style: mediumTextStyle(fontSize: 14.0, color: MyColor.black),
//       ),
//     );
//   }
//
//
//   void onPageChanged(int value) {
//     setState(() {
//       currentIndex = value;
//     });
//   }
//
//
// }


import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/constant/stringfile.dart/language.dart';
import 'package:cooking_champs/model/static_model/quiz_question_model.dart';
import 'package:cooking_champs/utils/navigators.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:cooking_champs/views/kids_learning/safety_kitchen_chapter/chapter10_view.dart';
import 'package:cooking_champs/views/kids_learning/safety_kitchen_chapter/chapter11_view.dart';
import 'package:cooking_champs/views/kids_learning/safety_kitchen_chapter/safety_kitchen_glossary_view.dart';
import 'package:cooking_champs/views/kids_learning/safety_kitchen_chapter/chapter1_view.dart';
import 'package:cooking_champs/views/kids_learning/safety_kitchen_chapter/chapter2_view.dart';
import 'package:cooking_champs/views/kids_learning/safety_kitchen_chapter/chapter3_view.dart';
import 'package:cooking_champs/views/kids_learning/safety_kitchen_chapter/chapter4_view.dart';
import 'package:cooking_champs/views/kids_learning/safety_kitchen_chapter/chapter5_view.dart';
import 'package:cooking_champs/views/kids_learning/safety_kitchen_chapter/chapter6_view.dart';
import 'package:cooking_champs/views/kids_learning/safety_kitchen_chapter/chapter7_view.dart';
import 'package:cooking_champs/views/kids_learning/safety_kitchen_chapter/chapter8_view.dart';
import 'package:cooking_champs/views/kids_learning/safety_kitchen_chapter/chapter9_view.dart';
import 'package:cooking_champs/views/kids_learning/quiz_view.dart';
import 'package:flutter/material.dart';
import 'safety_kitchen_main_activity_view.dart';

class SafetyKitchenView extends StatefulWidget {
  const SafetyKitchenView({super.key});

  @override
  State<SafetyKitchenView> createState() => _SafetyKitchenViewState();
}

int currentIndex = 0;
final PageController _pageController = PageController();

class _SafetyKitchenViewState extends State<SafetyKitchenView> {
  List<Widget> pageList = [
    Chapter1View(),
    Chapter2View(),
    Chapter3View(),
    Chapter4View(),
    Chapter5View(),
    Chapter6View(),
    Chapter7View(),
    Chapter8View(),
    Chapter9View(),
    Chapter10View(),
    Chapter11View(),
  ];

  addSkills() {
    setState(() {
      skillList = [
        Languages.of(context)!.activities,
        Languages.of(context)!.glossary,
        Languages.of(context)!.quiz
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    addSkills();
    final size = MediaQuery.of(context);
    // Check if device is iPad/tablet
    final bool isTablet = MediaQuery.of(context).size.shortestSide > 600;

    return Scaffold(
      backgroundColor: MyColor.orange,
      body: Stack(
        children: [
          PageView.builder(
              itemCount: pageList.length,
              controller: _pageController,
              onPageChanged: onPageChanged,
              itemBuilder: (context, int index) {
                currentIndex = index;
                return Container(child: pageList[currentIndex]);
              }),
          currentIndex == 0
              ? Stack(
            children: [
              hsized10,
              Container(
                margin: EdgeInsets.only(
                    bottom: isTablet ? 40 : 20,
                    left: isTablet ? 40 : 20,
                    right: isTablet ? 40 : 20
                ),
                alignment: Alignment.bottomLeft,
                child: Visibility(
                  visible: currentIndex == 0 ? true : false,
                  child: Container(
                    color: MyColor.orange,
                    child: Wrap(
                      children: List.generate(skillList.length, (index) {
                        return InkWell(
                          onTap: () {
                            if (index == 0) {
                              CustomNavigators.pushNavigate(MainSafetyKitchenActivityView(), context);
                            }
                            else if (index == 1) {
                              CustomNavigators.pushNavigate(SafetyKitchenGlossaryView(), context);
                            }else if(index == 2){
                              CustomNavigators.pushNavigate(QuizPage(quizQuestions:safetyQuizQuestions ,bgColor:MyColor.orange, chapter: '1',), context);
                            }
                          },
                          child: btnUI(skillList[index], index, isTablet),
                        );
                      }),
                    ),
                  ),
                ),
              ),
              UiUtils.roundedPage()
              // Image.asset(AssetsPath.cornerBg,height:120,width:120,),
            ],
          )
              : SizedBox.shrink()
        ],
      ),
      bottomNavigationBar: Container(
        color: MyColor.white,
        height: isTablet ? 70 : 50, // iPad ke liye thoda bada
        child: Container(
          alignment: Alignment.center,
          color: MyColor.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < pageList.length; i++)
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Wrap(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(isTablet ? 8.0 : 5.0),
                          child: Row(
                            children: [
                              SizedBox(
                                child: UiUtils.indicatorDotsWidget(
                                    color: currentIndex == i
                                        ? MyColor.appTheme
                                        : currentIndex == 2
                                        ? MyColor.blueLite1
                                        : const Color.fromARGB(
                                        255, 219, 217, 217),
                                    width: isTablet ? 14 : 10), // iPad ke liye bada
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  btnUI(String title, int index, bool isTablet) {
    return Container(
      margin: EdgeInsets.only(
          right: isTablet ? 25 : 18,
          top: isTablet ? 20 : 15
      ),
      padding: EdgeInsets.symmetric(
          horizontal: isTablet ? 45 : 35,
          vertical: isTablet ? 20 : 15
      ),
      decoration: BoxDecoration(
          color: MyColor.white,
          borderRadius: BorderRadius.circular(60)
      ),
      child: Text(
        title,
        style: mediumTextStyle(
            fontSize: isTablet ? 18.0 : 14.0, // iPad ke liye bada font
            color: MyColor.black
        ),
      ),
    );
  }


  void onPageChanged(int value) {
    setState(() {
      currentIndex = value;
    });
  }


}