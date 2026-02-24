import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/utils/navigators.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:flutter/material.dart';

class VegetableChapter5View extends StatefulWidget {
  const VegetableChapter5View({super.key});

  @override
  State<VegetableChapter5View> createState() => _VegetableChapter5ViewState();
}

class _VegetableChapter5ViewState extends State<VegetableChapter5View> {
  TextEditingController controller1 = TextEditingController();

  TextEditingController controller2 = TextEditingController();

  TextEditingController controller3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(AssetsPath.vegetableChapter5Img1),
                Padding(
                  padding: const EdgeInsets.only(top:45.0,left:20,right:20),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: (){
                          CustomNavigators.popNavigate(context);
                        },
                        child: Icon(Icons.arrow_back_ios),
                      ),

                      UiUtils.buildMediumText("All About Vegetables")
                    ],
                  ),
                )
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal:20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  hsized10,
                  UiUtils.buildBoldText("Greece",color: MyColor.darkSky,fontSize:23.0),
                  UiUtils.buildNormalText("Feta cheese comes from Greece, it is soft salty and creamy and eaten all over the world."),
                  hsized10,
                  UiUtils.buildNormalText("Greece is a small country in Europe with a very BIG history"),
                  hsized10,
                  UiUtils.buildNormalText("It has a population of 10,845,511, that’s ten million eight hundred and forty six thousand people living in Greece."),
                  hsized10,
                  UiUtils.buildNormalText("Most of the country is surrounded by sea and it has 6,000 islands but people only live on 227 Islands and the rest are uninhabited (no one lives there)."),
                  hsized10,
                  UiUtils.buildNormalText("Greek people love to dance and eat tasty treats called mesedes."),

                  hsized10,
                  UiUtils.buildNormalText("The Ancient Greeks lived around 3,500 years ago they told wonderful stories called myths about their many Gods."),

                  hsized10,
                  UiUtils.buildNormalText("Their gift of art, architecture, mathematics, medicine, philosophy and politics has shaped the modern western world we see today."),

                  hsized10,
                  UiUtils.buildNormalText("The Olympic Games were invented by the ancient Greeks thousands of years ago!"),

                  hsized20,
                  extensionBox(),

                  hsized100

                ],
              ),
            )

          ],
        ),
      ),
    );
  }

  extensionBox(){
    return Stack(
      children: [

        Container(
          margin: EdgeInsets.only(right:57,top:18,left:8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color:MyColor.white,
              border: Border.all(color:MyColor.appTheme,width:1),
              borderRadius: BorderRadius.circular(11)
          ),
          padding: EdgeInsets.only(right:20,left: 20,top:35,bottom:15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UiUtils.buildMediumText("Look at a map of the world.",color:MyColor.appTheme,fontSize:13.0),

              UiUtils().fillInTheBlanks("If yes what were they?",controller1,fontSize:13.0),
              hsized3,
              UiUtils().fillInTheBlanks("If yes what were they?",controller2,fontSize:13.0),
              hsized3,
              UiUtils().fillInTheBlanks("If yes what were they?",controller3,fontSize:13.0),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top:22),
          decoration: BoxDecoration(
              color:MyColor.darkYellow,
              borderRadius: BorderRadius.circular(55)
          ),
          padding: EdgeInsets.symmetric(horizontal: 10,vertical:5),
          child: Text("Extension",style:boldTextStyle(fontSize:11.0, color:MyColor.black),),
        ),
        Container(
            padding: EdgeInsets.only(top:0),
            alignment: Alignment.centerRight,
            child: Image.asset(AssetsPath.extensionImg,height:124,))
      ],
    );
  }
}
