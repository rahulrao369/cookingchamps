import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/constant/stringfile.dart/language.dart';
import 'package:cooking_champs/model/static_model/matching_model.dart';
import 'package:cooking_champs/utils/navigators.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:cooking_champs/views/kids_learning/common_activity_widget.dart';
import 'package:flutter/material.dart';
import '../../../widgets/global_button.dart';

class ActivityTwoView extends StatefulWidget {
  const ActivityTwoView({super.key});

  @override
  State<ActivityTwoView> createState() => _ActivityTwoViewState();
}

class _ActivityTwoViewState extends State<ActivityTwoView> {
  List<MatchTheFollowingModel> rulesList = [];
  List<bool> matchingStatus = [];
  List<String> matching = [];

  String topStep = "1.2";
  String step = "1/2";

  Offset? currentStart; // Current starting point of a line
  @override
  void initState() {
    setRulesList();
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
        padding: const EdgeInsets.only(bottom:5.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left:15,right:15,top:0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: (){
                          setState(() {
                            if(step == "1/2"){
                              CustomNavigators.popNavigate(context);
                            }else if(step == "2/2"){
                              step = "1/2";
                              // rulesList.clear();
                              // matchingStatus.clear();
                              // matching.clear();
                              setRulesList();
                            }else{
                              CustomNavigators.popNavigate(context);
                            }
                          });
                        },
                        child: Icon(Icons.arrow_back_ios,color: MyColor.black,size:28,),
                      ),
                      Text("${Languages.of(context)!.activity}$topStep",style:mediumTextStyle(fontSize:18.0, color:MyColor.black),)
                    ],
                  ),

                  UiUtils.bookReadGirl(MyColor.darkOrange,AssetsPath.bookReadImg, true)
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text("Matching chart with The Cooking Champ Kitchen Rules",style: boldTextStyle(fontSize:22.0, color:MyColor.darkOrange),),
            ),

            hsized10,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Match the Rule with the picture",style: mediumTextStyle(fontSize:16.0, color:MyColor.black),),
                        Text("(Drag answers from Column B to match with Column A. Have fun matching!)",style: mediumTextStyle(fontSize:12.0, color:MyColor.liteGray),),
                        hsized3,
                        Container(width:265,
                          height:3,
                          decoration: BoxDecoration(color: MyColor.dividerYellow,),)
                      ],
                    ),
                  ),
                  Text(step,style: mediumTextStyle(fontSize:16.0, color:MyColor.black),),
                ],
              ),
            ),

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

            // hsized20,
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(left:20.0,right: 10),
                      child:   Row(
                        children: [
                          UiUtils().buildDragTargets(rulesList,matchingStatus,matching,swapRules),
                          UiUtils().buildDraggableItems(rulesList,matchingStatus,matching,swapRules),
                        ],
                      ),

                      /*Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(rulesList.length, (index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          buildDragTargets(index),
                          buildDraggableItems(index),
                        ],
                      );
                      })),*/
                    ),

                    hsized40,
                    Container(
                        color: MyColor.white,
                        padding: EdgeInsets.only(left:20,right:20,bottom:20,top:0),
                        child:GlobalButton(step == "1/2"?Languages.of(context)!.next:Languages.of(context)!.submit,MyColor.appTheme,MyColor.appTheme, 55,double.infinity,nextOnTap,55,0,0,mediumTextStyle(fontSize:16.0, color:MyColor.white))
                    ),
                   // hsized30
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
    return UiUtils().buildDragTargetContainer(rulesList[index],matchingStatus[index],height:100,index: index,swapRules:swapRules,matching: matching[index]);
  }

  Widget buildDraggableItems(int index) {
    return Expanded(
      child: Container(
          padding: const EdgeInsets.only(right: 10),
          child:  UiUtils().buildRuleContainer(index,rulesList[index], matchingStatus[index],height:100,matching: matching[index])
      ),
    );
  }



  void handleMatch(int imageIndex, int ruleIndex) {
      swapRules(imageIndex,ruleIndex);
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
    });

   debugPrint("$matchingStatus");


     if(mounted){
       if(step == "1/2"){
         setState(() {
           if(!matchingStatus.contains(false)){
             //activityPageController.jumpToPage(activityCurrentIndex+1);
             rulesList.clear();
                 step = "2/2";
                 step2();
           }
         });
       }else if(step == "2/2"){
         setState(() {
           if(!matchingStatus.contains(false)){
             activityPageController.jumpToPage(2);
           }
         });
         // setState(() {
         //   for(int i = 0; i < rulesList.length; i++){
         //     matchingStatus[i] = (rulesList[i].title == rulesList[i].answer);
         //   }
         //   if(!matchingStatus.contains(false)){
         //     activityPageController.jumpToPage(2);
         //   }
         // });
     }
   }

  }

  step2(){
    rulesList = [
      MatchTheFollowingModel("Only use your cooking champ knife and peeler", AssetsPath.img3,"Keep appliances away from water",MyColor.darkOrange,name: "1"),
      MatchTheFollowingModel("Stay clean: wash your hands, hair tied up and apron on", AssetsPath.img9,"Only use your cooking champ knife and peeler",MyColor.darkOrange,name: "2"),
      MatchTheFollowingModel("Keep electrical cords away from stove top", AssetsPath.img12,"If something goes wrong call an adult",MyColor.darkOrange,name: "3"),
      MatchTheFollowingModel("If something goes wrong call an adult", AssetsPath.img10,"Keep cleaning products and food separate",MyColor.darkOrange,name: "4"),
      MatchTheFollowingModel("Keep appliances away from water", AssetsPath.img6,"Keep electrical cords away from stove top",MyColor.darkOrange,name: "5"),
      MatchTheFollowingModel("Keep cleaning products and food separate", AssetsPath.img11,"Stay clean: wash your hands, hair tied up and apron on",MyColor.darkOrange,name: "6"),
    ];
    matchingStatus = List.filled(rulesList.length, false);
    matching = List.filled(rulesList.length, "");
  }

  void setRulesList() {
    rulesList = [
      MatchTheFollowingModel("Always follow the knife safety rules!", AssetsPath.img1,"Don't play or run in the kitchen",MyColor.darkOrange,name: "1"),
      MatchTheFollowingModel("Ask an adult before you start cooking and only use the stove when you are with an adult", AssetsPath.activityImg2,"Always follow the knife safety rules!",MyColor.darkOrange,name: "2"),
      MatchTheFollowingModel("Don't play or run in the kitchen", AssetsPath.img8,"Make sure pot and pan handles are turned in",MyColor.darkOrange,name: "3"),
      MatchTheFollowingModel("Keep paper towels and tea towels away from stove tops", AssetsPath.img2,"Ask an adult before you start cooking and only use the stove when you are with an adult",MyColor.darkOrange,name: "4"),
      MatchTheFollowingModel("Make sure pot and pan handles are turned in", AssetsPath.img4,"Keep your kitchen clean and clean spills immediately",MyColor.darkOrange,name: "5"),
      MatchTheFollowingModel("Keep your kitchen clean and clean spills immediately", AssetsPath.img7,"Keep paper towels and tea towels away from stove tops",MyColor.darkOrange,name: "6"),
    ];

    matchingStatus = List.filled(rulesList.length, false);
    matching = List.filled(rulesList.length, "");
  }

}

class LinePainter extends CustomPainter {
  final List<Offset> startPoints;
  final List<Offset> endPoints;

  LinePainter(this.startPoints, this.endPoints);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < startPoints.length; i++) {
      canvas.drawLine(startPoints[i], endPoints[i], paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

