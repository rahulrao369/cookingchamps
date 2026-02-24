import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/utils/navigators.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:cooking_champs/views/kids_learning/Kids_recipe_main_view.dart';
import 'package:cooking_champs/views/kids_learning/all_about_vegetables/vegetable_activity5_view.dart';
import 'package:cooking_champs/views/kids_learning/go_to_page_number_view.dart';
import 'package:cooking_champs/views/kids_learning/kids_recipe_view.dart';
import 'package:flutter/material.dart';

class VegetableActivity2View extends StatelessWidget {
  const VegetableActivity2View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(AssetsPath.vegetableActivity2Img),
          ),
          Column(
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
                      child: UiUtils.hygieneAppBar(()=> Navigator.pop(context), text:"Activity 6.2",color:MyColor.black),),

                    UiUtils.bookReadGirl(MyColor.darkSky,AssetsPath.bookReadImg, true)
                  ],
                ),
              ),

              Expanded(child:SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal:20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UiUtils.buildBoldText("Growing vegetables and herbs",fontSize:23.0,color:MyColor.darkSky,),
                    hsized5,
                    UiUtils.buildNormalText("This activity is a group activity and can be as large or small as you can manage in your home or school yard.You can make a small garden in a pot or create a large vegetable bed in your school yard. In class research what grows well in your area. Select the plants you wish to grow. If you decide to undertake a larger project that involves setting up a kitchen garden for your school you may involve other classes and grade levels.",
                      fontSize:16.0,color:MyColor.black,),

                    UiUtils.buildParagraph("","If not :- ","In a large pot place potting mix and seeds following the directions for your plant choice.",color: MyColor.black,regularFontSize:16.0,highlightFontSize:16.0),


                    UiUtils.buildSemiBoldText("You will need:"),
                    UiUtils.buildBulletPoints([
                      " Carrot Seeds",
                      "Coriander Seeds (or other seeds)",
                      "Potting mix",
                      "Large pot/pots"
                    ]),

                    hsized20,

                    UiUtils.buildNormalText("Children should be given responsibility to water their seedling, weeding and harvest over the year.",
                      fontSize:16.0,color:MyColor.black,),


                  ],
                ),
              ))
            ],
          ),


        ],
      ),
      // floatingActionButton:InkWell(
      //   onTap: (){
      //     List<KidsRecipeModel> list = [
      //       KidsRecipeModel("Greek Horiatiki Salata","Activity 6.3",MyColor.sky1,greekHoriatikiSalataData()),
      //       KidsRecipeModel("Bruschetta al Pomodoro","Activity 6.4",MyColor.sky1, brusChettaAlPomodoroData()),
      //       KidsRecipeModel("Courgette Pappardelle","Activity 6.7",MyColor.sky1, courgettePappardelleNapoliSauceData()),
      //     ];
      //
      //     CustomNavigators.pushNavigate(KidsRecipeMainView(recipeList: list,chapter: "Activity 6",), context);
      //    // CustomNavigators.pushNavigate(GoToPageNumberView(text:"In your exercise book draw a plate of vegetables with all the colours of the rainbow", color:MyColor.darkSky, appBarTitle:"Activity 6.5",textColor:MyColor.darkSky,), context);
      //   },
      //   child: UiUtils.buildBoldText("Next",fontSize: 20.0,color:MyColor.darkSky),
      // ),
    );
  }
}
