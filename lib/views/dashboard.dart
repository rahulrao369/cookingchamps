// import 'dart:convert';
// import 'dart:io';
//
// import 'package:cooking_champs/constant/assets_path.dart';
// import 'package:cooking_champs/constant/my_color.dart';
// import 'package:cooking_champs/constant/my_fonts_style.dart';
// import 'package:cooking_champs/constant/stringfile.dart/language.dart';
// import 'package:cooking_champs/model/dynamic_models/user_identity_model.dart';
// import 'package:cooking_champs/services/api_path.dart';
// import 'package:cooking_champs/services/api_services.dart';
// import 'package:cooking_champs/services/user_prefences.dart';
// import 'package:cooking_champs/utils/all_dialogs.dart';
// import 'package:cooking_champs/utils/navigators.dart';
// import 'package:cooking_champs/utils/ui_utils.dart';
// import 'package:cooking_champs/views/aboutUs/aboutus_view.dart';
// import 'package:cooking_champs/views/home.dart';
// import 'package:cooking_champs/views/kids_learning/kids_learning_view.dart';
// import 'package:cooking_champs/views/menu/menu_view.dart';
// import 'package:cooking_champs/views/notication_view.dart';
// import 'package:cooking_champs/views/recipe/recipe_list_view.dart';
// import 'package:cooking_champs/views/story/memories_view.dart';
// import 'package:cooking_champs/widgets/exit_popup.dart';
// import 'package:cooking_champs/widgets/view_full_image.dart';
// import 'package:flutter/material.dart';
// import 'package:touch_ripple_effect/touch_ripple_effect.dart';
//
// class DashBoardView extends StatefulWidget {
//   final int? pageIndex;
//   // final String? tabCheck;
//
//   const DashBoardView({
//     super.key,
//     this.pageIndex,
//     // this.tabCheck
//   });
//
//   @override
//   State<DashBoardView> createState() => _DashBoardViewState();
// }
//
// bool? isTabExplore = false;
// int pageIndex = 0;
// String? tabCheck;
//
// class _DashBoardViewState extends State<DashBoardView> {
//   UserIdentityModel userDetails = UserIdentityModel();
//   String userResponse = "";
//   bool isBusy = false;
//   // pages count & variable assign >>>>>>>>>
//
//   var pages = [
//     const HomeView(),
//
//     RecipeListView(pageType: 'dash'),
//
//     //  const RecipeView(),
//     KidsLearningView(type: 'Dash',),
//
//     const MemoriesView(isAppbar: false,),
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     if (widget.pageIndex != null) {
//       pageIndex = widget.pageIndex!;
//     }
//
//     Future.delayed(Duration.zero, () async {
//       await getProfileDetail();
//       final userId = await PreferencesServices.getPreferencesData(
//           PreferencesServices.userId);
//
//       print("userId...>$userId");
//     });
//   }
//
//   void getUserData() async {
//     var data = await PreferencesServices.getPreferencesData(
//         PreferencesServices.loginUserIdentityDetails);
//     if (data != null) {
//       Map<String, dynamic> jsonResponse = await jsonDecode(data);
//       userDetails = UserIdentityModel.fromJson(jsonResponse);
//     }
//     if (mounted) {
//       setState(() {});
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     getUserData();
//     return PopScope(
//       canPop: false,
//       onPopInvoked: (pop) async {
//         //  onWillPop: () async {
//         AllDialogs.customDialog(
//             context,
//             DeleteAdsImageAlertDialog(
//               title: Languages.of(context)!.areYouSureYouWantToExitApp,
//             ));
//         return;
//       },
//       child: SafeArea(
//         top: false,
//         child: Scaffold(
//             appBar: PreferredSize(
//                 preferredSize: Size.zero,
//                 child: AppBar(
//                   surfaceTintColor: Colors.transparent,
//                   backgroundColor:
//                       pageIndex == 0 ? MyColor.appTheme : MyColor.yellowF6F1E1,
//                 )),
//             bottomNavigationBar: buildMyNavBar(context),
//             body: Column(
//               children: [
//                 // pageIndex == 3 || widget.tabCheck == "kids" ||  widget.tabCheck == "OurStories" ||  widget.tabCheck == "Aboutus"? SizedBox.shrink():
//                 pageIndex == 4 || tabCheck == "kids" || tabCheck == "Aboutus"
//                     ? SizedBox.shrink()
//                     : pageIndex != 0
//                         ? Container(
//                             padding: EdgeInsets.only(
//                                 left: 20, right: 20, top: 5, bottom: 5),
//                             decoration: BoxDecoration(
//                                 color: pageIndex == 0
//                                     ? MyColor.appTheme
//                                     : MyColor.yellowF6F1E1),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Expanded(
//                                   child: Row(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       children: [
//                                         InkWell(
//                                           onTap: () {
//                                             AllDialogs.customDialog(
//                                                 context,
//                                                 ViewFullImage(
//                                                     image:
//                                                         userDetails.image != null
//                                                             ? userDetails.image
//                                                                 .toString()
//                                                             : ""));
//                                             //userDetails.role == RegisterType.roleKids.value?null:   CustomNavigators.pushNavigate(EditProfileView(onUpdate:(){}), context);
//                                           },
//                                           child: Padding(
//                                             padding:
//                                                 const EdgeInsets.only(bottom: 5),
//                                             child: ClipRRect(
//                                                 borderRadius:
//                                                     BorderRadius.circular(500),
//                                                 child: UiUtils.networkProfile(
//                                                     60,
//                                                     60,
//                                                     userDetails.image != null
//                                                         ? ApiPath.imageBaseUrl +
//                                                             userDetails.image
//                                                                 .toString()
//                                                         : "")),
//                                           ),
//                                         ),
//                                         Expanded(
//                                           child: Padding(
//                                             padding:
//                                                 EdgeInsets.only(top: 0, left: 10),
//                                             child: Column(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.start,
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Text(
//                                                     "${Languages.of(context)!.hey}, ${userDetails.name ?? ""}",
//                                                     maxLines: 2,
//                                                     style: semiBoldTextStyle(
//                                                         fontSize: 17.0,
//                                                         color: pageIndex == 0
//                                                             ? MyColor.white
//                                                             : MyColor.appTheme)),
//                                                 Text(
//                                                     "${Languages.of(context)!.welcomeBack}!",
//                                                     style: regularTextStyle(
//                                                         fontSize: 16.0,
//                                                         color: pageIndex == 0
//                                                             ? MyColor.white
//                                                             : MyColor.black)),
//                                                 SizedBox(
//                                                   width: 10,
//                                                 )
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ]),
//                                 ),
//                                 pageIndex == 0
//                                     ? TouchRippleEffect(
//                                         borderRadius: BorderRadius.circular(27),
//                                         rippleColor: Colors.white,
//                                         onTap: () {
//                                           CustomNavigators.pushNavigate(
//                                               NotificationView(), context);
//                                         },
//                                         child: CircleAvatar(
//                                           backgroundColor: MyColor.dividerYellow,
//                                           radius: 25,
//                                           child: Center(
//                                             child: Image.asset(
//                                                 height: 42,
//                                                 AssetsPath.bell1png,
//                                                 color: MyColor.appTheme),
//                                           ),
//                                         ),
//                                       )
//                                     : TouchRippleEffect(
//                                         borderRadius: BorderRadius.circular(27),
//                                         rippleColor: Colors.white,
//                                         onTap: () {
//                                           CustomNavigators.pushNavigate(
//                                               NotificationView(), context);
//                                         },
//                                         child: Padding(
//                                           padding:
//                                               const EdgeInsets.only(right: 15.0),
//                                           child: Image.asset(
//                                               height: 42, AssetsPath.bellpng),
//                                         ),
//                                       )
//                               ],
//                             ),
//                           )
//                         : SizedBox.shrink(),
//                 Expanded(child: _getPage())
//               ],
//             ),
//             floatingActionButtonLocation:
//                 FloatingActionButtonLocation.centerDocked,
//             floatingActionButton: InkWell(
//               onTap: () {
//                 setState(() {
//                   pageIndex = 2;
//                   isTabExplore = false;
//                   tabCheck = "";
//                 });
//               },
//               child: Container(
//                 height: 57,
//                 width: 57,
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                     color: MyColor.appTheme, shape: BoxShape.circle),
//                 child: Image.asset(AssetsPath.kidsLearning,
//                     color: MyColor.white, height: 28, width: 28),
//               ),
//             )),
//       ),
//     );
//   }
//
//   Widget _getPage() {
//     if (isTabExplore!) {
//       switch (tabCheck) {
//         case "kids":
//           return KidsLearningView(
//             type: '',
//           );
//         case "OurStories":
//           return const MemoriesView(
//             isAppbar: false,
//           );
//         case "Aboutus":
//           return const AboutUsView();
//         default:
//           return pages[pageIndex];
//       }
//     } else {
//       return pageIndex == 4 ? pages[2] : pages[pageIndex];
//     }
//   }
//
//   Container buildMyNavBar(BuildContext context) {
//     return Container(
//       color: MyColor.white.withOpacity(0.60),
//       height: Platform.isAndroid ? 75 : 85,
//       child: BottomAppBar(
//         shape: const CircularNotchedRectangle(),
//         notchMargin: 8,
//         color: MyColor.liteYellowBottom,
//         child: Container(
//           // height:Platform.isAndroid? 75: 80,
//           decoration: const BoxDecoration(
//             // color: MyColor.liteYellowBottom,
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(20),
//               topRight: Radius.circular(20),
//             ),
//           ),
//           child: Wrap(
//             // mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(
//                     top: 1.0, bottom: Platform.isAndroid ? 10 : 12),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     menuItem(Languages.of(context)!.home, AssetsPath.homepng,
//                         onTapTab1, 0),
//                     menuItem(Languages.of(context)!.recipes,
//                         AssetsPath.recipepng, onTapTab1, 1),
//                     menuItem("", AssetsPath.savepng, onTapTab1, 2),
//                     menuItem(Languages.of(context)!.memories,
//                         AssetsPath.ourStories, onTapTab1, 3),
//                     menuItem(Languages.of(context)!.menu, AssetsPath.menu,
//                         onTapTab1, 4),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   menuItem(String title, String img, GestureTapCallback onTap, int index) {
//     return SizedBox(
//       height: 50,
//       child: Column(
//         children: [
//           Row(
//             children: [
//               InkWell(
//                 child: InkWell(
//                   radius: 200,
//                   borderRadius: BorderRadius.circular(100),
//                   // customBorder: const CircleBorder(),
//                   onTap: () {
//                     if (index == 4) {
//                       AllDialogs.globalBottomSheet(context, MenuView(), () {});
//                     } else {
//                       setState(() {
//                         pageIndex = index;
//                         isTabExplore = false;
//                         tabCheck = "";
//                       });
//                     }
//                   },
//                   child: SizedBox(
//                     height: 50,
//                     // width: 80,
//                     child: Column(
//                       children: [
//                         Image.asset(
//                           img,
//                           color: pageIndex == index
//                               ? MyColor.appTheme
//                               : MyColor.bottomIconColor,
//                           height: index == 2 ? 0 : 28,
//                         ),
//                         const SizedBox(
//                           height: 2,
//                         ),
//                         Text(title,
//                             style: semiBoldTextStyle(
//                                 fontSize: 11.0,
//                                 color: pageIndex == index
//                                     ? MyColor.appTheme
//                                     : MyColor.bottomIconColor))
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   void onTapTab1() {
//     setState(() {
//       pageIndex = 0;
//       isTabExplore = false;
//       tabCheck = "";
//     });
//   }
//
//   getProfileDetail() async {
//     if (!isBusy) {
//       if (mounted) {
//         setState(() {
//           isBusy = true;
//         });
//       }
//       await ApiServices.userDetail(context, "", false).then((onValue) {
//         if (mounted) {
//           setState(() {
//             if (onValue.status == true) {
//               if (onValue.data != null) {
//                 userDetails = UserIdentityModel.fromJson(onValue.data);
//                 if (userDetails.firstName != null) {
//                   getUserData();
//                 }
//               }
//             }
//           });
//         }
//       });
//
//       if (mounted) {
//         setState(() {
//           isBusy = false;
//         });
//       }
//     }
//   }
//
//   onExit() {
//     exit(0);
//   }
// }

import 'dart:convert';
import 'dart:io';

import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/stringfile.dart/language.dart';
import 'package:cooking_champs/model/dynamic_models/user_identity_model.dart';
import 'package:cooking_champs/services/api_path.dart';
import 'package:cooking_champs/services/api_services.dart';
import 'package:cooking_champs/services/user_prefences.dart';
import 'package:cooking_champs/utils/all_dialogs.dart';
import 'package:cooking_champs/utils/navigators.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:cooking_champs/views/aboutUs/aboutus_view.dart';
import 'package:cooking_champs/views/home.dart';
import 'package:cooking_champs/views/kids_learning/kids_learning_view.dart';
import 'package:cooking_champs/views/menu/menu_view.dart';
import 'package:cooking_champs/views/notication_view.dart';
import 'package:cooking_champs/views/recipe/recipe_list_view.dart';
import 'package:cooking_champs/views/story/memories_view.dart';
import 'package:cooking_champs/widgets/exit_popup.dart';
import 'package:cooking_champs/widgets/view_full_image.dart';
import 'package:flutter/material.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';

class DashBoardView extends StatefulWidget {
  final int? pageIndex;

  const DashBoardView({
    super.key,
    this.pageIndex,
  });

  @override
  State<DashBoardView> createState() => _DashBoardViewState();
}

bool? isTabExplore = false;
int pageIndex = 0;
String? tabCheck;

class _DashBoardViewState extends State<DashBoardView> {
  UserIdentityModel userDetails = UserIdentityModel();
  String userResponse = "";
  bool isBusy = false;

  // pages count & variable assign >>>>>>>>>
  var pages = [
    const HomeView(),
    RecipeListView(pageType: 'dash'),
    KidsLearningView(type: 'Dash'),
    const MemoriesView(isAppbar: false),
  ];

  @override
  void initState() {
    super.initState();
    if (widget.pageIndex != null) {
      pageIndex = widget.pageIndex!;
    }

    Future.delayed(Duration.zero, () async {
      await getProfileDetail();
      final userId = await PreferencesServices.getPreferencesData(
          PreferencesServices.userId);
      print("userId...>$userId");
    });
  }

  void getUserData() async {
    var data = await PreferencesServices.getPreferencesData(
        PreferencesServices.loginUserIdentityDetails);
    if (data != null) {
      Map<String, dynamic> jsonResponse = await jsonDecode(data);
      userDetails = UserIdentityModel.fromJson(jsonResponse);
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isIpad = MediaQuery.of(context).size.width > 600;

    getUserData();
    var size = MediaQuery.of(context).size;

    return PopScope(
      canPop: false,
      onPopInvoked: (pop) async {
        AllDialogs.customDialog(
            context,
            DeleteAdsImageAlertDialog(
              title: Languages.of(context)!.areYouSureYouWantToExitApp,
            ));
        return;
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.zero,
                child: AppBar(
                  surfaceTintColor: Colors.transparent,
                  backgroundColor: pageIndex == 0 ? MyColor.appTheme : MyColor.yellowF6F1E1,
                )
            ),
            bottomNavigationBar: buildMyNavBar(context, isIpad),
            body: Column(
              children: [
                pageIndex == 4 || tabCheck == "kids" || tabCheck == "Aboutus"
                    ? SizedBox.shrink()
                    : pageIndex != 0
                    ? Container(
                  padding: EdgeInsets.only(
                      left: isIpad ? 30.0 : 20.0,
                      right: isIpad ? 30.0 : 20.0,
                      top: isIpad ? 15.0 : 5.0,
                      bottom: isIpad ? 15.0 : 5.0
                  ),
                  decoration: BoxDecoration(
                      color: pageIndex == 0
                          ? MyColor.appTheme
                          : MyColor.yellowF6F1E1
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  AllDialogs.customDialog(
                                      context,
                                      ViewFullImage(
                                          image: userDetails.image != null
                                              ? userDetails.image.toString()
                                              : ""
                                      )
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: isIpad ? 10.0 : 5.0),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(500),
                                      child: UiUtils.networkProfile(
                                          isIpad ? 80.0 : 60.0,
                                          isIpad ? 80.0 : 60.0,
                                          userDetails.image != null
                                              ? ApiPath.imageBaseUrl + userDetails.image.toString()
                                              : ""
                                      )
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 0,
                                      left: isIpad ? 20.0 : 10.0
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "${Languages.of(context)!.hey}, ${userDetails.name ?? ""}",
                                          maxLines: 2,
                                          style: semiBoldTextStyle(
                                              fontSize: isIpad ? 22.0 : 17.0,
                                              color: pageIndex == 0
                                                  ? MyColor.white
                                                  : MyColor.appTheme
                                          )
                                      ),
                                      SizedBox(height: isIpad ? 5.0 : 2.0),
                                      Text(
                                          "${Languages.of(context)!.welcomeBack}!",
                                          style: regularTextStyle(
                                              fontSize: isIpad ? 20.0 : 16.0,
                                              color: pageIndex == 0
                                                  ? MyColor.white
                                                  : MyColor.black
                                          )
                                      ),
                                      SizedBox(width: 10)
                                    ],
                                  ),
                                ),
                              ),
                            ]
                        ),
                      ),
                      pageIndex == 0
                          ? TouchRippleEffect(
                        borderRadius: BorderRadius.circular(isIpad ? 35.0 : 27.0),
                        rippleColor: Colors.white,
                        onTap: () {
                          CustomNavigators.pushNavigate(NotificationView(), context);
                        },
                        child: CircleAvatar(
                          backgroundColor: MyColor.dividerYellow,
                          radius: isIpad ? 30.0 : 25.0,
                          child: Center(
                            child: Image.asset(
                                AssetsPath.bell1png,
                                height: isIpad ? 52.0 : 42.0,
                                color: MyColor.appTheme
                            ),
                          ),
                        ),
                      )
                          : TouchRippleEffect(
                        borderRadius: BorderRadius.circular(isIpad ? 35.0 : 27.0),
                        rippleColor: Colors.white,
                        onTap: () {
                          CustomNavigators.pushNavigate(NotificationView(), context);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: isIpad ? 20.0 : 15.0),
                          child: Image.asset(
                              AssetsPath.bellpng,
                              height: isIpad ? 52.0 : 42.0
                          ),
                        ),
                      )
                    ],
                  ),
                )
                    : SizedBox.shrink(),
                Expanded(child: _getPage())
              ],
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: InkWell(
              onTap: () {
                setState(() {
                  pageIndex = 2;
                  isTabExplore = false;
                  tabCheck = "";
                });
              },
              child: Container(
                height: isIpad ? 75.0 : 57.0,
                width: isIpad ? 75.0 : 57.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: MyColor.appTheme,
                    shape: BoxShape.circle
                ),
                child: Image.asset(
                    AssetsPath.kidsLearning,
                    color: MyColor.white,
                    height: isIpad ? 35.0 : 28.0,
                    width: isIpad ? 35.0 : 28.0
                ),
              ),
            )
        ),
      ),
    );
  }

  Widget _getPage() {
    if (isTabExplore!) {
      switch (tabCheck) {
        case "kids":
          return KidsLearningView(type: '');
        case "OurStories":
          return const MemoriesView(isAppbar: false);
        case "Aboutus":
          return const AboutUsView();
        default:
          return pages[pageIndex];
      }
    } else {
      return pageIndex == 4 ? pages[2] : pages[pageIndex];
    }
  }

  Container buildMyNavBar(BuildContext context, bool isIpad) {
    return Container(
      color: MyColor.white.withOpacity(0.60),
      height: isIpad ? 110.0 : (Platform.isAndroid ? 75 : 85),
      child: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: isIpad ? 12.0 : 8.0,
        color: MyColor.liteYellowBottom,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Wrap(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: 1.0,
                    bottom: isIpad ? 15.0 : (Platform.isAndroid ? 10 : 12)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    menuItem(Languages.of(context)!.home, AssetsPath.homepng, onTapTab1, 0, isIpad),
                    menuItem(Languages.of(context)!.recipes, AssetsPath.recipepng, onTapTab1, 1, isIpad),
                    menuItem("", AssetsPath.savepng, onTapTab1, 2, isIpad),
                    menuItem(Languages.of(context)!.memories, AssetsPath.ourStories, onTapTab1, 3, isIpad),
                    menuItem(Languages.of(context)!.menu, AssetsPath.menu, onTapTab1, 4, isIpad),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget menuItem(String title, String img, GestureTapCallback onTap, int index, bool isIpad) {
    return SizedBox(
      height: isIpad ? 65.0 : 50.0,
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                radius: isIpad ? 250.0 : 200.0,
                borderRadius: BorderRadius.circular(100),
                onTap: () {
                  if (index == 4) {
                    AllDialogs.globalBottomSheet(context, MenuView(), () {});
                  } else {
                    setState(() {
                      pageIndex = index;
                      isTabExplore = false;
                      tabCheck = "";
                    });
                  }
                },
                child: SizedBox(
                  height: isIpad ? 65.0 : 50.0,
                  child: Column(
                    children: [
                      Image.asset(
                        img,
                        color: pageIndex == index
                            ? MyColor.appTheme
                            : MyColor.bottomIconColor,
                        height: index == 2 ? 0 : (isIpad ? 35.0 : 28.0),
                      ),
                      SizedBox(height: isIpad ? 5.0 : 2.0),
                      Text(
                          title,
                          style: semiBoldTextStyle(
                              fontSize: isIpad ? 14.0 : 11.0,
                              color: pageIndex == index
                                  ? MyColor.appTheme
                                  : MyColor.bottomIconColor
                          )
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void onTapTab1() {
    setState(() {
      pageIndex = 0;
      isTabExplore = false;
      tabCheck = "";
    });
  }

  getProfileDetail() async {
    if (!isBusy) {
      if (mounted) {
        setState(() {
          isBusy = true;
        });
      }
      await ApiServices.userDetail(context, "", false).then((onValue) {
        if (mounted) {
          setState(() {
            if (onValue.status == true) {
              if (onValue.data != null) {
                userDetails = UserIdentityModel.fromJson(onValue.data);
                if (userDetails.firstName != null) {
                  getUserData();
                }
              }
            }
          });
        }
      });

      if (mounted) {
        setState(() {
          isBusy = false;
        });
      }
    }
  }

  onExit() {
    exit(0);
  }
}