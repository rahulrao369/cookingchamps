// import 'package:cooking_champs/constant/assets_path.dart';
// import 'package:cooking_champs/constant/my_color.dart';
// import 'package:cooking_champs/constant/my_fonts_style.dart';
// import 'package:cooking_champs/constant/sized_box.dart';
// import 'package:cooking_champs/constant/stringfile.dart/language.dart';
// import 'package:cooking_champs/utils/navigators.dart';
// import 'package:cooking_champs/utils/ui_utils.dart';
// import 'package:cooking_champs/views/kids_learning/common_activity_widget.dart';
// import 'package:cooking_champs/widgets/global_button.dart';
// import 'package:flutter/material.dart';
// import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
//
// class ActivityOneView extends StatefulWidget {
//   const ActivityOneView({super.key});
//
//   @override
//   State<ActivityOneView> createState() => _ActivityOneViewState();
// }
//
// class _ActivityOneViewState extends State<ActivityOneView> {
//   @override
//   Widget build(BuildContext context) {
//     final data = MediaQuery.of(context);
//     return MediaQuery(
//         data: data.copyWith(textScaleFactor: 1.0),
//         child: Scaffold(
//           backgroundColor: MyColor.white,
//           appBar: PreferredSize(
//             preferredSize:Size.zero,
//             child: AppBar(
//               surfaceTintColor: Colors.transparent,
//               backgroundColor:MyColor.white,
//             ),
//           ),
//           body: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 padding: EdgeInsets.only(left:15,right:15,top:0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         InkWell(
//                           onTap: (){
//                             CustomNavigators.popNavigate(context);
//                           },
//                           child: Icon(Icons.arrow_back_ios,color: MyColor.black,size:28,),
//                         ),
//                         Text("${Languages.of(context)!.activity}1.1",style:mediumTextStyle(fontSize:18.0, color:MyColor.black),)
//                       ],
//                     ),
//
//                     UiUtils.bookReadGirl(MyColor.darkOrange,AssetsPath.bookReadImg)
//
//                   ],
//                 ),
//               ),
//
//
//               Expanded(
//                   child: SingleChildScrollView(
//                     padding: EdgeInsets.fromLTRB(20,0,20,30),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Look at the picture below.",style:boldTextStyle(fontSize:23.0, color:MyColor.darkOrange),),
//                     hsized10,
//                     Padding(
//                       padding: const EdgeInsets.only(left:0.0,right: 0),
//                       child: Image.asset(AssetsPath.activityImg1),
//                     ),
//                     hsized10,
//                      Text("List the risks",style:semiBoldTextStyle(fontSize:18.0, color:MyColor.black),),
//                      Text("Draw a circle around the things that look risky in this kitchen.",style:regularNormalTextStyle(fontSize:15.0, color:MyColor.black),),
//                     textField(),
//
//                      hsized10,
//                      Text("Why are these areas or things risky?",style:regularNormalTextStyle(fontSize:15.0, color:MyColor.black),),
//
//                     textField(),
//                     hsized20,
//                      Text("How do you make this kitchen safer?",style:regularNormalTextStyle(fontSize:15.0, color:MyColor.black),),
//                     textField(),
//                     //hsized10,
//                     hsized25,
//                     UiUtils.extensionBox("Take a look at your kitchen at home, what do you see, did you find any safety risks?",title:"Homework",titleColor: MyColor.darkOrange,subDes: "List them and talk to your family about them. Take your list to school and see what your classmates found."),
//
//                     hsized40,
//                     GlobalButton(Languages.of(context)!.submit,MyColor.appTheme,MyColor.appTheme, 55,double.infinity,submitOnTap,55,0,0,mediumTextStyle(fontSize:16.0, color:MyColor.white)),
//                   ],
//                 ),
//               )),
//
//              // hsized30
//             ],
//           ),
//           // bottomSheet:  Container(
//           //     color: MyColor.white,
//           //     padding: EdgeInsets.only(left:20,right:20,bottom:20,top:0),
//           //     child:GlobalButton(Languages.of(context)!.submit,MyColor.appTheme,MyColor.appTheme, 55,double.infinity,submitOnTap,55,0,0,mediumTextStyle(fontSize:16.0, color:MyColor.white))
//           // ),
//         )
//     );
//   }
//
//   void submitOnTap() {
//     setState(() {
//       activityPageController.jumpToPage(1);
//     });
//     //CustomNavigators.pushNavigate(ActivityTwoView(), context);
//   }
//
//   textField(){
//     return Stack(
//       children: [
//         for (int i = 0; i < 2; i++)
//           Container(
//             margin: EdgeInsets.only(
//               top: 4 + (i + 1) * 28,
//             ),
//             decoration: const BoxDecoration(
//               border: DashedBorder(
//                 dashLength: 5,
//                 left: BorderSide.none,
//                 top: BorderSide.none,
//                 right: BorderSide.none,
//                 bottom: BorderSide(color: Colors.black, width: 1),
//               ),
//             ),
//           ),
//         TextField(
//           scrollPhysics: NeverScrollableScrollPhysics(),
//           decoration: InputDecoration(border: InputBorder.none),
//           cursorHeight: 22,
//           onTapOutside: (v){
//             FocusManager.instance.primaryFocus!.unfocus();
//           },
//           style: TextStyle(
//             fontSize: 20.0,
//           ),
//           keyboardType: TextInputType.multiline,
//           textInputAction: TextInputAction.newline,
//           maxLines: 2,
//           minLines: 1,
//         ),
//       ],
//     );
//   }
// }


import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/constant/stringfile.dart/language.dart';
import 'package:cooking_champs/utils/navigators.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:cooking_champs/views/kids_learning/common_activity_widget.dart';
import 'package:cooking_champs/widgets/global_button.dart';
import 'package:flutter/material.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';

class ActivityOneView extends StatefulWidget {
  const ActivityOneView({super.key});

  @override
  State<ActivityOneView> createState() => _ActivityOneViewState();
}

class _ActivityOneViewState extends State<ActivityOneView> {
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    final bool isTablet = data.size.shortestSide > 600;

    return MediaQuery(
        data: data.copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          backgroundColor: MyColor.white,
          appBar: PreferredSize(
            preferredSize: Size.zero,
            child: AppBar(
              surfaceTintColor: Colors.transparent,
              backgroundColor: MyColor.white,
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Container(
                padding: EdgeInsets.only(
                  left: isTablet ? 30.0 : 15.0,
                  right: isTablet ? 30.0 : 15.0,
                  top: isTablet ? 15.0 : 0.0,
                  bottom: isTablet ? 15.0 : 0.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Back Button and Title
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            CustomNavigators.popNavigate(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: MyColor.black,
                            size: isTablet ? 32.0 : 28.0,
                          ),
                        ),
                        SizedBox(width: isTablet ? 15.0 : 10.0),
                        Text(
                          "${Languages.of(context)!.activity} 1.1",
                          style: mediumTextStyle(
                            fontSize: isTablet ? 24.0 : 18.0,
                            color: MyColor.black,
                          ),
                        ),
                      ],
                    ),

                    // Book Read Girl Image
                    UiUtils.bookReadGirl(
                      MyColor.darkOrange,
                      AssetsPath.bookReadImg,
                      isTablet
                    ),
                  ],
                ),
              ),

              // Main Content
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    isTablet ? 35.0 : 20.0,
                    isTablet ? 20.0 : 0.0,
                    isTablet ? 35.0 : 20.0,
                    isTablet ? 50.0 : 30.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Instruction Text
                      Text(
                        "Look at the picture below.",
                        style: boldTextStyle(
                          fontSize: isTablet ? 28.0 : 23.0,
                          color: MyColor.darkOrange,
                        ),
                      ),

                      SizedBox(height: isTablet ? 20.0 : 10.0),

                      // Activity Image
                      Center(
                        child: Image.asset(
                          AssetsPath.activityImg1,
                          width: isTablet ? data.size.width * 0.8 : null,
                          fit: isTablet ? BoxFit.contain : BoxFit.cover,
                        ),
                      ),

                      SizedBox(height: isTablet ? 20.0 : 10.0),

                      // Questions Section
                      Text(
                        "List the risks",
                        style: semiBoldTextStyle(
                          fontSize: isTablet ? 22.0 : 18.0,
                          color: MyColor.black,
                        ),
                      ),

                      SizedBox(height: isTablet ? 8.0 : 4.0),

                      Text(
                        "Draw a circle around the things that look risky in this kitchen.",
                        style: regularNormalTextStyle(
                          fontSize: isTablet ? 18.0 : 15.0,
                          color: MyColor.black,
                        ),
                      ),

                      SizedBox(height: isTablet ? 15.0 : 10.0),

                      textField(isTablet),

                      SizedBox(height: isTablet ? 20.0 : 10.0),

                      Text(
                        "Why are these areas or things risky?",
                        style: regularNormalTextStyle(
                          fontSize: isTablet ? 18.0 : 15.0,
                          color: MyColor.black,
                        ),
                      ),

                      SizedBox(height: isTablet ? 15.0 : 10.0),

                      textField(isTablet),

                      SizedBox(height: isTablet ? 30.0 : 20.0),

                      Text(
                        "How do you make this kitchen safer?",
                        style: regularNormalTextStyle(
                          fontSize: isTablet ? 18.0 : 15.0,
                          color: MyColor.black,
                        ),
                      ),

                      SizedBox(height: isTablet ? 15.0 : 10.0),

                      textField(isTablet),

                      SizedBox(height: isTablet ? 30.0 : 25.0),

                      // Homework Box
                      UiUtils.extensionBox(
                        "Take a look at your kitchen at home, what do you see, did you find any safety risks? List them and talk to your family about them. Take your list to school and see what your classmates found.",
                        title: "Homework",
                        titleColor: MyColor.darkOrange,
                        subDes: "List them and talk to your family about them. Take your list to school and see what your classmates found.",
                        // isTablet: isTablet,
                      ),

                      SizedBox(height: isTablet ? 50.0 : 40.0),

                      // Submit Button
                      GlobalButton(
                        Languages.of(context)!.submit,
                        MyColor.appTheme,
                        MyColor.appTheme,
                        isTablet ? 65.0 : 55.0,
                        double.infinity,
                        submitOnTap,
                        isTablet ? 65.0 : 55.0,
                        0,
                        0,
                        mediumTextStyle(
                          fontSize: isTablet ? 18.0 : 16.0,
                          color: MyColor.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void submitOnTap() {
    setState(() {
      // activityPageController.jumpToPage(1);
    });
    // CustomNavigators.pushNavigate(ActivityTwoView(), context);
  }

  Widget textField(bool isTablet) {
    return Stack(
      children: [
        for (int i = 0; i < 2; i++)
          Container(
            margin: EdgeInsets.only(
              top: (isTablet ? 5.0 : 4.0) + (i + 1) * (isTablet ? 35.0 : 28.0),
            ),
            decoration: const BoxDecoration(
              border: DashedBorder(
                dashLength: 5,
                left: BorderSide.none,
                top: BorderSide.none,
                right: BorderSide.none,
                bottom: BorderSide(color: Colors.black, width: 1),
              ),
            ),
          ),
        TextField(
          scrollPhysics: NeverScrollableScrollPhysics(),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(
              bottom: isTablet ? 15.0 : 10.0,
            ),
          ),
          cursorHeight: isTablet ? 26.0 : 22.0,
          onTapOutside: (v) {
            FocusManager.instance.primaryFocus!.unfocus();
          },
          style: TextStyle(
            fontSize: isTablet ? 22.0 : 20.0,
          ),
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          maxLines: 2,
          minLines: 1,
        ),
      ],
    );
  }
}