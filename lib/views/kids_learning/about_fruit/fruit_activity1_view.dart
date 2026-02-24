import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/utils/navigators.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:cooking_champs/views/kids_learning/Kids_recipe_main_view.dart';
import 'package:cooking_champs/views/kids_learning/all_about_vegetables/vegetable_activity2_view.dart';
import 'package:cooking_champs/views/kids_learning/kids_recipe_view.dart';
import 'package:flutter/material.dart';

class FruitActivity1View extends StatelessWidget {
  const FruitActivity1View({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          hsized40,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(padding: EdgeInsets.only(bottom:30),
                  child: UiUtils.hygieneAppBar(()=> Navigator.pop(context), text:"Activity 7.1",color:MyColor.black),),
                UiUtils.bookReadGirl(MyColor.darkPink, AssetsPath.bookReadImg, true)
              ],
            ),
          ),


          Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal:20.0),
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UiUtils.buildBoldText("About Fruit",fontSize:23.0,color:MyColor.darkSky,),
                    UiUtils.buildMediumText("Children sit in a circle.",fontSize:16.0,color:MyColor.appTheme,),
                    hsized5,
                    Image.asset(AssetsPath.dividerLineImg),

                    hsized15,
                    RichText(
                      text: TextSpan(
                        style: regularTextStyle(fontSize:16.0,color:MyColor.black),
                        children: [
                          TextSpan(text:"Beginning with A, the first person begins by saying -"),
                          TextSpan(
                            text:"“My favourite fruit starts with A and it is an A_ _ _ _?”",
                            style:  regularTextStyle(fontSize:16.0,color:MyColor.red1),),
                        ],
                      ),
                    ),
                    hsized15,
                    UiUtils.buildNormalText("If the child cannot name a fruit they pass to the next child who repeats the same letter and answers.",fontSize:16.0),

                    hsized10,
                    UiUtils.buildNormalText("If the next child cannot name a fruit the whole group is given the opportunity and then return to the last person who moves to the next letter.",fontSize:16.0),
                    hsized10,
                    UiUtils.buildNormalText("My favourite fruit starts with B and so on until you reach the end of the alphabet.",fontSize:16.0),


                    hsized40,
                    UiUtils.buildFunFact(title: "Fun Fact", fact: 'Why do apples float when they are dropped in water!',des:"Because they are 25% air! WOW!"),

                    //  GlobalButton(Languages.of(context)!.next,MyColor.appTheme,MyColor.appTheme,55,double.infinity,()=> CustomNavigators.pushNavigate(VegetableActivity2View(),context), 55,0,0,semiBoldTextStyle(fontSize:18.0, color:MyColor.white))

                  ],
                ),
              ))

        ],
      ),
    );
  }
}
