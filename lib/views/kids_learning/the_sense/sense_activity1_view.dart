import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/dimen.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/constant/stringfile.dart/language.dart';
import 'package:cooking_champs/model/static_model/matching_model.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:cooking_champs/views/kids_learning/common_activity_widget.dart';
import 'package:cooking_champs/widgets/global_button.dart';
import 'package:flutter/material.dart';

class SenseActivity1View extends StatefulWidget {
  const SenseActivity1View({super.key});

  @override
  State<SenseActivity1View> createState() => SenseActivity1ViewState();
}

class SenseActivity1ViewState extends State<SenseActivity1View> {
  // Tracks which items are matched correctly
  List<MatchTheFollowingModel> sensesList = [];
  List<bool> matchingStatus = [];
  List<String> matching = [];
  bool isSubmit = false;


  @override
  void initState() {
    // Initialize the draggable and target lists
    sensesList = items();
    matchingStatus = List.filled(sensesList.length, false);
    matching = List.filled(sensesList.length,"");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            hsized40,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UiUtils.hygieneAppBar(() => Navigator.pop(context),
                    text: "Activity 5.1", color: MyColor.black),
                UiUtils.bookReadGirl(MyColor.red1, AssetsPath.bookReadImg, true)
              ],
            ),

            UiUtils.buildBoldText(
              "Match the word to the picture senses",
              color: MyColor.red1,
              fontSize: 23.0,
            ),
            Text("(Drag answers from Column B to match with Column A. Have fun matching!)",style: mediumTextStyle(fontSize:12.0, color:MyColor.liteGray),),


            hsized15,

            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:40.0),
                  child: Text("A",textAlign: TextAlign.center,style:semiBoldTextStyle(fontSize:20.0, color:MyColor.black),),
                ),
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(left:75.0),
                      child: Text("B",textAlign: TextAlign.center,style:semiBoldTextStyle(fontSize:20.0, color:MyColor.black))),
                ),
              ],
            ),

            hsized10,
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    Row(
                      children: [
                        UiUtils().buildDragTargets(sensesList,matchingStatus,matching,swapRules),
                        UiUtils().buildDraggableItems(sensesList,matchingStatus,matching,swapRules),
                      ],
                    ),
                   /* Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(sensesList.length, (index) {
                        return Row(
                          children: [

                            // Left Side..
                            buildDragTargets(index),

                            SizedBox(width:20,),
                            // Right Side..
                            buildDraggableItems(index),

                            // Right Side...

                          ],
                        );
                      }),
                    ),*/

                    hsized60,

                    GlobalButton(
                        Languages.of(context)!.submit,
                        MyColor.red1,
                        MyColor.red1,
                        btnSize55,
                        double.infinity, nextOnTap,
                        55,
                        0,
                        0,
                        semiBoldTextStyle(fontSize: 18.0, color: MyColor.white))


                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDragTargets(int index) {
    return UiUtils().buildDragTargetContainer(sensesList[index],matchingStatus[index],height:100,index: index,swapRules:swapRules,matching: matching[index]);
  }

  Widget buildDraggableItems(int index) {
    return Expanded(
      child: Container(
          padding: const EdgeInsets.only(right: 10),
          child:  UiUtils().buildRuleContainer(index,sensesList[index], matchingStatus[index],height:100,matching: matching[index])
      ),
    );
  }

  void nextOnTap() {
    setState(() {
      for(int i = 0; i < sensesList.length; i++){
        matchingStatus[i] = (sensesList[i].title == sensesList[i].answer);
        if(matchingStatus[i]){
          matching[i] = "Correct";
        }else{
          matching[i] = "Wrong";
        }
      }
      if(!matchingStatus.contains(false)){
        activityPageController.jumpToPage(activityCurrentIndex+1);
      }
    });

  }
  void swapRules(int index1, int index2) {
    // Ensure both indices are valid before performing the swap
    if (index1 >= 0 && index1 < sensesList.length && index2 >= 0 && index2 < sensesList.length) {
      setState(() {
        // Swap the titles
        var tempTitle = sensesList[index1].title;
        sensesList[index1].title = sensesList[index2].title;
        sensesList[index2].title = tempTitle;

        // Update the matching status for the swapped indices
        matching[index1] = "Drag";
        matching[index2] = "Drag";

        // Check if all but one are properly matched
        if (matching.where((status) => status == "").length == 1) {
          int falseIndex = matching.indexWhere((status) => status == "");
          matching[falseIndex] = "Drag";
        }
      });
    } else {
      // Log or handle invalid index cases
      print("Invalid indices: index1 = $index1, index2 = $index2");
    }
  }


}
