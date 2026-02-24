import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/stringfile.dart/language.dart';
import 'package:cooking_champs/model/static_model/glossary_model.dart';
import 'package:cooking_champs/views/kids_learning/glossary_view.dart';
import 'package:flutter/material.dart';

List<String> skillList = [];

class SenseChapter1View extends StatefulWidget {
  const SenseChapter1View({super.key});

  @override
  State<SenseChapter1View> createState() => _SenseChapter1ViewState();
}

class _SenseChapter1ViewState extends State<SenseChapter1View> {
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
      backgroundColor: MyColor.red1,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Image.asset(AssetsPath.senseChapter1Img),
          ),

          // Expanded(
          //   child: Container(
          //     margin: EdgeInsets.only(top:size.size.height * 0.01,left: 20,right: 20),
          //     child: SingleChildScrollView(
          //
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         mainAxisSize: MainAxisSize.min,
          //         children: [
          //           Text(Languages.of(context)!.whatInside,style:semiBoldTextStyle(fontSize:20.0, color:MyColor.white),),
          //           hsized8,
          //           Text("What’s inside",style:semiBoldTextStyle(fontSize:17.0, color:MyColor.white),),
          //           hsized8,
          //           Text("Our Senses",style:semiBoldTextStyle(fontSize:17.0, color:MyColor.white),),
          //           hsized15,
          //
          //           Container(
          //             margin: EdgeInsets.only(bottom: 20),
          //             alignment: Alignment.bottomLeft,
          //             child: Wrap(
          //               children: List.generate(skillList.length, (index) {
          //                 return InkWell(
          //                   onTap: () {
          //                     if (index == 0) {
          //                       CustomNavigators.pushNavigate(MainSenseActivityView(), context);
          //                     }
          //                     else if(index == 1){
          //                       basilPestoData();
          //                       CustomNavigators.pushNavigate(KidsRecipeView(recipeName:"Basil Pesto", recipe: recipeModel, appBarTitle:"5.1",color:MyColor.red1,), context);
          //                     }
          //                     else if(index == 2){
          //                       addGlossaryList();
          //                       CustomNavigators.pushNavigate(GlossaryView(), context);
          //                     }
          //                     else if(index ==3){
          //                       CustomNavigators.pushNavigate(QuizPage(quizQuestions: senseQuizQuestions,bgColor:MyColor.red1,btnColor: MyColor.white,btnTextColor: MyColor.red1, chapter: '5',), context);
          //                     }
          //                   },
          //                   child: btnUI(skillList[index], index),
          //                 );
          //               }),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  addGlossaryList() {
    setState(() {
      glossaryList = [
        GlossaryModel("Senses:",
            "People have five senses, the sense of sight, hearing, touch, smell, and taste. Senses work together to help us understand our world."),
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
        style: mediumTextStyle(fontSize: 14.0, color: MyColor.red1),
      ),
    );
  }
}
