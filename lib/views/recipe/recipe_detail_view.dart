import 'dart:async';
import 'dart:convert';

import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/dimen.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/constant/stringfile.dart/language.dart';
import 'package:cooking_champs/enums/register_enum.dart';
import 'package:cooking_champs/model/dynamic_models/recipe_model.dart';
import 'package:cooking_champs/model/dynamic_models/user_identity_model.dart';
import 'package:cooking_champs/model/post_model/send_friend_request.dart';
import 'package:cooking_champs/services/api_path.dart';
import 'package:cooking_champs/services/api_services.dart';
import 'package:cooking_champs/services/user_prefences.dart';
import 'package:cooking_champs/utils/all_dialogs.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:cooking_champs/widgets/global_button.dart';
import 'package:cooking_champs/widgets/view_full_image.dart';
import 'package:flutter/material.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';
import 'package:video_player/video_player.dart';

import '../../utils/navigators.dart';
import '../addyourrecipe.dart';

class RecipeDetailView extends StatefulWidget {
  final RecipeModel model;
  Color color;

  RecipeDetailView({super.key, required this.model, required this.color});

  @override
  State<RecipeDetailView> createState() => _RecipeDetailViewState();
}

class _RecipeDetailViewState extends State<RecipeDetailView> {
  UserIdentityModel userDetails = UserIdentityModel();
  String userResponse = "";
  RecipeModel recipeModel = RecipeModel();
  bool isSent = false;
  String reaction = "";

  @override
  void initState() {
    getUserData();
    getRecipeDetail(true);
    super.initState();
  }

  @override
  void dispose() {
    recipeModel.videolink != "" ? _controller?.pause() : null;
    super.dispose();
  }

  final bool _mounted = false;
  bool isVideoError = false;

  void _initializeController(String link) async {
    if (_controller != null) {
      await _controller!.dispose();
      _controller = null;
    }

    setState(() {
      isVideoError = true;
    });

    try {
      _controller = VideoPlayerController.networkUrl(
        Uri.parse(link),
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      );

      await _controller!.initialize();
      _controller!.pause();

      if (_mounted) {
        setState(() {
          isVideoError = false;
        });
      }

      _controller!.addListener(() {
        if (_mounted) {
          setState(() {});
        }
      });
    } catch (e) {
      print("Error initializing video controller: $e");

      if (_mounted) {
        setState(() {
          isVideoError = true;
        });
      }
    }
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
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    bool isIpad = size.width > 600;

    return Scaffold(
      backgroundColor: MyColor.white,
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: Size.zero,
        child: AppBar(
          leadingWidth: size.width * (isIpad ? 0.15 : 0.12),
          automaticallyImplyLeading: false,
          backgroundColor: widget.color,
          surfaceTintColor: widget.color,
          centerTitle: false,
          elevation: 0,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with Back Button and Title
            Container(
              color: widget.color,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: isIpad ? 30.0 : 20.0,
                      top: isIpad ? 20.0 : 15.0,
                      bottom: isIpad ? 20.0 : 15.0,
                    ),
                    child: InkWell(
                      radius: 80,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: isIpad ? 32.0 : 28.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: isIpad ? 20.0 : 10.0),
                      child: Text(
                        recipeModel.name ?? "",
                        style: mediumTextStyle(
                          fontSize: isIpad ? 24.0 : 18.0,
                          color: MyColor.black,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  userDetails.id == recipeModel.recipeAddedBy?.id.toString()
                      ? InkWell(
                    onTap: () {
                      CustomNavigators.pushNavigate(
                        AddYourRecipeView(
                          onCallBack: () {
                            getRecipeDetail(false);
                            setState(() {});
                          },
                          onCallScreen: true,
                          recipeId: recipeModel.id,
                          recipevideolink: recipeModel.videolink.toString(),
                        ),
                        context,
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(isIpad ? 10.0 : 6.0),
                      margin: EdgeInsets.only(right: isIpad ? 25.0 : 15.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(isIpad ? 12.0 : 8.0),
                        color: MyColor.appTheme,
                      ),
                      child: Center(
                        child: Text(
                          "Edit",
                          style: regularTextStyle(
                            fontSize: isIpad ? 16.0 : 14.0,
                            color: MyColor.white,
                          ),
                        ),
                      ),
                    ),
                  )
                      : SizedBox(width: isIpad ? 25.0 : 15.0),
                ],
              ),
            ),

            // Recipe Image
            Stack(
              children: [
                InkWell(
                  onTap: () {
                    AllDialogs.customDialog(
                      context,
                      ViewFullImage(
                        image: recipeModel.bannerImage != null
                            ? recipeModel.bannerImage.toString()
                            : "",
                      ),
                    );
                  },
                  child: Container(
                    width: size.width,
                    height: isIpad ? 500.0 : 270.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(isIpad ? 40.0 : 30.0),
                        bottomRight: Radius.circular(isIpad ? 40.0 : 30.0),
                      ),
                      color: widget.color,
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: isIpad ? 20.0 : 10.0),
                        Align(
                          alignment: Alignment.center,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(isIpad ? 30.0 : 20.0),
                              bottomRight: Radius.circular(isIpad ? 30.0 : 20.0),
                            ),
                            child: UiUtils.networkImages(
                              size.width,
                              isIpad ? 478.0 : 259.0,
                              recipeModel.bannerImage != null
                                  ? ApiPath.imageBaseUrl +
                                  recipeModel.bannerImage.toString()
                                  : "",
                              isBoxFit: true,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                recipeModel.recipeTools != null &&
                    recipeModel.recipeTools!.isNotEmpty
                    ? Container(
                  width: size.width,
                  margin: EdgeInsets.only(top: isIpad ? 320.0 : 230.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(isIpad ? 40.0 : 30.0),
                      bottomRight: Radius.circular(isIpad ? 40.0 : 30.0),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [],
                  ),
                )
                    : SizedBox.shrink(),
              ],
            ),

            // Content Sections
            Padding(
              padding: EdgeInsets.only(
                top: isIpad ? 30.0 : 20.0,
                left: isIpad ? 30.0 : 15.0,
                right: isIpad ? 30.0 : 15.0,
                bottom: isIpad ? 20.0 : 15.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tools Used Section
                  Text(
                    Languages.of(context)!.toolsUsed,
                    style: mediumTextStyle(
                      fontSize: isIpad ? 24.0 : 18.0,
                      color: MyColor.black,
                    ),
                  ),
                  recipeModel.recipeTools != null &&
                      recipeModel.recipeTools!.isNotEmpty
                      ? ListView.builder(
                    padding: EdgeInsets.only(top: isIpad ? 15.0 : 10.0),
                    itemCount: recipeModel.recipeTools!.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      var ingredient = recipeModel.recipeTools![index];
                      return Padding(
                        padding: EdgeInsets.only(top: isIpad ? 12.0 : 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              AssetsPath.dots,
                              height: isIpad ? 24.0 : 19.0,
                              width: isIpad ? 25.0 : 20.0,
                            ),
                            SizedBox(width: isIpad ? 12.0 : 8.0),
                            Expanded(
                              child: Text(
                                ingredient.toolName ?? "",
                                style: regularTextStyle(
                                  fontSize: isIpad ? 18.0 : 14.0,
                                  color: MyColor.black,
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  )
                      : Container(
                    padding: EdgeInsets.only(top: isIpad ? 15.0 : 10.0),
                    child: Text(
                      "No tools listed",
                      style: regularTextStyle(
                        fontSize: isIpad ? 16.0 : 13.0,
                        color: MyColor.grey,
                      ),
                    ),
                  ),

                  SizedBox(height: isIpad ? 30.0 : 20.0),

                  // Ingredients Section
                  Text(
                    Languages.of(context)!.ingredient,
                    style: mediumTextStyle(
                      fontSize: isIpad ? 24.0 : 18.0,
                      color: MyColor.black,
                    ),
                  ),
                  recipeModel.recipeIngredient != null &&
                      recipeModel.recipeIngredient!.isNotEmpty
                      ? ListView.builder(
                    padding: EdgeInsets.only(top: isIpad ? 15.0 : 10.0),
                    itemCount: recipeModel.recipeIngredient!.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      var ingredient = recipeModel.recipeIngredient![index];
                      return Padding(
                        padding: EdgeInsets.only(top: isIpad ? 12.0 : 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              AssetsPath.dots,
                              height: isIpad ? 24.0 : 19.0,
                              width: isIpad ? 25.0 : 20.0,
                            ),
                            SizedBox(width: isIpad ? 12.0 : 8.0),
                            Expanded(
                              child: Text(
                                ingredient.name ?? "",
                                style: regularTextStyle(
                                  fontSize: isIpad ? 18.0 : 14.0,
                                  color: MyColor.black,
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  )
                      : Container(
                    padding: EdgeInsets.only(top: isIpad ? 15.0 : 10.0),
                    child: Text(
                      "No ingredients listed",
                      style: regularTextStyle(
                        fontSize: isIpad ? 16.0 : 13.0,
                        color: MyColor.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(
              color: MyColor.colorDADADA,
              thickness: 1.0,
            ),

            // Steps Section
            recipeModel.recipeSteps != null &&
                recipeModel.recipeSteps!.isNotEmpty
                ? Padding(
              padding: EdgeInsets.only(
                top: isIpad ? 30.0 : 20.0,
                left: isIpad ? 30.0 : 15.0,
                right: isIpad ? 30.0 : 15.0,
                bottom: isIpad ? 30.0 : 20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Languages.of(context)!.howtoCook,
                    style: mediumTextStyle(
                      fontSize: isIpad ? 24.0 : 18.0,
                      color: MyColor.black,
                    ),
                  ),
                  ListView.builder(
                    padding: EdgeInsets.only(top: isIpad ? 15.0 : 10.0),
                    itemCount: recipeModel.recipeSteps!.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      var recipe = recipeModel.recipeSteps![index];
                      return Padding(
                        padding: EdgeInsets.only(top: isIpad ? 15.0 : 10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: isIpad ? 36.0 : 28.0,
                              height: isIpad ? 36.0 : 28.0,
                              decoration: BoxDecoration(
                                color: widget.color,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Center(
                                child: Text(
                                  "${index + 1}",
                                  style: semiBoldTextStyle(
                                    fontSize: isIpad ? 16.0 : 12.0,
                                    color: MyColor.black,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: isIpad ? 15.0 : 10.0),
                            Expanded(
                              child: Text(
                                recipe.name ?? "",
                                style: regularTextStyle(
                                  fontSize: isIpad ? 18.0 : 14.0,
                                  color: MyColor.black,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
                : SizedBox.shrink(),

            // Video Section
            recipeModel.videolink != "" && isVideoError == true
                ? Container(
              margin: EdgeInsets.only(
                left: isIpad ? 25.0 : 10.0,
                right: isIpad ? 25.0 : 10.0,
                bottom: isIpad ? 30.0 : 20.0,
                top: isIpad ? 10.0 : 5.0,
              ),
              padding: EdgeInsets.only(
                right: isIpad ? 20.0 : 13.0,
                left: isIpad ? 20.0 : 13.0,
                top: isIpad ? 10.0 : 5.0,
                bottom: isIpad ? 12.0 : 8.0,
              ),
              width: size.width * 0.95,
              height: isIpad ? size.height * 0.40 : size.height * 0.30,
              child: _buildVideoPlayer(0, isIpad),
            )
                : SizedBox.shrink(),

            // Reactions Section
            recipeModel.heartCount != null
                ? Center(
              child: Container(
                width: size.width * 0.95,
                margin: EdgeInsets.only(
                  left: isIpad ? 25.0 : 10.0,
                  right: isIpad ? 25.0 : 10.0,
                  top: isIpad ? 15.0 : 10.0,
                  bottom: isIpad ? 25.0 : 15.0,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: isIpad ? 20.0 : 13.0,
                  vertical: isIpad ? 15.0 : 10.0,
                ),
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(isIpad ? 65.0 : 55.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildReactionButton(
                      "heart",
                      AssetsPath.heartimg,
                      recipeModel.heartCount.toString(),
                      isIpad,
                    ),
                    _buildReactionButton(
                      "emoji",
                      AssetsPath.smileimg,
                      recipeModel.emojiCount.toString(),
                      isIpad,
                    ),
                    _buildReactionButton(
                      "star",
                      AssetsPath.starimg,
                      recipeModel.starCount.toString(),
                      isIpad,
                    ),
                    _buildReactionButton(
                      "batch",
                      AssetsPath.starbatchimg,
                      recipeModel.batchCount.toString(),
                      isIpad,
                    ),
                    _buildReactionButton(
                      "cook",
                      AssetsPath.cookimg,
                      recipeModel.cookCount.toString(),
                      isIpad,
                    ),
                    _buildReactionButton(
                      "like",
                      AssetsPath.likeimg,
                      recipeModel.likeCount.toString(),
                      isIpad,
                    ),
                  ],
                ),
              ),
            )
                : SizedBox.shrink(),

            // Bottom spacing
            SizedBox(height: isIpad ? 80.0 : 60.0),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(isIpad, size),
    );
  }

  Widget _buildReactionButton(
      String type, String asset, String count, bool isIpad) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            if (reaction == type) {
              reaction = "";
            } else {
              reaction = type;
            }
            sendReactionOnTap(reaction);
            setState(() {});
          },
          child: CircleAvatar(
            backgroundColor:
            reaction == type ? MyColor.color48335CB2 : Colors.white,
            radius: isIpad ? 28.0 : 20.0,
            child: Image.asset(
              asset,
              width: isIpad ? 28.0 : 22.0,
              height: isIpad ? 30.0 : 24.0,
            ),
          ),
        ),
        SizedBox(height: isIpad ? 8.0 : 5.0),
        Text(
          count,
          style: TextStyle(
            fontSize: isIpad ? 16.0 : 14.0,
            color: MyColor.color48335CB2,
            fontWeight: FontWeight.w400,
            fontFamily: Fonts.beVietnamProRegular,
          ),
        )
      ],
    );
  }

  Widget _buildBottomNavigationBar(bool isIpad, Size size) {
    return recipeModel.recipeAddedBy != null
        ? Container(
      padding: EdgeInsets.only(
        top: isIpad ? 25.0 : 15.0,
        bottom: isIpad ? 40.0 : 30.0,
        left: isIpad ? 30.0 : 20.0,
        right: isIpad ? 30.0 : 20.0,
      ),
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(isIpad ? 56.0 : 46.0),
          topRight: Radius.circular(isIpad ? 56.0 : 46.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // User Info
          Padding(
            padding: EdgeInsets.all(isIpad ? 12.0 : 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile Image
                InkWell(
                  onTap: () {
                    AllDialogs.customDialog(
                      context,
                      ViewFullImage(
                        image: recipeModel.recipeAddedBy!.image != null
                            ? "${recipeModel.recipeAddedBy!.image}"
                            : "",
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(500),
                    child: UiUtils.networkProfile(
                      isIpad ? 70.0 : 55.0,
                      isIpad ? 70.0 : 55.0,
                      recipeModel.recipeAddedBy!.image != null
                          ? "${ApiPath.imageBaseUrl}${recipeModel.recipeAddedBy!.image}"
                          : "",
                    ),
                  ),
                ),

                SizedBox(width: isIpad ? 15.0 : 10.0),

                // User Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        recipeModel.recipeAddedBy!.name ?? "",
                        style: mediumTextStyle(
                          fontSize: isIpad ? 20.0 : 16.0,
                          color: MyColor.black,
                        ),
                      ),
                      SizedBox(height: isIpad ? 5.0 : 3.0),
                      if (recipeModel.recipeAddedBy!.role.toString() ==
                          RegisterType.roleKids.value)
                        Text(
                          "${recipeModel.recipeAddedBy!.day == "null" ? "" : "${recipeModel.recipeAddedBy!.day} | "}${recipeModel.recipeAddedBy!.month == "null" ? "" : "${recipeModel.recipeAddedBy!.month} | "}${recipeModel.recipeAddedBy!.year == "null" ? "" : "${recipeModel.recipeAddedBy!.year} | "}${recipeModel.recipeAddedBy!.grade ?? ""}",
                          style: regularTextStyle(
                            fontSize: isIpad ? 16.0 : 14.0,
                            color: MyColor.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      else
                        SizedBox.shrink(),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Follow Button (if not own recipe)
          userDetails.id != recipeModel.recipeAddedBy!.id.toString()
              ? Padding(
            padding: EdgeInsets.only(top: isIpad ? 15.0 : 10.0),
            child: GlobalButton(
              btnText(recipeModel.recipeAddedBy!.followRequestStatus.toString()),
              MyColor.appTheme,
              MyColor.appTheme,
              isIpad ? 50.0 : btnSize40,
              double.infinity,
              sendRequestOnTap,
              isIpad ? 65.0 : 55.0,
              5,
              0,
              mediumTextStyle(
                fontSize: isIpad ? 18.0 : 16.0,
                color: MyColor.white,
              ),
            ),
          )
              : SizedBox.shrink(),
        ],
      ),
    )
        : SizedBox.shrink();
  }

  bool shouldShowButton() {
    final recipeAddedBy = recipeModel.recipeAddedBy;
    if (recipeAddedBy == null) return false;

    final userIdMatches =
        userDetails.id.toString() == recipeAddedBy.id.toString();
    final rolesMatch =
        userDetails.role.toString() == recipeAddedBy.role.toString();
    final btnTextValue = btnText(recipeAddedBy.friendRequestStatus.toString());

    if (userIdMatches && rolesMatch) {
      return false;
    } else if (!userIdMatches && !rolesMatch && btnTextValue.isNotEmpty) {
      return true;
    } else if (btnTextValue.isNotEmpty) {
      return true;
    }

    return false;
  }

  String btnText(String status) {
    debugPrint("status..$status");
    switch (status) {
      case "follow":
        return Languages.of(context)!.follow.toString();
      case "pending":
        return Languages.of(context)!.cancelRequest.toString();
      case "Accept":
        return "Accept";
      case "accepted":
        return Languages.of(context)!.friend.toString();
      case "rejected":
        return Languages.of(context)!.sendRequest.toString();
      case "unfollow":
        return Languages.of(context)!.unFallow.toString();
      default:
        return '';
    }
  }

  Future<void>? getRecipeDetail(bool? loader) async {
    try {
      await ApiServices.getRecipeDetail(
          context, loader!, widget.model.id.toString())
          .then((onValue) {
        if (mounted && onValue.status == true) {
          setState(() {
            if (onValue.data != null) {
              recipeModel = RecipeModel.fromJson(onValue.data);
              setState(() {});
              recipeModel.videolink != ""
                  ? _initializeController(recipeModel.videolink.toString())
                  : null;
              if (recipeModel.recipeAddedBy != null) {
                if (recipeModel.recipeAddedBy!.friendRequestStatus != null) {
                  if (recipeModel.recipeAddedBy!.friendRequestStatus.toString() !=
                      "request not sent") {
                    isSent = true;
                  } else {
                    isSent = false;
                  }
                }
              }
            }
          });
        }
      });
    } catch (e) {
      debugPrint('Error fetching stories: $e');
    }
  }

  void sendRequestOnTap() async {
    if (recipeModel.recipeAddedBy!.followRequestStatus.toString() == "follow" ||
        recipeModel.recipeAddedBy!.followRequestStatus.toString() == "unfollow") {
      FollowRequest friendRequest = FollowRequest(
        senderId: int.parse(userDetails.id ?? "0"),
        receiverId: int.parse(recipeModel.recipeAddedBy!.id.toString()),
        requestSentBy: userDetails.role,
        requestSentTo: recipeModel.recipeAddedBy!.role.toString(),
      );

      await ApiServices.followRequest(context, friendRequest).then((onValue) {
        if (onValue.status == true) {
          if (mounted) {
            setState(() {
              getRecipeDetail(false);
            });
          }
        }
      });
    }
  }

  void sendReactionOnTap(String status) async {
    ReactionRequest reactionRequest = ReactionRequest(
      recipeid: recipeModel.id,
      status: status,
      type: userDetails.role,
    );

    await ApiServices.reactionRequest(context, reactionRequest, false).then((onValue) {
      if (onValue.status == true) {
        if (mounted) {
          setState(() {
            getRecipeDetail(false);
          });
        }
      }
    });
  }

  VideoPlayerController? _controller;
  Widget _buildVideoPlayer(int index, bool isIpad) {
    return InkWell(
      onTap: () {
        if (_controller != null) {
          _controller!.value.isPlaying
              ? _controller!.pause()
              : _controller!.play();
          setState(() {});
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(isIpad ? 20.0 : 15.0),
          color: Colors.black,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(isIpad ? 20.0 : 15.0),
          child: _controller != null && _controller!.value.isInitialized
              ? AspectRatio(
            aspectRatio: _controller!.value.aspectRatio,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                VideoPlayer(_controller!),
                ClosedCaption(text: _controller!.value.caption.text),
                _ControlsOverlay(controller: _controller!, isIpad: isIpad),
                VideoProgressIndicator(
                  _controller!,
                  colors: VideoProgressColors(
                    playedColor: MyColor.appTheme,
                    bufferedColor: Colors.white.withOpacity(0.3),
                    backgroundColor: Colors.white.withOpacity(0.1),
                  ),
                  allowScrubbing: true,
                ),
              ],
            ),
          )
              : Center(
            child: CircularProgressIndicator(
              color: MyColor.appTheme,
            ),
          ),
        ),
      ),
    );
  }
}

class _ControlsOverlay extends StatefulWidget {
  const _ControlsOverlay({required this.controller, required this.isIpad});

  static const List<Duration> _exampleCaptionOffsets = <Duration>[
    Duration(seconds: -10),
    Duration(seconds: -3),
    Duration(seconds: -1, milliseconds: -500),
    Duration(milliseconds: -250),
    Duration.zero,
    Duration(milliseconds: 250),
    Duration(seconds: 1, milliseconds: 500),
    Duration(seconds: 3),
    Duration(seconds: 10),
  ];
  static const List<double> _examplePlaybackRates = <double>[
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
    3.0,
    5.0,
    10.0,
  ];

  final VideoPlayerController controller;
  final bool isIpad;

  @override
  State<_ControlsOverlay> createState() => _ControlsOverlayState();
}

class _ControlsOverlayState extends State<_ControlsOverlay> {
  bool isMuted = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: widget.controller.value.isPlaying
              ? const SizedBox.shrink()
              : Container(
            color: Colors.black26,
            child: Center(
              child: Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: widget.isIpad ? 80.0 : 60.0,
                semanticLabel: 'Play',
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            widget.controller.value.isPlaying
                ? widget.controller.pause()
                : widget.controller.play();
            setState(() {});
          },
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              0,
              widget.isIpad ? 15.0 : 10.0,
              widget.isIpad ? 15.0 : 10.0,
              widget.isIpad ? 20.0 : 15.0,
            ),
            child: CircleAvatar(
              backgroundColor: Colors.black.withOpacity(0.5),
              child: IconButton(
                onPressed: () {
                  if (isMuted) {
                    widget.controller.setVolume(1);
                  } else {
                    widget.controller.setVolume(0);
                  }
                  isMuted = !isMuted;
                  setState(() {});
                },
                icon: Icon(
                  isMuted ? Icons.volume_off : Icons.volume_up,
                  color: Colors.white,
                  size: widget.isIpad ? 24.0 : 20.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}




//
// import 'dart:async';
// import 'dart:convert';
//
// import 'package:cooking_champs/constant/assets_path.dart';
// import 'package:cooking_champs/constant/dimen.dart';
// import 'package:cooking_champs/constant/my_color.dart';
// import 'package:cooking_champs/constant/my_fonts_style.dart';
// import 'package:cooking_champs/constant/sized_box.dart';
// import 'package:cooking_champs/constant/stringfile.dart/language.dart';
// import 'package:cooking_champs/enums/register_enum.dart';
// import 'package:cooking_champs/model/dynamic_models/recipe_model.dart';
// import 'package:cooking_champs/model/dynamic_models/user_identity_model.dart';
// import 'package:cooking_champs/model/post_model/send_friend_request.dart';
// import 'package:cooking_champs/services/api_path.dart';
// import 'package:cooking_champs/services/api_services.dart';
// import 'package:cooking_champs/services/user_prefences.dart';
// import 'package:cooking_champs/utils/all_dialogs.dart';
// import 'package:cooking_champs/utils/ui_utils.dart';
// import 'package:cooking_champs/widgets/global_button.dart';
// import 'package:cooking_champs/widgets/view_full_image.dart';
// import 'package:flutter/material.dart';
// import 'package:touch_ripple_effect/touch_ripple_effect.dart';
// import 'package:video_player/video_player.dart';
//
// import '../../utils/navigators.dart';
// import '../addyourrecipe.dart';
//
// class RecipeDetailView extends StatefulWidget {
//   final RecipeModel model;
//   Color color;
//
//   RecipeDetailView({super.key, required this.model, required this.color});
//
//   @override
//   State<RecipeDetailView> createState() => _RecipeDetailViewState();
// }
//
// class _RecipeDetailViewState extends State<RecipeDetailView> {
//   UserIdentityModel userDetails = UserIdentityModel();
//   String userResponse = "";
//   RecipeModel recipeModel = RecipeModel();
//   bool isSent = false;
//  String  reaction  = "";
//   @override
//   void initState() {
//     getUserData();
//     getRecipeDetail(true);
//     super.initState();
//     // _initializeController("");
//     // _controller = VideoPlayerController.networkUrl(Uri.parse(
//     //     "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"),
//     //   videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
//     // )
//     //   ..initialize().then((_) {
//     //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
//     //     setState(() {});
//     //   });
//
//   }
//   @override
//   void dispose() {
//     recipeModel.videolink  != ""?   _controller!.pause():null;
//
//     super.dispose();
//   }
//   final bool _mounted = false;
//   bool isVideoError = false;
//   void _initializeController(String link) async {
//     // Dispose previous controller if it exists
//     if (_controller != null) {
//       await _controller!.dispose();
//       _controller = null; // Ensure it's fully reset
//     }
//
//     // Set loading state
//     setState(() {
//       isVideoError = true; // Reset error flag
//     });
//
//     try {
//       // Create new video player controller
//       _controller = VideoPlayerController.networkUrl(
//         Uri.parse(link),
//         videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
//       );
//
//       // Try to initialize the controller
//       await _controller!.initialize();
//
//       // Start playing after initialization
//       _controller!.pause();
//
//       if (_mounted) {
//         setState(() {
//           isVideoError = false; // No error, video loaded successfully
//         });
//       }
//
//       _controller!.addListener(() {
//         if (_mounted) {
//           setState(() {});
//         }
//       });
//
//     } catch (e) {
//       print("Error initializing video controller: $e");
//
//       if (_mounted) {
//         setState(() {
//           isVideoError = true; // Flag to show error UI
//         });
//       }
//     }
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
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: MyColor.white,
//       resizeToAvoidBottomInset: true,
//       appBar: PreferredSize(
//         preferredSize: Size.zero,
//         child: AppBar(
//           leadingWidth: size.width * 0.12,
//           automaticallyImplyLeading: false,
//           backgroundColor: widget.color,
//           surfaceTintColor: widget.color,
//           // leading: Padding(
//           //   padding: const EdgeInsets.only(left: 20.0),
//           //   child: InkWell(
//           //     radius: 80,
//           //     onTap: () {
//           //       Navigator.pop(context);
//           //     },
//           //     child: const Icon(
//           //       Icons.arrow_back_ios,
//           //       size: 28,
//           //       color: Colors.black,
//           //     ),
//           //   ),
//           // ),
//           // title: Text(recipeModel.name ?? "",
//           //     style: mediumTextStyle(fontSize: 18.0, color: MyColor.black)),
//           centerTitle: false,
//           elevation: 0,
//         ),
//       ),
//       body: SingleChildScrollView(
//           // padding: EdgeInsets.zero,
//
//           child: Wrap(
//         children: [
//           Container(
//             color: widget.color,
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(left: 20.0, top: 1),
//                   child: InkWell(
//                     radius: 80,
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     child: const Icon(
//                       Icons.arrow_back_ios,
//                       size: 28,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Text(recipeModel.name ?? "",
//                       style: mediumTextStyle(
//                           fontSize: 18.0, color: MyColor.black)),
//                 ),
//
//                 userDetails.id ==   recipeModel.recipeAddedBy?.id.toString()?
//                 InkWell(
//                   onTap: () {
//                     print("recipeModel.id>>>>>>>${recipeModel.id}");
//                     CustomNavigators.pushNavigate(
//                         AddYourRecipeView(
//                           onCallBack: () {
//                             getRecipeDetail(false);
//                             setState(() {});
//                           },
//                           onCallScreen: true,
//                           recipeId: recipeModel.id,
//                           recipevideolink: recipeModel.videolink.toString(),
//                         ),
//                         context);
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.all(5),
//                     margin: const EdgeInsets.only(right: 10),
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         color: MyColor.appTheme),
//                     // height: 10,
//                     child: Center(
//                         child: Text("Edit",
//                             style: regularTextStyle(
//                                 fontSize: 14.0, color: MyColor.white))),
//                   ),
//                 )
//                 :Container(),
//               ],
//             ),
//           ),
//           Stack(
//             children: [
//               InkWell(
//                 onTap: () {
//                   AllDialogs.customDialog(
//                       context,
//                       ViewFullImage(
//                           image: recipeModel.bannerImage != null
//                               ? recipeModel.bannerImage.toString()
//                               : ""));
//                 },
//                 child: Container(
//                   width: size.width,
//                   height: 280,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.only(
//                         bottomLeft: Radius.circular(30),
//                         bottomRight: Radius.circular(30)),
//                     color: widget.color,
//                   ),
//                   child: Column(
//                     children: [
//                       hsized20,
//                       Align(
//                         alignment: Alignment.center,
//                         child: ClipRRect(
//                             borderRadius: BorderRadius.only(
//                                 bottomLeft: Radius.circular(20),
//                                 bottomRight: Radius.circular(20)),
//                             child: UiUtils.networkImages(
//                                 size.width,
//                                 259,
//                                 recipeModel.bannerImage != null
//                                     ? ApiPath.imageBaseUrl +
//                                         recipeModel.bannerImage.toString()
//                                     : "",
//                                 isBoxFit: true)),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               recipeModel.recipeTools != null &&
//                       recipeModel.recipeTools!.isNotEmpty
//                   ? Container(
//                       width: size.width,
//                       //  height: 325,
//                       margin: EdgeInsets.only(top: 230),
//                       decoration: const BoxDecoration(
//                         borderRadius: BorderRadius.only(
//                             bottomLeft: Radius.circular(30),
//                             bottomRight: Radius.circular(30)),
//                         // color: MyColor.red,
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           // SingleChildScrollView(
//                           //   padding: EdgeInsets.symmetric(horizontal:20),
//                           //   scrollDirection: Axis.horizontal,
//                           //   child: Row(
//                           //       mainAxisAlignment:
//                           //           MainAxisAlignment.spaceEvenly,
//                           //       children: List.generate(
//                           //           recipeModel.recipeTools!.length, (i) {
//                           //         var tools = recipeModel.recipeTools![i];
//                           //         return Container(
//                           //           width: size.width * 0.20,
//                           //           height: 92,
//                           //           margin: EdgeInsets.only(right: 15,bottom: 8),
//                           //           decoration: BoxDecoration(
//                           //             borderRadius: BorderRadius.circular(23),
//                           //             color: MyColor.white,
//                           //             boxShadow: [
//                           //               BoxShadow(
//                           //                 color: MyColor.colorE2E2E2
//                           //                     .withOpacity(0.8),
//                           //                 spreadRadius: 3,
//                           //                 blurRadius: 2,
//                           //               ),
//                           //             ],
//                           //           ),
//                           //           child: Center(
//                           //               child: UiUtils.networkImages(
//                           //                   56,
//                           //                   56,
//                           //                   tools.toolImage != null
//                           //                       ? ApiPath.imageBaseUrl +
//                           //                           tools.toolImage.toString()
//                           //                       : "",isBoxFit: false)),
//                           //         );
//                           //       })),
//                           // )
//                         ],
//                       ),
//                     )
//                   : SizedBox.shrink(),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.only(
//                 top: 15.0, left: 15, right: 15, bottom: 15),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(Languages.of(context)!.toolsUsed,
//                     style:
//                         mediumTextStyle(fontSize: 18.0, color: MyColor.black)),
//                 recipeModel.recipeTools != null &&
//                         recipeModel.recipeTools!.isNotEmpty
//                     ? ListView.builder(
//                         padding: const EdgeInsets.only(top: 08),
//                         itemCount: recipeModel.recipeTools!.length,
//                         shrinkWrap: true,
//                         // Add this to fix the height issue
//                         physics: const NeverScrollableScrollPhysics(),
//                         // Disable ListView scrolling
//                         itemBuilder: (context, index) {
//                           var ingredient = recipeModel.recipeTools![index];
//                           return Padding(
//                             padding: const EdgeInsets.only(top: 8),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Image.asset(
//                                     height: 19, width: 20, AssetsPath.dots),
//                                 Expanded(
//                                   child: Text(ingredient.toolName ?? "",
//                                       style: regularTextStyle(
//                                           fontSize: 14.0,
//                                           color: MyColor.black)),
//                                 )
//                               ],
//                             ),
//                           );
//                         },
//                       )
//                     : SizedBox.shrink(),
//
//                 /// <-----ingredient  List---->
//                 hsized10,
//                 Text(Languages.of(context)!.ingredient,
//                     style:
//                         mediumTextStyle(fontSize: 18.0, color: MyColor.black)),
//                 recipeModel.recipeIngredient != null &&
//                         recipeModel.recipeIngredient!.isNotEmpty
//                     ? ListView.builder(
//                         padding: const EdgeInsets.only(top: 08),
//                         itemCount: recipeModel.recipeIngredient!.length,
//                         shrinkWrap: true,
//                         // Add this to fix the height issue
//                         physics: const NeverScrollableScrollPhysics(),
//                         // Disable ListView scrolling
//                         itemBuilder: (context, index) {
//                           var ingredient = recipeModel.recipeIngredient![index];
//                           return Padding(
//                             padding: const EdgeInsets.only(top: 8),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Image.asset(
//                                     height: 19, width: 20, AssetsPath.dots),
//                                 Expanded(
//                                   child: Text(ingredient.name ?? "",
//                                       style: regularTextStyle(
//                                           fontSize: 14.0,
//                                           color: MyColor.black)),
//                                 )
//                               ],
//                             ),
//                           );
//                         },
//                       )
//                     : SizedBox.shrink(),
//               ],
//             ),
//           ),
//           const Divider(
//             color: MyColor.colorDADADA,
//           ),
//           recipeModel.recipeSteps != null && recipeModel.recipeSteps!.isNotEmpty
//               ? Padding(
//                   padding: const EdgeInsets.only(
//                       top: 20.0, left: 15, right: 15, bottom: 30),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(Languages.of(context)!.howtoCook,
//                           style: mediumTextStyle(
//                               fontSize: 18.0, color: MyColor.black)),
//                       ListView.builder(
//                         padding: const EdgeInsets.only(top: 08),
//                         itemCount: recipeModel.recipeSteps!.length,
//                         shrinkWrap: true,
//                         // Add this to fix the height issue
//                         physics: const NeverScrollableScrollPhysics(),
//                         // Disable ListView scrolling
//                         itemBuilder: (context, index) {
//                           var recipe = recipeModel.recipeSteps![index];
//                           return Padding(
//                             padding: EdgeInsets.only(top: 8),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Expanded(
//                                   child: Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "Step ${index + 1}- ",
//                                         style: semiBoldTextStyle(
//                                             fontSize: 14.0,
//                                             color: MyColor.black),
//                                       ),
//                                       Expanded(
//                                         child: Padding(
//                                           padding:
//                                               const EdgeInsets.only(top: 1.0),
//                                           child: Text(recipe.name ?? "",
//                                               style: regularTextStyle(
//                                                   fontSize: 14.0,
//                                                   color: MyColor.black)),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 )
//               : SizedBox.shrink(),
//
//           recipeModel.videolink !="" &&     isVideoError ==true?
//           Container(
//             margin: EdgeInsets.only(left: 10, right: 10,bottom: 20),
//             padding: EdgeInsets.only(right: 13, left: 13, top: 5 ,bottom: 8),
//             width: size.width * 0.95,
//             height: size.height * 0.30,
//             // color: Colors.amber,
//             child:
//             _buildVideoPlayer(0),):Container(),
//           recipeModel.heartCount  !=  null ? Center(
//             child: Container(
//               width: size.width * 0.95,
//             //  height: size.height * 0.09,
//               margin: EdgeInsets.only(left: 10, right: 10),
//               padding: EdgeInsets.only(right: 13, left: 13, top: 5 ,bottom:5),
//               decoration: BoxDecoration(
//                 color: widget.color,
//                 borderRadius: BorderRadius.circular(55),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Column(
//                     children: [
//                       InkWell(
//                         onTap: (){
//                           if(   reaction == "heart"){
//                             reaction = "";
//                           }else{
//                             reaction = "heart";
//                           }sendReactionOnTap(reaction);
//                           setState(() {
//
//                           });
//                         },
//                         child: CircleAvatar(
//                           backgroundColor:reaction =="heart"?MyColor.color48335CB2: Colors.white,
//                           radius: 20,
//                           child: Image.asset(
//                             AssetsPath.heartimg,
//                             width: 22,
//                             height: 24,
//                           ),
//                         ),
//                       ),
//                       hsized5,
//                       Text(
//                         recipeModel.heartCount.toString(),
//                         style: TextStyle(
//                             fontSize: 14,
//                             color: MyColor.color48335CB2,
//                             fontWeight: FontWeight.w400,
//                             fontFamily: Fonts.beVietnamProRegular),
//                       )
//                     ],
//                   ),
//                   Column(
//                     children: [
//                       InkWell(
//                         onTap: (){
//                           if(   reaction == "emoji"){
//                             reaction = "";
//                           }else{
//                             reaction = "emoji";
//                           }sendReactionOnTap(reaction);
//                           setState(() {
//
//                           });
//
//                         },
//                         child: CircleAvatar(
//                           backgroundColor:reaction =="emoji"?MyColor.color48335CB2: Colors.white,
//                           radius: 20,
//                           child: Image.asset(
//                             AssetsPath.smileimg,
//                             width: 22,
//                             height: 24,
//                           ),
//                         ),
//                       ),  hsized5,
//                       Text(
//                         recipeModel.emojiCount.toString(),
//                         style: TextStyle(
//                             fontSize: 14,
//                             color: MyColor.color48335CB2,
//                             fontWeight: FontWeight.w400,
//                             fontFamily: Fonts.beVietnamProRegular),
//                       )
//                     ],
//                   ),
//                   Column(
//                     children: [
//                       InkWell(
//                         onTap: (){
//                           if(   reaction == "star"){
//                             reaction = "";
//                           }else{
//                             reaction = "star";
//                           }sendReactionOnTap(reaction);
//                           setState(() {
//
//                           });
//                         },
//                         child: CircleAvatar(
//                           backgroundColor:reaction =="star"?MyColor.color48335CB2: Colors.white,
//                           radius: 20,
//                           child: Image.asset(
//                             AssetsPath.starimg,
//                             width: 22,
//                             height: 24,
//                           ),
//                         ),
//                       ),  hsized5,
//                       Text(
//                         recipeModel.starCount.toString(),
//                         style: TextStyle(
//                             fontSize: 14,
//                             color: MyColor.color48335CB2,
//                             fontWeight: FontWeight.w400,
//                             fontFamily: Fonts.beVietnamProRegular),
//                       )
//                     ],
//                   ),
//                   Column(
//                     children: [
//                       InkWell(
//                         onTap: (){
//                           if(   reaction == "batch"){
//                             reaction = "";
//                           }else{
//                             reaction = "batch";
//                           }sendReactionOnTap(reaction);
//                           setState(() {
//
//                           });
//                         },
//                         child: CircleAvatar(
//                           backgroundColor:reaction =="batch"?MyColor.color48335CB2: Colors.white,
//                           radius: 20,
//                           child: Image.asset(
//                             AssetsPath.starbatchimg,
//                             width: 22,
//                             height: 24,
//                           ),
//                         ),
//                       ),  hsized5,
//                       Text(
//                         recipeModel.batchCount.toString(),
//                         style: TextStyle(
//                             fontSize: 14,
//                             color: MyColor.color48335CB2,
//                             fontWeight: FontWeight.w400,
//                             fontFamily: Fonts.beVietnamProRegular),
//                       )
//                     ],
//                   ),
//                   Column(
//                     children: [
//                       InkWell(
//                         onTap: (){
//                           if(   reaction == "cook"){
//                             reaction = "";
//                           }else{
//                             reaction = "cook";
//                           }sendReactionOnTap(reaction);
//                           setState(() {
//
//                           });
//                         },
//                         child: CircleAvatar(
//                           backgroundColor:reaction =="cook"?MyColor.color48335CB2: Colors.white,
//                           radius: 20,
//                           child: Image.asset(
//                             AssetsPath.cookimg,
//                             width: 22,
//                             height: 24,
//                           ),
//                         ),
//                       ),  hsized5,
//                       Text(
//                         recipeModel.cookCount.toString(),
//                         style: TextStyle(
//                             fontSize: 14,
//                             color: MyColor.color48335CB2,
//                             fontWeight: FontWeight.w400,
//                             fontFamily: Fonts.beVietnamProRegular),
//                       )
//                     ],
//                   ),
//                   Column(
//                     children: [
//                       InkWell(
//                         onTap: (){
//
//                           if(   reaction == "like"){
//                             reaction = "";
//                           }else{
//                             reaction = "like";
//                           }sendReactionOnTap(reaction);
//                           setState(() {
//
//                           });
//                         },
//                         child: CircleAvatar(
//                           backgroundColor:reaction =="like"?MyColor.color48335CB2: Colors.white,
//                           radius: 20,
//                           child: Image.asset(
//                             AssetsPath.likeimg,
//                             width: 22,
//                             height: 24,
//                           ),
//                         ),
//                       ),  hsized5,
//                       Text(
//                         recipeModel.likeCount.toString(),
//                         style: TextStyle(
//                             fontSize: 14,
//                             color: MyColor.color48335CB2,
//                             fontWeight: FontWeight.w400,
//                             fontFamily: Fonts.beVietnamProRegular),
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ):Container(),
//           hsized90
//         ],
//       )),
//       bottomNavigationBar: Wrap(
//         children: [
//           recipeModel.recipeAddedBy != null
//               ? Container(
//                   padding:
//                       EdgeInsets.only(top: 10, bottom: 30, left: 20, right: 20),
//                   decoration: BoxDecoration(
//                     color: widget.color,
//                     borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(46),
//                         topRight: Radius.circular(46)),
//                   ),
//                   alignment: Alignment
//                       .center, // Centers text vertically and horizontally
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             InkWell(
//                               onTap: () {
//                                 AllDialogs.customDialog(
//                                     context,
//                                     ViewFullImage(
//                                         image: recipeModel
//                                                     .recipeAddedBy!.image !=
//                                                 null
//                                             ? "${recipeModel.recipeAddedBy!.image}"
//                                             : ""));
//                               },
//                               child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(500),
//                                   child: UiUtils.networkProfile(
//                                       55,
//                                       55,
//                                       recipeModel.recipeAddedBy!.image != null
//                                           ? "${ApiPath.imageBaseUrl}${recipeModel.recipeAddedBy!.image}"
//                                           : "")),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(left: 10, top: 5),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(recipeModel.recipeAddedBy!.name ?? "",
//                                       style: mediumTextStyle(
//                                           fontSize: 16.0,
//                                           color: MyColor.black)),
//                                   SizedBox(
//                                     height: 3,
//                                   ),
//                                   if (recipeModel.recipeAddedBy!.role
//                                           .toString() ==
//                                       RegisterType.roleKids.value)
//                                     Text(
//                                         "${recipeModel.recipeAddedBy!.day == "null" ? "" : "${recipeModel.recipeAddedBy!.day} | "}${recipeModel.recipeAddedBy!.month == "null" ? "" : "${recipeModel.recipeAddedBy!.month} | "}${recipeModel.recipeAddedBy!.year == "null" ? "" : "${recipeModel.recipeAddedBy!.year} | "}${recipeModel.recipeAddedBy!.grade ?? ""}",
//                                         style: regularTextStyle(
//                                             fontSize: 14.0,
//                                             color: MyColor.black))
//                                   else
//                                     SizedBox.shrink(),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//
//                       // Inside the widget tree
//                       // shouldShowButton()
//                       //     ?
//                       userDetails.id != recipeModel.recipeAddedBy!.id.toString()
//                           ? Padding(
//                               padding: const EdgeInsets.only(top: 10.0),
//                               child: GlobalButton(
//                                 btnText(recipeModel
//                                     .recipeAddedBy!.followRequestStatus
//                                     .toString()),
//                                 MyColor.appTheme,
//                                 MyColor.appTheme,
//                                 btnSize40,
//                                 double.infinity,
//                                 sendRequestOnTap,
//                                 55,
//                                 5,
//                                 0,
//                                 mediumTextStyle(
//                                     fontSize: 16.0, color: MyColor.white),
//                               ),
//                             )
//                           : Container()
//                       // : SizedBox.shrink(),
//                       // userDetails.role.toString() ==  recipeModel.recipeAddedBy!.role.toString() && recipeModel.recipeAddedBy!.id.toString() != userDetails.id.toString()) &&
//                       /*  if (userDetails.role.toString() ==
//                               recipeModel.recipeAddedBy!.role.toString() &&
//                           recipeModel.recipeAddedBy!.id.toString() !=
//                               userDetails.id.toString() &&
//                           btnText(recipeModel.recipeAddedBy!.friendRequestStatus
//                                   .toString())
//                               .isNotEmpty)
//                         Padding(
//                           padding: const EdgeInsets.only(top: 10.0),
//                           child: GlobalButton(
//                               btnText(recipeModel
//                                   .recipeAddedBy!.friendRequestStatus
//                                   .toString()),
//                               MyColor.appTheme,
//                               MyColor.appTheme,
//                               btnSize40,
//                               double.infinity,
//                               sendRequestOnTap,
//                               55,
//                               5,
//                               0,
//                               mediumTextStyle(
//                                   fontSize: 16.0, color: MyColor.white)),
//                         )
//                       else
//                         SizedBox.fromSize()*/
//                     ],
//                   ),
//                 )
//               : SizedBox.shrink(),
//         ],
//       ),
//     );
//   }
//
//   // Function to determine if the button should be shown
//   bool shouldShowButton() {
//     final recipeAddedBy = recipeModel.recipeAddedBy;
//     if (recipeAddedBy == null) return false;
//
//     final userIdMatches =
//         userDetails.id.toString() == recipeAddedBy.id.toString();
//     final rolesMatch =
//         userDetails.role.toString() == recipeAddedBy.role.toString();
//     final btnTextValue = btnText(recipeAddedBy.friendRequestStatus.toString());
//     debugPrint("1111111");
//     // Conditions
//     if (userIdMatches && rolesMatch) {
//       debugPrint("1");
//       // Hide button if user ID matches or roles match
//       return false;
//     } else if (!userIdMatches && !rolesMatch && btnTextValue.isNotEmpty) {
//       debugPrint("2");
//       // Hide button if user ID matches or roles match
//       return true;
//     } else if (btnTextValue.isNotEmpty) {
//       debugPrint("3");
//       // Show button if roles match and btnText is not empty
//       return true;
//     }
//
//     return false;
//   }
//
//   String btnText(String status) {
//     debugPrint("status..$status");
//     switch (status) {
//       // case "request not sent":
//       case "follow":
//         return Languages.of(context)!.follow.toString();
//       case "pending":
//         return Languages.of(context)!.cancelRequest.toString();
//       // return Languages.of(context)!.unFallow.toString();
//       case "Accept":
//         return "Accept";
//       case "accepted":
//         return Languages.of(context)!.friend.toString();
//       case "rejected":
//         return Languages.of(context)!.sendRequest.toString();
//       case "unfollow":
//         return Languages.of(context)!.unFallow.toString();
//       default:
//         return '';
//     }
//   }
//
//   Future<void>? getRecipeDetail(bool? loader) async {
//     try {
//       await ApiServices.getRecipeDetail(
//               context, loader!, widget.model.id.toString())
//           .then((onValue) {
//         if (mounted && onValue.status == true) {
//           setState(() {
//             if (onValue.data != null) {
//
//               print(
//                   "onValue.data>>>>111>>>${onValue.data}");
//               recipeModel = RecipeModel.fromJson(onValue.data);
//               setState(() {
//
//               });
//               recipeModel.videolink  != ""?    _initializeController(recipeModel.videolink.toString()):null;
//               print(
//                   "followRequestStatus>>>>>>>${recipeModel.recipeAddedBy!.followRequestStatus}");
//               if (recipeModel.recipeAddedBy != null) {
//                 if (recipeModel.recipeAddedBy!.friendRequestStatus != null) {
//                   if (recipeModel.recipeAddedBy!.friendRequestStatus
//                           .toString() !=
//                       "request not sent") {
//                     isSent = true;
//                   } else {
//                     isSent = false;
//                   }
//                 }
//               }
//             }
//           });
//         }
//       });
//     } catch (e) {
//       debugPrint('Error fetching stories: $e');
//     }
//   }
//
//   void sendRequestOnTap() async {
//     if (recipeModel.recipeAddedBy!.followRequestStatus.toString() == "follow" ||
//             recipeModel.recipeAddedBy!.followRequestStatus.toString() ==
//                 "unfollow"
//         // ||
//         // recipeModel.recipeAddedBy!.friendRequestStatus.toString() ==
//         //     "pending"
//         ) {
//       FollowRequest friendRequest = FollowRequest(
//         senderId: int.parse(userDetails.id ?? "0"),
//         receiverId: int.parse(recipeModel.recipeAddedBy!.id.toString()),
//         requestSentBy: userDetails.role,
//         requestSentTo: recipeModel.recipeAddedBy!.role.toString(),
//       );
//
//       await ApiServices.followRequest(context, friendRequest).then((onValue) {
//         print("objectsssss");
//         if (onValue.status == true) {
//           if (mounted) {
//             setState(() {
//               getRecipeDetail(false);
//               // recipeModel.recipeAddedBy!.friendRequestStatus.toString() ==
//               //         "pending"
//               //     ? recipeModel.recipeAddedBy!.friendRequestStatus =
//               //         "request not sent"
//               //     : recipeModel.recipeAddedBy!.friendRequestStatus = "pending";
//             });
//           }
//         }
//       });
//     }
//   }
//
//   void sendReactionOnTap( String status) async {
//     // "recipe_id":"2",
//     // "type":"kid",
//     // "status":"like"
//
//     ReactionRequest reactionRequest = ReactionRequest(
//         recipeid: recipeModel.id,
//         status: status,
//         type: userDetails.role,
//
//       );
//
//       await ApiServices.reactionRequest(context, reactionRequest,false).then((onValue) {
//         print("reactionRequest>>>");
//         if (onValue.status == true) {
//           if (mounted) {
//             setState(() {
//               getRecipeDetail(false);
//               // recipeModel.recipeAddedBy!.friendRequestStatus.toString() ==
//               //         "pending"
//               //     ? recipeModel.recipeAddedBy!.friendRequestStatus =
//               //         "request not sent"
//               //     : recipeModel.recipeAddedBy!.friendRequestStatus = "pending";
//             });
//           }
//         }
//       });
//
//   }
//
//   VideoPlayerController? _controller;
//   Widget _buildVideoPlayer(int index) {
//     final data = MediaQuery.of(context);
//     final double width = data.size.width;
//     final double height = data.size.height;
//     final double aspectRatio = width / height;
//
//     return InkWell(
//       onTap: (){
//         print("object");
//         // _controller!.value.isPlaying
//         //     ? _controller!.pause()
//         //     :
//         // _controller!.play();
//         print("_controller>>>>>>>>>>>${_controller!.value.isPlaying}");
//       },
//       child: Container(
//       // color: Colors.red,
//         child: AspectRatio(
//           aspectRatio: _controller!.value.aspectRatio,
//           child: Stack(
//             alignment: Alignment.bottomCenter,
//             children: <Widget>[
//               VideoPlayer(_controller!),
//               ClosedCaption(text: _controller!.value.caption.text),
//               _ControlsOverlay(controller: _controller!),
//               VideoProgressIndicator(
//                 _controller!,
//                 colors: VideoProgressColors(
//                   playedColor: MyColor.color1C1C1C,
//                   bufferedColor: Colors.white,
//                   backgroundColor: Colors.white,
//                 ),
//                 allowScrubbing: true,
//               ),
//             ],
//           ),
//         ),
//         // child: AspectRatio(
//         //   aspectRatio: _controller!.value.aspectRatio,
//         //   child: VideoPlayer(_controller!),
//         // )
//             // : Container(child: Text("data"),),
//       ),
//     );
//   }
//
// }
// class _ControlsOverlay extends StatefulWidget {
//   const _ControlsOverlay({required this.controller});
//
//   static const List<Duration> _exampleCaptionOffsets = <Duration>[
//     Duration(seconds: -10),
//     Duration(seconds: -3),
//     Duration(seconds: -1, milliseconds: -500),
//     Duration(milliseconds: -250),
//     Duration.zero,
//     Duration(milliseconds: 250),
//     Duration(seconds: 1, milliseconds: 500),
//     Duration(seconds: 3),
//     Duration(seconds: 10),
//   ];
//   static const List<double> _examplePlaybackRates = <double>[
//     0.25,
//     0.5,
//     1.0,
//     1.5,
//     2.0,
//     3.0,
//     5.0,
//     10.0,
//   ];
//
//   final VideoPlayerController controller;
//
//   @override
//   State<_ControlsOverlay> createState() => _ControlsOverlayState();
// }
//
// class _ControlsOverlayState extends State<_ControlsOverlay> {
//   bool isMuted = false;
//
//   // @override
//   // void dispose() {
//   //   widget.controller.pause();
//   //   super.dispose();
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         AnimatedSwitcher(
//           duration: const Duration(milliseconds: 50),
//           reverseDuration: const Duration(milliseconds: 200),
//           child: widget.controller.value.isPlaying
//               ? const SizedBox.shrink()
//               : Container(
//             color: Colors.black26,
//             child: const Center(
//               child: Icon(
//                 Icons.play_arrow,
//                 color: Colors.white,
//                 size: 100.0,
//                 semanticLabel: 'Play',
//               ),
//             ),
//           ),
//         ),
//         GestureDetector(
//           onTap: () {
//             widget.controller.value.isPlaying
//                 ? widget.controller.pause()
//                 : widget.controller.play();
//             setState(() {});
//           },
//         ),
//         Align(
//           alignment: Alignment.topLeft,
//           child: PopupMenuButton<Duration>(
//             initialValue: widget.controller.value.captionOffset,
//             tooltip: 'Caption Offset',
//             onSelected: (Duration delay) {
//               widget.controller.setCaptionOffset(delay);
//             },
//             itemBuilder: (BuildContext context) {
//               return <PopupMenuItem<Duration>>[
//                 for (final Duration offsetDuration
//                 in _ControlsOverlay._exampleCaptionOffsets)
//                   PopupMenuItem<Duration>(
//                     value: offsetDuration,
//                     child: Text(
//                       '${offsetDuration.inMilliseconds}ms',
//                       style: const TextStyle(
//                         color: Colors.transparent,
//                       ),
//                     ),
//                   )
//               ];
//             },
//             child: Padding(
//               padding: const EdgeInsets.symmetric(
//                 // Using less vertical padding as the text is also longer
//                 // horizontally, so it feels like it would need more spacing
//                 // horizontally (matching the aspect ratio of the video).
//                 vertical: 12,
//                 horizontal: 16,
//               ),
//               child: Text(
//                 '${widget.controller.value.captionOffset.inMilliseconds}ms',
//                 style: const TextStyle(
//                   color: Colors.transparent,
//                 ),
//               ),
//             ),
//           ),
//         ),
//         Align(
//           alignment: Alignment.topRight,
//           child: Visibility(
//             visible: false,
//             child: PopupMenuButton<double>(
//               initialValue: widget.controller.value.playbackSpeed,
//               tooltip: 'Playback speed',
//               onSelected: (double speed) {
//                 widget.controller.setPlaybackSpeed(speed);
//               },
//               itemBuilder: (BuildContext context) {
//                 return <PopupMenuItem<double>>[
//                   for (final double speed
//                   in _ControlsOverlay._examplePlaybackRates)
//                     PopupMenuItem<double>(
//                       value: speed,
//                       child: Text('${speed}x'),
//                     )
//                 ];
//               },
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(
//                   // Using less vertical padding as the text is also longer
//                   // horizontally, so it feels like it would need more spacing
//                   // horizontally (matching the aspect ratio of the video).
//                   vertical: 12,
//                   horizontal: 16,
//                 ),
//                 child: Text('${widget.controller.value.playbackSpeed}x'),
//               ),
//             ),
//           ),
//         ),
//         Align(
//           alignment: Alignment.bottomRight,
//           child: Padding(
//             padding: const EdgeInsets.fromLTRB(0, 10, 10, 15),
//             child: CircleAvatar(
//               backgroundColor: MyColor.black.withOpacity(0.2),
//               child: IconButton(
//                   onPressed: () {
//                     debugPrint(isMuted.toString());
//                     if (isMuted) {
//                       widget.controller.setVolume(1);
//                     } else {
//                       widget.controller.setVolume(0);
//                     }
//                     isMuted = !isMuted;
//                     setState(() {});
//                   },
//                   icon: Visibility(
//                     visible: isMuted,
//                     replacement: const Icon(
//                       Icons.volume_up,
//                       color: Colors.white,
//                     ),
//                     child: const Icon(
//                       Icons.volume_off,
//                       color: Colors.white,
//                     ),
//                   )),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//





