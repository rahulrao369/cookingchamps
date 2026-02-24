// import 'package:cooking_champs/constant/my_color.dart';
// import 'package:cooking_champs/new_ui/recipe_step_widget.dart';
// import 'package:flutter/material.dart';
// import '../ai_recipe_service/recipe_model.dart';
// import 'full_screen_image.dart';
//
// class RecipeDetailScreen extends StatelessWidget {
//   final RecipeModel recipe;
//
//   const RecipeDetailScreen({
//     super.key,
//     required this.recipe,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFEFE7FF),
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Colors.black),
//         title: const Text(
//           "Generate Dish Detail",
//           style: TextStyle(color: Colors.black),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             /// 🔥 IMAGE HEADER
//             // Stack(
//             //   children: [
//             //     /// 🔹 Recipe Image with Full-Screen tap
//             //     GestureDetector(
//             //       onTap: () {
//             //         Navigator.push(
//             //           context,
//             //           PageRouteBuilder(
//             //             opaque: false,
//             //             pageBuilder: (_, __, ___) => FullScreenImageView(
//             //               imageUrl: recipe.imageUrl ??
//             //                   "assets/images/placeholder_recipe_default_02.png",
//             //               heroTag: "recipe_image",
//             //             ),
//             //           ),
//             //         );
//             //       },
//             //       child: Hero(
//             //         tag: "recipe_image",
//             //         child: AspectRatio(
//             //           aspectRatio: 16 / 9,
//             //           child: recipe.imageUrl != null
//             //               ? Image.network(
//             //             recipe.imageUrl!,
//             //             fit: BoxFit.cover,
//             //             errorBuilder: (_, __, ___) => _placeholderImage(),
//             //           )
//             //               : _placeholderImage(),
//             //         ),
//             //       ),
//             //     ),
//             //
//             //     /// ⏱ TIME BADGE (STATIC FOR NOW)
//             //     Positioned(
//             //       right: 12,
//             //       bottom: 12,
//             //       child: Container(
//             //         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//             //         decoration: BoxDecoration(
//             //           color: Colors.white,
//             //           borderRadius: BorderRadius.circular(20),
//             //           boxShadow: [
//             //             BoxShadow(
//             //               color: Colors.black.withOpacity(0.1),
//             //               blurRadius: 6,
//             //             )
//             //           ],
//             //         ),
//             //         child: const Row(
//             //           children: [
//             //             Icon(Icons.access_time, size: 14),
//             //             SizedBox(width: 4),
//             //             Text(
//             //               "15 mins",
//             //               style: TextStyle(fontSize: 12),
//             //             ),
//             //           ],
//             //         ),
//             //       ),
//             //     ),
//             //   ],
//             // ),
//
//             /// New Design
//             Container(
//               color: Color(0xFFEFE7FF),
//               child: Stack(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(
//                       right: 60,
//                       top: 70,
//                     ),
//                     child: Align(
//                       alignment: Alignment.bottomLeft,
//                       child: FractionallySizedBox(
//                         child: Image.asset(
//                           "assets/images/lines_image_02.webp",
//                           fit: BoxFit.contain,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(left: 10, top: 20, bottom: 20),
//                     child: Container(
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           /// Left side text content
//                           Expanded(
//                             flex: 5,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 /// Title
//                                 Text(
//                                   recipe.name ?? "No title",
//                                   style: const TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 22,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                   maxLines: 4,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//
//                                 const SizedBox(height: 12),
//
//                                 /// Time
//                                 Row(
//                                   children: [
//                                     const Icon(Icons.timer, size: 18),
//                                     const SizedBox(width: 6),
//                                     Expanded(
//                                       child: Text(
//                                         recipe.cookingTime,
//                                         style: const TextStyle(fontSize: 14),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//
//
//                                 const SizedBox(height: 8),
//
//                                 /// Calories
//                                 // Row(
//                                 //   children: [
//                                 //     Container(
//                                 //       padding: const EdgeInsets.all(
//                                 //         6,
//                                 //       ),
//                                 //       decoration: BoxDecoration(
//                                 //         borderRadius:
//                                 //         BorderRadius.circular(10),
//                                 //       ),
//                                 //       child: Image.asset(
//                                 //         "assets/images/cal_image.webp",
//                                 //         height: 33,
//                                 //         width: 33,
//                                 //       ),
//                                 //     ),
//                                 //     const SizedBox(width: 8),
//                                 //     Expanded(
//                                 //       child: Text(
//                                 //         // widget.recipe.kcal ?? "N/A",
//                                 //         "asdasd",
//                                 //         style: const TextStyle(
//                                 //           fontSize: 16,
//                                 //           color: Colors.black87,
//                                 //         ),
//                                 //       ),
//                                 //     ),
//                                 //   ],
//                                 // ),
//                               ],
//                             ),
//                           ),
//
//                           const SizedBox(width: 16),
//
//                           /// Right side big image
//                           Expanded(
//                             flex: 9,
//                             child: Hero(
//                               tag: "recipe_2_list1",
//                               child: GestureDetector(
//                                 onTap: () {
//                                   Navigator.push(
//                                     context,
//                                     PageRouteBuilder(
//                                       opaque: false,
//                                       pageBuilder: (_, __, ___) =>
//                                           FullScreenImageView(
//                                         imageUrl: recipe.imageUrl ??
//                                             "assets/images/placeholder_recipe_default_02.png",
//                                         heroTag: "recipe_image",
//                                       ),
//                                     ),
//                                   );
//                                 },
//                                 child: Container(
//                                     padding: EdgeInsets.all(6),
//                                     decoration: BoxDecoration(
//                                       color: MyColor.appTheme,
//                                       shape: BoxShape.circle,
//                                     ),
//                                     child:
//                                         // recipe.id == null ?
//                                         ClipOval(
//                                       child: (recipe.imageUrl != null &&
//                                               recipe.imageUrl!.isNotEmpty)
//                                           ? Image.network(
//                                               recipe.imageUrl!,
//                                               fit: BoxFit.cover,
//                                             )
//                                           : Image.asset(
//                                               "assets/images/placeholder_recipe_default_02.png",
//                                               fit: BoxFit.cover,
//                                             ),
//                                     )
//                                     //     : ClipOval(
//                                     //     child:
//                                     //     Image.network(
//                                     //       widget.imageUrl!,
//                                     //       fit: BoxFit.cover,
//                                     //     )
//                                     // ),
//                                     ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             /// 📦 CONTENT CARD
//             // Container(
//             //   width: double.infinity,
//             //   padding: const EdgeInsets.all(16),
//             //   decoration: const BoxDecoration(
//             //     color: Colors.white,
//             //     borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//             //   ),
//             //   child: Column(
//             //     crossAxisAlignment: CrossAxisAlignment.start,
//             //     children: [
//             //
//             //       /// 🧾 TITLE
//             //       Text(
//             //         recipe.name,
//             //         style: const TextStyle(
//             //           fontSize: 22,
//             //           fontWeight: FontWeight.bold,
//             //         ),
//             //       ),
//             //
//             //       const SizedBox(height: 12),
//             //
//             //       /// 📖 DESCRIPTION
//             //       if (recipe.description.isNotEmpty) ...[
//             //         const Text(
//             //           "Description",
//             //           style: _sectionTitleStyle,
//             //         ),
//             //         const SizedBox(height: 6),
//             //         Text(
//             //           recipe.description,
//             //           style: _bodyTextStyle,
//             //         ),
//             //         const SizedBox(height: 16),
//             //       ],
//             //
//             //       /// 🧺 INGREDIENTS
//             //       if (recipe.ingredients.isNotEmpty) ...[
//             //         const Text(
//             //           "Ingredients List",
//             //           style: _sectionTitleStyle,
//             //         ),
//             //         const SizedBox(height: 6),
//             //         ...recipe.ingredients.map(
//             //               (i) => Padding(
//             //             padding: const EdgeInsets.only(bottom: 4),
//             //             child: Text("• $i", style: _bodyTextStyle),
//             //           ),
//             //         ),
//             //         const SizedBox(height: 16),
//             //       ],
//             //
//             //       /// 📝 INSTRUCTIONS
//             //       if (recipe.steps.isNotEmpty) ...[
//             //         const Text(
//             //           "Instructions",
//             //           style: _sectionTitleStyle,
//             //         ),
//             //         const SizedBox(height: 6),
//             //         ...recipe.steps.asMap().entries.map(
//             //               (e) => Padding(
//             //             padding: const EdgeInsets.only(bottom: 8),
//             //             child: Text(
//             //               "Step ${e.key + 1} - ${e.value}",
//             //               style: _bodyTextStyle,
//             //             ),
//             //           ),
//             //         ),
//             //       ],
//             //     ],
//             //   ),
//             // ),
//
//             /// New Design
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 10,
//                 vertical: 20,
//               ),
//               child: Container(
//                 width: MediaQuery.of(context).size.width,
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 15,
//                   vertical: 20,
//                 ),
//                 decoration: BoxDecoration(
//                   color: MyColor.white,
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Description",
//                       style: TextStyle(
//                         color: MyColor.black,
//                         fontWeight: FontWeight.w500,
//                         fontSize: 17,
//                       ),
//                     ),
//                     const SizedBox(height: 15),
//                     Text(
//                       recipe.description ?? "No description available",
//                       style: TextStyle(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w400,
//                         color: MyColor.grey,
//                       ),
//                     ),
//                     const SizedBox(height: 30),
//                     Text(
//                       "Ingredients List",
//                       style: TextStyle(
//                         color: MyColor.black,
//                         fontWeight: FontWeight.w500,
//                         fontSize: 16,
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     // Text(
//                     //   "Available Ingredients List",
//                     //   style: TextStyle(
//                     //     fontWeight: FontWeight.w500,
//                     //     color: MyColor.black,
//                     //     fontSize: 14,
//                     //   ),
//                     // ),
//                     // const SizedBox(height: 10),
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                         vertical: 14,
//                         horizontal: 10,
//                       ),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(14),
//                         color: const Color(0xFFEFE7FF),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           if (recipe.ingredients.isNotEmpty) ...[
//                             ...recipe.ingredients.map(
//                               (i) => Padding(
//                                 padding: const EdgeInsets.only(bottom: 4),
//                                 child: Text("• $i", style: _bodyTextStyle),
//                               ),
//                             ),
//                           ],
//                         ],
//                       ),
//                     ),
//
//                     // const SizedBox(height: 20),
//                     // SizedBox(
//                     //   width: MediaQuery.of(context).size.width,
//                     //   child: CustomButton.button(
//                     //     buttonText: "Add Missing to Shopping List",
//                     //     buttonColor: MyColors.kappThemeColor,
//                     //     borderRadius: 10,
//                     //     onTap: () {
//                     //       Navigator.push(
//                     //         context,
//                     //         MaterialPageRoute(
//                     //           builder: (context) => MissingShoppingListScreen(
//                     //             missingIngredients:
//                     //             widget.recipe.missingIngredients ?? [],
//                     //           ),
//                     //         ),
//                     //       );
//                     //     },
//                     //     textStyle: TextStyle(
//                     //       fontFamily: FontFamily.outfitMedium,
//                     //       fontSize: 15,
//                     //       color: MyColors.kBackgroundWhiteColor,
//                     //     ),
//                     //   ),
//                     // ),
//
//                     const SizedBox(height: 30),
//                     Text(
//                       "Instructions",
//                       style: TextStyle(
//                         color: MyColor.black,
//                         fontWeight: FontWeight.w500,
//                         fontSize: 16,
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//
//                     /// Instruction New
//                     if (recipe.steps.isNotEmpty) ...[
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 14,
//                           horizontal: 10,
//                         ),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(14),
//                           color: const Color(0xFFEFE7FF),
//                         ),
//                         child: RecipeStepsWidget(
//                           steps: recipe.steps,
//                         ),
//                       ),
//                     ],
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _placeholderImage() {
//     return Container(
//       color: Colors.grey.shade300,
//       child: const Center(
//         child: Icon(Icons.image, size: 60, color: Colors.white),
//       ),
//     );
//   }
// }
//
// /// 🎨 STYLES
// const _sectionTitleStyle = TextStyle(
//   fontSize: 16,
//   fontWeight: FontWeight.w700,
// );
//
// const _bodyTextStyle = TextStyle(
//   fontSize: 14,
//   height: 1.5,
// );


import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/new_ui/recipe_step_widget.dart';
import 'package:flutter/material.dart';
import '../ai_recipe_service/recipe_model.dart';
import 'full_screen_image.dart';

class RecipeDetailScreen extends StatelessWidget {
  final RecipeModel recipe;

  const RecipeDetailScreen({
    super.key,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.shortestSide > 600;

    return Scaffold(
      backgroundColor: Color(0xFFEFE7FF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          "Generate Dish Detail",
          style: TextStyle(
            color: Colors.black,
            fontSize: isTablet ? 24.0 : 18.0, // ✅ Increased
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// New Design
            Container(
              color: Color(0xFFEFE7FF),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      right: isTablet ? 80.0 : 60.0,
                      top: isTablet ? 90.0 : 70.0,
                    ),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: FractionallySizedBox(
                        child: Image.asset(
                          "assets/images/lines_image_02.webp",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: isTablet ? 20.0 : 10.0,
                      top: isTablet ? 30.0 : 20.0,
                      bottom: isTablet ? 30.0 : 20.0,
                      right: isTablet ? 20.0 : 10.0,
                    ),
                    child: Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Left side text content
                          Expanded(
                            flex: isTablet ? 6 : 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// Title - BIGGER FOR TABLET
                                Text(
                                  recipe.name ?? "No title",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: isTablet ? 32.0 : 22.0, // ✅ Increased
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: isTablet ? 3 : 4,
                                  overflow: TextOverflow.ellipsis,
                                ),

                                SizedBox(height: isTablet ? 20.0 : 12.0),

                                /// Time - BIGGER
                                Row(
                                  children: [
                                    Icon(
                                      Icons.timer,
                                      size: isTablet ? 26.0 : 18.0, // ✅ Increased
                                      color: Colors.black54,
                                    ),
                                    SizedBox(width: isTablet ? 10.0 : 6.0),
                                    Expanded(
                                      child: Text(
                                        recipe.cookingTime,
                                        style: TextStyle(
                                          fontSize: isTablet ? 20.0 : 14.0, // ✅ Increased
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: isTablet ? 15.0 : 8.0),

                                /// Optional Calories Section
                                /*
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(isTablet ? 10.0 : 6.0),
                                      child: Image.asset(
                                        "assets/images/cal_image.webp",
                                        height: isTablet ? 45.0 : 33.0,
                                        width: isTablet ? 45.0 : 33.0,
                                      ),
                                    ),
                                    SizedBox(width: isTablet ? 12.0 : 8.0),
                                    Text(
                                      "250 kcal",
                                      style: TextStyle(
                                        fontSize: isTablet ? 20.0 : 16.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                */
                              ],
                            ),
                          ),

                          SizedBox(width: isTablet ? 30.0 : 16.0),

                          /// Right side big image - BIGGER FOR TABLET
                          Expanded(
                            flex: isTablet ? 7 : 9,
                            child: Hero(
                              tag: "recipe_2_list1",
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      opaque: false,
                                      pageBuilder: (_, __, ___) =>
                                          FullScreenImageView(
                                            imageUrl: recipe.imageUrl ??
                                                "assets/images/placeholder_recipe_default_02.png",
                                            heroTag: "recipe_image",
                                          ),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.all(
                                    isTablet ? 12.0 : 6.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: MyColor.appTheme,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: isTablet ? 10.0 : 5.0,
                                        spreadRadius: 1.0,
                                      ),
                                    ],
                                  ),
                                  child: ClipOval(
                                    child: (recipe.imageUrl != null &&
                                        recipe.imageUrl!.isNotEmpty)
                                        ? Image.network(
                                      recipe.imageUrl!,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                          "assets/images/placeholder_recipe_default_02.png",
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    )
                                        : Image.asset(
                                      "assets/images/placeholder_recipe_default_02.png",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// Content Card
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isTablet ? 25.0 : 10.0,
                vertical: isTablet ? 35.0 : 20.0,
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 30.0 : 15.0,
                  vertical: isTablet ? 35.0 : 20.0,
                ),
                decoration: BoxDecoration(
                  color: MyColor.white,
                  borderRadius: BorderRadius.circular(
                    isTablet ? 40.0 : 30.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: isTablet ? 20.0 : 10.0,
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Description Title - BIGGER
                    Text(
                      "Description",
                      style: TextStyle(
                        color: MyColor.black,
                        fontWeight: FontWeight.w700,
                        fontSize: isTablet ? 26.0 : 17.0, // ✅ Increased
                      ),
                    ),

                    SizedBox(height: isTablet ? 25.0 : 15.0),

                    // Description Text - BIGGER
                    Text(
                      recipe.description ?? "No description available",
                      style: TextStyle(
                        fontSize: isTablet ? 19.0 : 13.0, // ✅ Increased
                        fontWeight: FontWeight.w400,
                        color: MyColor.grey,
                        height: 1.6,
                      ),
                    ),

                    SizedBox(height: isTablet ? 45.0 : 30.0),

                    // Ingredients Title - BIGGER
                    Text(
                      "Ingredients List",
                      style: TextStyle(
                        color: MyColor.black,
                        fontWeight: FontWeight.w700,
                        fontSize: isTablet ? 26.0 : 16.0, // ✅ Increased
                      ),
                    ),

                    SizedBox(height: isTablet ? 30.0 : 20.0),

                    // Ingredients Container
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: isTablet ? 25.0 : 14.0,
                        horizontal: isTablet ? 20.0 : 10.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          isTablet ? 22.0 : 14.0,
                        ),
                        color: const Color(0xFFEFE7FF),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (recipe.ingredients.isNotEmpty) ...[
                            ...recipe.ingredients.map(
                                  (i) => Padding(
                                padding: EdgeInsets.only(
                                  bottom: isTablet ? 12.0 : 4.0,
                                  left: isTablet ? 5.0 : 0.0,
                                ),
                                child: Text(
                                  "• $i",
                                  style: TextStyle(
                                    fontSize: isTablet ? 18.0 : 14.0, // ✅ Increased
                                    height: 1.6,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),

                    SizedBox(height: isTablet ? 50.0 : 30.0),

                    // Instructions Title - BIGGER
                    Text(
                      "Instructions",
                      style: TextStyle(
                        color: MyColor.black,
                        fontWeight: FontWeight.w700,
                        fontSize: isTablet ? 26.0 : 16.0, // ✅ Increased
                      ),
                    ),

                    SizedBox(height: isTablet ? 30.0 : 20.0),

                    /// Instruction Container
                    if (recipe.steps.isNotEmpty) ...[
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: isTablet ? 25.0 : 14.0,
                          horizontal: isTablet ? 20.0 : 10.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            isTablet ? 22.0 : 14.0,
                          ),
                          color: const Color(0xFFEFE7FF),
                        ),
                        child: RecipeStepsWidget(
                          steps: recipe.steps,
                        ),
                      ),
                    ],

                    // Extra bottom spacing
                    SizedBox(height: isTablet ? 50.0 : 20.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeholderImage() {
    return Container(
      color: Colors.grey.shade300,
      child: Center(
        child: Icon(
          Icons.image,
          size: 60.0,
          color: Colors.white,
        ),
      ),
    );
  }
}