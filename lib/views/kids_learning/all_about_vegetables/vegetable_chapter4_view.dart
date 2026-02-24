import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/views/kids_learning/quiz_view.dart';
import 'package:flutter/material.dart';

class VegetableChapter4View extends StatefulWidget {
  const VegetableChapter4View({super.key});

  @override
  State<VegetableChapter4View> createState() => _VegetableChapter4ViewState();
}

class _VegetableChapter4ViewState extends State<VegetableChapter4View> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: MyColor.colorE7F3FB,
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20,top:60),
        height:size.size.height * 0.71,
        child: Stack(
          children: [
            CustomPaint(
              painter: ExactCurvePainter(),
              child: Container(
                height:size.size.height * 0.71,
                width:double.infinity,
                padding: EdgeInsets.only(left: 20, right: 20, top:25, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Five Vegetable a day you say!",
                      textAlign: TextAlign.center,
                      style: boldTextStyle(fontSize: 23.0, color: MyColor.green),
                    ),
                    hsized10,
                    Container(
                        width: 310,
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Text(
                            "How many vegetables must I eat Before I get my favourite treat? Tell me please so I might grow Must I eat all the colours of a rainbow?",
                            textAlign: TextAlign.center,
                            style:
                                semiBoldTextStyle(fontSize: 15.0, color: MyColor.appTheme),
                                                    ),
                            hsized5,
                            Text(
                              "At least five you say are you sure I must? Like potato, carrot, beans and asparagus? Beetroot, turnips and Peas Tomato and Zucchini please!",
                              textAlign: TextAlign.center,
                              style: semiBoldTextStyle(
                                  fontSize: 15.0, color: MyColor.appTheme),
                            ),
                            hsized5,
                            Text(
                              "Floss daily to remove plaque from between your teeth. and under your gumline, where your toothbrush may not reach.",
                              textAlign: TextAlign.center,
                              style: semiBoldTextStyle(
                                  fontSize: 15.0, color: MyColor.appTheme),
                            ),

                            hsized5,
                            Text(
                              "You know I’m feeling stronger already Happier fitter even a little more steady. Tonight I will eat my minestrone With five vegetables and just a little macaroni!",
                              textAlign: TextAlign.center,
                              style: semiBoldTextStyle(
                                  fontSize: 15.0, color: MyColor.appTheme),
                            )

                          ],
                        ),
                    ),

                    hsized80

                  ],
                ),
              ),
            ),
            Align(
              alignment:Alignment.bottomRight,
              child:   Image.asset(AssetsPath.readBookImg1,height:158,width:101,),
            )
          ],
        ),
      ),
    );
  }
}
