import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/model/static_model/day_model.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:flutter/material.dart';

class FoodActivity2AView extends StatefulWidget {
  const FoodActivity2AView({super.key});

  @override
  State<FoodActivity2AView> createState() => _FoodActivity2AViewState();
}

class _FoodActivity2AViewState extends State<FoodActivity2AView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.white,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 35),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UiUtils().foodEnergyAppBar(() => Navigator.pop(context),
                    text: "Activity 2.2- A"),
                UiUtils.bookReadGirl(MyColor.pink, AssetsPath.bookReadImg, true)
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        UiUtils.buildBoldText("I brushed my teeth", fontSize: 23.0, color: MyColor.pink),

                        hsized5,
                        UiUtils.buildNormalText(
                          "At home keep a record of you teeth brushing. Tick the morning and night boxes after you have brushed your teeth. At the end of the week ask your guardian to witness the activity and bring to school the following Monday to discuss with your class.",
                          color: MyColor.black,
                        ),


                        hsized20,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            UiUtils.buildBoldText("Morning"),
                            SizedBox(width:30,),
                            UiUtils.buildBoldText("Night"),
                            SizedBox(width:10,),
                          ],
                        ),
                        hsized10,
                        //Image.asset(AssetsPath.foodActivity4AImg),

                        Column(
                          children:List.generate(days.length,(int index){
                            return Padding(
                              padding: const EdgeInsets.only(top:10.0,bottom:10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      flex:2,
                                      child: Text(days[index].day,style:boldTextStyle(fontSize:18.0, color:days[index].color),)),

                                 //Icon(Icons.arrow_right_alt_outlined,size:50,color:days[index].color,),
                                  Image.asset(AssetsPath.arrowLine,width:60,color:days[index].color),
                                  SizedBox(width:30,),

                                  Expanded(
                                      flex:1,child: InkWell(
                                      onTap: (){
                                        setState(() {
                                          days[index].isMorningSelected = !days[index].isMorningSelected;
                                          days[index].isNightSelected = false;
                                        });
                                      },
                                      child: Icon(days[index].isMorningSelected?Icons.star:Icons.star_border_sharp,size:60,color:days[index].color,))),

                                  SizedBox(width:30,),

                                  Expanded(
                                      flex:1,child: InkWell(
                                      onTap: (){
                                        setState(() {
                                          days[index].isNightSelected = !days[index].isNightSelected;
                                          days[index].isMorningSelected = false;
                                        });
                                      },
                                      child: Icon(days[index].isNightSelected?Icons.star:Icons.star_border_sharp,size:60,color:days[index].color,))),
                                ],
                              ),
                            );
                          })
                        ),

                        hsized20,
                        Container(
                          width: double.infinity,
                          color: MyColor.grayLite1,
                          height: 2,
                        ),
                        hsized10,
                        UiUtils.buildRegularText("Witness signature",),
                        hsized80,
                      ],
                    ),
                  ),
                  hsized50,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
