import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/constant/stringfile.dart/language.dart';
import 'package:cooking_champs/model/static_model/glossary_model.dart';
import 'package:cooking_champs/model/static_model/quiz_question_model.dart';
import 'package:cooking_champs/utils/navigators.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:cooking_champs/views/kids_learning/glossary_view.dart';
import 'package:cooking_champs/views/kids_learning/hygiene/main_hygiene_activity.dart';
import 'package:cooking_champs/views/kids_learning/quiz_view.dart';
import 'package:flutter/material.dart';

List<String> skillList = [];
class HygieneChapter1View extends StatefulWidget {
  const HygieneChapter1View({super.key});

  @override
  State<HygieneChapter1View> createState() => _HygieneChapter1ViewState();
}

class _HygieneChapter1ViewState extends State<HygieneChapter1View> {


  addSkills() {
    setState(() {
      skillList = [
        Languages.of(context)!.activities,
        Languages.of(context)!.glossary,
        Languages.of(context)!.quizTime
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    addSkills();
    final size = MediaQuery.of(context);
    return  Scaffold(
      backgroundColor: MyColor.green,
      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.only(top:50.0,left:20,right: 20,bottom: 20),
            child:UiUtils.hygieneAppBar((){
              CustomNavigators.popNavigate(context);
             // CustomNavigators.pushRemoveUntil(KidsLearningView(type: "Hygiene"),context);
            }),
          ),


          Padding(
            padding: const EdgeInsets.symmetric(horizontal:20.0),
            child: Image.asset(
                AssetsPath.hygieneChapter1Img
            ),
          ),

          Expanded(
            child: Container(
              margin: EdgeInsets.only(top:size.size.height * 0.01,left: 20,right: 20),
              child: SingleChildScrollView(

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(Languages.of(context)!.whatInside,style:semiBoldTextStyle(fontSize:20.0, color:MyColor.white),),
                    hsized8,
                    Text("What is Hygiene?",style:semiBoldTextStyle(fontSize:17.0, color:MyColor.white),),
                    hsized8,
                    Text("What is Food Poisoning?",style:semiBoldTextStyle(fontSize:17.0, color:MyColor.white),),
                    hsized8,
                    Text("What is Food Poisoning?",style:semiBoldTextStyle(fontSize:17.0, color:MyColor.white),),
                    hsized8,
                    Text("Wash hands clean chart",style:semiBoldTextStyle(fontSize:17.0, color:MyColor.white),),

                    hsized8,
                    Text("Cooking Champs Hand Washing song",style:semiBoldTextStyle(fontSize:17.0, color:MyColor.white),),

                    hsized8,
                    Text("Cooking Champs Hand Washing song",style:semiBoldTextStyle(fontSize:17.0, color:MyColor.white),),

                    hsized15,
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      alignment: Alignment.bottomLeft,
                      child: Wrap(
                        children: List.generate(skillList.length, (index) {
                          return InkWell(
                            onTap: () {
                              if (index == 0) {
                                CustomNavigators.pushNavigate(MainHygieneActivityView(), context);
                              }
                             else if(index == 1){
                                addGlossaryList();
                                CustomNavigators.pushNavigate(GlossaryView(), context);
                              }else if(index ==2){
                                CustomNavigators.pushNavigate(QuizPage(quizQuestions:hygieneQuizQuestions, bgColor:MyColor.green, chapter: '3',), context);
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

  addGlossaryList(){
    setState(() {
      glossaryList = [
        GlossaryModel("Hygiene", "Keeping clean to stay healthy and prevent disease."),
        GlossaryModel("Germ", "A microscopic organism that causes illness. Bacteria and viruses that cause diseases are called germs."),
        GlossaryModel("Microscopic", "Something so small you can only see it through a microscope"),
        GlossaryModel("Poison", "A substance that can kill or seriously harm living things if it is swallowed, breathed, or taken in any way."),
        GlossaryModel("Poisonous", "Deadly, something that contains poison."),
      ];
    });
  }
  btnUI(String title,int index){
    return Container(
      margin: EdgeInsets.only(right:15,top:15 ),
      padding: EdgeInsets.symmetric(horizontal:30,vertical:15),
      decoration: BoxDecoration(
          color: MyColor.white,
          borderRadius: BorderRadius.circular(60)
      ),
      child: Text(title,style: mediumTextStyle(fontSize:14.0, color:MyColor.green),),
    );
  }

}
