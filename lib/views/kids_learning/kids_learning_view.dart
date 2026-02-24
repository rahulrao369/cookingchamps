// import 'dart:developer';
//
// import 'package:cooking_champs/constant/apiConnectorConstants.dart';
// import 'package:cooking_champs/constant/assets_path.dart';
// import 'package:cooking_champs/constant/my_color.dart';
// import 'package:cooking_champs/constant/my_fonts_style.dart';
// import 'package:cooking_champs/constant/sized_box.dart';
// import 'package:cooking_champs/constant/stringfile.dart/language.dart';
// import 'package:cooking_champs/model/dynamic_models/my_child_list_new.dart';
// import 'package:cooking_champs/model/dynamic_models/user_identity_model.dart';
// import 'package:cooking_champs/new_ui/web_view_screen.dart';
// import 'package:cooking_champs/services/api_path.dart';
// import 'package:cooking_champs/services/api_services.dart';
// import 'package:cooking_champs/services/user_prefences.dart';
// import 'package:cooking_champs/utils/all_dialogs.dart';
// import 'package:cooking_champs/utils/navigators.dart';
// import 'package:cooking_champs/utils/utility.dart';
// import 'package:cooking_champs/views/kids_learning/about_fruit/about_fruit_view.dart';
// import 'package:cooking_champs/views/kids_learning/about_honeybees/about_honeybees_view.dart';
// import 'package:cooking_champs/views/kids_learning/about_nuts/nuts_about_nuts_view.dart';
// import 'package:cooking_champs/views/kids_learning/all_about_vegetables/about_vegetable_view.dart';
// import 'package:cooking_champs/views/kids_learning/celebrations/celebrations_view.dart';
// import 'package:cooking_champs/views/kids_learning/food_energy/food_energy_view.dart';
// import 'package:cooking_champs/views/kids_learning/hygiene/hygine_view.dart';
// import 'package:cooking_champs/views/kids_learning/payment/kids_learning_payment.dart';
// import 'package:cooking_champs/views/kids_learning/safety_kitchen_chapter/safty_kitchen_view.dart';
// import 'package:cooking_champs/views/kids_learning/the_basic/the_basic_view.dart';
// import 'package:cooking_champs/views/kids_learning/the_sense/the_sense_view.dart';
// import 'package:flutter/material.dart';
// import 'package:pretty_http_logger/pretty_http_logger.dart';
// import 'package:responsive_grid/responsive_grid.dart';
// import 'package:touch_ripple_effect/touch_ripple_effect.dart';
// import 'dart:convert' as convert;
// import 'dart:developer' as developer;
// import '../dashboard.dart';
// import 'dart:convert';
//
// class KidsLearningView extends StatefulWidget {
//   final String type;
//
//   const KidsLearningView({super.key, required this.type});
//
//   @override
//   State<KidsLearningView> createState() => _KidsLearningViewState();
// }
//
// class _KidsLearningViewState extends State<KidsLearningView> {
//   bool navigateSafetyKic = false;
//   UserIdentityModel userDetails = UserIdentityModel();
//   String parentId = "";
//   bool unlockChapter = false;
//   String loginType = "";
//
//   List<KidsLearningModel> topicList = [];
//   MyChildListNew? myChildList;
//   Items? selectedChildObj;
//
//   String base64EncodeString(String input) {
//     return base64Encode(utf8.encode(input));
//   }
//
//   @override
//   void initState() {
//     loadLoginType();
//     super.initState();
//     navigateSafetyKic = true;
//     Future.delayed(Duration.zero, () {
//       if (loginType == "parent" || loginType == "individual") {
//         myChildListApi(false);
//       } else {
//         getProfileDetail();
//       }
//     });
//   }
//
//   void loadLoginType() async {
//     loginType = await PreferencesServices.getPreferencesData(
//         PreferencesServices.loginType);
//     loginType = loginType;
//     print("isLogin: $loginType");
//   }
//
//   setKidsLearning() {
//     setState(() {
//       topicList = [
//         KidsLearningModel("SAFETY IN THE KITCHEN",
//           AssetsPath.safety,
//         ),
//         KidsLearningModel(
//           "FOOD IS ENERGY",
//           AssetsPath.food,
//         ),
//         KidsLearningModel("ALL ABOUT HYGIENE", AssetsPath.allAboutHygiene),
//         KidsLearningModel("THE BASIC", AssetsPath.theBasic),
//         KidsLearningModel("THE SENSES", AssetsPath.theSenses),
//         KidsLearningModel("ALL ABOUT VEGETABLES", AssetsPath.allAboutVegetables),
//         KidsLearningModel("ALL ABOUT FRUITS", AssetsPath.allAboutFruits),
//         KidsLearningModel("HONEYBEES & HONEY", AssetsPath.honeybees),
//         KidsLearningModel("NUTS ABOUT NUTS", AssetsPath.nuts),
//         KidsLearningModel("CELEBRATION", AssetsPath.celebration),
//       ];
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     print("unlockChapter$unlockChapter");
//     setKidsLearning();
//     return WillPopScope(
//       onWillPop: () async {
//         setState(() {
//           tabCheck = "";
//           pageIndex = 0;
//         });
//         return true;
//       },
//       child: Scaffold(
//         appBar: widget.type == "Dash" ? null : _buildAppBar(context),
//         body: _buildBody(context),
//       ),
//     );
//   }
//
//   AppBar _buildAppBar(BuildContext context) {
//     // Check if device is iPad/tablet
//     final bool isTablet = MediaQuery.of(context).size.shortestSide > 600;
//
//     return AppBar(
//       leadingWidth: 0,
//       automaticallyImplyLeading: false,
//       backgroundColor: MyColor.yellowF6F1E1,
//       surfaceTintColor: MyColor.yellowF6F1E1,
//       title: Row(
//         children: [
//           InkWell(
//             radius: 80,
//             borderRadius: BorderRadius.circular(30),
//             onTap: () {
//               if (widget.type == "Food Activity" || widget.type == "Hygiene") {
//                 setState(() {
//                   pageIndex = 0;
//                   tabCheck = "";
//                   isTabExplore = false;
//                 });
//                 CustomNavigators.pushRemoveUntil(
//                     DashBoardView(
//                       pageIndex: 0,
//                     ),
//                     context);
//               } else {
//                 setState(() {
//                   pageIndex = 0;
//                   tabCheck = "";
//                   isTabExplore = false;
//                 });
//               }
//             },
//             child: Padding(
//               padding: EdgeInsets.only(left: 5.0, right: isTablet ? 20 : 10),
//               child: Icon(
//                 Icons.arrow_back_ios,
//                 size: isTablet ? 36 : 28, // iPad ke liye bada icon
//                 color: Colors.black,
//               ),
//             ),
//           ),
//           Text(
//             Languages.of(context)!.kidsLearning,
//             style: mediumTextStyle(
//                 fontSize: isTablet ? 24.0 : 18.0, // iPad ke liye bada font
//                 color: MyColor.black
//             ),
//           ),
//         ],
//       ),
//       centerTitle: true,
//       elevation: 0,
//       toolbarHeight: isTablet ? 80 : null, // iPad ke liye toolbar height increase
//     );
//   }
//
//   Widget _buildBody(BuildContext context) {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.all(5.0),
//         child: ResponsiveGridRow(
//           children: List.generate(topicList.length, (index) {
//             return ResponsiveGridCol(
//               xs: 6,
//               child: Stack(children: [
//                 Padding(
//                   padding: const EdgeInsets.all(5.0),
//                   child: TouchRippleEffect(
//                     borderRadius: BorderRadius.circular(27),
//                     rippleColor: Colors.white,
//                     onTap: () {
//                       final bool isLocked = !unlockChapter && index >= 3;
//                       debugPrint("Amount:- ${ myChildList
//                           ?.data?.subscriptionAmount?.amount
//                           .toString()} ");
//                       if (isLocked) {
//                         Future.delayed(Duration.zero, () {
//                           Navigator.of(context).push(MaterialPageRoute(builder: (context) => KidsLearningPayment(
//                             kidId: "0",
//                               parentId: parentId,
//                               subscriptionAmountId: myChildList
//                                   ?.data?.subscriptionAmount?.id
//                                   .toString() ??
//                                   "",
//                               subscriptionAmount: myChildList
//                                   ?.data?.subscriptionAmount?.amount
//                                   .toString() ??
//                                   ""),)).then((value) {
//                             if (value) {
//                               myChildListApi(false);
//                             }
//                           });
//
//                           // _showLockedDialog(context);
//                         });
//                       } else {
//                         _handleTileTap(context, index);
//                       }
//                     },
//                     child: _buildGridTile(
//                       (index == 2 || index == 4)
//                           ? MyColor.white
//                           : MyColor.black,
//                       topicList[index].img,
//                       topicList[index].title,
//                     ),
//                   ),
//                 ),
//                 (!unlockChapter && index >= 3)
//                     ? GestureDetector(
//                         onTap: () {
//                           print("ldkjshciyudscjkcsd");
//                           debugPrint("Amount 02 :- ${myChildList
//                               ?.data?.subscriptionAmount?.amount
//                               .toString()}");
//                           if (loginType == "parent" ||
//                               loginType == "individual")
//                             Navigator.of(context).push(MaterialPageRoute(builder: (context) => KidsLearningPayment(kidId: "0",
//                                 parentId: parentId,
//                                 subscriptionAmountId: myChildList
//                                     ?.data?.subscriptionAmount?.id
//                                     .toString() ??
//                                     "",
//                                 subscriptionAmount: myChildList
//                                     ?.data?.subscriptionAmount?.amount
//                                     .toString() ??
//                                     ""),)).then((value) {
//                               if (value) {
//                                 myChildListApi(false);
//                               }
//                             });
//
//                           // _showLockedDialog(context);
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.all(5.0),
//                           child: Container(
//                             height: 250,
//                             width: MediaQuery.of(context).size.width * 0.5,
//                             decoration: BoxDecoration(
//                               color: MyColor.grey.withOpacity(0.7),
//                               borderRadius: BorderRadius.circular(25),
//                             ),
//                             child: Icon(Icons.lock,
//                                 size: 65, color: MyColor.deepPurple),
//                           ),
//                         ),
//                       )
//                     : const SizedBox.shrink(),
//               ]),
//             );
//           }),
//         ),
//       ),
//     );
//   }
//
//   comingSoon() {
//     return Center(
//       child: Text(
//         "Coming Soon",
//         style: semiBoldTextStyle(fontSize: 24.0, color: MyColor.appTheme),
//       ),
//     );
//   }
//
//   ///...........................
//   void _showLockedDialog(BuildContext context) {
//     AllDialogs.alertDialog(
//       context,
//       StatefulBuilder(
//         builder: (BuildContext context, StateSetter setState) {
//           return Container(
//             width: MediaQuery.of(context).size.width * 0.9,
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(15),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                   child: Text(
//                     "Unlock Chapters",
//                     style:
//                         mediumTextStyle(fontSize: 18.0, color: MyColor.black),
//                   ),
//                 ),
//                 const Divider(height: 30),
//                 Center(
//                     child: Image.asset(
//                   AssetsPath.notoCoin,
//                   height: 105,
//                   width: 105,
//                 )),
//                 hsized15,
//                 const SizedBox(height: 8),
//                 const SizedBox(height: 12),
//                 Center(
//                   child: Text(
//                     "Amount:  \$${myChildList?.data?.subscriptionAmount?.amount}",
//                     style:
//                         mediumTextStyle(fontSize: 23.0, color: MyColor.black),
//                   ),
//                 ),
//                 Center(
//                   child: Text(
//                     "PURCHASE CHAPTER FOR MYSELF",
//                     style: regularTextStyle(
//                       fontSize: 13.0,
//                       color: MyColor.black,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: MyColor.appTheme,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(31),
//                       ),
//                       padding: const EdgeInsets.symmetric(vertical: 14),
//                     ),
//                     onPressed: () async {
//                       final userId =
//                           await PreferencesServices.getPreferencesData(
//                               PreferencesServices.userId);
//
//                       final String effectiveParentId =
//                           (parentId.isNotEmpty && parentId != "null")
//                               ? parentId
//                               : (userId ?? "");
//
//                       debugPrint(
//                           "parentId: $parentId   →  using: $effectiveParentId");
//                       debugPrint(
//                           "subscriptionId: ${myChildList?.data?.subscriptionAmount?.id}");
//
//                       final result = await Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => WebViewScreen(
//                             type: "purchasePlan",
//                             url: AppUrls.purchasePlanParentURL(
//                               parentId: effectiveParentId,
//                               subscriptionId: myChildList
//                                       ?.data?.subscriptionAmount?.id
//                                       .toString() ??
//                                   "",
//                             ),
//                             title: "Purchase Plan",
//                           ),
//                         ),
//                       );
//
//                       if (result != null && result is Map) {
//                         final bool isSuccess = result['status'] ?? false;
//                         final String message = result['message'] ?? '';
//
//                         showDialog(
//                           barrierDismissible: false,
//                           context: context,
//                           builder: (_) => AlertDialog(
//                             title: Text(isSuccess ? "Success" : "Failed"),
//                             content: Text(message),
//                             actions: [
//                               TextButton(
//                                 onPressed: () => Navigator.pop(context, true),
//                                 child: const Text("OK"),
//                               ),
//                             ],
//                           ),
//                         ).then((value) {
//                           if (value) {
//                             myChildListApi(false);
//                             Navigator.pop(context);
//                           }
//                         });
//                       }
//                     },
//                     child: Text(
//                       "Pay Now",
//                       style:
//                           mediumTextStyle(fontSize: 14.0, color: MyColor.white),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   getProfileDetail() async {
//     await ApiServices.userDetail(context, "", false).then((onValue) {
//       if (mounted) {
//         setState(() {
//           if (onValue.status == true) {
//             if (onValue.data != null) {
//               userDetails = UserIdentityModel.fromJson(onValue.data);
//               unlockChapter = userDetails.isPurchaseSubscription ?? false;
//               // PreferencesServices.setPreferencesData(PreferencesServices.loginType, userDetails.);
//               developer.log(
//                   "onValue.data user-detail>>>>>>>>>${jsonEncode(onValue.data)}");
//               if (userDetails.firstName != null) {
//                 PreferencesServices.setPreferencesData(
//                     PreferencesServices.loginUserIdentityDetails,
//                     userDetails.toJson());
//               }
//             }
//           }
//         });
//       }
//     });
//   }
//
//   Future<void> myChildListApi(bool load) async
//   {
//     ApiConnectorConstants.accessToken =
//         await PreferencesServices.getPreferencesData(
//                 PreferencesServices.userToken) ??
//             "";
//
//     HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
//       HttpLogger(logLevel: LogLevel.BODY),
//     ]);
//     try {
//       final uri =
//           Uri.parse("${ApiPath.baseUrl}${ApiPath.myChildListing}?page=1");
//
//       var response = await http.get(
//         uri,
//         headers: {
//           "Accept": "application/json",
//           "Content-type": "application/json",
//           "Authorization": "Bearer ${ApiConnectorConstants.accessToken}",
//         },
//       );
//       Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
//
//       if (jsonResponse['status'] == true) {
//         myChildList = MyChildListNew.fromJson(jsonResponse);
//
//         log("My Child List Data :- $myChildList");
//
//         /* if (dataMap.containsKey('id')) {
//           print("ID is: ${dataMap['id']}");
//         }
//         if (loginType != "individual")parentId = myChildList?.data?.items?.first.parentId ?? "";*/
//
//         if (myChildList?.data?.items?.isNotEmpty ?? false) {
//           parentId = myChildList?.data?.items?.first.parentId ?? "";
//         }
//         unlockChapter =
//             myChildList?.data?.isParentPurchaseSubscription ?? false;
//         // unlockChapter = true ;
//         // developer.log(convert.jsonEncode(jsonResponse));
//         setState(() {});
//       } else {
//         Utility.customToast(context, jsonResponse['message'].toString());
//       }
//     } catch (error) {
//       print("Error in wishListApi: $error");
//     }
//   }
//
//   void _handleTileTap(BuildContext context, int index) {
//     if (navigateSafetyKic) {
//       if (index == 0) {
//         CustomNavigators.pushNavigate(SafetyKitchenView(), context);
//       } else if (index == 1) {
//         CustomNavigators.pushNavigate(FoodEnergyView(), context);
//       } else if (index == 2) {
//         CustomNavigators.pushNavigate(AllAboutHygieneView(), context);
//       } else if (index == 3) {
//         CustomNavigators.pushNavigate(TheBasicView(), context);
//       } else if (index == 4) {
//         CustomNavigators.pushNavigate(TheSenseView(), context);
//       } else if (index == 5) {
//         CustomNavigators.pushNavigate(AboutVegetableView(), context);
//       } else if (index == 6) {
//         CustomNavigators.pushNavigate(AboutFruitView(), context);
//       } else if (index == 7) {
//         CustomNavigators.pushNavigate(AboutHoneyBeesView(), context);
//       } else if (index == 8) {
//         CustomNavigators.pushNavigate(AboutNutsView(), context);
//       } else if (index == 9) {
//         CustomNavigators.pushNavigate(CelebrationsView(), context);
//       }
//
//       celebrationCurrentPage = 0;
//       honeyCurrentPage = 0;
//       vegetableCurrentPage = 0;
//       eventCurrentPage = 0;
//       basicCurrentPage = 0;
//       hygieneCurrentPage = 0;
//       currentPage = 0;
//       currentIndex = 0;
//       setState(() {});
//     }
//   }
//
//   Widget _buildGridTile(Color color, String imagePath, String title) {
//     return Stack(
//       children: [
//         Container(
//           width: MediaQuery.of(context).size.width * 0.5,
//           height: 250,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(30),
//           ),
//           child: Image.asset(imagePath, fit: BoxFit.cover),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Text(title,
//               style: regularTextStyle(fontSize: 16.0, color: color)),
//         ),
//       ],
//     );
//   }
// }
//
// class KidsLearningModel {
//   String title;
//   String img;
//
//   KidsLearningModel(this.title, this.img);
// }

import 'dart:developer';

import 'package:cooking_champs/constant/apiConnectorConstants.dart';
import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/constant/stringfile.dart/language.dart';
import 'package:cooking_champs/model/dynamic_models/my_child_list_new.dart';
import 'package:cooking_champs/model/dynamic_models/user_identity_model.dart';
import 'package:cooking_champs/new_ui/web_view_screen.dart';
import 'package:cooking_champs/services/api_path.dart';
import 'package:cooking_champs/services/api_services.dart';
import 'package:cooking_champs/services/user_prefences.dart';
import 'package:cooking_champs/utils/all_dialogs.dart';
import 'package:cooking_champs/utils/navigators.dart';
import 'package:cooking_champs/utils/utility.dart';
import 'package:cooking_champs/views/kids_learning/about_fruit/about_fruit_view.dart';
import 'package:cooking_champs/views/kids_learning/about_honeybees/about_honeybees_view.dart';
import 'package:cooking_champs/views/kids_learning/about_nuts/nuts_about_nuts_view.dart';
import 'package:cooking_champs/views/kids_learning/all_about_vegetables/about_vegetable_view.dart';
import 'package:cooking_champs/views/kids_learning/celebrations/celebrations_view.dart';
import 'package:cooking_champs/views/kids_learning/food_energy/food_energy_view.dart';
import 'package:cooking_champs/views/kids_learning/hygiene/hygine_view.dart';
import 'package:cooking_champs/views/kids_learning/payment/kids_learning_payment.dart';
import 'package:cooking_champs/views/kids_learning/safety_kitchen_chapter/safty_kitchen_view.dart';
import 'package:cooking_champs/views/kids_learning/the_basic/the_basic_view.dart';
import 'package:cooking_champs/views/kids_learning/the_sense/the_sense_view.dart';
import 'package:flutter/material.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';
import 'dart:convert' as convert;
import 'dart:developer' as developer;
import '../dashboard.dart';
import 'dart:convert';

class KidsLearningView extends StatefulWidget {
  final String type;

  const KidsLearningView({super.key, required this.type});

  @override
  State<KidsLearningView> createState() => _KidsLearningViewState();
}

class _KidsLearningViewState extends State<KidsLearningView> {
  bool navigateSafetyKic = false;
  UserIdentityModel userDetails = UserIdentityModel();
  String parentId = "";
  bool unlockChapter = false;
  String loginType = "";

  List<KidsLearningModel> topicList = [];
  MyChildListNew? myChildList;
  Items? selectedChildObj;

  String base64EncodeString(String input) {
    return base64Encode(utf8.encode(input));
  }

  @override
  void initState() {
    loadLoginType();
    super.initState();
    navigateSafetyKic = true;
    Future.delayed(Duration.zero, () {
      if (loginType == "parent" || loginType == "individual") {
        myChildListApi(false);
      } else {
        getProfileDetail();
      }
    });
  }

  void loadLoginType() async {
    loginType = await PreferencesServices.getPreferencesData(
        PreferencesServices.loginType);
    loginType = loginType;
    print("isLogin: $loginType");
  }

  setKidsLearning() {
    setState(() {
      topicList = [
        KidsLearningModel("SAFETY IN THE KITCHEN", AssetsPath.safety),
        KidsLearningModel("FOOD IS ENERGY", AssetsPath.food),
        KidsLearningModel("ALL ABOUT HYGIENE", AssetsPath.allAboutHygiene),
        KidsLearningModel("THE BASIC", AssetsPath.theBasic),
        KidsLearningModel("THE SENSES", AssetsPath.theSenses),
        KidsLearningModel("ALL ABOUT VEGETABLES", AssetsPath.allAboutVegetables),
        KidsLearningModel("ALL ABOUT FRUITS", AssetsPath.allAboutFruits),
        KidsLearningModel("HONEYBEES & HONEY", AssetsPath.honeybees),
        KidsLearningModel("NUTS ABOUT NUTS", AssetsPath.nuts),
        KidsLearningModel("CELEBRATION", AssetsPath.celebration),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isIpad = MediaQuery.of(context).size.width > 600;

    print("unlockChapter$unlockChapter");
    print("widget.type :- ${widget.type}");
    setKidsLearning();
    return WillPopScope(
      onWillPop: () async {
        setState(() {
          tabCheck = "";
          pageIndex = 0;
        });
        return true;
      },
      child: Scaffold(
        appBar: widget.type == "Dash" ? null : _buildAppBar(context, isIpad),
        body: _buildBody(context, isIpad),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, bool isIpad) {
    return AppBar(
      leadingWidth: isIpad ? 80.0 : 0,
      automaticallyImplyLeading: false,
      backgroundColor: MyColor.yellowF6F1E1,
      surfaceTintColor: MyColor.yellowF6F1E1,
      title: Row(
        children: [
          InkWell(
            radius: isIpad ? 100.0 : 80.0,
            borderRadius: BorderRadius.circular(isIpad ? 40.0 : 30.0),
            onTap: () {
              if (widget.type == "Food Activity" || widget.type == "Hygiene") {
                setState(() {
                  pageIndex = 0;
                  tabCheck = "";
                  isTabExplore = false;
                });
                CustomNavigators.pushRemoveUntil(
                    DashBoardView(
                      pageIndex: 0,
                    ),
                    context);
              } else {
                setState(() {
                  pageIndex = 0;
                  tabCheck = "";
                  isTabExplore = false;
                });
              }
            },
            child: Padding(
              padding: EdgeInsets.only(
                  left: isIpad ? 10.0 : 5.0,
                  right: isIpad ? 30.0 : 10.0
              ),
              child: Icon(
                Icons.arrow_back_ios,
                size: isIpad ? 36.0 : 28.0,
                color: Colors.black,
              ),
            ),
          ),
          Text(
            Languages.of(context)!.kidsLearning,
            style: mediumTextStyle(
                fontSize: isIpad ? 24.0 : 18.0,
                color: MyColor.black
            ),
          ),
        ],
      ),
      centerTitle: true,
      elevation: 0,
      toolbarHeight: isIpad ? 90.0 : null,
    );
  }

  Widget _buildBody(BuildContext context, bool isIpad) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(isIpad ? 10.0 : 5.0),
        child: ResponsiveGridRow(
          children: List.generate(topicList.length, (index) {
            return ResponsiveGridCol(
              xs: isIpad ? 4 : 6, // iPad: 3 columns, Mobile: 2 columns
              child: Stack(children: [
                Padding(
                  padding: EdgeInsets.all(isIpad ? 10.0 : 5.0),
                  child: TouchRippleEffect(
                    borderRadius: BorderRadius.circular(isIpad ? 35.0 : 27.0),
                    rippleColor: Colors.white,
                    onTap: () {
                      final bool isLocked = !unlockChapter && index >= 3;
                      debugPrint("Amount:- ${myChildList
                          ?.data?.subscriptionAmount?.amount
                          .toString()} ");
                      if (isLocked) {
                        Future.delayed(Duration.zero, () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => KidsLearningPayment(
                              kidId: "0",
                              parentId: parentId,
                              subscriptionAmountId: myChildList
                                  ?.data?.subscriptionAmount?.id
                                  .toString() ??
                                  "",
                              subscriptionAmount: myChildList
                                  ?.data?.subscriptionAmount?.amount
                                  .toString() ??
                                  ""),)).then((value) {
                            if (value) {
                              myChildListApi(false);
                            }
                          });
                        });
                      } else {
                        _handleTileTap(context, index);
                      }
                    },
                    child: _buildGridTile(
                      context,
                      (index == 2 || index == 4)
                          ? MyColor.white
                          : MyColor.black,
                      topicList[index].img,
                      topicList[index].title,
                      isIpad,
                    ),
                  ),
                ),
                (!unlockChapter && index >= 3)
                    ? GestureDetector(
                  onTap: () {
                    debugPrint("Amount 02 :- ${myChildList
                        ?.data?.subscriptionAmount?.amount
                        .toString()}");
                    if (loginType == "parent" || loginType == "individual")
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => KidsLearningPayment(
                          kidId: "0",
                          parentId: parentId,
                          subscriptionAmountId: myChildList
                              ?.data?.subscriptionAmount?.id
                              .toString() ??
                              "",
                          subscriptionAmount: myChildList
                              ?.data?.subscriptionAmount?.amount
                              .toString() ??
                              ""),)).then((value) {
                        if (value) {
                          myChildListApi(false);
                        }
                      });
                  },
                  child: Padding(
                    padding: EdgeInsets.all(isIpad ? 10.0 : 5.0),
                    child: Container(
                      height: isIpad ? 350.0 : 250.0,
                      width: MediaQuery.of(context).size.width * (isIpad ? 0.32 : 0.5),
                      decoration: BoxDecoration(
                        color: MyColor.grey.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(isIpad ? 30.0 : 25.0),
                      ),
                      child: Icon(
                          Icons.lock,
                          size: isIpad ? 80.0 : 65.0,
                          color: MyColor.deepPurple
                      ),
                    ),
                  ),
                )
                    : const SizedBox.shrink(),
              ]),
            );
          }),
        ),
      ),
    );
  }

  comingSoon() {
    return Center(
      child: Text(
        "Coming Soon",
        style: semiBoldTextStyle(fontSize: 24.0, color: MyColor.appTheme),
      ),
    );
  }

  ///...........................
  void _showLockedDialog(BuildContext context) {
    final bool isIpad = MediaQuery.of(context).size.width > 600;

    AllDialogs.alertDialog(
      context,
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            width: MediaQuery.of(context).size.width * (isIpad ? 0.6 : 0.9),
            padding: EdgeInsets.all(isIpad ? 30.0 : 20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(isIpad ? 20.0 : 15.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Unlock Chapters",
                    style: mediumTextStyle(
                        fontSize: isIpad ? 24.0 : 18.0,
                        color: MyColor.black
                    ),
                  ),
                ),
                SizedBox(height: isIpad ? 30.0 : 15.0),
                const Divider(height: 30),
                Center(
                  child: Image.asset(
                    AssetsPath.notoCoin,
                    height: isIpad ? 140.0 : 105.0,
                    width: isIpad ? 140.0 : 105.0,
                  ),
                ),
                SizedBox(height: isIpad ? 20.0 : 15.0),
                Center(
                  child: Text(
                    "Amount:  \$${myChildList?.data?.subscriptionAmount?.amount}",
                    style: mediumTextStyle(
                        fontSize: isIpad ? 28.0 : 23.0,
                        color: MyColor.black
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "PURCHASE CHAPTER FOR MYSELF",
                    style: regularTextStyle(
                      fontSize: isIpad ? 16.0 : 13.0,
                      color: MyColor.black,
                    ),
                  ),
                ),
                SizedBox(height: isIpad ? 25.0 : 20.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColor.appTheme,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(isIpad ? 35.0 : 31.0),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: isIpad ? 18.0 : 14.0
                      ),
                    ),
                    onPressed: () async {
                      final userId =
                      await PreferencesServices.getPreferencesData(
                          PreferencesServices.userId);

                      final String effectiveParentId =
                      (parentId.isNotEmpty && parentId != "null")
                          ? parentId
                          : (userId ?? "");

                      debugPrint(
                          "parentId: $parentId   →  using: $effectiveParentId");
                      debugPrint(
                          "subscriptionId: ${myChildList?.data?.subscriptionAmount?.id}");

                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WebViewScreen(
                            type: "purchasePlan",
                            url: AppUrls.purchasePlanParentURL(
                              parentId: effectiveParentId,
                              subscriptionId: myChildList
                                  ?.data?.subscriptionAmount?.id
                                  .toString() ??
                                  "",
                            ),
                            title: "Purchase Plan",
                          ),
                        ),
                      );

                      if (result != null && result is Map) {
                        final bool isSuccess = result['status'] ?? false;
                        final String message = result['message'] ?? '';

                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text(isSuccess ? "Success" : "Failed"),
                            content: Text(message),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text("OK"),
                              ),
                            ],
                          ),
                        ).then((value) {
                          if (value) {
                            myChildListApi(false);
                            Navigator.pop(context);
                          }
                        });
                      }
                    },
                    child: Text(
                      "Pay Now",
                      style: mediumTextStyle(
                          fontSize: isIpad ? 18.0 : 14.0,
                          color: MyColor.white
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  getProfileDetail() async {
    await ApiServices.userDetail(context, "", false).then((onValue) {
      if (mounted) {
        setState(() {
          if (onValue.status == true) {
            if (onValue.data != null) {
              userDetails = UserIdentityModel.fromJson(onValue.data);
              unlockChapter = userDetails.isPurchaseSubscription ?? false;
              developer.log(
                  "onValue.data user-detail>>>>>>>>>${jsonEncode(onValue.data)}");
              if (userDetails.firstName != null) {
                PreferencesServices.setPreferencesData(
                    PreferencesServices.loginUserIdentityDetails,
                    userDetails.toJson());
              }
            }
          }
        });
      }
    });
  }

  Future<void> myChildListApi(bool load) async
  {
    ApiConnectorConstants.accessToken =
        await PreferencesServices.getPreferencesData(
            PreferencesServices.userToken) ??
            "";

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    try {
      final uri =
      Uri.parse("${ApiPath.baseUrl}${ApiPath.myChildListing}?page=1");

      var response = await http.get(
        uri,
        headers: {
          "Accept": "application/json",
          "Content-type": "application/json",
          "Authorization": "Bearer ${ApiConnectorConstants.accessToken}",
        },
      );
      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);

      if (jsonResponse['status'] == true) {
        myChildList = MyChildListNew.fromJson(jsonResponse);

        log("My Child List Data :- $myChildList");

        if (myChildList?.data?.items?.isNotEmpty ?? false) {
          parentId = myChildList?.data?.items?.first.parentId ?? "";
        }
        unlockChapter =
            myChildList?.data?.isParentPurchaseSubscription ?? false;
        setState(() {});
      } else {
        Utility.customToast(context, jsonResponse['message'].toString());
      }
    } catch (error) {
      print("Error in wishListApi: $error");
    }
  }

  void _handleTileTap(BuildContext context, int index) {
    if (navigateSafetyKic) {
      if (index == 0) {
        CustomNavigators.pushNavigate(SafetyKitchenView(), context);
      } else if (index == 1) {
        CustomNavigators.pushNavigate(FoodEnergyView(), context);
      } else if (index == 2) {
        CustomNavigators.pushNavigate(AllAboutHygieneView(), context);
      } else if (index == 3) {
        CustomNavigators.pushNavigate(TheBasicView(), context);
      } else if (index == 4) {
        CustomNavigators.pushNavigate(TheSenseView(), context);
      } else if (index == 5) {
        CustomNavigators.pushNavigate(AboutVegetableView(), context);
      } else if (index == 6) {
        CustomNavigators.pushNavigate(AboutFruitView(), context);
      } else if (index == 7) {
        CustomNavigators.pushNavigate(AboutHoneyBeesView(), context);
      } else if (index == 8) {
        CustomNavigators.pushNavigate(AboutNutsView(), context);
      } else if (index == 9) {
        CustomNavigators.pushNavigate(CelebrationsView(), context);
      }

      celebrationCurrentPage = 0;
      honeyCurrentPage = 0;
      vegetableCurrentPage = 0;
      eventCurrentPage = 0;
      basicCurrentPage = 0;
      hygieneCurrentPage = 0;
      currentPage = 0;
      currentIndex = 0;
      setState(() {});
    }
  }

  Widget _buildGridTile(BuildContext context, Color color, String imagePath, String title, bool isIpad) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * (isIpad ? 0.32 : 0.5),
          height: isIpad ? 350.0 : 250.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(isIpad ? 35.0 : 30.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(isIpad ? 35.0 : 30.0),
            child: Image.asset(
                imagePath,
                fit: BoxFit.cover
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(isIpad ? 20.0 : 15.0),
          child: Text(
            title,
            style: regularTextStyle(
                fontSize: isIpad ? 18.0 : 16.0,
                color: color
            ),
          ),
        ),
      ],
    );
  }
}

class KidsLearningModel {
  String title;
  String img;

  KidsLearningModel(this.title, this.img);
}