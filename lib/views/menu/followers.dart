import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';

import '../../constant/my_color.dart';
import '../../constant/my_fonts_style.dart';
import '../../constant/sized_box.dart';
import '../../constant/stringfile.dart/language.dart';
import '../../model/dynamic_models/followlist_model.dart';
import '../../model/dynamic_models/user_identity_model.dart';
import '../../model/post_model/send_friend_request.dart';
import '../../services/api_path.dart';
import '../../services/api_services.dart';
import '../../services/user_prefences.dart';
import '../../utils/ui_utils.dart';

class FollowersScr extends StatefulWidget {
  final int? index;
  const FollowersScr({super.key, this.index});

  @override
  State<FollowersScr> createState() => _FollowersScrState();
}

class _FollowersScrState extends State<FollowersScr>
    with TickerProviderStateMixin {
  late final TabController tabController;
  List<String> tabItemList = [];
  List<IAmFollowing> followingList = [];
  List<MyFollowers> followerList = [];
  Followlist followlistRes = Followlist();
  UserIdentityModel userDetails = UserIdentityModel();
  @override
  void initState() {
    setTabItem();
    // TODO: implement initState
    super.initState();
    getUserData();
    getfollwerDetail();
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

  void setTabItem() {
    tabItemList = [
      "My Followers",
      "I’m Following",
    ];
    tabController = TabController(
        vsync: this, length: tabItemList.length, initialIndex: widget.index!);
    // Future.delayed(Duration.zero, () {
    //   getFriendsRequest(true);
    // });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  int totalPage = 1;
  int page = 1;
  int tabIndex = 0;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
      final bool isTab = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        automaticallyImplyLeading: false,
        backgroundColor: MyColor.yellowF6F1E1,
        surfaceTintColor: MyColor.yellowF6F1E1,
        title: Padding(
          padding: const EdgeInsets.only(left: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TouchRippleEffect(
                borderRadius: BorderRadius.circular(30),
                rippleColor: Colors.white,
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 30,
                  color: Colors.black,
                ),
              ),
              Text(Languages.of(context)!.follow,
                  style: mediumTextStyle(fontSize: 18.0, color: MyColor.black)),
            ],
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          TabBar(
            dividerColor: MyColor.colorE5E9F4,
            indicatorColor: MyColor.appTheme,
            controller: tabController,
            onTap: (value) {
              setState(() {
                getfollwerDetail();
              });
            },
            tabs: List.generate(tabItemList.length, (index) {
              return UiUtils.tabItem(context, size, tabItemList[index],isTab);
            }),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                followUi(size),
                followingUi(size),
              ],
            ),
          ),
        ],
      ),
    );
  }

  followUi(var size) {
    return listFollowerView();
  }

  followingUi(Size size) {
    return listfollowingView();
  }

  listFollowerView() {
    final isSearchTab = tabIndex == 2;

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
            ListView.builder(
              padding: EdgeInsets.only(top: 10),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: followerList.length,
              itemBuilder: (BuildContext context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 5, bottom: 0),
                  child: Column(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        decoration: BoxDecoration(
                          color: MyColor.white,
                          borderRadius: BorderRadius.circular(
                              12), // Optional rounded corners
                        ),
                        alignment: Alignment
                            .center, // Centers text vertically and horizontally
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // ClipRRect(
                            //   borderRadius: BorderRadius.circular(10),
                            //   child: Image.network(followlistRes.iAmFollowing![index].receiverDetails!.image!.toString(),height: 70,),
                            // ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(500),
                              child: UiUtils.networkProfile(
                                  60,
                                  60,
                                  followerList[index]
                                              .userDetails!
                                              .image!
                                              .toString() !=
                                          null
                                      ? ApiPath.imageBaseUrl +
                                          followerList[index]
                                              .userDetails!
                                              .image!
                                              .toString()
                                      : ""),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                  followerList[index]
                                                      .userDetails!
                                                      .name
                                                      .toString(),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: mediumTextStyle(
                                                      fontSize: 16.0,
                                                      color: MyColor.black)),
                                              followerList[index]
                                                          .userDetails
                                                          .toString() ==
                                                      "accepted"
                                                  ? Container(
                                                      height: 25,
                                                      decoration: BoxDecoration(
                                                          color: MyColor.grey3,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          6))),
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      margin: EdgeInsets.only(
                                                          left: 10),
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
                                                            height: 15,
                                                          ),
                                                          SizedBox(
                                                            width: 2,
                                                          ),
                                                          Text("Friends",
                                                              style: regularNormalTextStyleWithoutHeight(
                                                                  fontSize:
                                                                      12.0,
                                                                  color: MyColor
                                                                      .black)),
                                                        ],
                                                      ),
                                                    )
                                                  : Container()
                                            ],
                                          ),
                                          hsized3,
                                          followerList[index]
                                                      .userDetails!
                                                      .role ==
                                                  "kid"
                                              ? Row(
                                                  children: [
                                                    followerList[index]
                                                                .userDetails!
                                                                .day
                                                                .toString() ==
                                                            "null"
                                                        ? Container()
                                                        : Text(
                                                            "${followerList[index].userDetails!.day} |",
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: regularTextStyle(
                                                                fontSize: 14.0,
                                                                color: MyColor
                                                                    .black)),
                                                    followerList[index]
                                                                .userDetails!
                                                                .month
                                                                .toString() ==
                                                            "null"
                                                        ? Container()
                                                        : Text(
                                                            "${followerList[index].userDetails!.month} | ",
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: regularTextStyle(
                                                                fontSize: 14.0,
                                                                color: MyColor
                                                                    .black)),
                                                    followerList[index]
                                                                .userDetails!
                                                                .year ==
                                                            "null"
                                                        ? Container()
                                                        : Text(
                                                            "${followerList[index].userDetails!.year} | ",
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: regularTextStyle(
                                                                fontSize: 14.0,
                                                                color: MyColor
                                                                    .black)),
                                                    followerList[index]
                                                                .userDetails!
                                                                .grade ==
                                                            "null"
                                                        ? Container()
                                                        : Text(
                                                            "${followerList[index].userDetails!.grade}",
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: regularTextStyle(
                                                                fontSize: 14.0,
                                                                color: MyColor
                                                                    .black)),
                                                  ],
                                                )
                                              : Container(),
                                        ],
                                      ),
                                    ),
                                    followerList[index]
                                                .userDetails!
                                                .friendrequeststatus ==
                                            "request not sent"
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, right: 5),
                                            child: InkWell(
                                                radius: 60,
                                                onTap: () {
                                                  sendRequestOnTap(
                                                      index, followerList);
                                                },
                                                child: Container(
                                                    height: 35,
                                                    width: 35,
                                                    decoration: BoxDecoration(
                                                        color: MyColor
                                                            .yellowF6F1E1,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    6))),
                                                    child: Center(
                                                        child: Image.asset(
                                                      "assets/images/addperson1.png",
                                                      height: 18,
                                                    )))),
                                          )
                                        : Container()
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  listfollowingView() {
    final isSearchTab = tabIndex == 2;

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
            ListView.builder(
              padding: EdgeInsets.only(top: 10),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: followingList.length,
              itemBuilder: (BuildContext context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 5, bottom: 0),
                  child: Column(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        decoration: BoxDecoration(
                          color: MyColor.white,
                          borderRadius: BorderRadius.circular(
                              12), // Optional rounded corners
                        ),
                        alignment: Alignment
                            .center, // Centers text vertically and horizontally
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // ClipRRect(
                            //   borderRadius: BorderRadius.circular(10),
                            //   child: Image.network(followlistRes.iAmFollowing![index].receiverDetails!.image!.toString(),height: 70,),
                            // ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(500),
                              child: UiUtils.networkProfile(
                                  60,
                                  60,
                                  followingList[index]
                                              .userDetails!
                                              .image
                                              .toString() !=
                                          null
                                      ? ApiPath.imageBaseUrl +
                                          followingList[index]
                                              .userDetails!
                                              .image
                                              .toString()
                                      : ""),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                  followingList[index]
                                                      .userDetails!
                                                      .name
                                                      .toString(),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: mediumTextStyle(
                                                      fontSize: 16.0,
                                                      color: MyColor.black)),
                                              followingList[index]
                                                          .userDetails!
                                                          .friendrequeststatus ==
                                                      "accepted"
                                                  ? Container(
                                                      height: 25,
                                                      decoration: BoxDecoration(
                                                          color: MyColor.grey3,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          6))),
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      margin: EdgeInsets.only(
                                                          left: 10),
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
                                                            height: 15,
                                                          ),
                                                          SizedBox(
                                                            width: 2,
                                                          ),
                                                          Text("Friends",
                                                              style: regularNormalTextStyleWithoutHeight(
                                                                  fontSize:
                                                                      12.0,
                                                                  color: MyColor
                                                                      .black)),
                                                        ],
                                                      ),
                                                    )
                                                  : Container()
                                            ],
                                          ),
                                          hsized3,
                                          Row(
                                            children: [
                                              followingList[index]
                                                          .userDetails!
                                                          .role ==
                                                      "kid"
                                                  ? Row(
                                                      children: [
                                                        followingList[index]
                                                                    .userDetails!
                                                                    .day
                                                                    .toString() ==
                                                                "null"
                                                            ? Container()
                                                            : Text(
                                                                "${followingList[index].userDetails!.day} |",
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: regularTextStyle(
                                                                    fontSize:
                                                                        14.0,
                                                                    color: MyColor
                                                                        .black)),
                                                        followingList[index]
                                                                    .userDetails!
                                                                    .month
                                                                    .toString() ==
                                                                "null"
                                                            ? Container()
                                                            : Text(
                                                                "${followingList[index].userDetails!.month} | ",
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: regularTextStyle(
                                                                    fontSize:
                                                                        14.0,
                                                                    color: MyColor
                                                                        .black)),
                                                        followingList[index]
                                                                    .userDetails!
                                                                    .year ==
                                                                "null"
                                                            ? Container()
                                                            : Text(
                                                                "${followingList[index].userDetails!.year} |",
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: regularTextStyle(
                                                                    fontSize:
                                                                        14.0,
                                                                    color: MyColor
                                                                        .black)),
                                                        followingList[index]
                                                                    .userDetails!
                                                                    .grade ==
                                                                "null"
                                                            ? Container()
                                                            : Text(
                                                                " ${followingList[index].userDetails!.grade}",
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: regularTextStyle(
                                                                    fontSize:
                                                                        14.0,
                                                                    color: MyColor
                                                                        .black)),
                                                      ],
                                                    )
                                                  : Container(),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 1, right: 5),
                                                child: InkWell(
                                                    radius: 60,
                                                    onTap: () {
                                                      followRequestOnTap(
                                                          index, followingList);
                                                      setState(() {});
                                                    },
                                                    child: Container(
                                                        height: 23,
                                                        width: 60,
                                                        padding:
                                                            EdgeInsets.all(1),
                                                        decoration: BoxDecoration(
                                                            color: MyColor
                                                                .yellowF6F1E1,
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        6))),
                                                        child: Center(
                                                            child: Text(
                                                                "Unfollow",
                                                                style: regularTextStyle(
                                                                    fontSize:
                                                                        10.0,
                                                                    color: MyColor
                                                                        .black))))),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    followingList[index]
                                                .userDetails!
                                                .friendrequeststatus ==
                                            "request not sent"
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, right: 5),
                                            child: InkWell(
                                                radius: 60,
                                                onTap: () {
                                                  sendRequestOnTap(
                                                      index, followingList);
                                                  setState(() {});
                                                },
                                                child: Container(
                                                    height: 35,
                                                    width: 35,
                                                    decoration: BoxDecoration(
                                                        color: MyColor
                                                            .yellowF6F1E1,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    6))),
                                                    child: Center(
                                                        child: Image.asset(
                                                      "assets/images/addperson1.png",
                                                      height: 18,
                                                    )))),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  void followRequestOnTap(int index, List data) async {
    if (data[index].userDetails!.friendrequeststatus != "") {
      FollowRequest friendRequest = FollowRequest(
        senderId: int.parse(userDetails.id ?? "0"),
        receiverId: int.parse(data[index].userDetails!.id!),
        requestSentBy: userDetails.role,
        requestSentTo: data[index].userDetails!.role,
      );
      await ApiServices.followRequest(context, friendRequest).then((onValue) {
        if (onValue.status == true) {
          if (mounted) {
            setState(() {
              getfollwerDetail();
            });
          }
        }
      });
    }
  }

  void sendRequestOnTap(int index, List data) async {
    if (data[index].userDetails!.friendrequeststatus == "request not sent") {
      SendFriendRequest friendRequest = SendFriendRequest(
        senderId: int.parse(userDetails.id ?? "0"),
        receiverId: int.parse(data[index].userDetails!.id!),
        requestSentBy: userDetails.role,
        requestSentTo: data[index].userDetails!.role,
      );

      await ApiServices.sendRequest(context, friendRequest).then((onValue) {
        if (onValue.status == true) {
          getfollwerDetail();
          if (mounted) {
            setState(() {
              // recipeModel.recipeAddedBy!.friendRequestStatus.toString() ==
              //     "pending"
              //     ? recipeModel.recipeAddedBy!.friendRequestStatus =
              // "request not sent"
              //     : recipeModel.recipeAddedBy!.friendRequestStatus = "pending";
            });
          }
        }
      });
    }
  }

  getfollwerDetail() async {
    try {
      var onValue = await ApiServices.followDetail(context, false);
      print("onValue.data>>>>>>>>>${onValue.data}");

      if (mounted) {
        setState(() {
          if (onValue.status == true && onValue.data != null) {
            print("onValue.data>>>>>>>>>${onValue.data}");

            // Ensure followeList is properly initialized
            followingList
                .clear(); // Optional: Clears the list before adding new data

            if (onValue.data['I_am_following'] != null) {
              followingList.addAll(
                (onValue.data['I_am_following'] as List)
                    .map((item) => IAmFollowing.fromJson(item))
                    .toList(),
              );
            }
            followerList
                .clear(); // Optional: Clears the list before adding new data

            if (onValue.data['my_followers'] != null) {
              followerList.addAll(
                (onValue.data['my_followers'] as List)
                    .map((item) => MyFollowers.fromJson(item))
                    .toList(),
              );
            }
            print("Updated followeList length: ${followingList.length}");
          } else {
            print("onValue.status is false or onValue.data is null");
          }
        });
      }
    } catch (e, stackTrace) {
      print("Error in getProfileDetail(): $e");
      print(stackTrace);
    }
  }
}
