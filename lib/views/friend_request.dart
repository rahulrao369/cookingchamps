// import 'dart:convert';
//
// import 'package:cooking_champs/constant/assets_path.dart';
// import 'package:cooking_champs/constant/my_color.dart';
// import 'package:cooking_champs/constant/my_fonts_style.dart';
// import 'package:cooking_champs/constant/sized_box.dart';
// import 'package:cooking_champs/constant/stringfile.dart/language.dart';
// import 'package:cooking_champs/enums/register_enum.dart';
// import 'package:cooking_champs/model/dynamic_models/friend_model.dart';
// import 'package:cooking_champs/model/dynamic_models/user_identity_model.dart';
// import 'package:cooking_champs/model/post_model/friend_accept_reject_request.dart';
// import 'package:cooking_champs/services/api_path.dart';
// import 'package:cooking_champs/services/api_services.dart';
// import 'package:cooking_champs/utils/navigators.dart';
// import 'package:cooking_champs/utils/ui_utils.dart';
// import 'package:cooking_champs/views/dashboard.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
//
// import '../model/post_model/send_friend_request.dart';
// import '../services/user_prefences.dart';
//
// class FriendRequestView extends StatefulWidget {
//   final String type;
//   const FriendRequestView({super.key, required this.type});
//
//   @override
//   State<FriendRequestView> createState() => _FriendRequestViewState();
// }
//
// class _FriendRequestViewState extends State<FriendRequestView>
//     with TickerProviderStateMixin {
//   TextEditingController searchController = TextEditingController();
//   late final TabController tabController;
//   List<dynamic> filteredList = [];
//   List<String> tabItemList = [];
//   List<FriendsModel> myFriendsList = [];
//   List<UserIdentityModel> userList = [];
//   UserIdentityModel senderDetail = UserIdentityModel();
//   FriendsModel friendsModel = FriendsModel();
//   dynamic isFocusColor = '';
//
//   String myFriend = "";
//   String request = "";
//   String searchFriends = "";
//   String requestId = "";
//   String accept = "";
//
//   bool isLoading = false;
//   bool hasMoreData = true;
//
//   int totalPage = 1;
//   int page = 1;
//   int tabIndex = 0;
//
//   @override
//   void initState() {
//     setTabItem();
//     getUserData();
//     super.initState();
//   }
//
//   void getUserData() async {
//     var data = await PreferencesServices.getPreferencesData(
//         PreferencesServices.loginUserIdentityDetails);
//     if (data != null) {
//       Map<String, dynamic> jsonResponse = await jsonDecode(data);
//       userDetails = UserIdentityModel.fromJson(jsonResponse);
//       debugPrint("jsonResponse..$jsonResponse}");
//     }
//     if (mounted) {
//       setState(() {});
//     }
//   }
//
//   @override
//   void dispose() {
//     tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return DefaultTabController(
//       length: tabItemList.length,
//       child: Scaffold(
//         appBar: AppBar(
//           leadingWidth: size.width * 0.12,
//           automaticallyImplyLeading: false,
//           backgroundColor: MyColor.yellowF6F1E1,
//           surfaceTintColor: MyColor.yellowF6F1E1,
//           leading: InkWell(
//             radius: 80,
//             onTap: () {
//               setState(() {
//                 // isTabExplore = false;
//               });
//               if (widget.type == "Notification") {
//                 CustomNavigators.pushRemoveUntil(
//                     DashBoardView(
//                       pageIndex: 0,
//                     ),
//                     context);
//               } else {
//                 Navigator.pop(context);
//               }
//             },
//             child: Padding(
//               padding: const EdgeInsets.only(left: 20),
//               child: const Icon(
//                 Icons.arrow_back_ios,
//                 size: 30,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//           title: Text(Languages.of(context)!.friendRequest,
//               style: mediumTextStyle(fontSize: 18.0, color: MyColor.black)),
//           centerTitle: false,
//           elevation: 0,
//         ),
//         body: Column(
//           children: [
//             TabBar(
//               dividerColor: MyColor.colorE5E9F4,
//               indicatorColor: MyColor.appTheme,
//               controller: tabController,
//               onTap: (value) {
//                 setState(() {
//                   myFriendsList.clear();
//                   filteredList.clear();
//                   searchController.clear();
//                   isLoading = false;
//                   hasMoreData = true;
//                   tabIndex = tabController.index;
//                 });
//                 Future.delayed(Duration.zero, () {
//                   getFriendsRequest(true);
//                 });
//               },
//               tabs: List.generate(tabItemList.length, (index) {
//                 return UiUtils.tabItem(context, size, tabItemList[index]);
//               }),
//             ),
//             hsized15,
//             Container(
//               alignment: Alignment.center,
//               height: 55,
//               margin: const EdgeInsets.fromLTRB(12, 5, 12, 15),
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   color: isFocusColor == "firstName"
//                       ? MyColor.colorD8DCE4
//                       : MyColor.grayLite,
//                 ),
//                 color: const Color.fromARGB(255, 237, 239, 241),
//                 borderRadius: const BorderRadius.all(Radius.circular(12)),
//               ),
//               padding: const EdgeInsets.fromLTRB(12, 5, 0, 15),
//               child: TextField(
//                 controller: searchController,
//                 textCapitalization: TextCapitalization.sentences,
//                 onTap: () {
//                   setState(() {
//                     isFocusColor = "firstName";
//                   });
//                 },
//                 onChanged: (value) => filterList(value),
//                 style: regularTextStyle(fontSize: 14.0, color: MyColor.black),
//                 decoration: InputDecoration(
//                   border: InputBorder.none,
//                   hintText: Languages.of(context)!.searchByName.toString(),
//                   suffixIcon: Padding(
//                     padding: const EdgeInsets.only(bottom: 2),
//                     child: IconButton(
//                       icon: Icon(
//                         Icons.search,
//                         color: MyColor.black,
//                         size: 35,
//                       ),
//                       onPressed: () {},
//                     ),
//                   ),
//                   hintStyle: regularTextStyle(
//                     fontSize: 14.0,
//                     color: MyColor.grayLite1,
//                   ),
//                   isDense: true,
//                   contentPadding: const EdgeInsets.only(top: 10),
//                 ),
//                 cursorColor: MyColor.black,
//               ),
//             ),
//             Expanded(
//               child: TabBarView(
//                 controller: tabController,
//                 physics: NeverScrollableScrollPhysics(),
//                 children: <Widget>[
//                   myFriendsUi(size),
//                   requestUi(size),
//                   searchFriendsUi(size),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void setTabItem() {
//     tabItemList = ["My Friends", "Request", "Search Friends"];
//     tabController = TabController(vsync: this, length: tabItemList.length);
//     Future.delayed(Duration.zero, () {
//       getFriendsRequest(true);
//     });
//   }
//
//   myFriendsUi(var size) {
//     return myFriendsList.isNotEmpty
//         ? listView()
//         : Center(child: Text("No friends"));
//   }
//
//   requestUi(Size size) {
//     return myFriendsList.isNotEmpty
//         ? listView()
//         : Center(child: Text("No friends request"));
//   }
//
//   searchFriendsUi(Size size) {
//     return userList.isNotEmpty ? listView() : SizedBox.fromSize();
//   }
//
//   var typecacel = '';
//   listView() {
//     final isSearchTab = tabIndex == 2;
//     final currentList = isSearchTab ? userList : myFriendsList;
//
//     return NotificationListener<ScrollNotification>(
//       onNotification: (ScrollNotification scrollInfo) {
//         if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
//             !isLoading &&
//             totalPage >= page) {
//           Future.delayed(Duration.zero, () {
//             // getFriendsRequest(false);
//           });
//         }
//         return false;
//       },
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             searchController.text.trim().isNotEmpty && filteredList.isNotEmpty
//                 ? ListView.builder(
//                     padding: EdgeInsets.zero,
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: searchController.text.length < 4
//                         ? 0
//                         : filteredList.length,
//                     itemBuilder: (BuildContext context, index) {
//                       final senderDetail = tabIndex != 2
//                           ? filteredList[index].senderDetail
//                           : filteredList[index];
//
//                       /// <------- This Ui code extend not reposnding button effect not working well so im add  full code ui degine again --------->
//
//                       //  return UiUtils.friendRequestUi(
//                       //    senderDetail.name ?? "",
//                       //    senderDetail.role == RegisterType.roleKids.value
//                       //        ? "${senderDetail.day.toString() == "null" ? "":"${senderDetail.day.toString()} |"}${senderDetail.month.toString() == "null"  ? "":"${senderDetail.month.toString()} |"}${senderDetail.year ?? ""} | ${senderDetail.grade ?? ""}"
//                       //        : "",
//                       //    senderDetail.role != null
//                       //        ? ApiPath.imageBaseUrl + senderDetail.image.toString()
//                       //        : "",
//                       //    tabIndex == 0
//                       //        ? "My Friends"
//                       //        : tabIndex == 1
//                       //        ? "Request"
//                       //        : "Search Friends",
//                       //    (v){
//                       //      if(v != "cancel"){
//                       //                friendsModel = filteredList[index];
//                       //                requestId = filteredList[index].id ?? "";
//                       //                acceptRejectOnCallBack(v);
//                       //              }else{
//                       //        typecacel = v;
//                       //      }
//                       //            }
//                       // , (){
//                       //    print("sendRequestOnTap>>>>>1");
//                       //    senderDetail.friendRequestStatus = "";
//                       //    sendRequestOnTap(index,   int.parse(senderDetail.id),senderDetail.role,typecacel
//                       //
//                       //    );
//                       //    },
//                       //
//                       //      senderDetail.friendRequestStatus.toString()
//                       //  );
//                       return Padding(
//                         padding: const EdgeInsets.only(
//                             left: 10, right: 10, top: 5, bottom: 5),
//                         child: Column(
//                           children: [
//                             Container(
//                               padding: EdgeInsets.only(
//                                   left: 10, right: 10, bottom: 10),
//                               decoration: BoxDecoration(
//                                 color: MyColor.white,
//                                 borderRadius: BorderRadius.circular(
//                                     12), // Optional rounded corners
//                               ),
//                               alignment: Alignment
//                                   .center, // Centers text vertically and horizontally
//                               child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   ClipRRect(
//                                     borderRadius: BorderRadius.circular(500),
//                                     child: UiUtils.networkProfile(
//                                         60.0,
//                                         60.0,
//                                         senderDetail.role != null
//                                             ? ApiPath.imageBaseUrl +
//                                                 senderDetail.image.toString()
//                                             : ""),
//                                   ),
//                                   Expanded(
//                                     child: Padding(
//                                       padding: const EdgeInsets.only(
//                                           left: 10, top: 10),
//                                       child: Row(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Expanded(
//                                             child: Column(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.start,
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment
//                                                           .spaceBetween,
//                                                   children: [
//                                                     Text(
//                                                         senderDetail.name
//                                                             .toString(),
//                                                         maxLines: 2,
//                                                         overflow: TextOverflow
//                                                             .ellipsis,
//                                                         style: mediumTextStyle(
//                                                             fontSize: 16.0,
//                                                             color:
//                                                                 MyColor.black)),
//                                                     senderDetail.friendRequestStatus ==
//                                                             "Accepted"
//                                                         ? Container(
//                                                             height: 25,
//                                                             decoration: BoxDecoration(
//                                                                 color: MyColor
//                                                                     .grey3,
//                                                                 borderRadius: BorderRadius
//                                                                     .all(Radius
//                                                                         .circular(
//                                                                             6))),
//                                                             padding:
//                                                                 EdgeInsets.all(
//                                                                     5),
//                                                             margin:
//                                                                 EdgeInsets.only(
//                                                                     left: 10),
//                                                             child: Row(
//                                                               mainAxisAlignment:
//                                                                   MainAxisAlignment
//                                                                       .center,
//                                                               crossAxisAlignment:
//                                                                   CrossAxisAlignment
//                                                                       .center,
//                                                               children: [
//                                                                 Image.asset(
//                                                                   "assets/images/rightperson.png",
//                                                                   height: 15,
//                                                                 ),
//                                                                 SizedBox(
//                                                                   width: 2,
//                                                                 ),
//                                                                 Text("Friends",
//                                                                     style: regularNormalTextStyleWithoutHeight(
//                                                                         fontSize:
//                                                                             12.0,
//                                                                         color: MyColor
//                                                                             .black)),
//                                                               ],
//                                                             ),
//                                                           )
//                                                         : senderDetail
//                                                                     .friendRequestStatus ==
//                                                                 "Pending"
//                                                             ? InkWell(
//                                                                 onTap: () {
//                                                                   showPopup(
//                                                                       index,
//                                                                       int.parse(
//                                                                           senderDetail
//                                                                               .id),
//                                                                       senderDetail
//                                                                           .role,
//                                                                       "cancel");
//
//                                                                   // sendRequestOnTap(index, int.parse(senderDetail.id), senderDetail.role, "cancel");
//                                                                   // senderDetail.friendRequestStatus = "";
//                                                                 },
//                                                                 child:
//                                                                     Container(
//                                                                   height: 35,
//                                                                   width: 35,
//                                                                   decoration:
//                                                                       BoxDecoration(
//                                                                           color: MyColor
//                                                                               .yellowF6F1E1,
//                                                                           // color: Colors.purple,
//                                                                           borderRadius:
//                                                                               BorderRadius.all(Radius.circular(6))),
//                                                                   padding:
//                                                                       EdgeInsets
//                                                                           .all(
//                                                                               5),
//                                                                   margin: EdgeInsets
//                                                                       .only(
//                                                                           left:
//                                                                               10,
//                                                                           top:
//                                                                               10,
//                                                                           right:
//                                                                               5),
//                                                                   child: Image
//                                                                       .asset(
//                                                                     "assets/images/rightperson.png",
//                                                                     height: 18,
//                                                                   ),
//                                                                 ),
//                                                               )
//                                                             /* : tabIndex == 0
//                                                                 ? Padding(
//                                                                     padding: const EdgeInsets
//                                                                         .only(
//                                                                         top: 10,
//                                                                         right:
//                                                                             5),
//                                                                     child: InkWell(
//                                                                         radius: 60,
//                                                                         onTap: () {
//                                                                           showDialog(
//                                                                             context:
//                                                                                 context,
//                                                                             builder:
//                                                                                 (BuildContext context) {
//                                                                               return AlertDialog(
//                                                                                   contentPadding: EdgeInsets.only(left: 5, right: 5, bottom: 10, top: 10),
//                                                                                   insetPadding: EdgeInsets.zero,
//                                                                                   title: Center(
//                                                                                     child: Text(
//                                                                                       "Are you sure want to remove friend!",
//                                                                                       style: TextStyle(fontSize: 18),
//                                                                                     ),
//                                                                                   ),
//                                                                                   content: Container(
//                                                                                     width: MediaQuery.of(context).size.width * 0.80,
//                                                                                     margin: EdgeInsets.only(top: 10),
//                                                                                     child: Row(
//                                                                                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                                                                       children: [
//                                                                                         ElevatedButton(
//                                                                                             style: ElevatedButton.styleFrom(
//                                                                                                 backgroundColor: MyColor.white,
//                                                                                                 overlayColor: MyColor.liteOrange,
//                                                                                                 enableFeedback: true,
//                                                                                                 enabledMouseCursor: MouseCursor.defer,
//                                                                                                 elevation: 5,
//                                                                                                 shape: RoundedRectangleBorder(
//                                                                                                   borderRadius: BorderRadius.circular(10), // Custom shape
//                                                                                                 ),
//                                                                                                 minimumSize: Size(100, 40),
//                                                                                                 padding: EdgeInsets.zero),
//                                                                                             onPressed: () {
//                                                                                               Navigator.pop(context);
//                                                                                             },
//                                                                                             child: Row(
//                                                                                               children: [
//                                                                                                 Text(Languages.of(context)!.no.toString(), style: mediumTextStyle(fontSize: 13.0, color: MyColor.appTheme)),
//                                                                                               ],
//                                                                                             )),
//                                                                                         ElevatedButton(
//                                                                                             style: ElevatedButton.styleFrom(
//                                                                                               backgroundColor: MyColor.appTheme,
//                                                                                               overlayColor: MyColor.liteOrange,
//                                                                                               enableFeedback: true,
//                                                                                               enabledMouseCursor: MouseCursor.defer,
//                                                                                               elevation: 5,
//                                                                                               shape: RoundedRectangleBorder(
//                                                                                                 borderRadius: BorderRadius.circular(10), // Custom shape
//                                                                                               ),
//                                                                                               padding: EdgeInsets.zero,
//                                                                                               minimumSize: Size(100, 40),
//                                                                                             ),
//                                                                                             onPressed: () {
//                                                                                               Navigator.pop(context);
//                                                                                               accept = "no";
//                                                                                               setState(() {});
//                                                                                               requestId = senderDetail.id ?? "";
//                                                                                               print("zxczxczxc");
//                                                                                               Future.delayed(Duration.zero, acceptReject);
//                                                                                             },
//                                                                                             child: Row(
//                                                                                               mainAxisAlignment: MainAxisAlignment.center,
//                                                                                               children: [
//                                                                                                 Text(Languages.of(context)!.yes.toString(), style: mediumTextStyle(fontSize: 13.0, color: MyColor.white)),
//                                                                                               ],
//                                                                                             )),
//                                                                                       ],
//                                                                                     ),
//                                                                                   ));
//                                                                             },
//                                                                           );
//                                                                         },
//                                                                         child: Container(
//                                                                             height: 35,
//                                                                             width: 35,
//                                                                             decoration: BoxDecoration(
//                                                                                 color: MyColor.yellowF6F1E1,
//                                                                                 // color: Colors.red,
//                                                                                 borderRadius: BorderRadius.all(Radius.circular(6))),
//                                                                             child: Center(
//                                                                                 child: SvgPicture.asset(
//                                                                               // "assets/images/addpderson1.png",
//                                                                               "assets/images/friendsvg.svg",
//                                                                               height: 18,
//                                                                             )))),
//                                                                   )*/
//                                                             : tabIndex == 2
//                                                                 ? senderDetail
//                                                                             .friendRequestStatus ==
//                                                                         "Requested"
//                                                                     ? Row(
//                                                                         children: [
//                                                                           Material(
//                                                                             color:
//                                                                                 Colors.transparent, // Keeps background unchanged
//                                                                             child:
//                                                                                 InkWell(
//                                                                               splashColor: MyColor.appTheme.withOpacity(0.3), // Makes ripple more visible
//                                                                               highlightColor: Colors.transparent, // Removes gray overlay effect
//                                                                               splashFactory: InkRipple.splashFactory, // Expands ripple size
//                                                                               borderRadius: BorderRadius.circular(50), // Smoothens the ripple effect
//                                                                               radius: 100, // Increases ripple expansion area
//                                                                               onTap: () {
//                                                                                 if (senderDetail.friendRequestId.toString().isNotEmpty) {
//                                                                                   requestId = senderDetail.friendRequestId.toString();
//                                                                                 }
//                                                                                 setState(() {});
//                                                                                 acceptRejectOnCallBack("Accept");
//                                                                               },
//                                                                               child: Padding(
//                                                                                 padding: EdgeInsets.all(5), // Extra padding for a bigger effect
//                                                                                 child: SvgPicture.asset(AssetsPath.fillCheck, width: 30),
//                                                                               ),
//                                                                             ),
//                                                                           ),
//                                                                           SizedBox(
//                                                                             width:
//                                                                                 5,
//                                                                           ),
//                                                                           Material(
//                                                                             color:
//                                                                                 Colors.transparent, // Keeps background unchanged
//                                                                             child:
//                                                                                 InkWell(
//                                                                               splashColor: MyColor.appTheme.withOpacity(0.3), // Makes ripple more visible
//                                                                               highlightColor: Colors.transparent, // Removes gray overlay effect
//                                                                               splashFactory: InkRipple.splashFactory, // Expands ripple size
//                                                                               borderRadius: BorderRadius.circular(50), // Smoothens the ripple effect
//                                                                               radius: 100, // Increases ripple expansion area
//                                                                               onTap: () {
//                                                                                 if (senderDetail.friendRequestId.toString().isNotEmpty) {
//                                                                                   requestId = senderDetail.friendRequestId.toString();
//                                                                                 }
//                                                                                 setState(() {});
//                                                                                 debugPrint("Reject");
//                                                                                 acceptRejectOnCallBack("Reject");
//                                                                                 // onCallBack("Reject");
//                                                                               },
//                                                                               child: Padding(
//                                                                                 padding: EdgeInsets.all(5), // Extra padding for a bigger effect
//                                                                                 child: SvgPicture.asset(AssetsPath.fillCancel, width: 30),
//                                                                               ),
//                                                                             ),
//                                                                           ),
//                                                                         ],
//                                                                       )
//                                                                     : Padding(
//                                                                         padding: const EdgeInsets
//                                                                             .only(
//                                                                             top:
//                                                                                 10,
//                                                                             right:
//                                                                                 5),
//                                                                         child: InkWell(
//                                                                             radius: 60,
//                                                                             onTap: () {
//                                                                               sendRequestOnTap(index, int.parse(senderDetail.id), senderDetail.role, "");
//                                                                               senderDetail.friendRequestStatus = "Pending";
//                                                                             },
//                                                                             child: Container(
//                                                                                 height: 35,
//                                                                                 width: 35,
//                                                                                 padding: EdgeInsets.all(5),
//                                                                                 margin: EdgeInsets.only(left: 10),
//                                                                                 decoration: BoxDecoration(color: MyColor.green, borderRadius: BorderRadius.all(Radius.circular(6))),
//                                                                                 child: Center(
//                                                                                     child: Image.asset(
//                                                                                   "assets/images/addperson1.png",
//                                                                                   height: 18,
//                                                                                 )))),
//                                                                       )
//                                                                 : SizedBox
//                                                                     .shrink()
//                                                   ],
//                                                 ),
//                                                 hsized3,
//                                                 Text(
//                                                     senderDetail.role ==
//                                                             RegisterType
//                                                                 .roleKids.value
//                                                         ? "${senderDetail.day.toString() == "null" ? "" : "${senderDetail.day.toString()} |"}${senderDetail.month.toString() == "null" ? "" : "${senderDetail.month.toString()} |"}${senderDetail.year ?? ""} | ${senderDetail.grade ?? ""}"
//                                                         : "",
//                                                     maxLines: 2,
//                                                     overflow:
//                                                         TextOverflow.ellipsis,
//                                                     style: regularTextStyle(
//                                                         fontSize: 14.0,
//                                                         color: MyColor.black)),
//                                               ],
//                                             ),
//                                           ),
//                                           (tabIndex == 0
//                                                       ? "My Friends"
//                                                       : tabIndex == 1
//                                                           ? "Request"
//                                                           : "Search Friends") ==
//                                                   "Request"
//                                               ? Row(
//                                                   children: [
//                                                     InkWell(
//                                                         radius: 60,
//                                                         onTap: () {},
//                                                         child: SvgPicture.asset(
//                                                             AssetsPath
//                                                                 .fillCheck)),
//                                                     SizedBox(
//                                                       width: 5,
//                                                     ),
//                                                     InkWell(
//                                                         radius: 60,
//                                                         onTap: () {
//                                                           // onCallBack("Reject");
//                                                         },
//                                                         child: SvgPicture.asset(
//                                                             AssetsPath
//                                                                 .fillCancel)),
//                                                   ],
//                                                 )
//                                               : SizedBox.shrink()
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Divider(),
//                           ],
//                         ),
//                       );
//                     },
//                   )
//                 : searchController.text.trim().isEmpty && filteredList.isEmpty
//                     ? ListView.builder(
//                         padding: EdgeInsets.zero,
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemCount: tabIndex == 2
//                             ? searchController.text.isEmpty
//                                 ? 0
//                                 : userList.length
//                             : myFriendsList.length,
//                         itemBuilder: (BuildContext context, index) {
//                           if (tabIndex == 2) {
//                             senderDetail = userList[index];
//                           } else if (myFriendsList.isNotEmpty &&
//                               myFriendsList[index].senderDetail != null) {
//                             senderDetail = myFriendsList[index].senderDetail!;
//                           }
//                           return UiUtils.friendRequestUi(
//                               senderDetail.name ?? "",
//                               senderDetail.role == RegisterType.roleKids.value
//                                   ? "${senderDetail.day.toString() == "null" ? "" : "${senderDetail.day} | "}${senderDetail.month.toString() == "null" ? "" : "${senderDetail.month.toString()} | "}${senderDetail.year ?? ""} | ${senderDetail.grade ?? ""}"
//                                   : "",
//                               senderDetail.image != null
//                                   ? ApiPath.imageBaseUrl +
//                                       senderDetail.image.toString()
//                                   : "",
//                               tabIndex == 0
//                                   ? "My Friends"
//                                   : tabIndex == 1
//                                       ? "Request"
//                                       : "Search Friends",
//                               (v) {
//                                 friendsModel = myFriendsList[index];
//                                 requestId = myFriendsList[index].id ?? "";
//                                 acceptRejectOnCallBack(v);
//                               },
//                               () {
//                                 showPopup(
//                                     index,
//                                     int.parse(senderDetail.id.toString()),
//                                     senderDetail.role.toString(),
//                                     "cancel");
//                                 // sendRequestOnTap(
//                                 //     index,
//                                 //     int.parse(senderDetail.id.toString()),
//                                 //     senderDetail.role!,
//                                 //     "");
//                               },
//                               senderDetail.friendRequestStatus.toString(),
//                               () {
//                                 friendsModel = myFriendsList[index];
//                                 requestId = myFriendsList[index].id ?? "";
//                                 debugPrint("requestId..$requestId");
//                                 setState(() {});
//                                 Navigator.pop(context);
//                                 showUnfriendDialog(context);
//                                 //  followRequestOnTap(index,senderDetail);
//                               });
//                         },
//                       )
//                     : SizedBox.shrink(),
//             loader(),
//             hsized40,
//           ],
//         ),
//       ),
//     );
//   }
//
//   void followRequestOnTap(int index, UserIdentityModel data) async {
//     if (data.friendRequestStatus != "") {
//       FollowRequest friendRequest = FollowRequest(
//         senderId: int.parse(userDetails.id ?? "0"),
//         receiverId: int.parse(data.id!),
//         requestSentBy: userDetails.role,
//         requestSentTo: data.role,
//       );
//       await ApiServices.followRequest(context, friendRequest).then((onValue) {
//         if (onValue.status == true) {
//           if (mounted) {
//             setState(() {});
//           }
//         }
//       });
//     }
//   }
//
//   loader() {
//     return isLoading
//         ? Container(
//             margin: EdgeInsets.only(top: 20, bottom: 80),
//             height: 50,
//             alignment: Alignment.center,
//             child: CircularProgressIndicator(
//               color: MyColor.appTheme,
//             ),
//           )
//         : SizedBox.shrink();
//   }
//
//   acceptRejectOnCallBack(String acceptStatus) {
//     setState(() {
//       if (acceptStatus == "Accept") {
//         accept = "yes";
//
//         acceptNoPopup("Are you sure want to accept friend request!");
//       } else {
//         accept = "no";
//         acceptNoPopup("Are you sure want to remove friend!");
//       }
//       debugPrint("accept...$accept");
//     });
//     //  Future.delayed(Duration.zero, acceptReject);
//   }
//
//   acceptReject() async {
//     FriendAcceptRejectRequest acceptRejectRequest = FriendAcceptRejectRequest(
//       friendRequestId: int.parse(requestId),
//       accept: accept,
//     );
//     debugPrint("acceptStatus...${acceptRejectRequest.accept}");
//
//     await ApiServices.acceptRejectFriendsRequest(
//             context, acceptRejectRequest, true)
//         .then((onValue) {
//       if (onValue.status == true) {
//         if (mounted) {
//           setState(() {
//             accept = "Accept";
//             myFriendsList.remove(friendsModel);
//           });
//         }
//       }
//       Future.delayed(Duration.zero, () {
//         debugPrint("test");
//         getFriendsRequest(false);
//       });
//     });
//   }
//
//   UserIdentityModel userDetails = UserIdentityModel();
//   void sendRequestOnTap(
//       int index, int id, String type, String typecacel) async {
//     print("11111111111111");
//     SendFriendRequest friendRequest = SendFriendRequest(
//         senderId: int.parse(userDetails.id ?? "0"),
//         receiverId: id,
//         requestSentBy: userDetails.role,
//         requestSentTo: type.toString(),
//         type: typecacel);
//
//     await ApiServices.sendRequest(context, friendRequest).then((onValue) {
//       if (onValue.status == true) {
//         print("onValue.message>>>>>>>>>${onValue.message}");
//         if (onValue.message.toString() == "Friend request sent successfully!") {
//           senderDetail.friendRequestStatus = "Pending";
//           setState(() {});
//           getFriendsRequest(false);
//         } else if (onValue.message.toString() ==
//             "Friend request cancelled successfully!") {
//           senderDetail.friendRequestStatus = "Pending";
//           setState(() {});
//           getFriendsRequest(false);
//         }
//         if (mounted) {
//           setState(() {
//             // recipeModel.recipeAddedBy!.friendRequestStatus.toString() ==
//             //     "pending"
//             //     ? recipeModel.recipeAddedBy!.friendRequestStatus =
//             // "request not sent"
//             //     : recipeModel.recipeAddedBy!.friendRequestStatus = "pending";
//           });
//         }
//       }
//     });
//   }
//
//   void filterList(String query) {
//     List<dynamic> originalList = tabIndex == 2 ? userList : myFriendsList;
//
//     setState(() {
//       if (query.isEmpty) {
//         filteredList = [];
//       } else {
//         filteredList = originalList.where((item) {
//           String name = tabIndex != 2
//               ? item.senderDetail.name?.toLowerCase() ?? ""
//               : item.name?.toLowerCase() ?? "";
//           return name.contains(query.toLowerCase());
//         }).toList();
//         // Optional debug
//         debugPrint("Filtered list size: ${filteredList.length}");
//       }
//     });
//   }
//
//   Future<void> getFriendsRequest(bool load) async {
//     if (isLoading || !hasMoreData) return;
//
//     String type = ["accepted", "pending", "all"][tabController.index];
//
//     setState(() {
//       isLoading = true; // Start loading
//     });
//
//     try {
//       var onValue =
//           await ApiServices.getFriendsRequest(context, page, load, type);
//       if (!mounted || onValue.status != true) return;
//       setState(() {
//         var items = (onValue.data as List<dynamic>?) ?? [];
//         if (page == 1) {
//           myFriendsList.clear(); // Clear the list only on the first page
//         }
//         if (page == 1) {
//           userList.clear(); // Clear the list only on the first page
//         }
//
//         if (items.isNotEmpty) {
//           dynamic friends = tabIndex == 2
//               ? items.map((item) => UserIdentityModel.fromJson(item)).toList()
//               : items.map((item) => FriendsModel.fromJson(item)).toList();
//           if (tabIndex == 2) {
//             userList.addAll(friends);
//             userList.sort((a, b) => a.name!.compareTo(b.name!));
//             print("userList>>>>>>${json.encode(userList)}");
//             filterList(searchController.text);
//           } else {
//             myFriendsList.addAll(friends);
//             myFriendsList.sort((a, b) =>
//                 a.senderDetail!.name!.compareTo(b.senderDetail!.name!));
//             print("myFriendsList>>>>>>$myFriendsList");
//             print("myFriendsList>>>>>>${json.encode(myFriendsList)}");
//           }
//         } else {
//           hasMoreData = false; // No more data to load
//         }
//       });
//     } catch (e) {
//       debugPrint('Error fetching friends request: $e');
//     } finally {
//       setState(() {
//         isLoading = false; // End loading
//       });
//     }
//   }
//
//   Future<void> getFriendsRequest1(bool load) async {
//     String type = tabController.index == 0
//         ? "accepted"
//         : tabController.index == 1
//             ? "pending"
//             : "all";
//     if (isLoading || !hasMoreData) return;
//     setState(() {
//       isLoading = true; // Start loading
//     });
//     try {
//       var onValue =
//           await ApiServices.getFriendsRequest(context, page, load, type);
//       if (mounted && onValue.status == true) {
//         print("onvalue>>>>>>$onValue");
//         setState(() {
//           var items = onValue.data as List<dynamic>? ??
//               []; // Safely cast items to List<dynamic>
//           myFriendsList.clear(); // Clear the list only on the first page
//           if (items.isNotEmpty) {
//             if (tabIndex == 2) {
//               var friends = items
//                   .map((item) => UserIdentityModel.fromJson(item))
//                   .toList();
//               friends.sort((a, b) => b.id!.compareTo(a.id!));
//               userList.addAll(friends);
//               debugPrint("items...$items");
//             } else {
//               var friends =
//                   items.map((item) => FriendsModel.fromJson(item)).toList();
//               friends.sort((a, b) => b.id!.compareTo(a.id!));
//               myFriendsList.addAll(friends);
//             }
//             print("myFriendsList>>>>>>${myFriendsList}");
//           } else {
//             hasMoreData = false; // No more data to load
//           }
//         });
//       }
//     } catch (e) {
//       debugPrint('Error fetching stories: $e');
//     } finally {
//       setState(() {
//         isLoading = false; // End loading
//       });
//     }
//   }
//
//   void showUnfriendDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text("Unfriend"),
//           content: Text("Are you sure you want to remove this friend?"),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context); // Close dialog
//               },
//               child: Text("Cancel"),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 acceptRejectOnCallBack("");
//               },
//               child: Text("Unfriend", style: TextStyle(color: Colors.red)),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   acceptNoPopup(String title) {
//     return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//             contentPadding:
//                 EdgeInsets.only(left: 5, right: 5, bottom: 10, top: 10),
//             insetPadding: EdgeInsets.zero,
//             title: Center(
//               child: Text(
//                 title,
//                 style: TextStyle(fontSize: 18),
//               ),
//             ),
//             content: Container(
//               width: MediaQuery.of(context).size.width * 0.80,
//               margin: EdgeInsets.only(top: 10),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: MyColor.white,
//                           overlayColor: MyColor.liteOrange,
//                           enableFeedback: true,
//                           enabledMouseCursor: MouseCursor.defer,
//                           elevation: 5,
//                           shape: RoundedRectangleBorder(
//                             borderRadius:
//                                 BorderRadius.circular(10), // Custom shape
//                           ),
//                           minimumSize: Size(100, 40),
//                           padding: EdgeInsets.zero),
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       child: Row(
//                         children: [
//                           Text(Languages.of(context)!.no.toString(),
//                               style: mediumTextStyle(
//                                   fontSize: 13.0, color: MyColor.appTheme)),
//                         ],
//                       )),
//                   ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: MyColor.appTheme,
//                         overlayColor: MyColor.liteOrange,
//                         enableFeedback: true,
//                         enabledMouseCursor: MouseCursor.defer,
//                         elevation: 5,
//                         shape: RoundedRectangleBorder(
//                           borderRadius:
//                               BorderRadius.circular(10), // Custom shape
//                         ),
//                         padding: EdgeInsets.zero,
//                         minimumSize: Size(100, 40),
//                       ),
//                       onPressed: () {
//                         Navigator.pop(context);
//                         Future.delayed(Duration.zero, acceptReject);
//                       },
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(Languages.of(context)!.yes.toString(),
//                               style: mediumTextStyle(
//                                   fontSize: 13.0, color: MyColor.white)),
//                         ],
//                       )),
//                 ],
//               ),
//             ));
//       },
//     );
//   }
//
//   showPopup(int index, int id, String role, String type) {
//     return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//             contentPadding:
//                 EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
//             title: Container(
//               alignment: Alignment.center,
//               padding: EdgeInsets.only(bottom: 20),
//               child: Text(
//                 "Undo friend request",
//                 style: TextStyle(color: Colors.black, fontSize: 25),
//               ),
//             ),
//             content: Container(
//               padding: EdgeInsets.only(bottom: 10),
//               width: MediaQuery.of(context).size.width * 0.60,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: MyColor.white,
//                           overlayColor: MyColor.liteOrange,
//                           enableFeedback: true,
//                           enabledMouseCursor: MouseCursor.defer,
//                           elevation: 5,
//                           shape: RoundedRectangleBorder(
//                             borderRadius:
//                                 BorderRadius.circular(10), // Custom shape
//                           ),
//                           padding: EdgeInsets.zero),
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       child: Row(
//                         children: [
//                           Text(Languages.of(context)!.no.toString(),
//                               style: mediumTextStyle(
//                                   fontSize: 13.0, color: MyColor.appTheme)),
//                         ],
//                       )),
//                   ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: MyColor.appTheme,
//                           overlayColor: MyColor.liteOrange,
//                           enableFeedback: true,
//                           enabledMouseCursor: MouseCursor.defer,
//                           elevation: 5,
//                           shape: RoundedRectangleBorder(
//                             borderRadius:
//                                 BorderRadius.circular(10), // Custom shape
//                           ),
//                           padding: EdgeInsets.zero),
//                       onPressed: () {
//                         Navigator.pop(context);
//                         sendRequestOnTap(index, id, role, type);
//                         // sendRequestOnTap(
//                         //     index,
//                         //     int.parse(senderDetail.id.toString()),
//                         //     senderDetail.role!,
//                         //     "");
//                         senderDetail.friendRequestStatus = "";
//                       },
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(Languages.of(context)!.yes.toString(),
//                               style: mediumTextStyle(
//                                   fontSize: 13.0, color: MyColor.white)),
//                         ],
//                       )),
//                 ],
//               ),
//             ));
//       },
//     );
//   }
// }


import 'dart:convert';

import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/constant/stringfile.dart/language.dart';
import 'package:cooking_champs/enums/register_enum.dart';
import 'package:cooking_champs/model/dynamic_models/friend_model.dart';
import 'package:cooking_champs/model/dynamic_models/user_identity_model.dart';
import 'package:cooking_champs/model/post_model/friend_accept_reject_request.dart';
import 'package:cooking_champs/services/api_path.dart';
import 'package:cooking_champs/services/api_services.dart';
import 'package:cooking_champs/utils/navigators.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:cooking_champs/views/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../model/post_model/send_friend_request.dart';
import '../services/user_prefences.dart';

class FriendRequestView extends StatefulWidget {
  final String type;
  const FriendRequestView({super.key, required this.type});

  @override
  State<FriendRequestView> createState() => _FriendRequestViewState();
}

class _FriendRequestViewState extends State<FriendRequestView>
    with TickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  late final TabController tabController;
  List<dynamic> filteredList = [];
  List<String> tabItemList = [];
  List<FriendsModel> myFriendsList = [];
  List<UserIdentityModel> userList = [];
  UserIdentityModel senderDetail = UserIdentityModel();
  FriendsModel friendsModel = FriendsModel();
  dynamic isFocusColor = '';

  String myFriend = "";
  String request = "";
  String searchFriends = "";
  String requestId = "";
  String accept = "";

  bool isLoading = false;
  bool hasMoreData = true;

  int totalPage = 1;
  int page = 1;
  int tabIndex = 0;

  @override
  void initState() {
    setTabItem();
    getUserData();
    super.initState();
  }

  void getUserData() async {
    var data = await PreferencesServices.getPreferencesData(
        PreferencesServices.loginUserIdentityDetails);
    if (data != null) {
      Map<String, dynamic> jsonResponse = await jsonDecode(data);
      userDetails = UserIdentityModel.fromJson(jsonResponse);
      debugPrint("jsonResponse..$jsonResponse}");
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final bool isIpad = MediaQuery.of(context).size.width > 600;

    return DefaultTabController(
      length: tabItemList.length,
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: size.width * (isIpad ? 0.15 : 0.12),
          automaticallyImplyLeading: false,
          backgroundColor: MyColor.yellowF6F1E1,
          surfaceTintColor: MyColor.yellowF6F1E1,
          leading: InkWell(
            radius: isIpad ? 100.0 : 80.0,
            borderRadius: BorderRadius.circular(isIpad ? 40.0 : 30.0),
            onTap: () {
              setState(() {
                // isTabExplore = false;
              });
              if (widget.type == "Notification") {
                CustomNavigators.pushRemoveUntil(
                    DashBoardView(
                      pageIndex: 0,
                    ),
                    context);
              } else {
                Navigator.pop(context);
              }
            },
            child: Padding(
              padding: EdgeInsets.only(left: isIpad ? 30.0 : 20.0),
              child: Icon(
                Icons.arrow_back_ios,
                size: isIpad ? 36.0 : 30.0,
                color: Colors.black,
              ),
            ),
          ),
          title: Text(
            Languages.of(context)!.friendRequest,
            style: mediumTextStyle(
              fontSize: isIpad ? 28.0 : 18.0,
              color: MyColor.black,
            ),
          ),
          centerTitle: false,
          elevation: 0,
          toolbarHeight: isIpad ? 80.0 : 56.0,
        ),
        body: Column(
          children: [
            TabBar(
              dividerColor: MyColor.colorE5E9F4,
              indicatorColor: MyColor.appTheme,
              indicatorWeight: isIpad ? 3.0 : 2.0,
              controller: tabController,
              onTap: (value) {
                setState(() {
                  myFriendsList.clear();
                  filteredList.clear();
                  searchController.clear();
                  isLoading = false;
                  hasMoreData = true;
                  tabIndex = tabController.index;
                });
                Future.delayed(Duration.zero, () {
                  getFriendsRequest(true);
                });
              },
              tabs: List.generate(tabItemList.length, (index) {
                return UiUtils.tabItem(context, size, tabItemList[index], isIpad);
              }),
            ),
            SizedBox(height: isIpad ? 20.0 : 15.0),
            Container(
              alignment: Alignment.center,
              height: isIpad ? 70.0 : 55.0,
              margin: EdgeInsets.fromLTRB(
                isIpad ? 20.0 : 12.0,
                isIpad ? 8.0 : 5.0,
                isIpad ? 20.0 : 12.0,
                isIpad ? 20.0 : 15.0,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isFocusColor == "firstName"
                      ? MyColor.colorD8DCE4
                      : MyColor.grayLite,
                ),
                color: const Color.fromARGB(255, 237, 239, 241),
                borderRadius: BorderRadius.all(Radius.circular(isIpad ? 16.0 : 12.0)),
              ),
              padding: EdgeInsets.fromLTRB(
                isIpad ? 16.0 : 12.0,
                isIpad ? 8.0 : 5.0,
                0,
                isIpad ? 20.0 : 15.0,
              ),
              child: TextField(
                controller: searchController,
                textCapitalization: TextCapitalization.sentences,
                onTap: () {
                  setState(() {
                    isFocusColor = "firstName";
                  });
                },
                onChanged: (value) => filterList(value),
                style: regularTextStyle(
                  fontSize: isIpad ? 20.0 : 14.0,
                  color: MyColor.black,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: Languages.of(context)!.searchByName.toString(),
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(bottom: isIpad ? 3.0 : 2.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.search,
                        color: MyColor.black,
                        size: isIpad ? 40.0 : 35.0,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  hintStyle: regularTextStyle(
                    fontSize: isIpad ? 20.0 : 14.0,
                    color: MyColor.grayLite1,
                  ),
                  isDense: true,
                  contentPadding: EdgeInsets.only(top: isIpad ? 15.0 : 10.0),
                ),
                cursorColor: MyColor.black,
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  myFriendsUi(size),
                  requestUi(size),
                  searchFriendsUi(size),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void setTabItem() {
    tabItemList = ["My Friends", "Request", "Search Friends"];
    tabController = TabController(vsync: this, length: tabItemList.length);
    Future.delayed(Duration.zero, () {
      getFriendsRequest(true);
    });
  }

  myFriendsUi(var size) {
    final bool isIpad = MediaQuery.of(context).size.width > 600;

    return myFriendsList.isNotEmpty
        ? listView()
        : Center(
      child: Text(
        "No friends",
        style: regularTextStyle(
          fontSize: isIpad ? 22.0 : 16.0,
          color: MyColor.black,
        ),
      ),
    );
  }

  requestUi(Size size) {
    final bool isIpad = MediaQuery.of(context).size.width > 600;

    return myFriendsList.isNotEmpty
        ? listView()
        : Center(
      child: Text(
        "No friends request",
        style: regularTextStyle(
          fontSize: isIpad ? 22.0 : 16.0,
          color: MyColor.black,
        ),
      ),
    );
  }

  searchFriendsUi(Size size) {
    return userList.isNotEmpty ? listView() : SizedBox.fromSize();
  }

  var typecacel = '';

  listView() {
    final bool isIpad = MediaQuery.of(context).size.width > 600;
    final isSearchTab = tabIndex == 2;
    final currentList = isSearchTab ? userList : myFriendsList;

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
            !isLoading &&
            totalPage >= page) {
          Future.delayed(Duration.zero, () {
            // getFriendsRequest(false);
          });
        }
        return false;
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            searchController.text.trim().isNotEmpty && filteredList.isNotEmpty
                ? ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: searchController.text.length < 4
                  ? 0
                  : filteredList.length,
              itemBuilder: (BuildContext context, index) {
                final senderDetail = tabIndex != 2
                    ? filteredList[index].senderDetail
                    : filteredList[index];

                return Padding(
                  padding: EdgeInsets.only(
                    left: isIpad ? 15.0 : 10.0,
                    right: isIpad ? 15.0 : 10.0,
                    top: isIpad ? 10.0 : 5.0,
                    bottom: isIpad ? 10.0 : 5.0,
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(isIpad ? 15.0 : 10.0),
                        decoration: BoxDecoration(
                          color: MyColor.white,
                          borderRadius: BorderRadius.circular(isIpad ? 16.0 : 12.0),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(500.0),
                              child: UiUtils.networkProfile(
                                isIpad ? 80.0 : 60.0,
                                isIpad ? 80.0 : 60.0,
                                senderDetail.role != null
                                    ? ApiPath.imageBaseUrl +
                                    senderDetail.image.toString()
                                    : "",
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: isIpad ? 15.0 : 10.0,
                                  top: isIpad ? 10.0 : 10.0,
                                ),
                                child: Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  senderDetail.name
                                                      .toString(),
                                                  maxLines: 2,
                                                  overflow: TextOverflow
                                                      .ellipsis,
                                                  style: mediumTextStyle(
                                                    fontSize: isIpad ? 22.0 : 16.0,
                                                    color: MyColor.black,
                                                  ),
                                                ),
                                              ),
                                              senderDetail.friendRequestStatus ==
                                                  "Accepted"
                                                  ? Container(
                                                height: isIpad ? 35.0 : 25.0,
                                                decoration: BoxDecoration(
                                                  color: MyColor.grey3,
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(isIpad ? 8.0 : 6.0),
                                                  ),
                                                ),
                                                padding: EdgeInsets.all(isIpad ? 8.0 : 5.0),
                                                margin: EdgeInsets.only(
                                                  left: isIpad ? 15.0 : 10.0,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .center,
                                                  children: [
                                                    Image.asset(
                                                      "assets/images/rightperson.png",
                                                      height: isIpad ? 20.0 : 15.0,
                                                    ),
                                                    SizedBox(
                                                      width: isIpad ? 5.0 : 2.0,
                                                    ),
                                                    Text(
                                                      "Friends",
                                                      style: regularNormalTextStyleWithoutHeight(
                                                        fontSize: isIpad ? 16.0 : 12.0,
                                                        color: MyColor.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                                  : senderDetail
                                                  .friendRequestStatus ==
                                                  "Pending"
                                                  ? InkWell(
                                                onTap: () {
                                                  showPopup(
                                                    index,
                                                    int.parse(senderDetail.id),
                                                    senderDetail.role,
                                                    "cancel",
                                                  );
                                                },
                                                child: Container(
                                                  height: isIpad ? 45.0 : 35.0,
                                                  width: isIpad ? 45.0 : 35.0,
                                                  decoration: BoxDecoration(
                                                    color: MyColor.yellowF6F1E1,
                                                    borderRadius: BorderRadius.all(
                                                      Radius.circular(isIpad ? 8.0 : 6.0),
                                                    ),
                                                  ),
                                                  padding: EdgeInsets.all(isIpad ? 10.0 : 5.0),
                                                  margin: EdgeInsets.only(
                                                    left: isIpad ? 15.0 : 10.0,
                                                    top: isIpad ? 15.0 : 10.0,
                                                    right: isIpad ? 10.0 : 5.0,
                                                  ),
                                                  child: Image.asset(
                                                    "assets/images/rightperson.png",
                                                    height: isIpad ? 25.0 : 18.0,
                                                  ),
                                                ),
                                              )
                                                  : tabIndex == 2
                                                  ? senderDetail.friendRequestStatus ==
                                                  "Requested"
                                                  ? Row(
                                                children: [
                                                  Material(
                                                    color: Colors
                                                        .transparent,
                                                    child: InkWell(
                                                      splashColor: MyColor.appTheme.withOpacity(0.3),
                                                      highlightColor: Colors.transparent,
                                                      splashFactory: InkRipple.splashFactory,
                                                      borderRadius: BorderRadius.circular(50.0),
                                                      radius: 100.0,
                                                      onTap: () {
                                                        if (senderDetail.friendRequestId.toString().isNotEmpty) {
                                                          requestId = senderDetail.friendRequestId.toString();
                                                        }
                                                        setState(() {});
                                                        acceptRejectOnCallBack("Accept");
                                                      },
                                                      child: Padding(
                                                        padding: EdgeInsets.all(isIpad ? 8.0 : 5.0),
                                                        child: SvgPicture.asset(
                                                          AssetsPath.fillCheck,
                                                          width: isIpad ? 35.0 : 30.0,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: isIpad ? 10.0 : 5.0,
                                                  ),
                                                  Material(
                                                    color: Colors.transparent,
                                                    child: InkWell(
                                                      splashColor: MyColor.appTheme.withOpacity(0.3),
                                                      highlightColor: Colors.transparent,
                                                      splashFactory: InkRipple.splashFactory,
                                                      borderRadius: BorderRadius.circular(50.0),
                                                      radius: 100.0,
                                                      onTap: () {
                                                        if (senderDetail.friendRequestId.toString().isNotEmpty) {
                                                          requestId = senderDetail.friendRequestId.toString();
                                                        }
                                                        setState(() {});
                                                        debugPrint("Reject");
                                                        acceptRejectOnCallBack("Reject");
                                                      },
                                                      child: Padding(
                                                        padding: EdgeInsets.all(isIpad ? 8.0 : 5.0),
                                                        child: SvgPicture.asset(
                                                          AssetsPath.fillCancel,
                                                          width: isIpad ? 35.0 : 30.0,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                                  : Padding(
                                                padding: EdgeInsets.only(
                                                  top: isIpad ? 15.0 : 10.0,
                                                  right: isIpad ? 10.0 : 5.0,
                                                ),
                                                child: InkWell(
                                                  radius: 60.0,
                                                  onTap: () {
                                                    sendRequestOnTap(
                                                      index,
                                                      int.parse(senderDetail.id),
                                                      senderDetail.role,
                                                      "",
                                                    );
                                                    senderDetail.friendRequestStatus = "Pending";
                                                  },
                                                  child: Container(
                                                    height: isIpad ? 45.0 : 35.0,
                                                    width: isIpad ? 45.0 : 35.0,
                                                    padding: EdgeInsets.all(isIpad ? 10.0 : 5.0),
                                                    margin: EdgeInsets.only(left: isIpad ? 15.0 : 10.0),
                                                    decoration: BoxDecoration(
                                                      color: MyColor.green,
                                                      borderRadius: BorderRadius.all(Radius.circular(isIpad ? 8.0 : 6.0)),
                                                    ),
                                                    child: Center(
                                                      child: Image.asset(
                                                        "assets/images/addperson1.png",
                                                        height: isIpad ? 25.0 : 18.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                                  : SizedBox.shrink(),
                                            ],
                                          ),
                                          SizedBox(height: isIpad ? 5.0 : 3.0),
                                          Text(
                                            senderDetail.role ==
                                                RegisterType.roleKids.value
                                                ? "${senderDetail.day.toString() == "null" ? "" : "${senderDetail.day.toString()} |"}${senderDetail.month.toString() == "null" ? "" : "${senderDetail.month.toString()} |"}${senderDetail.year ?? ""} | ${senderDetail.grade ?? ""}"
                                                : "",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: regularTextStyle(
                                              fontSize: isIpad ? 18.0 : 14.0,
                                              color: MyColor.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    (tabIndex == 0
                                        ? "My Friends"
                                        : tabIndex == 1
                                        ? "Request"
                                        : "Search Friends") ==
                                        "Request"
                                        ? Row(
                                      children: [
                                        InkWell(
                                          radius: 60.0,
                                          onTap: () {},
                                          child: SvgPicture.asset(
                                            AssetsPath.fillCheck,
                                            width: isIpad ? 35.0 : 30.0,
                                          ),
                                        ),
                                        SizedBox(
                                          width: isIpad ? 10.0 : 5.0,
                                        ),
                                        InkWell(
                                          radius: 60.0,
                                          onTap: () {
                                            // onCallBack("Reject");
                                          },
                                          child: SvgPicture.asset(
                                            AssetsPath.fillCancel,
                                            width: isIpad ? 35.0 : 30.0,
                                          ),
                                        ),
                                      ],
                                    )
                                        : SizedBox.shrink()
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1.0,
                        height: isIpad ? 20.0 : 10.0,
                      ),
                    ],
                  ),
                );
              },
            )
                : searchController.text.trim().isEmpty && filteredList.isEmpty
                ? ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: tabIndex == 2
                  ? searchController.text.isEmpty
                  ? 0
                  : userList.length
                  : myFriendsList.length,
              itemBuilder: (BuildContext context, index) {
                if (tabIndex == 2) {
                  senderDetail = userList[index];
                } else if (myFriendsList.isNotEmpty &&
                    myFriendsList[index].senderDetail != null) {
                  senderDetail = myFriendsList[index].senderDetail!;
                }
                return UiUtils.friendRequestUi(
                  senderDetail.name ?? "",
                  senderDetail.role == RegisterType.roleKids.value
                      ? "${senderDetail.day.toString() == "null" ? "" : "${senderDetail.day} | "}${senderDetail.month.toString() == "null" ? "" : "${senderDetail.month.toString()} | "}${senderDetail.year ?? ""} | ${senderDetail.grade ?? ""}"
                      : "",
                  senderDetail.image != null
                      ? ApiPath.imageBaseUrl +
                      senderDetail.image.toString()
                      : "",
                  tabIndex == 0
                      ? "My Friends"
                      : tabIndex == 1
                      ? "Request"
                      : "Search Friends",
                      (v) {
                    friendsModel = myFriendsList[index];
                    requestId = myFriendsList[index].id ?? "";
                    acceptRejectOnCallBack(v);
                  },
                      () {
                    showPopup(
                      index,
                      int.parse(senderDetail.id.toString()),
                      senderDetail.role.toString(),
                      "cancel",
                    );
                  },
                  senderDetail.friendRequestStatus.toString(),
                      () {
                    friendsModel = myFriendsList[index];
                    requestId = myFriendsList[index].id ?? "";
                    debugPrint("requestId..$requestId");
                    setState(() {});
                    Navigator.pop(context);
                    showUnfriendDialog(context);
                  },
                );
              },
            )
                : SizedBox.shrink(),
            loader(),
            SizedBox(height: isIpad ? 60.0 : 40.0),
          ],
        ),
      ),
    );
  }

  void followRequestOnTap(int index, UserIdentityModel data) async {
    if (data.friendRequestStatus != "") {
      FollowRequest friendRequest = FollowRequest(
        senderId: int.parse(userDetails.id ?? "0"),
        receiverId: int.parse(data.id!),
        requestSentBy: userDetails.role,
        requestSentTo: data.role,
      );
      await ApiServices.followRequest(context, friendRequest).then((onValue) {
        if (onValue.status == true) {
          if (mounted) {
            setState(() {});
          }
        }
      });
    }
  }

  loader() {
    final bool isIpad = MediaQuery.of(context).size.width > 600;

    return isLoading
        ? Container(
      margin: EdgeInsets.only(top: isIpad ? 30.0 : 20.0, bottom: isIpad ? 100.0 : 80.0),
      height: isIpad ? 70.0 : 50.0,
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        color: MyColor.appTheme,
        strokeWidth: isIpad ? 3.0 : 2.0,
      ),
    )
        : SizedBox.shrink();
  }

  acceptRejectOnCallBack(String acceptStatus) {
    setState(() {
      if (acceptStatus == "Accept") {
        accept = "yes";
        acceptNoPopup("Are you sure want to accept friend request!");
      } else {
        accept = "no";
        acceptNoPopup("Are you sure want to remove friend!");
      }
      debugPrint("accept...$accept");
    });
  }

  acceptReject() async {
    FriendAcceptRejectRequest acceptRejectRequest = FriendAcceptRejectRequest(
      friendRequestId: int.parse(requestId),
      accept: accept,
    );
    debugPrint("acceptStatus...${acceptRejectRequest.accept}");

    await ApiServices.acceptRejectFriendsRequest(
        context, acceptRejectRequest, true)
        .then((onValue) {
      if (onValue.status == true) {
        if (mounted) {
          setState(() {
            accept = "Accept";
            myFriendsList.remove(friendsModel);
          });
        }
      }
      Future.delayed(Duration.zero, () {
        debugPrint("test");
        getFriendsRequest(false);
      });
    });
  }

  UserIdentityModel userDetails = UserIdentityModel();

  void sendRequestOnTap(
      int index, int id, String type, String typecacel) async {
    print("11111111111111");
    SendFriendRequest friendRequest = SendFriendRequest(
        senderId: int.parse(userDetails.id ?? "0"),
        receiverId: id,
        requestSentBy: userDetails.role,
        requestSentTo: type.toString(),
        type: typecacel);

    await ApiServices.sendRequest(context, friendRequest).then((onValue) {
      if (onValue.status == true) {
        print("onValue.message>>>>>>>>>${onValue.message}");
        if (onValue.message.toString() == "Friend request sent successfully!") {
          senderDetail.friendRequestStatus = "Pending";
          setState(() {});
          getFriendsRequest(false);
        } else if (onValue.message.toString() ==
            "Friend request cancelled successfully!") {
          senderDetail.friendRequestStatus = "Pending";
          setState(() {});
          getFriendsRequest(false);
        }
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  void filterList(String query) {
    List<dynamic> originalList = tabIndex == 2 ? userList : myFriendsList;

    setState(() {
      if (query.isEmpty) {
        filteredList = [];
      } else {
        filteredList = originalList.where((item) {
          String name = tabIndex != 2
              ? item.senderDetail.name?.toLowerCase() ?? ""
              : item.name?.toLowerCase() ?? "";
          return name.contains(query.toLowerCase());
        }).toList();
        debugPrint("Filtered list size: ${filteredList.length}");
      }
    });
  }

  Future<void> getFriendsRequest(bool load) async {
    if (isLoading || !hasMoreData) return;

    String type = ["accepted", "pending", "all"][tabController.index];

    setState(() {
      isLoading = true;
    });

    try {
      var onValue =
      await ApiServices.getFriendsRequest(context, page, load, type);
      if (!mounted || onValue.status != true) return;
      setState(() {
        var items = (onValue.data as List<dynamic>?) ?? [];
        if (page == 1) {
          myFriendsList.clear();
        }
        if (page == 1) {
          userList.clear();
        }

        if (items.isNotEmpty) {
          dynamic friends = tabIndex == 2
              ? items.map((item) => UserIdentityModel.fromJson(item)).toList()
              : items.map((item) => FriendsModel.fromJson(item)).toList();
          if (tabIndex == 2) {
            userList.addAll(friends);
            userList.sort((a, b) => a.name!.compareTo(b.name!));
            print("userList>>>>>>${json.encode(userList)}");
            filterList(searchController.text);
          } else {
            myFriendsList.addAll(friends);
            myFriendsList.sort((a, b) =>
                a.senderDetail!.name!.compareTo(b.senderDetail!.name!));
            print("myFriendsList>>>>>>$myFriendsList");
            print("myFriendsList>>>>>>${json.encode(myFriendsList)}");
          }
        } else {
          hasMoreData = false;
        }
      });
    } catch (e) {
      debugPrint('Error fetching friends request: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> getFriendsRequest1(bool load) async {
    String type = tabController.index == 0
        ? "accepted"
        : tabController.index == 1
        ? "pending"
        : "all";
    if (isLoading || !hasMoreData) return;
    setState(() {
      isLoading = true;
    });
    try {
      var onValue =
      await ApiServices.getFriendsRequest(context, page, load, type);
      if (mounted && onValue.status == true) {
        print("onvalue>>>>>>$onValue");
        setState(() {
          var items = onValue.data as List<dynamic>? ?? [];
          myFriendsList.clear();
          if (items.isNotEmpty) {
            if (tabIndex == 2) {
              var friends = items
                  .map((item) => UserIdentityModel.fromJson(item))
                  .toList();
              friends.sort((a, b) => b.id!.compareTo(a.id!));
              userList.addAll(friends);
              debugPrint("items...$items");
            } else {
              var friends =
              items.map((item) => FriendsModel.fromJson(item)).toList();
              friends.sort((a, b) => b.id!.compareTo(a.id!));
              myFriendsList.addAll(friends);
            }
            print("myFriendsList>>>>>>${myFriendsList}");
          } else {
            hasMoreData = false;
          }
        });
      }
    } catch (e) {
      debugPrint('Error fetching stories: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void showUnfriendDialog(BuildContext context) {
    final bool isIpad = MediaQuery.of(context).size.width > 600;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Unfriend",
            style: TextStyle(fontSize: isIpad ? 24.0 : 18.0),
          ),
          content: Text(
            "Are you sure you want to remove this friend?",
            style: TextStyle(fontSize: isIpad ? 20.0 : 16.0),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: TextStyle(fontSize: isIpad ? 18.0 : 14.0),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                acceptRejectOnCallBack("");
              },
              child: Text(
                "Unfriend",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: isIpad ? 18.0 : 14.0,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  acceptNoPopup(String title) {
    final bool isIpad = MediaQuery.of(context).size.width > 600;

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.only(
            left: isIpad ? 15.0 : 5.0,
            right: isIpad ? 15.0 : 5.0,
            bottom: isIpad ? 15.0 : 10.0,
            top: isIpad ? 15.0 : 10.0,
          ),
          insetPadding: EdgeInsets.zero,
          title: Center(
            child: Text(
              title,
              style: TextStyle(fontSize: isIpad ? 24.0 : 18.0),
            ),
          ),
          content: Container(
            width: MediaQuery.of(context).size.width * (isIpad ? 0.70 : 0.80),
            margin: EdgeInsets.only(top: isIpad ? 20.0 : 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColor.white,
                    overlayColor: MyColor.liteOrange,
                    enableFeedback: true,
                    enabledMouseCursor: MouseCursor.defer,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(isIpad ? 12.0 : 10.0),
                    ),
                    minimumSize: Size(isIpad ? 120.0 : 100.0, isIpad ? 50.0 : 40.0),
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Text(
                        Languages.of(context)!.no.toString(),
                        style: mediumTextStyle(
                          fontSize: isIpad ? 18.0 : 13.0,
                          color: MyColor.appTheme,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColor.appTheme,
                    overlayColor: MyColor.liteOrange,
                    enableFeedback: true,
                    enabledMouseCursor: MouseCursor.defer,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(isIpad ? 12.0 : 10.0),
                    ),
                    padding: EdgeInsets.zero,
                    minimumSize: Size(isIpad ? 120.0 : 100.0, isIpad ? 50.0 : 40.0),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Future.delayed(Duration.zero, acceptReject);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Languages.of(context)!.yes.toString(),
                        style: mediumTextStyle(
                          fontSize: isIpad ? 18.0 : 13.0,
                          color: MyColor.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  showPopup(int index, int id, String role, String type) {
    final bool isIpad = MediaQuery.of(context).size.width > 600;

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.only(
            left: isIpad ? 15.0 : 10.0,
            right: isIpad ? 15.0 : 10.0,
            bottom: isIpad ? 15.0 : 10.0,
            top: isIpad ? 15.0 : 10.0,
          ),
          title: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: isIpad ? 25.0 : 20.0),
            child: Text(
              "Undo friend request",
              style: TextStyle(
                color: Colors.black,
                fontSize: isIpad ? 28.0 : 25.0,
              ),
            ),
          ),
          content: Container(
            padding: EdgeInsets.only(bottom: isIpad ? 15.0 : 10.0),
            width: MediaQuery.of(context).size.width * (isIpad ? 0.70 : 0.60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColor.white,
                    overlayColor: MyColor.liteOrange,
                    enableFeedback: true,
                    enabledMouseCursor: MouseCursor.defer,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(isIpad ? 12.0 : 10.0),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Text(
                        Languages.of(context)!.no.toString(),
                        style: mediumTextStyle(
                          fontSize: isIpad ? 18.0 : 13.0,
                          color: MyColor.appTheme,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColor.appTheme,
                    overlayColor: MyColor.liteOrange,
                    enableFeedback: true,
                    enabledMouseCursor: MouseCursor.defer,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(isIpad ? 12.0 : 10.0),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    sendRequestOnTap(index, id, role, type);
                    senderDetail.friendRequestStatus = "";
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Languages.of(context)!.yes.toString(),
                        style: mediumTextStyle(
                          fontSize: isIpad ? 18.0 : 13.0,
                          color: MyColor.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}