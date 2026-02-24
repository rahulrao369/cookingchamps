import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/utils/navigators.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:cooking_champs/views/kids_learning/all_about_vegetables/vegetable_activity2_view.dart';
import 'package:flutter/material.dart';

class VegetableActivity1View extends StatelessWidget {
  const VegetableActivity1View({super.key});

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
                child: UiUtils.hygieneAppBar(()=> Navigator.pop(context), text:"Activity 6.1",color:MyColor.black),),

                UiUtils.bookReadGirl(MyColor.darkSky,AssetsPath.senseAppbarImage, true)
              ],
            ),
          ),


          Expanded(
              child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal:20.0),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UiUtils.buildBoldText("About Vegetables",fontSize:23.0,color:MyColor.darkSky,),
                UiUtils.buildMediumText("Children sit in a circle",fontSize:16.0,color:MyColor.appTheme,),
                hsized5,
                Image.asset(AssetsPath.dividerLineImg,color:MyColor.appTheme,),

                hsized20,
                RichText(
                  text: TextSpan(
                    style: regularTextStyle(fontSize:16.0,color:MyColor.black),
                    children: [
                      TextSpan(text:"Beginning with A, the first person begins by saying -"),
                      TextSpan(
                          text:"“My favourite Vegetable starts with A and it is an A_ _ _ _?”",
                          style:  regularTextStyle(fontSize:16.0,color:MyColor.red1),),
                    ],
                  ),
                ),
                hsized15,
                UiUtils.buildNormalText("If he/she cannot name a vegetable they pass to the next person who repeats the same letter and answers.",fontSize:16.0),

                hsized10,
                UiUtils.buildNormalText("If they cannot name a vegetable the whole group is given the opportunity and then return to the last person who moves to the next letter.",fontSize:16.0),
                hsized10,
                UiUtils.buildNormalText("My favourite Vegetable starts with B and so on until you reach the end of the alphabet.",fontSize:16.0),


                UiUtils.buildJokeSection("Q. What has eyes but cannot see?","A. Potato!",image: "Boy"),
                
              //  GlobalButton(Languages.of(context)!.next,MyColor.appTheme,MyColor.appTheme,55,double.infinity,()=> CustomNavigators.pushNavigate(VegetableActivity2View(),context), 55,0,0,semiBoldTextStyle(fontSize:18.0, color:MyColor.white))

              ],
            ),
          ))

        ],
      ),
      // floatingActionButton:InkWell(
      //   onTap: (){
      //     CustomNavigators.pushNavigate(VegetableActivity2View(),context); },
      //   child: UiUtils.buildBoldText("Next",fontSize: 20.0,color:MyColor.darkSky),
      // ),
    );
  }
}
