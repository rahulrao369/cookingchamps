import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/constant/stringfile.dart/language.dart';
import 'package:cooking_champs/model/static_model/matching_model.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:cooking_champs/views/kids_learning/common_activity_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../widgets/global_button.dart';

class BasicActivity1View extends StatefulWidget {
  const BasicActivity1View({super.key});

  @override
  State<BasicActivity1View> createState() => _BasicActivity1ViewState();
}

class _BasicActivity1ViewState extends State<BasicActivity1View> {
  // List to hold matching lines as pairs of offsets
  List<Offset> startPoints = [];
  List<Offset> endPoints = [];
  List<MatchTheFollowingModel> rulesList = [];
  List<bool> matchingStatus = [];
  List<String> matching = [];


  Offset? currentStart; // Current starting point of a line
  @override
  void initState() {
    step1();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:Size.zero,
        child: AppBar(
          backgroundColor:MyColor.white,
          surfaceTintColor: Colors.transparent,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom:0.0,left:15,right:15,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UiUtils.hygieneAppBar(()=> Navigator.pop(context),text: "Activity 4.1",color:MyColor.black),
                UiUtils.bookReadGirl(MyColor.purple,AssetsPath.bookReadImg, true)
              ],
            ),

            Text("Matching tools",style: boldTextStyle(fontSize:22.0, color:MyColor.appTheme),),

            Text("Draw a line between the tool and its correct definition.",style: mediumTextStyle(fontSize:16.0, color:MyColor.black),),
            hsized3,
            Container(
              width:300,
              height:3,
              decoration: BoxDecoration(color: MyColor.dividerYellow,),),

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
              child: ListView(
                shrinkWrap: true,
               // crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    children: [

                      UiUtils().buildDragTargets(rulesList,matchingStatus,matching,swapRules),


                      UiUtils().buildDraggableItems(rulesList,matchingStatus,matching,swapRules),
                    ],
                  ),


                  hsized50,
                  GlobalButton(Languages.of(context)!.next,MyColor.appTheme,MyColor.appTheme, 55,double.infinity,nextOnTap,55,0,0,mediumTextStyle(fontSize:16.0, color:MyColor.white)),
               hsized70,

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDragTargets() {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(rulesList.length, (index) {
        return UiUtils().buildDragTargetContainer(rulesList[index],matchingStatus[index],index: index,swapRules:swapRules,matching: matching[index]);
        //  buildDragTargets(),
      }),
    );


 }

  Widget buildDraggableItems() {
    return Expanded(
      flex: 2,
      child: Container(
          padding: const EdgeInsets.only(right: 10),
          child: ReorderableListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children:
            rulesList
                .asMap()
                .map((index, item) => MapEntry(
              index,

              ListTile(
                selectedColor: Colors.transparent,
                key: Key(item.title),
                title: UiUtils().buildRuleContainer(index,rulesList[index], matchingStatus[index],matching: matching[index]),
              ),
            ))
                .values
                .toList(),
            onReorder: (int oldIndex, int newIndex) {
             // if (newIndex > oldIndex) newIndex -= 1;
              swapRules(oldIndex, newIndex);
            },
          ),

      ),
    );
  }
  /*SizedBox(
      width: 160,
      child: ReorderableListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children:
        rulesList
            .asMap()
            .map((index, item) => MapEntry(
          index,

          ListTile(
            key: Key(item.title),
            title: UiUtils().buildDragTargetContainer(rulesList[index],matchingStatus[index],index: index,swapRules:swapRules,matching: matching[index])
          ),
        ))
            .values
            .toList(),
        onReorder: (int oldIndex, int newIndex) {
          if (newIndex > oldIndex) newIndex -= 1;
          swapRules(oldIndex, newIndex);
        },
      ),
    );*/

  void nextOnTap() {
    setState(() {
      for(int i = 0; i < rulesList.length; i++){
        matchingStatus[i] = (rulesList[i].title == rulesList[i].answer);
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
  void handleMatch(int imageIndex, int ruleIndex) {
    setState(() {
      swapRules(imageIndex,ruleIndex);
      debugPrint("matchingStatus...${matchingStatus[imageIndex]}");
    });
  }

  void swapRules(int index1, int index2) {
    // Ensure both indices are valid before performing the swap
    if (index1 >= 0 && index1 < rulesList.length && index2 >= 0 && index2 < rulesList.length) {
      setState(() {
        // Swap the titles
        var tempTitle = rulesList[index1].title;
        rulesList[index1].title = rulesList[index2].title;
        rulesList[index2].title = tempTitle;

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



  step1(){
    rulesList.clear();
    rulesList = [
      MatchTheFollowingModel("Whisk", AssetsPath.pans,"Pans",MyColor.appTheme),
      MatchTheFollowingModel("Colander", AssetsPath.tongs,"Tongs",MyColor.appTheme),
      MatchTheFollowingModel("Apron", AssetsPath.woodenSpoon,"Wooden spoon",MyColor.appTheme),
      MatchTheFollowingModel("Tongs", AssetsPath.whisk,"Whisk",MyColor.appTheme),
      MatchTheFollowingModel("Pans", AssetsPath.apron,"Apron",MyColor.appTheme),
      MatchTheFollowingModel("Wooden spoon", AssetsPath.colander,"Colander",MyColor.appTheme),
    ];
    matchingStatus = List.filled(rulesList.length, false);
    matching = List.filled(rulesList.length, "");
  }
}

