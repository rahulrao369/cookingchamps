import 'dart:convert';
import 'dart:developer';
import 'dart:math' hide log;
import 'package:video_thumbnail/video_thumbnail.dart';
import 'dart:typed_data';
import 'package:cooking_champs/constant/app_state.dart';
import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/constant/stringfile.dart/language.dart';
import 'package:cooking_champs/model/dynamic_models/home_model.dart';
import 'package:cooking_champs/model/dynamic_models/my_story_model.dart';
import 'package:cooking_champs/model/dynamic_models/recipe_model.dart';
import 'package:cooking_champs/model/dynamic_models/school_stories_model.dart';
import 'package:cooking_champs/model/dynamic_models/user_identity_model.dart';
import 'package:cooking_champs/new_ui/video_scroll_screen.dart';
import 'package:cooking_champs/services/api_path.dart';
import 'package:cooking_champs/services/api_services.dart';
import 'package:cooking_champs/services/user_prefences.dart';
import 'package:cooking_champs/update_app/update_app_services.dart';
import 'package:cooking_champs/utils/all_dialogs.dart';
import 'package:cooking_champs/utils/navigators.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:cooking_champs/utils/utility.dart';
import 'package:cooking_champs/views/dashboard.dart';
import 'package:cooking_champs/views/notication_view.dart';
import 'package:cooking_champs/views/recipe/recipe_detail_view.dart';
import 'package:cooking_champs/views/recipe/see_all_recipe.dart';
import 'package:cooking_champs/views/story/all_story_view.dart';
import 'package:cooking_champs/views/story/storie_detials.dart';
import 'package:cooking_champs/widgets/global_button.dart';
import 'package:cooking_champs/widgets/view_full_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';
import '../ai_recipe_service/ai_recipe_service.dart';
import '../ai_recipe_service/home_ai_recipe_service.dart';
import '../model/dynamic_models/school_video_model.dart';
import '../new_ui/add_recipe_screen.dart';
import '../new_ui/dish_list_screen_by_search.dart';
import 'growingactivity.dart';
import 'monthly_challenge_bannetr_detials.dart';

import 'package:cooking_champs/model/dynamic_models/recipe_model.dart'
    as ApiRecipe;

import 'package:cooking_champs/ai_recipe_service/recipe_model.dart' as AiRecipe;

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool colorBg = true;
  UserIdentityModel userDetails = UserIdentityModel();
  HomeModel homeModel = HomeModel();
  List<RecipeModel> recipeOfTheWeekList = [];
  List<RecipeModel> popularRecipeList = [];
  List<StoryModel> featuredStoryList = [];
  List<Videos> schoolStoryList = [];
  String userResponse = "";
  List exploreList = [
    "Kids Learning",
    "Our Stories",
    "About Us",
  ];

  @override
  void initState() {
    getUserData();
    super.initState();
    fetchSchoolStories();
    loadThumbnail();
  }

  void getUserData() async {
    Future.delayed(Duration.zero, () {
      home(true);
    });

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

  Uint8List? thumbnailBytes;

  void loadThumbnail() async {
    final bytes = await getVideoThumbnail('https://example.com/video.mp4');
    setState(() {
      thumbnailBytes = bytes;
    });
  }

  Future<Uint8List?> getVideoThumbnail(String videoUrl) async {
    try {
      final uint8list = await VideoThumbnail.thumbnailData(
        video: videoUrl,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 300,
        quality: 75,
      );
      return uint8list;
    } catch (e) {
      print("Error generating thumbnail: $e");
      return null;
    }
  }

  String pickRandom(List<String> list) {
    final random = Random();
    return list[random.nextInt(list.length)];
  }

  /// New Code (Vaibhav)
  void home(bool load) async {
    await ApiServices.home(context, load, "").then((onValue) {
      if (!mounted) return;

      if (onValue.status == true && onValue.data != null) {
        setState(() {
          colorBg = false;
          homeModel = HomeModel.fromJson(onValue.data);

          /// Recipe of the week
          if (homeModel.recipeOfTheWeek != null &&
              homeModel.recipeOfTheWeek!.name != null) {
            recipeOfTheWeekList.add(homeModel.recipeOfTheWeek!);
          }

          /// Popular recipes
          if (homeModel.popularRecipes != null &&
              homeModel.popularRecipes!.isNotEmpty) {
            popularRecipeList.addAll(homeModel.popularRecipes!);

            for (int i = 0; i < popularRecipeList.length; i++) {
              popularRecipeList[i].color = Utility().getColorForIndex(i);
            }
          }

          /// Featured stories
          if (homeModel.featuredStories != null &&
              homeModel.featuredStories!.isNotEmpty) {
            featuredStoryList.addAll(homeModel.featuredStories!);
          }

          log("Popular Recipes => ${homeModel.popularRecipes}");
          log("Featured Stories => ${homeModel.featuredStories}");
        });
      }
    });

    await UpdateAppServices().checkForUpdate(context);
  }

  Future<void> fetchSchoolStories() async {
    final schoolStoriesModel =
        await ApiServices.schoolStories(context: context, load: true);

    if (!mounted) return;

    if (schoolStoriesModel?.data != null &&
        schoolStoriesModel!.data!.isNotEmpty) {
      final List<Videos> fetchedVideos = schoolStoriesModel.data!
          .where((school) => school.videos != null)
          .expand<Videos>((school) => school.videos!)
          .toList();

      if (fetchedVideos.isNotEmpty) {
        setState(() {
          schoolStoryList.addAll(fetchedVideos);
        });

        log("Videos added => ${schoolStoryList.length}");
      } else {
        log("No videos found inside school stories");
      }
    } else {
      log("No school stories found");
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:
          (colorBg == true) ? Colors.transparent : MyColor.appTheme,
      body: RefreshIndicator(
        color: MyColor.appTheme,
        onRefresh: () {
          return Future.delayed(
            const Duration(seconds: 1),
            () {
              Future.delayed(Duration.zero, () {
                home(true);
              });
            },
          );
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                decoration: BoxDecoration(
                    color: pageIndex == 0
                        ? MyColor.appTheme
                        : MyColor.yellowF6F1E1),
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
                                            : ""));
                                //userDetails.role == RegisterType.roleKids.value?null:   CustomNavigators.pushNavigate(EditProfileView(onUpdate:(){}), context);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                    bottom: 5,
                                    top: (AppState.devicetype == "ipad")
                                        ? 20.0
                                        : 0,
                                    left: (AppState.devicetype == "ipad")
                                        ? 10.0
                                        : 0),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(500),
                                    child: UiUtils.networkProfile(
                                        (AppState.devicetype == "ipad")
                                            ? 70.0
                                            : 60,
                                        (AppState.devicetype == "ipad")
                                            ? 70.0
                                            : 60,
                                        userDetails.image != null
                                            ? ApiPath.imageBaseUrl +
                                                userDetails.image.toString()
                                            : "")),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: (AppState.devicetype == "ipad")
                                        ? 20.0
                                        : 0,
                                    left: (AppState.devicetype == "ipad")
                                        ? 20.0
                                        : 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "${Languages.of(context)!.hey}, ${userDetails.name ?? ""}",
                                        maxLines: 2,
                                        style: semiBoldTextStyle(
                                            fontSize:
                                                (AppState.devicetype == "ipad")
                                                    ? 24.0
                                                    : 17.0,
                                            color: pageIndex == 0
                                                ? MyColor.white
                                                : MyColor.appTheme)),
                                    Text(
                                        "${Languages.of(context)!.welcomeBack}!",
                                        style: regularTextStyle(
                                            fontSize:
                                                (AppState.devicetype == "ipad")
                                                    ? 23.0
                                                    : 16.0,
                                            color: pageIndex == 0
                                                ? MyColor.white
                                                : MyColor.black)),
                                    SizedBox(
                                      width: 10,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ]),
                    ),

                    /// AI Icon Top
                    // GestureDetector(
                    //   onTap: () {
                    //     CustomNavigators.pushNavigate(
                    //         AddRecipeScreen(), context);
                    //   },
                    //   child: SvgPicture.asset(
                    //     "assets/images/addDishIcon.svg",
                    //     height: 38,
                    //   ),
                    // ),
                    wSized8,
                    pageIndex == 0
                        ? TouchRippleEffect(
                            borderRadius: BorderRadius.circular(19),
                            rippleColor: Colors.white,
                            onTap: () {
                              CustomNavigators.pushNavigate(
                                  NotificationView(), context);
                            },
                            child: CircleAvatar(
                              backgroundColor: MyColor.dividerYellow,
                              radius:
                                  (AppState.devicetype == "ipad") ? 26.0 : 19,
                              child: Center(
                                child: Image.asset(
                                    height: (AppState.devicetype == "ipad")
                                        ? 52.0
                                        : 38,
                                    AssetsPath.bell1png,
                                    color: MyColor.appTheme),
                              ),
                            ),
                          )
                        : TouchRippleEffect(
                            borderRadius: BorderRadius.circular(27),
                            rippleColor: Colors.white,
                            onTap: () {
                              CustomNavigators.pushNavigate(
                                  NotificationView(), context);
                            },
                            child: Image.asset(
                                height:
                                    (AppState.devicetype == "ipad") ? 52 : 38,
                                AssetsPath.bellpng),
                          )
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: Container(
                  height: (AppState.devicetype == "ipad") ? 350 : 228,
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 0),
                  decoration: BoxDecoration(
                      // color: MyColor.yellowF6F1E1,
                      color: MyColor.appTheme,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(35),
                          bottomLeft: Radius.circular(35))),
                  child: Column(
                    children: [
                      recipeOfTheWeekList.isEmpty
                          ? SizedBox(
                              width: size.width * 0.94,
                            )
                          : Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Center(
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(35),
                                      child: UiUtils.networkImages(
                                        (AppState.devicetype == "ipad")
                                            ? size.width
                                            : size.width * 0.92,
                                        (AppState.devicetype == "ipad")
                                            ? 300
                                            : 173,
                                        "${ApiPath.imageBaseUrl}${homeModel.monthlyChallengeBanner?.bannerImage}",
                                      ),
                                    ),

                                    /// Overlay content
                                    Positioned.fill(
                                      // ✅ important
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          /// Title
                                          Container(
                                            padding: const EdgeInsets.only(
                                                top: 20, left: 15, right: 20),
                                            height: 80,
                                            child: Text(
                                              homeModel
                                                  .monthlyChallengeBanner!.title
                                                  .toString(),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: boldTextStyle(
                                                fontSize:
                                                    (AppState.devicetype ==
                                                            "ipad")
                                                        ? 27.0
                                                        : 20.0,
                                                color: MyColor.appTheme,
                                              ),
                                            ),
                                          ),

                                          /// Bottom-left button
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 30, bottom: 15),
                                            child: InkWell(
                                              onTap: () {
                                                CustomNavigators.pushNavigate(
                                                  Monthlychallengebanner(
                                                    title: homeModel
                                                        .monthlyChallengeBanner!
                                                        .title
                                                        .toString(),
                                                    description: homeModel.monthlyChallengeBanner!.description.toString(),
                                                  ),
                                                  context,
                                                );
                                              },
                                              child: Container(
                                                height: (AppState.devicetype ==
                                                        "ipad")
                                                    ? 50
                                                    : 25,
                                                width: (AppState.devicetype ==
                                                        "ipad")
                                                    ? 200
                                                    : 113,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: Colors.amber,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    textAlign: TextAlign.center,
                                                    Languages.of(context)!
                                                        .viewDetail
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: (AppState
                                                                  .devicetype ==
                                                              "ipad")
                                                          ? 25
                                                          : 12,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Visibility(
                      visible: false,
                      child: Container(
                          height: 115,
                          width: size.width,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          alignment: Alignment.center,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                exploreUi(0),
                                exploreUi(1),
                                exploreUi(2),
                              ])),
                    ),
                    hsized15,
                    (AppState.devicetype == "ipad")
                        ? homeModel.recipeOfTheWeek != null ||
                                homeModel.growingActivity != null
                            ? Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 5, top: 10),
                                      child: Stack(
                                        children: [
                                          SizedBox(
                                            height: 460,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    CustomNavigators.pushNavigate(
                                                        RecipeDetailView(
                                                            model:
                                                                recipeOfTheWeekList[
                                                                    0],
                                                            color: recipeOfTheWeekList[
                                                                        0]
                                                                    .color ??
                                                                MyColor
                                                                    .blueLite),
                                                        context);
                                                  },
                                                  child: Container(
                                                    height: 460,
                                                    // width: size.width * 0.45,
                                                    decoration: BoxDecoration(
                                                        color: MyColor.white,
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    39))),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                            // height: 300,
                                                            // width:
                                                            //     size.width * 0.40.,
                                                            decoration:
                                                                BoxDecoration(
                                                                    // color: MyColor.colorE2EBFF,
                                                                    color: Colors
                                                                        .transparent,
                                                                    borderRadius:
                                                                        const BorderRadius
                                                                            .all(
                                                                            Radius.circular(39))),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Stack(
                                                                  children: [
                                                                    ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                      child: UiUtils
                                                                          .networkImages(
                                                                        size.width *
                                                                            0.451,
                                                                        330,
                                                                        "${ApiPath.imageBaseUrl}${homeModel.recipeOfTheWeek!.bannerImage.toString()}",
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      margin: EdgeInsets
                                                                          .all(
                                                                              15),
                                                                      decoration: BoxDecoration(
                                                                          color: Colors
                                                                              .white,
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(15))),
                                                                      width:
                                                                          100,
                                                                      // height: 20,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                        child: Text(
                                                                            Languages.of(context)!
                                                                                .recipeOfTheMonth,
                                                                            // overflow: TextOverflow.ellipsis,
                                                                            style:
                                                                                boldTextStyle(
                                                                              fontSize: 12.0,
                                                                              color: MyColor.appTheme,
                                                                            )),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                hsized10,
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              0,
                                                                          right:
                                                                              10),
                                                                  child: Text(
                                                                      homeModel
                                                                          .recipeOfTheWeek!
                                                                          .name
                                                                          .toString(),
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style:
                                                                          semiBoldTextStyle(
                                                                        fontSize:
                                                                            20.0,
                                                                        color: MyColor
                                                                            .appTheme,
                                                                      )),
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                      size.width *
                                                                          0.40,
                                                                  child:
                                                                      Builder(
                                                                    builder:
                                                                        (context) {
                                                                      List<String>
                                                                          ingredients =
                                                                          homeModel.recipeOfTheWeek?.recipeIngredient?.map((e) => e.name ?? "").toList() ??
                                                                              [];

                                                                      // Limit to 3 items and add "+ More" if necessary
                                                                      String displayText = ingredients.length >
                                                                              2
                                                                          ? "${ingredients.sublist(0, 3).join(', ')} \n+ More"
                                                                          : ingredients
                                                                              .join(', ');

                                                                      return Text(
                                                                        displayText,
                                                                        maxLines:
                                                                            3,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        textAlign:
                                                                            TextAlign.justify,
                                                                        style: regularNormalTextStyle(
                                                                            fontSize:
                                                                                15.0,
                                                                            color:
                                                                                MyColor.appTheme),
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 5, top: 00),
                                      child: Stack(
                                        children: [
                                          SizedBox(
                                            height: 460,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    CustomNavigators
                                                        .pushNavigate(
                                                            GrowingActivityScr(
                                                              title: homeModel
                                                                  .growingActivity!
                                                                  .title
                                                                  .toString(),
                                                              description: homeModel
                                                                  .growingActivity!
                                                                  .description
                                                                  .toString(),
                                                            ),
                                                            context);
                                                  },
                                                  child: Container(
                                                    height: 460,
                                                    // width: size.width * 0.45,
                                                    decoration: BoxDecoration(
                                                        color: MyColor.white,
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    39))),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                            // height: 390,
                                                            // width:
                                                            //     size.width * 0.35,
                                                            decoration:
                                                                BoxDecoration(
                                                                    // color: MyColor.colorE2EBFF,
                                                                    color: Colors
                                                                        .transparent,
                                                                    borderRadius:
                                                                        const BorderRadius
                                                                            .all(
                                                                            Radius.circular(39))),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Stack(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          top:
                                                                              5,
                                                                          left:
                                                                              5,
                                                                          right:
                                                                              5),
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),
                                                                        child: UiUtils
                                                                            .networkImages(
                                                                          size.width *
                                                                              0.451,
                                                                          330,
                                                                          isBoxFit:
                                                                              true,
                                                                          "${ApiPath.imageBaseUrl}${homeModel.growingActivity!.image.toString()}",
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      margin: EdgeInsets
                                                                          .all(
                                                                              15),
                                                                      decoration: BoxDecoration(
                                                                          color: Colors
                                                                              .white,
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(15))),
                                                                      width:
                                                                          100,
                                                                      // height: 20,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                        child: Text(
                                                                            Languages.of(context)!
                                                                                .growingActivity,
                                                                            // overflow: TextOverflow.ellipsis,
                                                                            style:
                                                                                boldTextStyle(
                                                                              fontSize: 12.0,
                                                                              color: MyColor.appTheme,
                                                                            )),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                hsized10,
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              0,
                                                                          right:
                                                                              10),
                                                                  child: Text(
                                                                      homeModel
                                                                          .growingActivity!
                                                                          .title
                                                                          .toString(),
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      style:
                                                                          semiBoldTextStyle(
                                                                        fontSize:
                                                                            20.0,
                                                                        color: MyColor
                                                                            .appTheme,
                                                                      )),
                                                                ),
                                                                hsized10,
                                                                SizedBox(
                                                                  width:
                                                                      size.width *
                                                                          0.40,
                                                                  child:
                                                                      Builder(
                                                                    builder:
                                                                        (context) {
                                                                      return Container(
                                                                        child:
                                                                            LimitedBox(
                                                                          maxHeight:
                                                                              50,
                                                                          // You can adjust this based on font size and line height
                                                                          child:
                                                                              Html(
                                                                            data:
                                                                                homeModel.growingActivity!.description.toString(),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Container()
                        : homeModel.recipeOfTheWeek != null ||
                                homeModel.growingActivity != null
                            ? Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 5, top: 10),
                                      child: Stack(
                                        children: [
                                          SizedBox(
                                            height: 300,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    CustomNavigators.pushNavigate(
                                                        RecipeDetailView(
                                                            model:
                                                                recipeOfTheWeekList[
                                                                    0],
                                                            color: recipeOfTheWeekList[
                                                                        0]
                                                                    .color ??
                                                                MyColor
                                                                    .blueLite),
                                                        context);
                                                  },
                                                  child: Container(
                                                    height: 300,
                                                    // width: size.width * 0.45,
                                                    decoration: BoxDecoration(
                                                        color: MyColor.white,
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    39))),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                            height: 300,
                                                            width: size.width *
                                                                0.45,
                                                            decoration:
                                                                BoxDecoration(
                                                                    // color: MyColor.colorE2EBFF,
                                                                    color: Colors
                                                                        .transparent,
                                                                    borderRadius:
                                                                        const BorderRadius
                                                                            .all(
                                                                            Radius.circular(39))),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Stack(
                                                                  children: [
                                                                    ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                      child: UiUtils
                                                                          .networkImages(
                                                                        size.width *
                                                                            0.451,
                                                                        210,
                                                                        "${ApiPath.imageBaseUrl}${homeModel.recipeOfTheWeek!.bannerImage.toString()}",
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      margin: EdgeInsets
                                                                          .all(
                                                                              15),
                                                                      decoration: BoxDecoration(
                                                                          color: Colors
                                                                              .white,
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(15))),
                                                                      width:
                                                                          100,
                                                                      // height: 20,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                        child: Text(
                                                                            Languages.of(context)!
                                                                                .recipeOfTheMonth,
                                                                            // overflow: TextOverflow.ellipsis,
                                                                            style:
                                                                                boldTextStyle(
                                                                              fontSize: 12.0,
                                                                              color: MyColor.appTheme,
                                                                            )),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                hsized10,
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              10,
                                                                          right:
                                                                              10),
                                                                  child: Text(
                                                                      homeModel
                                                                          .recipeOfTheWeek!
                                                                          .name
                                                                          .toString(),
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style:
                                                                          semiBoldTextStyle(
                                                                        fontSize:
                                                                            15.0,
                                                                        color: MyColor
                                                                            .appTheme,
                                                                      )),
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                      size.width *
                                                                          0.40,
                                                                  child:
                                                                      Builder(
                                                                    builder:
                                                                        (context) {
                                                                      List<String>
                                                                          ingredients =
                                                                          homeModel.recipeOfTheWeek?.recipeIngredient?.map((e) => e.name ?? "").toList() ??
                                                                              [];

                                                                      // Limit to 3 items and add "+ More" if necessary
                                                                      String displayText = ingredients.length >
                                                                              2
                                                                          ? "${ingredients.sublist(0, 3).join(', ')} \n+ More"
                                                                          : ingredients
                                                                              .join(', ');

                                                                      return Text(
                                                                        displayText,
                                                                        maxLines:
                                                                            3,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        textAlign:
                                                                            TextAlign.justify,
                                                                        style: regularNormalTextStyle(
                                                                            fontSize:
                                                                                12.0,
                                                                            color:
                                                                                MyColor.appTheme),
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 5, top: 10),
                                      child: Stack(
                                        children: [
                                          SizedBox(
                                            height: 300,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    CustomNavigators
                                                        .pushNavigate(
                                                            GrowingActivityScr(
                                                              title: homeModel
                                                                  .growingActivity!
                                                                  .title
                                                                  .toString(),
                                                              description: homeModel
                                                                  .growingActivity!
                                                                  .description
                                                                  .toString(),
                                                            ),
                                                            context);
                                                  },
                                                  child: Container(
                                                    height: 300,
                                                    // width: size.width * 0.45,
                                                    decoration: BoxDecoration(
                                                        color: MyColor.white,
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    39))),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                            height: 300,
                                                            width: size.width *
                                                                0.45,
                                                            decoration:
                                                                BoxDecoration(
                                                                    // color: MyColor.colorE2EBFF,
                                                                    color: Colors
                                                                        .transparent,
                                                                    borderRadius:
                                                                        const BorderRadius
                                                                            .all(
                                                                            Radius.circular(39))),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Stack(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          top:
                                                                              5,
                                                                          left:
                                                                              5,
                                                                          right:
                                                                              5),
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),
                                                                        child: UiUtils
                                                                            .networkImages(
                                                                          size.width *
                                                                              0.451,
                                                                          205,
                                                                          isBoxFit:
                                                                              true,
                                                                          "${ApiPath.imageBaseUrl}${homeModel.growingActivity!.image.toString()}",
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      margin: EdgeInsets
                                                                          .all(
                                                                              15),
                                                                      decoration: BoxDecoration(
                                                                          color: Colors
                                                                              .white,
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(15))),
                                                                      width:
                                                                          100,
                                                                      // height: 20,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                        child: Text(
                                                                            Languages.of(context)!
                                                                                .growingActivity,
                                                                            // overflow: TextOverflow.ellipsis,
                                                                            style:
                                                                                boldTextStyle(
                                                                              fontSize: 12.0,
                                                                              color: MyColor.appTheme,
                                                                            )),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                hsized10,
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              10,
                                                                          right:
                                                                              10),
                                                                  child: Text(
                                                                      homeModel
                                                                          .growingActivity!
                                                                          .title
                                                                          .toString(),
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      style:
                                                                          semiBoldTextStyle(
                                                                        fontSize:
                                                                            15.0,
                                                                        color: MyColor
                                                                            .appTheme,
                                                                      )),
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                      size.width *
                                                                          0.40,
                                                                  child:
                                                                      Builder(
                                                                    builder:
                                                                        (context) {
                                                                      return Container(
                                                                        child:
                                                                            LimitedBox(
                                                                          maxHeight:
                                                                              50,
                                                                          // You can adjust this based on font size and line height
                                                                          child:
                                                                              Html(
                                                                            data:
                                                                                homeModel.growingActivity!.description.toString(),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, top: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// AI Recipe
                          GestureDetector(
                              onTap: () {
                                CustomNavigators.pushNavigate(
                                    AddRecipeScreen(), context);
                              },
                              child: (AppState.devicetype == "ipad")
                                  ? Center(
                                      child: Image.asset(
                                      "assets/images/Frame 427320855.png",
                                      height: 100,
                                    ))
                                  : Image.asset(
                                      "assets/images/Frame 427320855.png")),
                          hsized15,

                          /// School Stories
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(Languages.of(context)!.schoolStories,
                                  overflow: TextOverflow.ellipsis,
                                  style: mediumTextStyle(
                                      fontSize: (AppState.devicetype == "ipad")
                                          ? 25.0
                                          : 18.0,
                                      color: MyColor.black)),
                              hsized15,

                              /// Old code
                              // SizedBox(
                              //   height: 130,
                              //   child: Row(
                              //     children: List.generate(schoolStoryList.length, (index) {
                              //       return Expanded(
                              //         child: Padding(
                              //           padding: EdgeInsets.only(
                              //             right: index == 2 ? 0 : 5,
                              //           ),
                              //           child: InkWell(
                              //             onTap: () {
                              //               CustomNavigators.pushNavigate(
                              //                 VideoScrollScreen(
                              //                   videos: demoVideoList,
                              //                   initialIndex: index,
                              //                 ),
                              //                 context,
                              //               );
                              //             },
                              //             child: ClipRRect(
                              //               borderRadius:
                              //                   BorderRadius.circular(10),
                              //               child: Stack(
                              //                 fit: StackFit.expand,
                              //                 children: [
                              //                   Image.network(
                              //                    "${ApiPath.imageBaseUrl}${schoolStoryList[index].schoolLogo}",
                              //                     fit: BoxFit.cover,
                              //                   ),
                              //                   Positioned(
                              //                     left: 5,
                              //                     bottom: 5,
                              //                     child: Container(
                              //                       padding:
                              //                           const EdgeInsets.all(8),
                              //                       decoration: BoxDecoration(
                              //                         color: MyColor.appTheme,
                              //                         shape: BoxShape.circle,
                              //                       ),
                              //                       child: Image.asset(
                              //                         "assets/images/videoPlayIcon.png",
                              //                         height: 15,
                              //                         width: 18,
                              //                       ),
                              //                     ),
                              //                   ),
                              //                 ],
                              //               ),
                              //             ),
                              //           ),
                              //         ),
                              //       );
                              //     }),
                              //   ),
                              // ),

                              SizedBox(
                                height:
                                    (AppState.devicetype == "ipad") ? 270 : 130,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: schoolStoryList.length,
                                  itemBuilder: (context, index) {
                                    final video = schoolStoryList[index];

                                    final thumbnailUrl = video.thumbnailImage !=
                                                null &&
                                            video.thumbnailImage!.isNotEmpty
                                        ? "${ApiPath.videoBaseUrl}${video.thumbnailImage}"
                                        : "${ApiPath.imageBaseUrl}/default_thumbnail.png";

                                    // Calculate width so 2 items are visible
                                    final double itemWidth =
                                        (MediaQuery.of(context).size.width -
                                                15 * 3) /
                                            3.2;

                                    return Padding(
                                      padding: EdgeInsets.only(
                                          right: index ==
                                                  schoolStoryList.length - 1
                                              ? 0
                                              : 15),
                                      child: GestureDetector(
                                        onTap: () {
                                          if (video.videoPath == null ||
                                              video.videoPath!.isEmpty) return;

                                          final List<SchoolVideo> videoList =
                                              schoolStoryList.map((v) {
                                            return SchoolVideo(
                                              url:
                                                  "${ApiPath.videoBaseUrl}${v.videoPath}",
                                              title: v.title ?? "",
                                              description: v.description ?? "",
                                            );
                                          }).toList();

                                          final int initialIndex =
                                              schoolStoryList.indexOf(video);

                                          CustomNavigators.pushNavigate(
                                            VideoScrollScreen(
                                              videos: videoList,
                                              initialIndex: initialIndex,
                                            ),
                                            context,
                                          );
                                        },
                                        child: SizedBox(
                                          width: itemWidth,
                                          // fix the width here!
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Stack(
                                              fit: StackFit.expand,
                                              children: [
                                                Image.network(
                                                  thumbnailUrl,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (_, __, ___) =>
                                                      Container(
                                                          color:
                                                              Colors.grey[300]),
                                                ),
                                                Positioned(
                                                  left: 5,
                                                  bottom: 5,
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      color: MyColor.appTheme,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Image.asset(
                                                      "assets/images/videoPlayIcon.png",
                                                      height: (AppState
                                                                  .devicetype ==
                                                              "ipad")
                                                          ? 50
                                                          : 15,
                                                      width: (AppState
                                                                  .devicetype ==
                                                              "ipad")
                                                          ? 50
                                                          : 18,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),

                          hsized15,

                          /// Popular Recipe
                          popularRecipeList.isNotEmpty
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            Languages.of(context)!
                                                .popularRecipe,
                                            overflow: TextOverflow.ellipsis,
                                            style: mediumTextStyle(
                                                fontSize:
                                                    (AppState.devicetype ==
                                                            "ipad")
                                                        ? 25.0
                                                        : 18.0,
                                                color: MyColor.black)),
                                        InkWell(
                                          // radius: 80,
                                          onTap: () {
                                            CustomNavigators.pushNavigate(
                                                SeeAllRecipeView(
                                                  pageType: "Popular Recipe",
                                                ),
                                                context);
                                            setState(() {});
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5.0, vertical: 5),
                                            child: Container(
                                              padding: (AppState.devicetype ==
                                                      "ipad")
                                                  ? EdgeInsets.only(
                                                      left: 30,
                                                      right: 30,
                                                      top: 15,
                                                      bottom: 15)
                                                  : EdgeInsets.only(
                                                      left: 10,
                                                      right: 10,
                                                      top: 5,
                                                      bottom: 5),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 2.0,
                                                    color: MyColor.appTheme),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        50.0) //                 <--- border radius here
                                                    ),
                                              ),
                                              child: Text(
                                                  Languages.of(context)!.seeall,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: mediumTextStyle(
                                                      fontSize: (AppState
                                                                  .devicetype ==
                                                              "ipad")
                                                          ? 20.0
                                                          : 15.0,
                                                      color: MyColor.appTheme)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    popularRecipeList.isEmpty
                                        ? Container()
                                        : SizedBox(
                                            height:
                                                (AppState.devicetype == "ipad")
                                                    ? 250
                                                    : 180,
                                            child: ListView.builder(
                                                itemCount:
                                                    popularRecipeList.length,
                                                physics: ScrollPhysics(),
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder:
                                                    (context, int index) {
                                                  var model =
                                                      popularRecipeList[index];
                                                  return gridItem(
                                                      size, index, model);
                                                }),
                                          )
                                  ],
                                )
                              : SizedBox.shrink(),

                          hsized15,

                          /// Featured Story
                          featuredStoryList.isNotEmpty
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 5,
                                        right: 5,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              Languages.of(context)!
                                                  .featuredStory,
                                              overflow: TextOverflow.ellipsis,
                                              style: mediumTextStyle(
                                                  fontSize:
                                                      (AppState.devicetype ==
                                                              "ipad")
                                                          ? 25.0
                                                          : 18.0,
                                                  color: MyColor.black)),
                                          InkWell(
                                            onTap: () {
                                              CustomNavigators.pushNavigate(
                                                  AllStoryView(), context);
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5.0,
                                                      vertical: 5),
                                              child: Container(
                                                padding: (AppState.devicetype ==
                                                        "ipad")
                                                    ? EdgeInsets.only(
                                                        left: 30,
                                                        right: 30,
                                                        top: 15,
                                                        bottom: 15)
                                                    : EdgeInsets.only(
                                                        left: 10,
                                                        right: 10,
                                                        top: 5,
                                                        bottom: 5),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 2.0,
                                                      color: MyColor.appTheme),
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(
                                                          50.0) //                 <--- border radius here
                                                      ),
                                                ),
                                                child: Text(
                                                    Languages.of(context)!
                                                        .seeall,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: mediumTextStyle(
                                                        fontSize: (AppState
                                                                    .devicetype ==
                                                                "ipad")
                                                            ? 20.0
                                                            : 15.0,
                                                        color:
                                                            MyColor.appTheme)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(

                                        // height: 280,

                                        // alignment: Alignment.centerLeft,
                                        child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: List.generate(
                                            featuredStoryList.length,
                                            (int index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5,
                                                right: 5,
                                                bottom: 5,
                                                top: 10),
                                            child: TouchRippleEffect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              rippleColor: Colors.white,
                                              awaitAnimation: false,
                                              onTap: () {
                                                CustomNavigators.pushNavigate(
                                                    StoriesDetailsView(
                                                      model: featuredStoryList[
                                                          index],
                                                      type: '',
                                                    ),
                                                    context);
                                              },
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(bottom: 15),
                                                padding:
                                                    EdgeInsets.only(bottom: 15),
                                                decoration: const BoxDecoration(
                                                    color: MyColor.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                width: (AppState.devicetype ==
                                                        "ipad")
                                                    ? size.width * 0.46
                                                    : size.width * 0.46,
                                                // height: (AppState.devicetype == "ipad") ? size.height * 0.50 : size.height * 0.29,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    UiUtils.networkImages(
                                                      size.width * 0.52,
                                                      (AppState.devicetype ==
                                                              "ipad")
                                                          ? size.height * 0.20
                                                          : size.height * 0.14,
                                                      "${ApiPath.imageBaseUrl}${featuredStoryList[index].image.toString()}",
                                                    ),
                                                    hsized10,
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              featuredStoryList[
                                                                          index]
                                                                      .title ??
                                                                  "",
                                                              maxLines: 1,
                                                              style: mediumTextStyle(
                                                                  fontSize: (AppState
                                                                              .devicetype ==
                                                                          "ipad")
                                                                      ? 22.0
                                                                      : 15.0,
                                                                  color: MyColor
                                                                      .black,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis)),
                                                          hsized5,
                                                          Text(
                                                              featuredStoryList[
                                                                          index]
                                                                      .description ??
                                                                  "",
                                                              maxLines: 2,
                                                              style: regularTextStyle(
                                                                  fontSize: (AppState
                                                                              .devicetype ==
                                                                          "ipad")
                                                                      ? 19.0
                                                                      : 11.0,
                                                                  color: MyColor
                                                                      .black,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis))
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                      ),
                                    )),
                                  ],
                                )
                              : SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                // height: 200,
                width: double.infinity,
                color: Colors.red,
              )
            ],
          ),
        ),
      ),
    );
  }

  gridItem(var size, int index, RecipeModel model) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5, top: 8, right: 10, left: 0),
      child: InkWell(
        onTap: () {
          CustomNavigators.pushNavigate(
              RecipeDetailView(
                  model: model, color: model.color ?? MyColor.blueLite),
              context);
        },
        child: Container(
          // height: Platform.isAndroid ? size.height * 0.39:size.height * 0.32,
          // width: size.width * 0.80,
          width: (AppState.devicetype == "ipad") ? 400 : size.width * 0.80,
          height: 80,
          padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 5),
          margin: (AppState.devicetype == "ipad")
              ? EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 5)
              : EdgeInsets.zero,
          decoration: BoxDecoration(
              color: model.color,
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        hsized15,
                        Expanded(
                          child: Text(
                            model.name ?? "",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            style: semiBoldTextStyle(
                                fontSize: (AppState.devicetype == "ipad")
                                    ? 23.0
                                    : 16.0,
                                color: MyColor.black),
                          ),
                        ),
                        hsized15,
                        model.recipeIngredient != null
                            ? SizedBox(
                                width: size.width * 0.40,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: model.recipeIngredient!.length > 1
                                      ? 1
                                      : model.recipeIngredient!.length,
                                  itemBuilder: (context, int index) {
                                    return Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            model.recipeIngredient![index]
                                                    .name ??
                                                "",
                                            maxLines: 2,
                                            // overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                            style: regularNormalTextStyle(
                                              fontSize: (AppState.devicetype ==
                                                      "ipad")
                                                  ? 20.0
                                                  : 13.0,
                                              color: MyColor.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              )
                            : SizedBox.shrink(),
                      ],
                    ),
                  ),
                  Container(
                    width: (AppState.devicetype == "ipad") ? 120 : 100,
                    height: (AppState.devicetype == "ipad") ? 120 : 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white, // Border color
                        width: 5, // Border width
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: UiUtils.networkImages(
                        (AppState.devicetype == "ipad") ? 100 : 60,
                        (AppState.devicetype == "ipad") ? 100 : 60,
                        model.bannerImage != null
                            ? ApiPath.imageBaseUrl +
                                model.bannerImage.toString()
                            : "",
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  exploreUi(int index) {
    return Expanded(
      flex: 2,
      child: InkWell(
        onTap: () {
          setState(() {
            tabCheck = index == 0
                ? "kids"
                : index == 1
                    ? "OurStories"
                    : index == 2
                        ? "Aboutus"
                        : "";
            pageIndex = 0;
          });
          //   CustomNavigators.pushReplacementNavigate(DashBoardView(pageIndex:0, tabCheck: index == 0 ? "kids" : index == 1 ? "OurStories" : index == 2 ? "Aboutus" : "",), context);
          setState(() {
            isTabExplore = true;
          });
        },
        child: Container(
          margin: EdgeInsets.only(right: index == 2 ? 5 : 10, left: 5),
          padding: EdgeInsets.only(right: 10, left: 10, top: 5, bottom: 10),
          decoration: BoxDecoration(
              color: index == 0
                  ? MyColor.colorFFF0FF8
                  : index == 1
                      ? MyColor.colorEDEFFF
                      : MyColor.colorF3E6FF,
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              hsized10,
              Image.asset(
                index == 0
                    ? AssetsPath.kitslearningorange
                    : index == 1
                        ? AssetsPath.ourStories
                        : AssetsPath.aboutsBlue,
                width: 36,
                height: 36,
              ),
              hsized10,
              Text(exploreList[index],
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: semiBoldTextStyle(
                      fontSize: 14.0,
                      color: index == 0
                          ? MyColor.orange
                          : index == 1
                              ? MyColor.blue1
                              : MyColor.appTheme)),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildThumbnail(SchoolStoryData school, int index) {
    final videos = school.videos ?? [];

    String imageUrl;

    if (videos.isEmpty || index >= videos.length) {
      // fallback to school logo
      imageUrl = "${ApiPath.imageBaseUrl}${school.schoolLogo}";
    } else {
      imageUrl = videos[index].thumbnailImage != null
          ? "${ApiPath.imageBaseUrl}${videos[index].thumbnailImage}"
          : "${ApiPath.imageBaseUrl}${school.schoolLogo}";
    }

    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => Container(color: Colors.grey[300]),
    );
  }

  Widget bannerUi(var size, RecipeModel model) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 11.0, bottom: 0.0, left: 15.0, right: 15.0),
      child: TouchRippleEffect(
        borderRadius: BorderRadius.circular(27),
        rippleColor: Colors.white,
        onTap: () {},
        child: Container(
          decoration: const BoxDecoration(
              color: MyColor.colorE0FFC6,
              borderRadius: BorderRadius.all(Radius.circular(24))),
          // height: 165,
          width: size.width * 0.94,
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(24))),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 21, right: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              hsized45,
                              SizedBox(
                                width: size.width * 0.50,
                                child: Text(model.name ?? "",
                                    overflow: TextOverflow.ellipsis,
                                    style: semiBoldTextStyle(
                                        fontSize: 17.0, color: MyColor.black)),
                              ),
                              hsized2,
                              model.recipeIngredient != null
                                  ? SizedBox(
                                      width: size.width * 0.35,
                                      child: Wrap(
                                        children: List.generate(
                                            model.recipeIngredient!.length > 1
                                                ? 1
                                                : model.recipeIngredient!
                                                    .length, (int index) {
                                          return Text(
                                              model.recipeIngredient![index]
                                                      .name ??
                                                  "",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.start,
                                              style: regularNormalTextStyle(
                                                  fontSize: 12.0,
                                                  color: MyColor.black));
                                        }),
                                      ))
                                  : SizedBox.shrink(),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 28.0, top: 15, bottom: 20),
                        child: GlobalButton(
                            Languages.of(context)!.viewDetailsarrow.toString(),
                            MyColor.appTheme,
                            MyColor.appTheme,
                            30.0,
                            size.width * 0.27, () {
                          CustomNavigators.pushNavigate(
                              RecipeDetailView(
                                  model: model,
                                  color: model.color ?? MyColor.colorE0FFC6),
                              context);
                        },
                            10,
                            5,
                            0,
                            regularTextStyle(
                                fontSize: 13.0, color: MyColor.white)),
                      ),
                    ],
                  ),
                  ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomRight: Radius.circular(27)),
                      child: UiUtils.networkImages(size.width * 0.30, 100,
                          "${ApiPath.imageBaseUrl}${model.bannerImage}")),
                ],
              ),
              Container(
                decoration: const BoxDecoration(
                    color: MyColor.yellow,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(27),
                        bottomRight: Radius.circular(27))),
                height: 41,
                width: size.width * 0.50,
                child: Padding(
                  padding: EdgeInsets.only(left: 21, top: 10),
                  child: Text("Recipe of the Week",
                      style: regularTextStyle(
                          fontSize: 16.0, color: MyColor.black)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
