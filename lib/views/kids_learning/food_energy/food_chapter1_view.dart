// import 'package:cooking_champs/constant/assets_path.dart';
// import 'package:cooking_champs/constant/my_color.dart';
// import 'package:cooking_champs/constant/my_fonts_style.dart';
// import 'package:cooking_champs/constant/sized_box.dart';
// import 'package:cooking_champs/constant/stringfile.dart/language.dart';
// import 'package:cooking_champs/model/static_model/glossary_model.dart';
// import 'package:cooking_champs/model/static_model/quiz_question_model.dart';
// import 'package:cooking_champs/utils/navigators.dart';
// import 'package:cooking_champs/views/kids_learning/Kids_recipe_main_view.dart';
// import 'package:cooking_champs/views/kids_learning/food_energy/main_food_activity_view.dart';
// import 'package:cooking_champs/views/kids_learning/glossary_view.dart';
// import 'package:cooking_champs/views/kids_learning/kids_recipe_view.dart';
// import 'package:cooking_champs/views/kids_learning/quiz_view.dart';
// import 'package:cooking_champs/views/kids_learning/safety_kitchen_chapter/safty_kitchen_view.dart';
// import 'package:flutter/material.dart';
//
// List<String> skillList = [];
// class FoodEnergyChapter1View extends StatefulWidget {
//   const FoodEnergyChapter1View({super.key});
//
//   @override
//   State<FoodEnergyChapter1View> createState() => _FoodEnergyChapter1ViewState();
// }
//
// class _FoodEnergyChapter1ViewState extends State<FoodEnergyChapter1View> {
//
//
//   addSkills() {
//     setState(() {
//       skillList = [
//         Languages.of(context)!.activities,
//         Languages.of(context)!.recipes,
//         Languages.of(context)!.glossary,
//         Languages.of(context)!.quizTime
//       ];
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     addSkills();
//     final size = MediaQuery.of(context);
//     return  Scaffold(
//       backgroundColor: MyColor.pink,
//       body: Column(
//         children: [
//
//           Padding(
//             padding: const EdgeInsets.only(top:50.0,left:20,right: 20,bottom: 20),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 InkWell(
//                   radius: 80,
//                   onTap: (){
//                     setState(() {
//                       currentIndex = 0;
//                     });
//                     Navigator.pop(context);
//                   },
//                   child: Icon(Icons.arrow_back_ios,size:28,),
//                 ),
//                 SizedBox(width:10),
//                 Text("Food is energy",style:mediumTextStyle(fontSize:18.0, color:MyColor.black),),
//               ],
//             ),
//           ),
//
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal:20.0),
//             child: Image.asset(
//                 AssetsPath.foodEnergyImg1
//             ),
//           ),
//
//           Expanded(
//             child: Container(
//               margin: EdgeInsets.only(top:size.size.height * 0.01,left: 20,right: 20),
//               child: SingleChildScrollView(
//
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(Languages.of(context)!.whatInside,style:semiBoldTextStyle(fontSize:20.0, color:MyColor.white),),
//                     hsized8,
//                     Text("The trail mix story",style:semiBoldTextStyle(fontSize:17.0, color:MyColor.white),),
//                     hsized8,
//                     Text("Digestion",style:semiBoldTextStyle(fontSize:17.0, color:MyColor.white),),
//                     hsized8,
//                     Text("Rhyming Rules to stop decay",style:semiBoldTextStyle(fontSize:17.0, color:MyColor.white),),
//                     hsized8,
//                     Text("A healthy diet: eat a rainbow",style:semiBoldTextStyle(fontSize:17.0, color:MyColor.white),),
//
//                     hsized15,
//                     Container(
//                       margin: EdgeInsets.only(bottom: 20),
//                       alignment: Alignment.bottomLeft,
//                       child: Wrap(
//                         children: List.generate(skillList.length, (index) {
//                           return InkWell(
//                             onTap: () {
//                               if (index == 0) {
//                                 CustomNavigators.pushNavigate(MainFoodActivityView(), context);
//                               }
//                               else if (index == 1) {
//                                 List<KidsRecipeModel> list = [
//                                   KidsRecipeModel("Trail Mix","2.1",MyColor.green,trailMix()),
//                                   KidsRecipeModel("Smoothie","2.2",MyColor.green, smoothieList()),
//                                   KidsRecipeModel("Rainbow Soup","2.3",MyColor.green, rainbowSoup()),
//                                 ];
//
//                                 CustomNavigators.pushNavigate(KidsRecipeMainView(recipeList: list,chapter: "2",), context);
//                               }else if(index == 2){
//                                 addGlossaryList();
//                                 CustomNavigators.pushNavigate(GlossaryView(), context);
//                               }else if(index ==3){
//                                 CustomNavigators.pushNavigate(QuizPage(quizQuestions:foodQuizQuestions, bgColor:MyColor.pink, chapter: '2',), context);
//                               }
//                             },
//                             child: btnUI(skillList[index], index),
//                           );
//                         }),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//
//         ],
//       ),
//     );
//   }
//
//   addGlossaryList(){
//     setState(() {
//       glossaryList = [
//         GlossaryModel("Balanced diet", "The right amount of a variety of food and water. Gives you energy and keeps you healthy."),
//         GlossaryModel("Digest", "When your body changes food into energy."),
//         GlossaryModel("Digestive system", "All the parts of the body that work together to change food to energy."),
//         GlossaryModel("Energy", "Is the power we need to live. Our body needs energy to work. Other types of energy include electrical energy and mechanical energy."),
//         GlossaryModel("Experiment", "Is an activity people do to learn about the world around us."),
//         GlossaryModel("Healthy", "When you are healthy you feel strong and good and are not sick."),
//         GlossaryModel("Hypothesis", "A guess you make about what is going to happen in an experiment before you have done it."),
//         GlossaryModel("Nutrients", "Something in food that helps people, animals, and plants live and grow. If you don’t get enough nutrients, you may feel tired and become sick."),
//         GlossaryModel("Stomach", "The stomach is where food is churned up and changed to energy."),
//         GlossaryModel("Rainbow", "An arc of colours that appears when sunlight passes through bits of water in the air."),
//         GlossaryModel("Variety", "Different types, assortment."),
//       ];
//     });
//   }
//
//
//
//   btnUI(String title,int index){
//     return Container(
//       margin: EdgeInsets.only(right:15,top:15 ),
//       padding: EdgeInsets.symmetric(horizontal:30,vertical:15),
//       decoration: BoxDecoration(
//           color: MyColor.white,
//           borderRadius: BorderRadius.circular(60)
//       ),
//       child: Text(title,style: mediumTextStyle(fontSize:14.0, color:MyColor.pink),),
//     );
//   }
//
// }

import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/constant/stringfile.dart/language.dart';
import 'package:cooking_champs/model/static_model/glossary_model.dart';
import 'package:cooking_champs/model/static_model/quiz_question_model.dart';
import 'package:cooking_champs/utils/navigators.dart';
import 'package:cooking_champs/views/kids_learning/Kids_recipe_main_view.dart';
import 'package:cooking_champs/views/kids_learning/food_energy/main_food_activity_view.dart';
import 'package:cooking_champs/views/kids_learning/glossary_view.dart';
import 'package:cooking_champs/views/kids_learning/kids_recipe_view.dart';
import 'package:cooking_champs/views/kids_learning/quiz_view.dart';
import 'package:cooking_champs/views/kids_learning/safety_kitchen_chapter/safty_kitchen_view.dart';
import 'package:flutter/material.dart';

List<String> skillList = [];
class FoodEnergyChapter1View extends StatefulWidget {
  const FoodEnergyChapter1View({super.key});

  @override
  State<FoodEnergyChapter1View> createState() => _FoodEnergyChapter1ViewState();
}

class _FoodEnergyChapter1ViewState extends State<FoodEnergyChapter1View> {


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
    // Check if device is iPad/tablet
    final bool isTablet = MediaQuery.of(context).size.shortestSide > 600;

    return Scaffold(
      backgroundColor: MyColor.pink,
      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.only(top:50.0, left:20, right: 20, bottom: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  radius: 80,
                  onTap: (){
                    setState(() {
                      currentIndex = 0;
                    });
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: isTablet ? 32 : 28, // iPad ke liye thoda bada
                  ),
                ),
                SizedBox(width:10),
                Text(
                  "Food is energy",
                  style: mediumTextStyle(
                      fontSize: isTablet ? 21.0 : 18.0, // iPad ke liye thoda bada
                      color: MyColor.black
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal:20.0),
            child: Image.asset(AssetsPath.foodEnergyImg1),
          ),

          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                  top: size.size.height * 0.01,
                  left: 20,
                  right: 20
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      Languages.of(context)!.whatInside,
                      style: semiBoldTextStyle(
                          fontSize: isTablet ? 23.0 : 20.0, // iPad ke liye thoda bada
                          color: MyColor.white
                      ),
                    ),
                    SizedBox(height: isTablet ? 10 : 8), // iPad ke liye spacing
                    Text(
                      "The trail mix story",
                      style: semiBoldTextStyle(
                          fontSize: isTablet ? 19.0 : 17.0, // iPad ke liye thoda bada
                          color: MyColor.white
                      ),
                    ),
                    SizedBox(height: isTablet ? 10 : 8), // iPad ke liye spacing
                    Text(
                      "Digestion",
                      style: semiBoldTextStyle(
                          fontSize: isTablet ? 19.0 : 17.0, // iPad ke liye thoda bada
                          color: MyColor.white
                      ),
                    ),
                    SizedBox(height: isTablet ? 10 : 8), // iPad ke liye spacing
                    Text(
                      "Rhyming Rules to stop decay",
                      style: semiBoldTextStyle(
                          fontSize: isTablet ? 19.0 : 17.0, // iPad ke liye thoda bada
                          color: MyColor.white
                      ),
                    ),
                    SizedBox(height: isTablet ? 10 : 8), // iPad ke liye spacing
                    Text(
                      "A healthy diet: eat a rainbow",
                      style: semiBoldTextStyle(
                          fontSize: isTablet ? 19.0 : 17.0, // iPad ke liye thoda bada
                          color: MyColor.white
                      ),
                    ),

                    SizedBox(height: isTablet ? 20 : 15), // iPad ke liye spacing
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      alignment: Alignment.bottomLeft,
                      child: Wrap(
                        children: List.generate(skillList.length, (index) {
                          return InkWell(
                            onTap: () {
                              if (index == 0) {
                                CustomNavigators.pushNavigate(MainFoodActivityView(), context);
                              }
                              else if (index == 1) {
                                List<KidsRecipeModel> list = [
                                  KidsRecipeModel("Trail Mix","2.1",MyColor.green,trailMix()),
                                  KidsRecipeModel("Smoothie","2.2",MyColor.green, smoothieList()),
                                  KidsRecipeModel("Rainbow Soup","2.3",MyColor.green, rainbowSoup()),
                                ];

                                CustomNavigators.pushNavigate(KidsRecipeMainView(recipeList: list,chapter: "2",), context);
                              }else if(index == 2){
                                addGlossaryList();
                                CustomNavigators.pushNavigate(GlossaryView(), context);
                              }else if(index ==3){
                                CustomNavigators.pushNavigate(QuizPage(quizQuestions:foodQuizQuestions, bgColor:MyColor.pink, chapter: '2',), context);
                              }
                            },
                            child: btnUI(skillList[index], index, isTablet),
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
        GlossaryModel("Balanced diet", "The right amount of a variety of food and water. Gives you energy and keeps you healthy."),
        GlossaryModel("Digest", "When your body changes food into energy."),
        GlossaryModel("Digestive system", "All the parts of the body that work together to change food to energy."),
        GlossaryModel("Energy", "Is the power we need to live. Our body needs energy to work. Other types of energy include electrical energy and mechanical energy."),
        GlossaryModel("Experiment", "Is an activity people do to learn about the world around us."),
        GlossaryModel("Healthy", "When you are healthy you feel strong and good and are not sick."),
        GlossaryModel("Hypothesis", "A guess you make about what is going to happen in an experiment before you have done it."),
        GlossaryModel("Nutrients", "Something in food that helps people, animals, and plants live and grow. If you don't get enough nutrients, you may feel tired and become sick."),
        GlossaryModel("Stomach", "The stomach is where food is churned up and changed to energy."),
        GlossaryModel("Rainbow", "An arc of colours that appears when sunlight passes through bits of water in the air."),
        GlossaryModel("Variety", "Different types, assortment."),
      ];
    });
  }



  btnUI(String title, int index, bool isTablet){
    return Container(
      margin: EdgeInsets.only(
        right: isTablet ? 18 : 15, // iPad ke liye spacing
        top: isTablet ? 18 : 15, // iPad ke liye spacing
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? 35 : 30, // iPad ke liye padding
        vertical: isTablet ? 18 : 15, // iPad ke liye padding
      ),
      decoration: BoxDecoration(
          color: MyColor.white,
          borderRadius: BorderRadius.circular(60)
      ),
      child: Text(
        title,
        style: mediumTextStyle(
            fontSize: isTablet ? 16.0 : 14.0, // iPad ke liye thoda bada
            color: MyColor.pink
        ),
      ),
    );
  }

}