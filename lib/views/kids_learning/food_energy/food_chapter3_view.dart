// import 'package:cooking_champs/constant/assets_path.dart';
// import 'package:cooking_champs/constant/my_color.dart';
// import 'package:cooking_champs/constant/my_fonts_style.dart';
// import 'package:cooking_champs/constant/sized_box.dart';
// import 'package:cooking_champs/utils/ui_utils.dart';
// import 'package:cooking_champs/views/kids_learning/safety_kitchen_chapter/safty_kitchen_view.dart';
// import 'package:flutter/material.dart';
//
// class FoodEnergyChapter3View extends StatefulWidget {
//   const FoodEnergyChapter3View({super.key});
//
//   @override
//   State<FoodEnergyChapter3View> createState() => _FoodEnergyChapter3ViewState();
// }
//
// class _FoodEnergyChapter3ViewState extends State<FoodEnergyChapter3View> {
//   List<String> mixStoryList = [
//     "• Trail mix is a super nutritious snack and high-in energy that is eaten all over the world.",
//     "• It’s made of nuts, seeds, dried fruits and chocolate or carob and doesn’t need special storage so it can be taken anywhere.",
//     "• People like hikers, explorers, pioneers, hunters, soldiers, scouts and even ancient travellers have been making and eating it for thousands of years! WOW!"
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context);
//     return Scaffold(
//       backgroundColor: MyColor.white,
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(top: 50.0, bottom: 20),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         InkWell(
//                           radius: 80,
//                           onTap: () {
//                             setState(() {
//                               currentIndex = 0;
//                             });
//                             Navigator.pop(context);
//                           },
//                           child: Icon(
//                             Icons.arrow_back_ios,
//                             size: 28,
//                           ),
//                         ),
//                         SizedBox(width: 10),
//                         Text(
//                           "Food is energy",
//                           style: mediumTextStyle(
//                               fontSize: 18.0, color: MyColor.black),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Text(
//                     "The trail mix story",
//                     style: boldTextStyle(fontSize: 23.0, color: MyColor.pink),
//                   ),
//                   hsized8,
//                   Text(
//                     "• Trail mix is a super nutritious snack and high-in energy that is eaten all over the world.",
//                     style: regularNormalTextStyle(
//                         fontSize: 16.0, color: MyColor.black),
//                   ),
//                   hsized10,
//                   Text(
//                     "• It’s made of nuts, seeds, dried fruits and chocolate or carob and doesn’t need special storage so it can be taken anywhere.",
//                     style: regularNormalTextStyle(
//                         fontSize: 16.0, color: MyColor.black),
//                   ),
//                   hsized10,
//                   Text(
//                     "• People like hikers, explorers, pioneers, hunters, soldiers, scouts and even ancient travellers have been making and eating it for thousands of years! WOW!",
//                     style: regularNormalTextStyle(
//                         fontSize: 16.0, color: MyColor.black),
//                   ),
//                 ],
//               ),
//             ),
//             hsized10,
//             Image.asset(AssetsPath.foodChapterImg3),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   hsized10,
//                   Text(
//                     "• In some European countries like Germany, Poland and Hungary, trail mix is called “student food” or “student snack”.",
//                     style: regularNormalTextStyle(
//                         fontSize: 16.0, color: MyColor.black),
//                   ),
//                   hsized10,
//                   Text(
//                     "• In New Zealand they call it “scroggin” or “schmogle” He He!",
//                     style: regularNormalTextStyle(
//                         fontSize: 16.0, color: MyColor.black),
//                   ),
//                   hsized10,
//                   Text(
//                     "• In America they call it GORP (It stands for Good Old Raisins and Peanuts)",
//                     style: regularNormalTextStyle(
//                         fontSize: 16.0, color: MyColor.black),
//                   ),
//                   hsized10,
//                   Text(
//                     "• There is even a special day to celebrate it! August 31 is National Trail Mix Day! Wow!",
//                     style: regularNormalTextStyle(
//                         fontSize: 16.0, color: MyColor.black),
//                   ),
//                 ],
//               ),
//             ),
//             hsized20,
//             Padding(
//                 padding: const EdgeInsets.only(left: 15.0),
//                 child: UiUtils.extensionBox(
//                     "On a map of the world, find Germany, Poland, Hungary, New Zealand and America. Are any of these countries close to each other? Which is the furthest away?",
//                     rightPadding: 55)),
//             hsized100
//           ],
//         ),
//       ),
//     );
//   }
//
//   btnUI(String title, int index) {
//     return Container(
//       margin: EdgeInsets.only(right: 15, top: 15),
//       padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//       decoration: BoxDecoration(
//           color: MyColor.white, borderRadius: BorderRadius.circular(60)),
//       child: Text(
//         title,
//         style: mediumTextStyle(fontSize: 14.0, color: MyColor.pink),
//       ),
//     );
//   }
// }

import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:cooking_champs/views/kids_learning/safety_kitchen_chapter/safty_kitchen_view.dart';
import 'package:flutter/material.dart';

class FoodEnergyChapter3View extends StatefulWidget {
  const FoodEnergyChapter3View({super.key});

  @override
  State<FoodEnergyChapter3View> createState() => _FoodEnergyChapter3ViewState();
}

class _FoodEnergyChapter3ViewState extends State<FoodEnergyChapter3View> {
  List<String> mixStoryList = [
    "• Trail mix is a super nutritious snack and high-in energy that is eaten all over the world.",
    "• It's made of nuts, seeds, dried fruits and chocolate or carob and doesn't need special storage so it can be taken anywhere.",
    "• People like hikers, explorers, pioneers, hunters, soldiers, scouts and even ancient travellers have been making and eating it for thousands of years! WOW!"
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context);
    // Check if device is iPad/tablet
    final bool isTablet = MediaQuery.of(context).size.shortestSide > 600;

    return Scaffold(
      backgroundColor: MyColor.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 25.0 : 20.0 // iPad ke liye padding
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: isTablet ? 60.0 : 50.0, // iPad ke liye top padding
                        bottom: isTablet ? 25 : 20 // iPad ke liye bottom padding
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          radius: 80,
                          onTap: () {
                            setState(() {
                              currentIndex = 0;
                            });
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: isTablet ? 32 : 28, // iPad ke liye thoda bada
                          ),
                        ),
                        SizedBox(width: isTablet ? 12 : 10), // iPad ke liye spacing
                        Text(
                          "Food is energy",
                          style: mediumTextStyle(
                              fontSize: isTablet ? 21.0 : 18.0, // iPad ke liye thoda bada
                              color: MyColor.black
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "The trail mix story",
                    style: boldTextStyle(
                        fontSize: isTablet ? 26.0 : 23.0, // iPad ke liye thoda bada
                        color: MyColor.pink
                    ),
                  ),
                  SizedBox(height: isTablet ? 10 : 8), // iPad ke liye spacing
                  Text(
                    "• Trail mix is a super nutritious snack and high-in energy that is eaten all over the world.",
                    style: regularNormalTextStyle(
                        fontSize: isTablet ? 18.0 : 16.0, // iPad ke liye thoda bada
                        color: MyColor.black
                    ),
                  ),
                  SizedBox(height: isTablet ? 12 : 10), // iPad ke liye spacing
                  Text(
                    "• It's made of nuts, seeds, dried fruits and chocolate or carob and doesn't need special storage so it can be taken anywhere.",
                    style: regularNormalTextStyle(
                        fontSize: isTablet ? 18.0 : 16.0, // iPad ke liye thoda bada
                        color: MyColor.black
                    ),
                  ),
                  SizedBox(height: isTablet ? 12 : 10), // iPad ke liye spacing
                  Text(
                    "• People like hikers, explorers, pioneers, hunters, soldiers, scouts and even ancient travellers have been making and eating it for thousands of years! WOW!",
                    style: regularNormalTextStyle(
                        fontSize: isTablet ? 18.0 : 16.0, // iPad ke liye thoda bada
                        color: MyColor.black
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: isTablet ? 15 : 10), // iPad ke liye spacing
            Image.asset(
              AssetsPath.foodChapterImg3,
              width: isTablet ? size.size.width * 0.9 : null, // iPad ke liye width control
              fit: BoxFit.contain,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 25.0 : 20.0 // iPad ke liye padding
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: isTablet ? 15 : 10), // iPad ke liye spacing
                  Text(
                    "• In some European countries like Germany, Poland and Hungary, trail mix is called 'student food' or 'student snack'.",
                    style: regularNormalTextStyle(
                        fontSize: isTablet ? 18.0 : 16.0, // iPad ke liye thoda bada
                        color: MyColor.black
                    ),
                  ),
                  SizedBox(height: isTablet ? 12 : 10), // iPad ke liye spacing
                  Text(
                    "• In New Zealand they call it 'scroggin' or 'schmogle' He He!",
                    style: regularNormalTextStyle(
                        fontSize: isTablet ? 18.0 : 16.0, // iPad ke liye thoda bada
                        color: MyColor.black
                    ),
                  ),
                  SizedBox(height: isTablet ? 12 : 10), // iPad ke liye spacing
                  Text(
                    "• In America they call it GORP (It stands for Good Old Raisins and Peanuts)",
                    style: regularNormalTextStyle(
                        fontSize: isTablet ? 18.0 : 16.0, // iPad ke liye thoda bada
                        color: MyColor.black
                    ),
                  ),
                  SizedBox(height: isTablet ? 12 : 10), // iPad ke liye spacing
                  Text(
                    "• There is even a special day to celebrate it! August 31 is National Trail Mix Day! Wow!",
                    style: regularNormalTextStyle(
                        fontSize: isTablet ? 18.0 : 16.0, // iPad ke liye thoda bada
                        color: MyColor.black
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: isTablet ? 25 : 20), // iPad ke liye spacing
            Padding(
              padding: EdgeInsets.only(
                left: isTablet ? 20.0 : 15.0, // iPad ke liye padding
                right: isTablet ? 20.0 : 15.0, // iPad ke liye padding
              ),
              child: UiUtils.extensionBox(
                "On a map of the world, find Germany, Poland, Hungary, New Zealand and America. Are any of these countries close to each other? Which is the furthest away?",
                rightPadding: isTablet ? 65 : 55, // iPad ke liye padding
                 // iPad ke liye parameter pass karna hoga
              ),
            ),
            SizedBox(height: isTablet ? 120 : 100) // iPad ke liye bottom spacing
          ],
        ),
      ),
    );
  }

  btnUI(String title, int index) {
    // Check if device is iPad/tablet
    final bool isTablet = MediaQuery.of(context).size.shortestSide > 600;

    return Container(
      margin: EdgeInsets.only(
        right: isTablet ? 18 : 15, // iPad ke liye spacing
        top: isTablet ? 18 : 15, // iPad ke liye spacing
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? 35 : 30, // iPad ke liye padding
        vertical: isTablet ? 18 : 15, // iPad ke liye padding
      ),
      decoration: BoxDecoration(
          color: MyColor.white,
          borderRadius: BorderRadius.circular(60)
      ),
      child: Text(
        title,
        style: mediumTextStyle(
            fontSize: isTablet ? 16.0 : 14.0, // iPad ke liye thoda bada
            color: MyColor.pink
        ),
      ),
    );
  }
}