import 'dart:convert';

import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/constant/stringfile.dart/language.dart';
import 'package:cooking_champs/enums/register_enum.dart';
import 'package:cooking_champs/model/dynamic_models/user_identity_model.dart';
import 'package:cooking_champs/my_orders/my_orders_new.dart';
import 'package:cooking_champs/new_ui/cart_shops_details/shopes/Shopes.dart';
import 'package:cooking_champs/new_ui/login_new_view.dart';
import 'package:cooking_champs/new_ui/manage_address.dart';
import 'package:cooking_champs/new_ui/membership_new.dart';
import 'package:cooking_champs/services/api_path.dart';
import 'package:cooking_champs/services/api_services.dart';
import 'package:cooking_champs/services/user_prefences.dart';
import 'package:cooking_champs/utils/all_dialogs.dart';
import 'package:cooking_champs/utils/navigators.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:cooking_champs/views/authentication/change_password_view.dart';
import 'package:cooking_champs/views/dashboard.dart';
import 'package:cooking_champs/views/friend_request.dart';
import 'package:cooking_champs/views/helpsupport.dart';
import 'package:cooking_champs/views/my_kids_listing_view.dart';
import 'package:cooking_champs/views/profile/editprofile.dart';
import 'package:cooking_champs/views/save_view.dart';
import 'package:cooking_champs/widgets/delete_account_popup.dart';
import 'package:cooking_champs/widgets/logout_popup.dart';
import 'package:cooking_champs/widgets/view_full_image.dart';
import 'package:flutter/material.dart';

import '../../constant/app_state.dart';
import '../../model/dynamic_models/termcondirion.dart';
import '../privacypolicy.dart';
import 'followers.dart';
import 'dart:developer' as developer;

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  UserIdentityModel userDetails = UserIdentityModel();
  String friendRequestCount = "0";
  String loginType = "";

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      loadLoginType();
      callApi(context);
    });

    getUserData();
    getProfileDetail();
    super.initState();
  }

  void loadLoginType() async {
    loginType = await PreferencesServices.getPreferencesData(
        PreferencesServices.loginType);
    loginType = loginType;
    print("isLogin: $loginType");
  }

  void getUserData() async {
    var data = await PreferencesServices.getPreferencesData(
        PreferencesServices.loginUserIdentityDetails);
    if (data != null) {
      Map<String, dynamic> jsonResponse = await jsonDecode(data);
      if (mounted) {
        setState(() {
          userDetails = UserIdentityModel.fromJson(jsonResponse);
          print("onValue.data>>>>>>>>>${jsonResponse}");
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    countFriendRequestApi();
    final data = MediaQuery.of(context);
    final size = data.size;
    return
      Scaffold(
        backgroundColor: Colors.transparent,
        bottomNavigationBar: MediaQuery.removePadding(
          context: context,
          removeLeft: true,
          removeRight: true,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: MyColor.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            //   alignment: Alignment.bottomCenter,
            child: SafeArea(
              top: false,
              child: Column(
                children: [
                  hsized10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 5,
                        decoration: const BoxDecoration(
                            color: MyColor.liteGrayB5B5B5,
                            borderRadius:
                            BorderRadius.all(Radius.circular(20))),
                      ),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(
                                top: 15, bottom: 15, left: 20, right: 20),
                            // padding: const EdgeInsets.only(top: 10, bottom: 10),
                            width: size.width,
                            // height: 90,
                            decoration: const BoxDecoration(
                                color: MyColor.yellowF6F1E1,
                                borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0, right: 5, top: 5, bottom: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            AllDialogs.customDialog(
                                              context,
                                              ViewFullImage(
                                                image: userDetails.image != null
                                                    ? userDetails.image
                                                    .toString()
                                                    : "",
                                              ),
                                            );
                                          },
                                          child: buildProfileImage(
                                            userDetails.image != null
                                                ? ApiPath.imageBaseUrl +
                                                userDetails.image.toString()
                                                : "",
                                            userDetails
                                                .isPurchaseSubscription ??
                                                false,
                                          )),
                                      // Expanded(
                                      //   flex: 30,
                                      //   child: InkWell(
                                      //     onTap: () {
                                      //       AllDialogs.customDialog(
                                      //         context,
                                      //         ViewFullImage(
                                      //           image: userDetails.image != null
                                      //               ? userDetails.image
                                      //                   .toString()
                                      //               : "",
                                      //         ),
                                      //       );
                                      //     },
                                      //     child: buildProfileImage(
                                      //       userDetails.image != null
                                      //           ? ApiPath.imageBaseUrl +
                                      //               userDetails.image.toString()
                                      //           : "",
                                      //       userDetails
                                      //               .isPurchaseSubscription ??
                                      //           false,
                                      //     ),
                                      //   ),
                                      // ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(userDetails.name ?? "",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: mediumTextStyle(
                                                  fontSize: (AppState.devicetype == "ipad") ? 24.0 : 17.0,
                                                  color: MyColor.black)),
                                          GestureDetector(
                                            onTap: () {
                                              followingOnTap();
                                            },
                                            child: Text(
                                                "${Languages.of(context)!.following}    ${userDetails.following}",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: mediumTextStyle(
                                                    fontSize: (AppState.devicetype == "ipad") ? 21.0 : 14.0,
                                                    color: MyColor.grey2)),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              followersOnTap();
                                            },
                                            child: Text(
                                                "${Languages.of(context)!.followers}    ${userDetails.followers}",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: mediumTextStyle(
                                                    fontSize: (AppState.devicetype == "ipad") ? 21.0 : 14.0,
                                                    color: MyColor.grey2)),
                                          ),
                                        ],
                                      ),
                                      // Expanded(
                                      //   flex: 30,
                                      //   child: SingleChildScrollView(
                                      //     child: Column(
                                      //       mainAxisAlignment:
                                      //           MainAxisAlignment.start,
                                      //       crossAxisAlignment:
                                      //           CrossAxisAlignment.start,
                                      //       children: [
                                      //         Text(userDetails.name ?? "",
                                      //             overflow:
                                      //                 TextOverflow.ellipsis,
                                      //             maxLines: 2,
                                      //             style: mediumTextStyle(
                                      //                 fontSize: 17.0,
                                      //                 color: MyColor.black)),
                                      //         hsized5,
                                      //         InkWell(
                                      //           radius: 30,
                                      //           onTap: () {
                                      //             followingOnTap();
                                      //           },
                                      //           child: Text(
                                      //               "${Languages.of(context)!.following}    ${userDetails.following}",
                                      //               overflow:
                                      //                   TextOverflow.ellipsis,
                                      //               maxLines: 2,
                                      //               style: mediumTextStyle(
                                      //                   fontSize: 14.0,
                                      //                   color: MyColor.grey2)),
                                      //         ),
                                      //         InkWell(
                                      //           radius: 30,
                                      //           onTap: () {
                                      //             followersOnTap();
                                      //           },
                                      //           child: Text(
                                      //               "${Languages.of(context)!.followers}    ${userDetails.followers}",
                                      //               overflow:
                                      //                   TextOverflow.ellipsis,
                                      //               maxLines: 2,
                                      //               style: mediumTextStyle(
                                      //                   fontSize: 14.0,
                                      //                   color: MyColor.grey2)),
                                      //         ),
                                      //       ],
                                      //     ),
                                      //   ),
                                      // ),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                              MyColor.appTheme,
                                              overlayColor:
                                              MyColor.liteOrange,
                                              enableFeedback: true,
                                              enabledMouseCursor:
                                              MouseCursor.defer,
                                              elevation: 5,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    10), // Custom shape
                                              ),
                                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7)),
                                          onPressed: () {
                                            AllDialogs.customDialog(
                                                context, LogoutPopup());
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                  height: (AppState.devicetype == "ipad") ? 40 : 20,
                                                  width: (AppState.devicetype == "ipad") ? 40 : 20,
                                                  AssetsPath.logout),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                  Languages.of(context)!
                                                      .logout
                                                      .toString(),
                                                  overflow: TextOverflow.ellipsis,
                                                  style: mediumTextStyle(
                                                      fontSize: (AppState.devicetype == "ipad") ? 20.0 : 13.0,
                                                      color:
                                                      MyColor.white)),
                                            ],
                                          )
                                      ),
                                      // Expanded(
                                      //   child: SizedBox(
                                      //     //width: size.width * 0.25,
                                      //     height: 37,
                                      //     child: ElevatedButton(
                                      //         style: ElevatedButton.styleFrom(
                                      //             backgroundColor:
                                      //                 MyColor.appTheme,
                                      //             overlayColor:
                                      //                 MyColor.liteOrange,
                                      //             enableFeedback: true,
                                      //             enabledMouseCursor:
                                      //                 MouseCursor.defer,
                                      //             elevation: 5,
                                      //             shape: RoundedRectangleBorder(
                                      //               borderRadius:
                                      //                   BorderRadius.circular(
                                      //                       10), // Custom shape
                                      //             ),
                                      //             padding: EdgeInsets.zero),
                                      //         onPressed: () {
                                      //           AllDialogs.customDialog(
                                      //               context, LogoutPopup());
                                      //         },
                                      //         child: Row(
                                      //           mainAxisAlignment:
                                      //               MainAxisAlignment.center,
                                      //           children: [
                                      //             Expanded(
                                      //               child: Padding(
                                      //                 padding:
                                      //                     const EdgeInsets.only(
                                      //                         left: 12,
                                      //                         right: 10),
                                      //                 child: Image.asset(
                                      //                     height: 20,
                                      //                     width: 20,
                                      //                     AssetsPath.logout),
                                      //               ),
                                      //             ),
                                      //             Expanded(
                                      //               child: Text(
                                      //                   Languages.of(context)!
                                      //                       .logout
                                      //                       .toString(),
                                      //                   style: mediumTextStyle(
                                      //                       fontSize: 13.0,
                                      //                       color:
                                      //                           MyColor.white)),
                                      //             ),
                                      //           ],
                                      //         )),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(Languages.of(context)!.explore.toString(),
                                    style: regularTextStyle(
                                        fontSize:(AppState.devicetype == "ipad") ? 20.0 : 13.0, color: MyColor.black)),
                                hsized10,
                                itemCard(
                                    size,
                                    Languages.of(context)!
                                        .kidLearning
                                        .toString(),
                                    AssetsPath.person,
                                    1,
                                    kidLearningOnTap),
                                itemCard(
                                    size,
                                    Languages.of(context)!.shop.toString(),
                                    AssetsPath.shop,
                                    1,
                                    shopOnTap),
                                userDetails.role == RegisterType.roleKids.value
                                    ? SizedBox.shrink()
                                    : itemCard(
                                    size,
                                    Languages.of(context)!
                                        .myOrders
                                        .toString(),
                                    AssetsPath.myOrders,
                                    1,
                                    myOrdersOnTap),
                                userDetails.role == RegisterType.roleKids.value
                                    ? SizedBox.shrink()
                                    : itemCard(
                                    size,
                                    Languages.of(context)!
                                        .manageAddress
                                        .toString(),
                                    AssetsPath.manageAddress,
                                    1,
                                    addressOnTap),
                                // userDetails.role == RegisterType.roleKids.value
                                //     ? SizedBox.shrink()
                                //     : itemCard(
                                //         size,
                                //         Languages.of(context)!
                                //             .memberships
                                //             .toString(),
                                //         AssetsPath.memberships,
                                //         1,
                                //         sMembershipsOnTap),
                                itemCard(
                                    size,
                                    Languages.of(context)!.memories.toString(),
                                    AssetsPath.overstories,
                                    2,
                                    ourStoriesOnTap),
                                itemCard(
                                    size,
                                    Languages.of(context)!
                                        .bookmarkRecipes
                                        .toString(),
                                    AssetsPath.bookmarkIc,
                                    3,
                                    bookmarkOnTap),
                                (loginType == "individual" ||
                                    userDetails.role ==
                                        RegisterType.roleKids.value)
                                    ? SizedBox.shrink()
                                    : itemCard(
                                    size,
                                    Languages.of(context)!
                                        .myKids
                                        .toString(),
                                    AssetsPath.kitslearningorange,
                                    4,
                                    myKidsOnTap),
                                itemCard(
                                    size,
                                    Languages.of(context)!
                                        .friendRequest
                                        .toString(),
                                    AssetsPath.addPerson,
                                    5,
                                    friendRequestOnTap),
                                // itemCard(
                                //     size,
                                //     Languages.of(context)!
                                //         .inviteFriends
                                //         .toString(),
                                //     AssetsPath.inviteFriends,
                                //     6,
                                //     inviteRequestOnTap),
                                itemCard(
                                    size,
                                    Languages.of(context)!.aboutUs.toString(),
                                    AssetsPath.aboutus,
                                    7,
                                    aboutOnTap),
                              ],
                            ),
                          ),
                          const Divider(
                            color: MyColor.colorDADADA,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(Languages.of(context)!.support.toString(),
                                    style: regularTextStyle(
                                        fontSize: (AppState.devicetype == "ipad") ? 20.0 : 13.0, color: MyColor.black)),
                                hsized10,
                                userDetails.role == RegisterType.roleKids.value
                                    ? itemCard(
                                    size,
                                    Languages.of(context)!
                                        .helpSupport
                                        .toString(),
                                    AssetsPath.help,
                                    9,
                                    helpSupportOnTap)
                                    : Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    itemCard(
                                        size,
                                        Languages.of(context)!
                                            .editProfile
                                            .toString(),
                                        AssetsPath.editprofile,
                                        8,
                                        editProfileOnTap),
                                    itemCard(
                                        size,
                                        Languages.of(context)!
                                            .changePassword
                                            .toString(),
                                        AssetsPath.changepassword,
                                        9,
                                        changePassOnTap),
                                    itemCard(
                                        size,
                                        Languages.of(context)!
                                            .privacypolicy
                                            .toString(),
                                        AssetsPath.privacypolicy,
                                        10,
                                        privacypolicyOnTap),
                                    itemCard(
                                        size,
                                        Languages.of(context)!
                                            .termcondition
                                            .toString(),
                                        AssetsPath.termcondition,
                                        11,
                                        termConditionOnTap),
                                    itemCard(
                                        size,
                                        Languages.of(context)!
                                            .helpSupport
                                            .toString(),
                                        AssetsPath.help,
                                        12,
                                        helpSupportOnTap),
                                    itemCard(
                                        size,
                                        Languages.of(context)!
                                            .deleteAccount
                                            .toString(),
                                        AssetsPath.delete,
                                        13,
                                        deleteAccountOnTap),
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.04,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }

  itemCard(
      var size, String title, String img, int id, GestureTapCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
          padding: EdgeInsets.only(bottom: 20, top: 10),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  width: size.width,
                  // Adjust this value as per your layout needs
                  child: Row(
                    children: [
                      Image.asset(
                        height: (AppState.devicetype == "ipad") ? 35 : 23,
                        width: (AppState.devicetype == "ipad") ? 35 : 23,
                        img,
                        color: id == 13 ? MyColor.red : MyColor.appTheme,
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Text(title,
                            style: regularTextStyle(
                                fontSize: (AppState.devicetype == "ipad") ? 20.0 : 13.0,
                                color: id == 13 ? MyColor.red : MyColor.black)),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      int.parse(friendRequestCount.toString()) > 0 && id == 5
                          ? Container(
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: MyColor.appTheme,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            friendRequestCount,
                            style: TextStyle(color: MyColor.white),
                          ),
                        ),
                      )
                          : SizedBox.shrink(),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: (AppState.devicetype == "ipad") ? 32 : 20,
                        color: id == 13 ? MyColor.red : Colors.black,
                      ),
                    ],
                  ),
                ),
              )
            ],
          )

        /*  ListTile(
          contentPadding: EdgeInsets.zero,
          minLeadingWidth: size.width,
          splashColor: MyColor.appTheme.withOpacity(0.02),
          minTileHeight: 40,
          onTap: onTap,
          leading: SizedBox(
            width: size.width * 0.80,
            // Adjust this value as per your layout needs
            child: Row(
              children: [
                Image.asset(
                  height: 23,
                  width: 23,
                  img,
                  color: id == 13 ? MyColor.red : MyColor.appTheme,
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(title,
                      style: regularTextStyle(
                          fontSize: 13.0,
                          color: id == 13 ? MyColor.red : MyColor.black)),
                ),
              ],
            ),
          ),
          trailing: SizedBox(
            width: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                int.parse(friendRequestCount.toString()) > 0 && id == 5
                    ? Container(
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: MyColor.appTheme,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            friendRequestCount,
                            style: TextStyle(color: MyColor.white),
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 20,
                  color: id == 13 ? MyColor.red : Colors.black,
                ),
              ],
            ),
          ),
        ),*/
      ),
    );
  }

  void kidLearningOnTap() {
    setState(() {
      isTabExplore = true;
      pageIndex = 4;
      tabCheck = "kids";
    });
    Navigator.pop(context);
    // CustomNavigators.pushRemoveUntil(const DashBoardView(
    //   pageIndex: 3,
    //   tabCheck: "kids",
    // ), context);
  }

  void shopOnTap() {
    CustomNavigators.pushNavigate(const Shopesclass(), context);
  }

  void addressOnTap() {
    CustomNavigators.pushNavigate(const ManageAddress(), context);
  }

  void myOrdersOnTap() {
    CustomNavigators.pushNavigate(const MyOrdersNew(), context);
  }

  void sMembershipsOnTap() {
    CustomNavigators.pushNavigate(const MembershipNew(), context);
  }

  void friendRequestOnTap() {
    setState(() {
      isTabExplore = true;
    });
    CustomNavigators.pushNavigate(
        FriendRequestView(
          type: 'menu',
        ),
        context);
  }

  void ourStoriesOnTap() {
    Navigator.pop(context);
    setState(() {
      isTabExplore = true;
      pageIndex = 3;
      tabCheck = "OurStories";
    });
  }

  void myKidsOnTap() {
    setState(() {
      isTabExplore = true;
    });
    CustomNavigators.pushNavigate(
        const MyKidsListingView(pageType: 'MyKids'), context);
  }

  void aboutOnTap() {
    Navigator.pop(context);
    setState(() {
      isTabExplore = true;
      pageIndex = 4;
      tabCheck = "Aboutus";
    });
  }

  void editProfileOnTap() {
    CustomNavigators.pushNavigate(
        EditProfileView(
          onUpdate: onUpdate,
        ),
        context);
  }

  void changePassOnTap() {
    CustomNavigators.pushNavigate(ChangePasswordView(), context);
  }

  void privacypolicyOnTap() {
    CustomNavigators.pushNavigate(PrivacyPolicyView(), context);
  }

  void termConditionOnTap() {
    CustomNavigators.pushNavigate(TermConditionView(), context);
  }

  void helpSupportOnTap() {
    CustomNavigators.pushNavigate(HelpSupportView(), context);
  }

  void followersOnTap() {
    CustomNavigators.pushNavigate(
        FollowersScr(
          index: 0,
        ),
        context);
  }

  void followingOnTap() {
    CustomNavigators.pushNavigate(
        FollowersScr(
          index: 1,
        ),
        context);
  }

  void deleteAccountOnTap() {
    AllDialogs.customDialog(
        context, DeleteAccountPopup(onCallBack: onDeleteAccount));
  }

  onDeleteAccount(String t) {
    debugPrint("ttt..$t");
    Future.delayed(Duration.zero, deleteApi);
  }

  Future<void> deleteApi() async {
    await ApiServices.deleteAccount(context).then((onValue) {
      if (mounted) {
        if (onValue.status == true) {
          PreferencesServices.setLogoutPreferencesData();
          CustomNavigators.pushRemoveUntil(WelcomeCookingChampsView(), context);
        }
      }
    });
  }

  onUpdate() {
    Future.delayed(Duration.zero, getProfileDetail);
  }

  getProfileDetail() async {
    await ApiServices.userDetail(context, "", false).then((onValue) {
      if (mounted) {
        setState(() {
          if (onValue.status == true) {
            if (onValue.data != null) {
              userDetails = UserIdentityModel.fromJson(onValue.data);

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

  void countFriendRequestApi() {
    Future.delayed(const Duration(minutes: 1), () {
      // call API functionality
      //  callApi(context);
    });
  }

  callApi(BuildContext context) async {
    await ApiServices.countFriendRequest(context, false).then((onValue) {
      if (mounted) {
        setState(() {
          if (onValue.status == true) {
            friendRequestCount = onValue.pendingReqCount ?? "";
            //"1";
          }
        });
      }
    });
  }

  void bookmarkOnTap() {
    CustomNavigators.pushNavigate(BookmarkRecipeView(), context);
  }

  void inviteRequestOnTap() {
    // CustomNavigators.pushNavigate(InviteFriendsView(), context);
  }

  Widget buildProfileImage(String imageUrl, bool isMember) {
    return Container(
      height: (AppState.devicetype == "ipad") ? 100 : 75, // slightly increased to accommodate star below
      width: (AppState.devicetype == "ipad") ? 100 : 75,
      alignment: Alignment.center,
      child: Stack(
        clipBehavior: Clip.none, // 🔥 ensures star outside is visible
        alignment: Alignment.center,
        children: [
          if (isMember)
            Container(
              width: (AppState.devicetype == "ipad") ? 100 : 68,
              height: (AppState.devicetype == "ipad") ? 100 : 68,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: MyColor.orange, width: 3),
              ),
            ),

          // Profile Image
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: UiUtils.networkProfile(
              (AppState.devicetype == "ipad") ? 80 : 60,
              (AppState.devicetype == "ipad") ? 80 : 60,
              imageUrl,
            ),
          ),

          // Star badge
          if (isMember)
            Positioned(
              bottom: -6, // moved slightly down
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: MyColor.orange,
                ),
                child: Icon(
                  Icons.star,
                  color: Colors.white,
                  size: (AppState.devicetype == "ipad") ? 20 : 14,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// import 'dart:convert';
//
// import 'package:cooking_champs/constant/assets_path.dart';
// import 'package:cooking_champs/constant/my_color.dart';
// import 'package:cooking_champs/constant/my_fonts_style.dart';
// import 'package:cooking_champs/constant/sized_box.dart';
// import 'package:cooking_champs/constant/stringfile.dart/language.dart';
// import 'package:cooking_champs/enums/register_enum.dart';
// import 'package:cooking_champs/model/dynamic_models/user_identity_model.dart';
// import 'package:cooking_champs/my_orders/my_orders_new.dart';
// import 'package:cooking_champs/new_ui/cart_shops_details/shopes/Shopes.dart';
// import 'package:cooking_champs/new_ui/login_new_view.dart';
// import 'package:cooking_champs/new_ui/manage_address.dart';
// import 'package:cooking_champs/new_ui/membership_new.dart';
// import 'package:cooking_champs/services/api_path.dart';
// import 'package:cooking_champs/services/api_services.dart';
// import 'package:cooking_champs/services/user_prefences.dart';
// import 'package:cooking_champs/utils/all_dialogs.dart';
// import 'package:cooking_champs/utils/navigators.dart';
// import 'package:cooking_champs/utils/ui_utils.dart';
// import 'package:cooking_champs/views/authentication/change_password_view.dart';
// import 'package:cooking_champs/views/dashboard.dart';
// import 'package:cooking_champs/views/friend_request.dart';
// import 'package:cooking_champs/views/helpsupport.dart';
// import 'package:cooking_champs/views/my_kids_listing_view.dart';
// import 'package:cooking_champs/views/profile/editprofile.dart';
// import 'package:cooking_champs/views/save_view.dart';
// import 'package:cooking_champs/widgets/delete_account_popup.dart';
// import 'package:cooking_champs/widgets/logout_popup.dart';
// import 'package:cooking_champs/widgets/view_full_image.dart';
// import 'package:flutter/material.dart';
//
// import '../../constant/app_state.dart';
// import '../../model/dynamic_models/termcondirion.dart';
// import '../privacypolicy.dart';
// import 'followers.dart';
// import 'dart:developer' as developer;
//
// class MenuView extends StatefulWidget {
//   const MenuView({super.key});
//
//   @override
//   State<MenuView> createState() => _MenuViewState();
// }
//
// class _MenuViewState extends State<MenuView> {
//   UserIdentityModel userDetails = UserIdentityModel();
//   String friendRequestCount = "0";
//   String loginType = "";
//
//   @override
//   void initState() {
//     Future.delayed(Duration.zero, () {
//       loadLoginType();
//       callApi(context);
//     });
//
//     getUserData();
//     getProfileDetail();
//     super.initState();
//   }
//
//   void loadLoginType() async {
//     loginType = await PreferencesServices.getPreferencesData(
//         PreferencesServices.loginType);
//     loginType = loginType;
//     print("isLogin: $loginType");
//   }
//
//   void getUserData() async {
//     var data = await PreferencesServices.getPreferencesData(
//         PreferencesServices.loginUserIdentityDetails);
//     if (data != null) {
//       Map<String, dynamic> jsonResponse = await jsonDecode(data);
//       if (mounted) {
//         setState(() {
//           userDetails = UserIdentityModel.fromJson(jsonResponse);
//           print("onValue.data>>>>>>>>>${jsonResponse}");
//         });
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     countFriendRequestApi();
//     final data = MediaQuery.of(context);
//     final size = data.size;
//     final bool isIpad = size.width > 600;
//
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       bottomNavigationBar: MediaQuery.removePadding(
//         context: context,
//         removeLeft: true,
//         removeRight: true,
//         child: Container(
//           width: double.infinity,
//           decoration: BoxDecoration(
//             color: MyColor.white,
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(isIpad ? 30.0 : 20.0),
//               topRight: Radius.circular(isIpad ? 30.0 : 20.0),
//             ),
//           ),
//           child: SafeArea(
//             top: false,
//             child: Column(
//               children: [
//                 hsized10,
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       width: isIpad ? 120.0 : 100.0,
//                       height: isIpad ? 8.0 : 5.0,
//                       decoration: BoxDecoration(
//                         color: MyColor.liteGrayB5B5B5,
//                         borderRadius: BorderRadius.all(Radius.circular(isIpad ? 25.0 : 20.0)),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Container(
//                           margin: EdgeInsets.only(
//                             top: isIpad ? 25.0 : 15.0,
//                             bottom: isIpad ? 25.0 : 15.0,
//                             left: isIpad ? 30.0 : 20.0,
//                             right: isIpad ? 30.0 : 20.0,
//                           ),
//                           width: size.width,
//                           decoration: BoxDecoration(
//                             color: MyColor.yellowF6F1E1,
//                             borderRadius: BorderRadius.all(Radius.circular(isIpad ? 20.0 : 16.0)),
//                           ),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                   left: isIpad ? 15.0 : 0.0,
//                                   right: isIpad ? 15.0 : 5.0,
//                                   top: isIpad ? 15.0 : 5.0,
//                                   bottom: isIpad ? 15.0 : 5.0,
//                                 ),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     GestureDetector(
//                                       onTap: () {
//                                         AllDialogs.customDialog(
//                                           context,
//                                           ViewFullImage(
//                                             image: userDetails.image != null
//                                                 ? userDetails.image.toString()
//                                                 : "",
//                                           ),
//                                         );
//                                       },
//                                       child: buildProfileImage(
//                                         userDetails.image != null
//                                             ? ApiPath.imageBaseUrl +
//                                             userDetails.image.toString()
//                                             : "",
//                                         userDetails.isPurchaseSubscription ?? false,
//                                         isIpad,
//                                       ),
//                                     ),
//
//                                     Expanded(
//                                       child: Padding(
//                                         padding: EdgeInsets.only(left: isIpad ? 20.0 : 15.0),
//                                         child: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               userDetails.name ?? "",
//                                               overflow: TextOverflow.ellipsis,
//                                               maxLines: 2,
//                                               style: semiBoldTextStyle(
//                                                 fontSize: isIpad ? 28.0 : 17.0,
//                                                 color: MyColor.black,
//                                               ),
//                                             ),
//                                             SizedBox(height: isIpad ? 8.0 : 5.0),
//                                             GestureDetector(
//                                               onTap: () {
//                                                 followingOnTap();
//                                               },
//                                               child: Text(
//                                                 "${Languages.of(context)!.following}    ${userDetails.following}",
//                                                 overflow: TextOverflow.ellipsis,
//                                                 maxLines: 1,
//                                                 style: regularTextStyle(
//                                                   fontSize: isIpad ? 22.0 : 14.0,
//                                                   color: MyColor.grey2,
//                                                 ),
//                                               ),
//                                             ),
//                                             SizedBox(height: isIpad ? 5.0 : 3.0),
//                                             GestureDetector(
//                                               onTap: () {
//                                                 followersOnTap();
//                                               },
//                                               child: Text(
//                                                 "${Languages.of(context)!.followers}    ${userDetails.followers}",
//                                                 overflow: TextOverflow.ellipsis,
//                                                 maxLines: 1,
//                                                 style: regularTextStyle(
//                                                   fontSize: isIpad ? 22.0 : 14.0,
//                                                   color: MyColor.grey2,
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//
//                                     ElevatedButton(
//                                       style: ElevatedButton.styleFrom(
//                                         backgroundColor: MyColor.appTheme,
//                                         overlayColor: MyColor.liteOrange,
//                                         enableFeedback: true,
//                                         enabledMouseCursor: MouseCursor.defer,
//                                         elevation: isIpad ? 8.0 : 5.0,
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius: BorderRadius.circular(isIpad ? 15.0 : 10.0),
//                                         ),
//                                         padding: EdgeInsets.symmetric(
//                                           horizontal: isIpad ? 15.0 : 10.0,
//                                           vertical: isIpad ? 12.0 : 7.0,
//                                         ),
//                                       ),
//                                       onPressed: () {
//                                         AllDialogs.customDialog(context, LogoutPopup());
//                                       },
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.center,
//                                         children: [
//                                           Image.asset(
//                                             AssetsPath.logout,
//                                             height: isIpad ? 28.0 : 20.0,
//                                             width: isIpad ? 28.0 : 20.0,
//                                           ),
//                                           SizedBox(width: isIpad ? 10.0 : 5.0),
//                                           Text(
//                                             Languages.of(context)!.logout.toString(),
//                                             overflow: TextOverflow.ellipsis,
//                                             style: mediumTextStyle(
//                                               fontSize: isIpad ? 22.0 : 13.0,
//                                               color: MyColor.white,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//
//                         Padding(
//                           padding: EdgeInsets.only(
//                             left: isIpad ? 30.0 : 20.0,
//                             right: isIpad ? 30.0 : 20.0,
//                             top: isIpad ? 20.0 : 10.0,
//                           ),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 Languages.of(context)!.explore.toString(),
//                                 style: semiBoldTextStyle(
//                                   fontSize: isIpad ? 24.0 : 13.0,
//                                   color: MyColor.black,
//                                 ),
//                               ),
//                               hsized10,
//                               itemCard(
//                                 size,
//                                 Languages.of(context)!.kidLearning.toString(),
//                                 AssetsPath.person,
//                                 1,
//                                 kidLearningOnTap,
//                                 isIpad,
//                               ),
//                               itemCard(
//                                 size,
//                                 Languages.of(context)!.shop.toString(),
//                                 AssetsPath.shop,
//                                 1,
//                                 shopOnTap,
//                                 isIpad,
//                               ),
//                               userDetails.role == RegisterType.roleKids.value
//                                   ? SizedBox.shrink()
//                                   : itemCard(
//                                 size,
//                                 Languages.of(context)!.myOrders.toString(),
//                                 AssetsPath.myOrders,
//                                 1,
//                                 myOrdersOnTap,
//                                 isIpad,
//                               ),
//                               userDetails.role == RegisterType.roleKids.value
//                                   ? SizedBox.shrink()
//                                   : itemCard(
//                                 size,
//                                 Languages.of(context)!.manageAddress.toString(),
//                                 AssetsPath.manageAddress,
//                                 1,
//                                 addressOnTap,
//                                 isIpad,
//                               ),
//                               itemCard(
//                                 size,
//                                 Languages.of(context)!.memories.toString(),
//                                 AssetsPath.overstories,
//                                 2,
//                                 ourStoriesOnTap,
//                                 isIpad,
//                               ),
//                               itemCard(
//                                 size,
//                                 Languages.of(context)!.bookmarkRecipes.toString(),
//                                 AssetsPath.bookmarkIc,
//                                 3,
//                                 bookmarkOnTap,
//                                 isIpad,
//                               ),
//                               (loginType == "individual" ||
//                                   userDetails.role == RegisterType.roleKids.value)
//                                   ? SizedBox.shrink()
//                                   : itemCard(
//                                 size,
//                                 Languages.of(context)!.myKids.toString(),
//                                 AssetsPath.kitslearningorange,
//                                 4,
//                                 myKidsOnTap,
//                                 isIpad,
//                               ),
//                               itemCard(
//                                 size,
//                                 Languages.of(context)!.friendRequest.toString(),
//                                 AssetsPath.addPerson,
//                                 5,
//                                 friendRequestOnTap,
//                                 isIpad,
//                               ),
//                               itemCard(
//                                 size,
//                                 Languages.of(context)!.aboutUs.toString(),
//                                 AssetsPath.aboutus,
//                                 7,
//                                 aboutOnTap,
//                                 isIpad,
//                               ),
//                             ],
//                           ),
//                         ),
//
//                         Divider(
//                           color: MyColor.colorDADADA,
//                           thickness: isIpad ? 2.0 : 1.0,
//                         ),
//
//                         Padding(
//                           padding: EdgeInsets.only(
//                             left: isIpad ? 30.0 : 20.0,
//                             right: isIpad ? 30.0 : 20.0,
//                             top: isIpad ? 20.0 : 10.0,
//                           ),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 Languages.of(context)!.support.toString(),
//                                 style: semiBoldTextStyle(
//                                   fontSize: isIpad ? 24.0 : 13.0,
//                                   color: MyColor.black,
//                                 ),
//                               ),
//                               hsized10,
//                               userDetails.role == RegisterType.roleKids.value
//                                   ? itemCard(
//                                 size,
//                                 Languages.of(context)!.helpSupport.toString(),
//                                 AssetsPath.help,
//                                 9,
//                                 helpSupportOnTap,
//                                 isIpad,
//                               )
//                                   : Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   itemCard(
//                                     size,
//                                     Languages.of(context)!.editProfile.toString(),
//                                     AssetsPath.editprofile,
//                                     8,
//                                     editProfileOnTap,
//                                     isIpad,
//                                   ),
//                                   itemCard(
//                                     size,
//                                     Languages.of(context)!.changePassword.toString(),
//                                     AssetsPath.changepassword,
//                                     9,
//                                     changePassOnTap,
//                                     isIpad,
//                                   ),
//                                   itemCard(
//                                     size,
//                                     Languages.of(context)!.privacypolicy.toString(),
//                                     AssetsPath.privacypolicy,
//                                     10,
//                                     privacypolicyOnTap,
//                                     isIpad,
//                                   ),
//                                   itemCard(
//                                     size,
//                                     Languages.of(context)!.termcondition.toString(),
//                                     AssetsPath.termcondition,
//                                     11,
//                                     termConditionOnTap,
//                                     isIpad,
//                                   ),
//                                   itemCard(
//                                     size,
//                                     Languages.of(context)!.helpSupport.toString(),
//                                     AssetsPath.help,
//                                     12,
//                                     helpSupportOnTap,
//                                     isIpad,
//                                   ),
//                                   itemCard(
//                                     size,
//                                     Languages.of(context)!.deleteAccount.toString(),
//                                     AssetsPath.delete,
//                                     13,
//                                     deleteAccountOnTap,
//                                     isIpad,
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//
//                         SizedBox(
//                           height: isIpad ? size.height * 0.06 : size.height * 0.04,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   itemCard(var size, String title, String img, int id, GestureTapCallback onTap, bool isIpad) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         padding: EdgeInsets.only(
//           bottom: isIpad ? 25.0 : 20.0,
//           top: isIpad ? 15.0 : 10.0,
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Expanded(
//               flex: 3,
//               child: Row(
//                 children: [
//                   Container(
//                     width: isIpad ? 50.0 : 30.0,
//                     height: isIpad ? 50.0 : 30.0,
//                     decoration: BoxDecoration(
//                       color: MyColor.appTheme.withOpacity(id == 13 ? 0.1 : 0.1),
//                       borderRadius: BorderRadius.circular(isIpad ? 12.0 : 8.0),
//                     ),
//                     child: Center(
//                       child: Image.asset(
//                         img,
//                         height: isIpad ? 30.0 : 20.0,
//                         width: isIpad ? 30.0 : 20.0,
//                         color: id == 13 ? MyColor.red : MyColor.appTheme,
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: isIpad ? 20.0 : 15.0),
//                   Expanded(
//                     child: Text(
//                       title,
//                       style: regularTextStyle(
//                         fontSize: isIpad ? 22.0 : 13.0,
//                         color: id == 13 ? MyColor.red : MyColor.black,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             Expanded(
//               flex: 1,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   if (int.parse(friendRequestCount.toString()) > 0 && id == 5)
//                     Container(
//                       margin: EdgeInsets.only(right: isIpad ? 15.0 : 10.0),
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: MyColor.appTheme,
//                       ),
//                       child: Padding(
//                         padding: EdgeInsets.all(isIpad ? 12.0 : 8.0),
//                         child: Text(
//                           friendRequestCount,
//                           style: TextStyle(
//                             color: MyColor.white,
//                             fontSize: isIpad ? 18.0 : 12.0,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   Icon(
//                     Icons.arrow_forward_ios_outlined,
//                     size: isIpad ? 28.0 : 20.0,
//                     color: id == 13 ? MyColor.red : Colors.black,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void kidLearningOnTap() {
//     setState(() {
//       isTabExplore = true;
//       pageIndex = 4;
//       tabCheck = "kids";
//     });
//     Navigator.pop(context);
//   }
//
//   void shopOnTap() {
//     CustomNavigators.pushNavigate(const Shopesclass(), context);
//   }
//
//   void addressOnTap() {
//     CustomNavigators.pushNavigate(const ManageAddress(), context);
//   }
//
//   void myOrdersOnTap() {
//     CustomNavigators.pushNavigate(const MyOrdersNew(), context);
//   }
//
//   void sMembershipsOnTap() {
//     CustomNavigators.pushNavigate(const MembershipNew(), context);
//   }
//
//   void friendRequestOnTap() {
//     setState(() {
//       isTabExplore = true;
//     });
//     CustomNavigators.pushNavigate(
//         FriendRequestView(
//           type: 'menu',
//         ),
//         context);
//   }
//
//   void ourStoriesOnTap() {
//     Navigator.pop(context);
//     setState(() {
//       isTabExplore = true;
//       pageIndex = 3;
//       tabCheck = "OurStories";
//     });
//   }
//
//   void myKidsOnTap() {
//     setState(() {
//       isTabExplore = true;
//     });
//     CustomNavigators.pushNavigate(
//         const MyKidsListingView(pageType: 'MyKids'), context);
//   }
//
//   void aboutOnTap() {
//     Navigator.pop(context);
//     setState(() {
//       isTabExplore = true;
//       pageIndex = 4;
//       tabCheck = "Aboutus";
//     });
//   }
//
//   void editProfileOnTap() {
//     CustomNavigators.pushNavigate(
//         EditProfileView(
//           onUpdate: onUpdate,
//         ),
//         context);
//   }
//
//   void changePassOnTap() {
//     CustomNavigators.pushNavigate(ChangePasswordView(), context);
//   }
//
//   void privacypolicyOnTap() {
//     CustomNavigators.pushNavigate(PrivacyPolicyView(), context);
//   }
//
//   void termConditionOnTap() {
//     CustomNavigators.pushNavigate(TermConditionView(), context);
//   }
//
//   void helpSupportOnTap() {
//     CustomNavigators.pushNavigate(HelpSupportView(), context);
//   }
//
//   void followersOnTap() {
//     CustomNavigators.pushNavigate(
//         FollowersScr(
//           index: 0,
//         ),
//         context);
//   }
//
//   void followingOnTap() {
//     CustomNavigators.pushNavigate(
//         FollowersScr(
//           index: 1,
//         ),
//         context);
//   }
//
//   void deleteAccountOnTap() {
//     AllDialogs.customDialog(
//         context, DeleteAccountPopup(onCallBack: onDeleteAccount));
//   }
//
//   onDeleteAccount(String t) {
//     debugPrint("ttt..$t");
//     Future.delayed(Duration.zero, deleteApi);
//   }
//
//   Future<void> deleteApi() async {
//     await ApiServices.deleteAccount(context).then((onValue) {
//       if (mounted) {
//         if (onValue.status == true) {
//           PreferencesServices.setLogoutPreferencesData();
//           CustomNavigators.pushRemoveUntil(WelcomeCookingChampsView(), context);
//         }
//       }
//     });
//   }
//
//   onUpdate() {
//     Future.delayed(Duration.zero, getProfileDetail);
//   }
//
//   getProfileDetail() async {
//     await ApiServices.userDetail(context, "", false).then((onValue) {
//       if (mounted) {
//         setState(() {
//           if (onValue.status == true) {
//             if (onValue.data != null) {
//               userDetails = UserIdentityModel.fromJson(onValue.data);
//
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
//   void countFriendRequestApi() {
//     Future.delayed(const Duration(minutes: 1), () {
//       // call API functionality
//     });
//   }
//
//   callApi(BuildContext context) async {
//     await ApiServices.countFriendRequest(context, false).then((onValue) {
//       if (mounted) {
//         setState(() {
//           if (onValue.status == true) {
//             friendRequestCount = onValue.pendingReqCount ?? "";
//           }
//         });
//       }
//     });
//   }
//
//   void bookmarkOnTap() {
//     CustomNavigators.pushNavigate(BookmarkRecipeView(), context);
//   }
//
//   void inviteRequestOnTap() {
//     // CustomNavigators.pushNavigate(InviteFriendsView(), context);
//   }
//
//   Widget buildProfileImage(String imageUrl, bool isMember, bool isIpad) {
//     return Container(
//       height: isIpad ? 120.0 : 75.0,
//       width: isIpad ? 120.0 : 75.0,
//       alignment: Alignment.center,
//       child: Stack(
//         clipBehavior: Clip.none,
//         alignment: Alignment.center,
//         children: [
//           if (isMember)
//             Container(
//               width: isIpad ? 110.0 : 68.0,
//               height: isIpad ? 110.0 : 68.0,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(color: MyColor.orange, width: isIpad ? 4.0 : 3.0),
//               ),
//             ),
//
//           ClipRRect(
//             borderRadius: BorderRadius.circular(100),
//             child: UiUtils.networkProfile(
//               isIpad ? 90.0 : 60.0,
//               isIpad ? 90.0 : 60.0,
//               imageUrl,
//             ),
//           ),
//
//           if (isMember)
//             Positioned(
//               bottom: isIpad ? -8.0 : -6.0,
//               child: Container(
//                 padding: EdgeInsets.all(isIpad ? 6.0 : 4.0),
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: MyColor.orange,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.2),
//                       blurRadius: isIpad ? 8.0 : 4.0,
//                       spreadRadius: isIpad ? 2.0 : 1.0,
//                     ),
//                   ],
//                 ),
//                 child: Icon(
//                   Icons.star,
//                   color: Colors.white,
//                   size: isIpad ? 24.0 : 14.0,
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }