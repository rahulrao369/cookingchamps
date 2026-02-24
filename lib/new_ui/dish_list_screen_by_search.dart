// import 'package:cooking_champs/utils/common_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:responsive_grid/responsive_grid.dart';
// import '../constant/assets_path.dart';
// import '../constant/my_color.dart';
// import '../constant/my_fonts_style.dart';
// import '../constant/sized_box.dart';
// import '../constant/stringfile.dart/language.dart';
// import '../model/dynamic_models/home_model.dart';
// import '../model/dynamic_models/recipe_model.dart';
// import '../model/post_model/add_favorite_request.dart';
// import '../services/api_path.dart';
// import '../services/api_services.dart';
// import '../utils/navigators.dart';
// import '../utils/ui_utils.dart';
// import '../utils/utility.dart';
// import '../views/recipe/recipe_detail_view.dart';
//
// class DishListScreenBySearch extends StatefulWidget {
//   final String pageType;
//   const DishListScreenBySearch({super.key, required this.pageType});
//
//   @override
//   State<DishListScreenBySearch> createState() => _DishListScreenBySearchState();
// }
//
// class _DishListScreenBySearchState extends State<DishListScreenBySearch> {
//
//   List<RecipeModel> recipeList = [];
//   RecipeModel recipeModel = RecipeModel();
//   HomeModel homeModel = HomeModel();
//   List<RecipeModel> popularRecipeList = [];
//   bool isLoading = false; // To prevent multiple calls
//   bool hasMoreData = true; // To track if there is more data to load
//   int totalPage = 1;
//   int page = 1;
//   String recipeId = "";
//
//   bool isBusy = false;
//
//   @override
//   Widget build(BuildContext context) {
//     final data = MediaQuery.of(context);
//     var size = data.size;
//     return MediaQuery(
//         data: data.copyWith(textScaleFactor: 1.0),
//         child: CommonScaffold(
//           appBar: commonAppBar(
//               context: context,
//               title: "Generated Recipe",
//               centerTitle: false),
//           body: RefreshIndicator(
//             onRefresh: () async {
//               page = 1;
//               await Future.delayed(Duration(seconds: 2), getRecipe);
//               return;
//             },
//             child: NotificationListener<ScrollNotification>(
//               onNotification: (ScrollNotification scrollInfo) {
//                 if (scrollInfo.metrics.pixels ==
//                     scrollInfo.metrics.maxScrollExtent &&
//                     !isLoading &&
//                     totalPage >= page) {
//                   Future.delayed(Duration.zero, getRecipe);
//                 }
//                 return false;
//               },
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Padding(
//                         padding: const EdgeInsets.only(
//                             top: 10.0, right: 10, left: 10),
//                         child:
//                         // isBusy
//                         //     ? SizedBox.shrink()
//                         //     : recipeList.isNotEmpty
//                         //     ?
//                   ResponsiveGridRow(
//                             children: List.generate(recipeList.length,
//                                     (index) {
//                                   return ResponsiveGridCol(
//                                       xs: 6,
//                                       child: gridItem(
//                                           size, index, recipeList[index]));
//                                 }))
//
//                         //     : widget.pageType == "Favorite"
//                         //     ? Container(
//                         //   padding: EdgeInsets.only(
//                         //       top: size.height * 0.2),
//                         //   alignment: Alignment.center,
//                         //   child: noStory(
//                         //       size,
//                         //       Languages.of(context)!
//                         //           .noSaveRecipeyet,
//                         //       AssetsPath.savetagscr,
//                         //       Languages.of(context)!
//                         //           .youdonthaveanysaved),
//                         // )
//                         //     : Container(
//                         //   padding: EdgeInsets.only(
//                         //       top: size.height * 0.2),
//                         //   alignment: Alignment.center,
//                         //   child: noStory(
//                         //       size,
//                         //       Languages.of(context)!.noRecipesYet,
//                         //       AssetsPath.noRecipe,
//                         //       Languages.of(context)!
//                         //           .youHavenAddedAnyRecipesYet),
//                         // )
//             ),
//                     page != 1 && isLoading
//                         ? Container(
//                         margin: EdgeInsets.only(top: 20, bottom: 80),
//                         height: 50,
//                         alignment: Alignment.center,
//                         child: CircularProgressIndicator(
//                           color: MyColor.appTheme,
//                         ))
//                         : SizedBox.shrink(),
//                     hsized30,
//                   ],
//                 ),
//               ),
//
// // Function to handle empty states
//             ),
//           ),
//           /// Floating button
//           // floatingActionButton: widget.pageType == "dash" ||
//           //     widget.pageType == "Favorite" ||
//           //     widget.pageType == "Popular Recipe"
//           //     ? null
//           //     : TouchRippleEffect(
//           //   borderRadius: BorderRadius.circular(27),
//           //   rippleColor: Colors.white,
//           //   onTap: () {
//           //     CustomNavigators.pushNavigate(
//           //         AddYourRecipeView(onCallBack: onCallBackRecipe),
//           //         context);
//           //   },
//           //   child: const CircleAvatar(
//           //     radius: 35,
//           //     backgroundColor: MyColor.appTheme,
//           //     child: Icon(
//           //       Icons.add,
//           //       size: 40,
//           //       color: MyColor.white,
//           //     ),
//           //   ),
//           // ),
//         ));
//   }
//
//   void onCallBackRecipe(RecipeModel model) {
//     if (mounted) {
//       setState(() {
//         model.isFavourite = "No";
//         model.status = "0";
//         recipeList.insert(0, model); // Add `model` at the first index
//         for (int i = 0; i < recipeList.length; i++) {
//           recipeList[i].color = Utility().getColorForIndex(i);
//         }
//       });
//     }
//   }
//
//   Future<void> getRecipe() async {
//     if (isLoading || !hasMoreData) return;
//
//     if (!isBusy) {
//       setState(() {
//         isBusy = (page == 1);
//         isLoading = true; // Start loading
//       });
//
//       bool load =
//       (page == 1); // Set `load` to true for the first page, false otherwise
//
//       try {
//         var onValue;
//         if (widget.pageType == "Favorite") {
//           onValue = await ApiServices.getFavoriteList(context, load);
//         } else {
//           onValue = await ApiServices.getRecipeList(context, page.toString(),
//               load, widget.pageType == "dash" ? "all" : "");
//         }
//
//         if (mounted && onValue.status == true) {
//           setState(() {
//             if (onValue.data['total_page'] != null) {
//               totalPage = onValue.data['total_page'];
//             }
//
//             var items = onValue.data['items'] as List<dynamic>? ??
//                 []; // Safely cast items to List<dynamic>
//
//             if (page == 1) {
//               recipeList.clear(); // Clear the list only on the first page
//             }
//
//             if (items.isNotEmpty) {
//               // Convert items to StoryModel and add to the list
//               var storyModels =
//               items.map((item) => RecipeModel.fromJson(item)).toList();
//
//               // Sort by `id` in descending order (replace with `a.id.compareTo(b.id)` for ascending order)
//               storyModels.sort((a, b) => b.id!.compareTo(a.id!));
//
//               recipeList.addAll(storyModels);
//               page++; // Increment the page number for the next call
//
//               for (int i = 0; i < recipeList.length; i++) {
//                 recipeList[i].color = Utility().getColorForIndex(i);
//               }
//             } else {
//               hasMoreData = false; // No more data to load
//             }
//           });
//         }
//       } catch (e) {
//         debugPrint('Error fetching stories: $e');
//       } finally {
//         if (mounted) {
//           setState(() {
//             isBusy = false;
//             isLoading = false; // End loading
//           });
//         }
//       }
//     }
//   }
//
//   noStory(var size, String title, String img, String des) {
//     return Container(
//       padding: EdgeInsets.only(top: 5),
//       height: 220,
//       child: Center(
//         child: Container(
//             width: size.width * 0.90,
//             height: 180,
//             decoration: const BoxDecoration(
//                 color: MyColor.yellowF6F1E1,
//                 borderRadius: BorderRadius.all(Radius.circular(20))),
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 children: [
//                   Image.asset(
//                     img,
//                     height: 45,
//                   ),
//                   hsized10,
//                   Text(title,
//                       style: mediumTextStyle(
//                           fontSize: 14.0, color: MyColor.black)),
//                   hsized5,
//                   Text(des,
//                       textAlign: TextAlign.center,
//                       style: regularTextStyle(
//                           fontSize: 12.0, color: MyColor.black)),
//                 ],
//               ),
//             )),
//       ),
//     );
//   }
//
//   gridItem(var size, int index, RecipeModel model) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 5, top: 10, right: 8, left: 8),
//       child: Container(
//         //height:  widget.pageType == "dash" || widget.pageType == "Favorite"?size.height * 0.32:size.height * 0.32,
//         width: 320,
//         padding: const EdgeInsets.only(left: 5, right: 5, bottom: 12, top: 5),
//         decoration: BoxDecoration(
//             color: model.color,
//             borderRadius: const BorderRadius.all(Radius.circular(20))),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Stack(
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(15),
//                       child: UiUtils.networkImages(
//                           size.width,
//                           150,
//                           model.bannerImage != null
//                               ? ApiPath.imageBaseUrl +
//                               model.bannerImage.toString()
//                               : ""),
//                       // UiUtils.networkImages(size.width * 0.30,80,model.bannerImage != null? ApiPath.imageBaseUrl+model.bannerImage.toString():""),
//                     ),
//                     widget.pageType == "dash" || widget.pageType == "Favorite"
//                         ? InkWell(
//                       onTap: () {
//                         debugPrint("test..");
//                         setState(() {
//                           recipeModel = model;
//                           recipeId = model.id ?? "";
//                           if (model.isFavourite == "No") {
//                             model.isFavourite = "Yes";
//                           } else {
//                             model.isFavourite = "No";
//                           }
//                         });
//                         Future.delayed(Duration.zero, addFavorite);
//                       },
//                       child: Container(
//                           alignment: Alignment.topRight,
//                           padding: const EdgeInsets.only(
//                               bottom: 0, right: 5, top: 5),
//                           child: CircleAvatar(
//                             backgroundColor: MyColor.white,
//                             child: Image.asset(
//                               height: 15,
//                               width: size.width * 0.15,
//                               AssetsPath.savetag,
//                               color: model.isFavourite != "No"
//                                   ? MyColor.red
//                                   : null,
//                             ),
//                           )),
//                     )
//                         : SizedBox.shrink(),
//                   ],
//                 ),
//                 hsized15,
//                 Text(model.name ?? "",
//                     maxLines: 1,
//                     textAlign: TextAlign.center,
//                     style: semiBoldTextStyle(
//                         fontSize: 15.0, color: MyColor.black)),
//                 hsized3,
//                 model.recipeIngredient != null
//                     ? SizedBox(
//                     width: size.width * 0.35,
//                     child: ListView.builder(
//                       shrinkWrap: true,
//                       padding: EdgeInsets.zero,
//                       physics: NeverScrollableScrollPhysics(),
//                       itemCount: model.recipeIngredient!.length > 1
//                           ? 1
//                           : model.recipeIngredient!.length,
//                       itemBuilder: (context, int index) {
//                         return Text(
//                             model.recipeIngredient![index].name ?? "",
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                             textAlign: TextAlign.center,
//                             style: regularNormalTextStyle(
//                                 fontSize: 12.0, color: MyColor.black));
//                       },
//                     ))
//                     : SizedBox.shrink(),
//                 Text("More+",
//                     style: regularNormalTextStyle(
//                         fontSize: 12.0, color: MyColor.black)),
//                 hsized10,
//               ],
//             ),
//             InkWell(
//               radius: 60,
//               borderRadius: BorderRadius.circular(27),
//               // rippleColor: MyColor.liteGray,
//
//               onTap: () {
//                 CustomNavigators.pushNavigate(
//                     RecipeDetailView(
//                         model: model, color: model.color ?? MyColor.blueLite),
//                     context);
//               },
//               child: Align(
//                 alignment: Alignment.bottomCenter,
//                 child: const CircleAvatar(
//                   radius: 20,
//                   backgroundColor: MyColor.appTheme,
//                   child: Icon(
//                     Icons.arrow_forward_ios,
//                     color: MyColor.white,
//                     size: 15,
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> addFavorite() async {
//     AddFavoriteRequest favoriteRequest =
//     AddFavoriteRequest(recipeId: int.parse(recipeId));
//
//     await ApiServices.addToFavorite(context, favoriteRequest, true)
//         .then((onValue) {
//       if (mounted) {
//         setState(() {
//           if (onValue.status == true) {
//             if (onValue.message.toString() ==
//                 "Recipe removed from favorites successfully!") {
//               if (widget.pageType == "Favorite") {
//                 recipeList.remove(recipeModel);
//               }
//               recipeModel.isFavourite = "No";
//             } else {
//               recipeModel.isFavourite = "Yes";
//             }
//           } else {
//             recipeModel.isFavourite = "No";
//           }
//         });
//       }
//     });
//   }
//
// }

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../ai_recipe_service/recipe_model.dart';
import 'ai_generate_recipe_detail.dart';

class DishListScreenBySearch extends StatelessWidget {
  final ValueNotifier<List<RecipeModel>> recipeNotifier;
  final int totalExpectedRecipes; // total recipes we expect from AI (default 5)

  const DishListScreenBySearch({
    super.key,
    required this.recipeNotifier,
    this.totalExpectedRecipes = 5,
  });

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.shortestSide > 600;

    // 🔹 DEBUG: Print the AI recipe map to console when the list updates
    recipeNotifier.addListener(() {
      final recipes = recipeNotifier.value;
      if (recipes.isNotEmpty) {
        print(">>>> AI Recipe List (${recipes.length} recipes):\n" +
            recipes.map((r) => r.toJson().toString()).join("\n") +
            " <<<<<");
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Generated Recipes",
          style: TextStyle(
            fontSize: isTablet ? 25.0 : 18.0,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(isTablet ? 20.0 : 12.0),
        child: ValueListenableBuilder<List<RecipeModel>>(
          valueListenable: recipeNotifier,
          builder: (context, recipes, _) {
            final isLoading = recipes.length < totalExpectedRecipes;

            return GridView.builder(
              itemCount: isLoading
                  ? totalExpectedRecipes
                  : recipes.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isTablet ? 3 : 2,
                mainAxisSpacing: isTablet ? 18.0 : 12.0,
                crossAxisSpacing: isTablet ? 18.0 : 12.0,
                childAspectRatio: isTablet ? 0.72 : 0.67,
              ),
              itemBuilder: (context, index) {
                // 🔹 Show shimmer until recipe arrives
                if (index >= recipes.length) {
                  return _recipeGridShimmer(isTablet: isTablet);
                }

                final recipe = recipes[index];
                return _recipeCard(context, recipe, index, isTablet: isTablet);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _recipeGridShimmer({bool isTablet = false}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(isTablet ? 22.0 : 18.0),
        ),
        padding: EdgeInsets.all(isTablet ? 16.0 : 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image placeholder
            Container(
              height: isTablet ? 150.0 : 120.0,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(isTablet ? 16.0 : 14.0),
              ),
            ),
            SizedBox(height: isTablet ? 16.0 : 12.0),

            Container(
              height: isTablet ? 20.0 : 16.0,
              width: isTablet ? 140.0 : 120.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(isTablet ? 10.0 : 8.0),
              ),
            ),
            SizedBox(height: isTablet ? 10.0 : 8.0),

            Container(
              height: isTablet ? 18.0 : 14.0,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(isTablet ? 10.0 : 8.0),
              ),
            ),
            SizedBox(height: isTablet ? 8.0 : 6.0),

            Container(
              height: isTablet ? 18.0 : 14.0,
              width: isTablet ? 100.0 : 80.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(isTablet ? 10.0 : 8.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _recipeCard(BuildContext context, RecipeModel recipe, int index, {bool isTablet = false}) {
    final List<Color> bgColors = [
      const Color(0xFFEFE7FF), // light purple
      const Color(0xFFFFFBD6), // light yellow
    ];

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => RecipeDetailScreen(recipe: recipe),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(isTablet ? 12.0 : 7.0),
        decoration: BoxDecoration(
          color: bgColors[index % bgColors.length],
          borderRadius: BorderRadius.circular(isTablet ? 30.0 : 26.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// 🔖 Bookmark icon
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: EdgeInsets.all(isTablet ? 8.0 : 6.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.bookmark_border,
                  size: isTablet ? 22.0 : 18.0,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: isTablet ? 8.0 : 6.0),

            /// 🍲 Image
            ClipRRect(
              borderRadius: BorderRadius.circular(isTablet ? 70.0 : 60.0),
              child: Image.network(
                recipe.imageUrl ??
                    "assets/images/placeholder_recipe_default_02.png",
                height: isTablet ? 130.0 : 100.0,
                width: isTablet ? 130.0 : 100.0,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: isTablet ? 130.0 : 100.0,
                    width: isTablet ? 130.0 : 100.0,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(isTablet ? 70.0 : 60.0),
                    ),
                    child: Icon(
                      Icons.fastfood,
                      size: isTablet ? 40.0 : 30.0,
                      color: Colors.grey.shade400,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: isTablet ? 12.0 : 8.0),

            /// 📝 Text section
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    recipe.name,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: isTablet ? 20.0 : 15.0,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: isTablet ? 10.0 : 5.0),
                  Expanded(
                    child: Text(
                      recipe.description ?? "",
                      textAlign: TextAlign.center,
                      maxLines: isTablet ? 5 : 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: isTablet ? 15.0 : 10.0,
                        color: Colors.black87,
                        height: 1.3,
                      ),
                    ),
                  ),
                  SizedBox(height: isTablet ? 8.0 : 5.0),
                ],
              ),
            ),

            /// ➡ Arrow button
            Container(
              height: isTablet ? 32.0 : 25.0,
              width: isTablet ? 32.0 : 25.0,
              decoration: const BoxDecoration(
                color: Color(0xFF3B2E5A),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_forward_ios,
                size: isTablet ? 18.0 : 14.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}





