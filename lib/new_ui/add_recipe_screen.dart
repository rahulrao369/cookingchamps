// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:dotted_border/dotted_border.dart';
// import '../ai_recipe_service/ai_recipe_service.dart';
// import '../ai_recipe_service/recipe_model.dart';
// import '../constant/my_color.dart';
// import '../constant/sized_box.dart';
// import '../constant/my_fonts_style.dart';
// import 'dish_list_screen_by_search.dart';
//
// final ValueNotifier<List<RecipeModel>> recipeStreamNotifier =
//     ValueNotifier<List<RecipeModel>>([]);
//
// class AddRecipeScreen extends StatefulWidget {
//   const AddRecipeScreen({super.key});
//
//   @override
//   State<AddRecipeScreen> createState() => _AddRecipeScreenState();
// }
//
// class _AddRecipeScreenState extends State<AddRecipeScreen> {
//   final TextEditingController notes01Controller = TextEditingController();
//   final TextEditingController notes02Controller = TextEditingController();
//
//   final List<TextEditingController> _ingredientControllers = [
//     TextEditingController(),
//   ];
//
//   final ImagePicker _imagePicker = ImagePicker();
//   File? _selectedImage;
//
//   bool _isLoading = false;
//
//   // ─────────── IMAGE PICKER ───────────
//   Future<void> _pickImage(ImageSource source) async {
//     final XFile? image = await _imagePicker.pickImage(
//       source: source,
//       imageQuality: 80,
//     );
//
//     if (image != null) {
//       setState(() => _selectedImage = File(image.path));
//     }
//   }
//
//   void _showImagePickerSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (_) => SafeArea(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ListTile(
//               leading: const Icon(Icons.camera_alt),
//               title: const Text('Camera'),
//               onTap: () {
//                 Navigator.pop(context);
//                 _pickImage(ImageSource.camera);
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.photo_library),
//               title: const Text('Gallery'),
//               onTap: () {
//                 Navigator.pop(context);
//                 _pickImage(ImageSource.gallery);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ─────────── INGREDIENTS ───────────
//   void _addIngredient() {
//     setState(() => _ingredientControllers.add(TextEditingController()));
//   }
//
//   void _removeIngredient(int index) {
//     if (_ingredientControllers.length > 1) {
//       _ingredientControllers[index].dispose();
//       setState(() => _ingredientControllers.removeAt(index));
//     }
//   }
//
//   String? selectedDishType;
//   String? selectedCookingMethod;
//   String? selectedAgeGroup;
//   String? selectedDifficulty;
//
//   final dishTypes = ["Hot", "Cold"];
//   final cookingMethods = [
//     "No Heat",
//     "Oven (Adult Supervision)",
//     "Gas (Adult Only)",
//   ];
//   final ageGroups = ["6–8", "9–10", "11–12"];
//   final difficulties = ["Easy", "With Parent"];
//
//
//   @override
//   void dispose() {
//     for (var controller in _ingredientControllers) {
//       controller.dispose();
//     }
//     notes01Controller.dispose();
//     notes02Controller.dispose();
//     super.dispose();
//   }
//
//   // ─────────── UI ───────────
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       top: false,
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: Stack(
//           children: [
//             Stack(
//               alignment: Alignment.center,
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Color(0XFFBCC66F),
//                     borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(50),
//                       bottomRight: Radius.circular(50),
//                     ),
//                   ),
//                   height: 380,
//                   width: MediaQuery.of(context).size.width,
//                   child: Padding(
//                     padding: const EdgeInsets.only(top: 50),
//                     child: Image.asset(
//                       "assets/images/image 500-Photoroom (1) 1.png",
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             DraggableScrollableSheet(
//               minChildSize: 0.7,
//               maxChildSize: 0.9,
//               initialChildSize: 0.7,
//               expand: true,
//               builder: (BuildContext context, ScrollController controller) {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                         image: AssetImage(
//                           "assets/images/background_bump_image 1.webp",
//                         ),
//                         fit: BoxFit.fill,
//                       ),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.only(
//                         right: 5,
//                         left: 5,
//                       ),
//                       child: Column(
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.pop(context);
//                             },
//                             child: Container(
//                               height: 50,
//                               margin: EdgeInsets.all(8),
//                               width: 50,
//                               alignment: Alignment.center,
//                               decoration: BoxDecoration(
//                                   color: MyColor.appTheme,
//                                   shape: BoxShape.circle,
//                                   border: Border.all(
//                                       color: Colors.black, width: 2)),
//                               child: SvgPicture.asset(
//                                 "assets/images/back-svgrepo-com.svg",
//                                 width: 35,
//                                 height: 35,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             child: SingleChildScrollView(
//                               controller: controller,
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Text(
//                                     'Add Manually',
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       // fontFamily: FontFamily.outfitSemiBold,
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: 24,
//                                     ),
//                                   ),
//                                   SizedBox(height: 10),
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "Add Ingredients",
//                                         style: TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w600,
//                                             color: MyColor.black),
//                                       ),
//
//                                       ListView.separated(
//                                         padding: EdgeInsets.only(top: 20),
//                                         shrinkWrap: true,
//                                         physics:
//                                             const NeverScrollableScrollPhysics(),
//                                         itemCount:
//                                             _ingredientControllers.length,
//                                         separatorBuilder: (_, __) =>
//                                             const SizedBox(height: 12),
//                                         itemBuilder: (context, index) {
//                                           return Row(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.center,
//                                             children: [
//                                               /// 🔹 TEXT FIELD
//                                               Expanded(
//                                                 child: TextFormField(
//                                                   onTapOutside: (v) {
//                                                     FocusManager.instance.primaryFocus!.unfocus();
//                                                   },
//                                                   controller:
//                                                       _ingredientControllers[
//                                                           index],
//                                                   decoration: InputDecoration(
//                                                     labelText:
//                                                         '${index + 1}. Ingredients',
//                                                     floatingLabelBehavior:
//                                                         FloatingLabelBehavior
//                                                             .always,
//                                                     hintText:
//                                                         'Enter Ingredient',
//                                                     border: OutlineInputBorder(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               7),
//                                                       borderSide: BorderSide(
//                                                         width: 1,
//                                                         color: MyColor
//                                                             .kFieldBorderColor,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   validator: (value) =>
//                                                       value != null &&
//                                                               value.isNotEmpty
//                                                           ? null
//                                                           : 'Required',
//                                                 ),
//                                               ),
//
//                                               /// 🔹 REMOVE BUTTON (except first field)
//                                               if (index != 0) ...[
//                                                 const SizedBox(width: 8),
//                                                 GestureDetector(
//                                                   onTap: () =>
//                                                       _removeIngredient(index),
//                                                   child: Icon(
//                                                     Icons
//                                                         .remove_circle_outline_outlined,
//                                                     color: Colors.red,
//                                                     size: 20,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ],
//                                           );
//                                         },
//                                       ),
//
//                                       const SizedBox(height: 10),
//
//                                       /// 🔹 Add Button
//                                       Align(
//                                         alignment: Alignment.centerRight,
//                                         child: TextButton(
//                                           onPressed: _addIngredient,
//                                           style: TextButton.styleFrom(
//                                             side: const BorderSide(
//                                               color: Colors.black,
//                                               // change color as needed
//                                               width: 1.2,
//                                             ),
//                                             // shape: RoundedRectangleBorder(
//                                             //   borderRadius: BorderRadius.circular(8), // optional
//                                             // ),
//                                             padding:
//                                             const EdgeInsets.symmetric(
//                                                 horizontal: 12,
//                                                 vertical: 6),
//                                           ),
//                                           child: Row(
//                                             mainAxisSize: MainAxisSize.min,
//                                             children: const [
//                                               Text(
//                                                 'Add',
//                                                 style: TextStyle(
//                                                     fontWeight:
//                                                     FontWeight.w600,
//                                                     color:
//                                                     MyColor.appTheme),
//                                               ),
//                                               SizedBox(width: 4),
//                                               Icon(
//                                                 Icons.add,
//                                                 size: 18,
//                                                 color: MyColor.appTheme,
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                       hsized20,
//
//                                       /// 🔹 FILTER POPUPS
//                                       Wrap(
//                                         spacing: 10,
//                                         runSpacing: 10,
//                                         children: [
//                                           _popupFilter(
//                                             label: "Dish Type",
//                                             value: selectedDishType,
//                                             options: dishTypes,
//                                             onSelected: (v) => setState(() => selectedDishType = v),
//                                             icon: Icons.restaurant_menu_rounded,
//                                             accentColor: Colors.orangeAccent,
//                                           ),
//
//                                           _popupFilter(
//                                             label: "Cooking Method",
//                                             value: selectedCookingMethod,
//                                             options: cookingMethods,
//                                             onSelected: (v) => setState(() => selectedCookingMethod = v),
//                                             icon: Icons.local_fire_department_rounded,
//                                             accentColor: Colors.redAccent,
//                                           ),
//
//                                           _popupFilter(
//                                             label: "Age Group",
//                                             value: selectedAgeGroup,
//                                             options: ageGroups,
//                                             onSelected: (v) => setState(() => selectedAgeGroup = v),
//                                             icon: Icons.child_care_rounded,
//                                             accentColor: Colors.purpleAccent,
//                                           ),
//
//                                           _popupFilter(
//                                             label: "Difficulty",
//                                             value: selectedDifficulty,
//                                             options: difficulties,
//                                             onSelected: (v) => setState(() => selectedDifficulty = v),
//                                             icon: Icons.star_rounded,
//                                             accentColor: Colors.green,
//                                           ),
//                                         ],
//                                       ),
//
//                                       hsized15,
//
//                                       Text(
//                                         "Notes",
//                                         style: TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w600,
//                                             color: MyColor.black),
//                                       ),
//
//                                       hsized10,
//                                       TextFormField(
//                                         controller: notes02Controller,
//                                         onTapOutside: (v) {
//                                           FocusManager.instance.primaryFocus!.unfocus();
//                                         },
//                                         decoration: InputDecoration(
//                                           hintText: 'Enter Notes',
//                                           hintStyle: TextStyle(
//                                               fontWeight: FontWeight.w300,
//                                               fontSize: 15,
//                                               color: MyColor.color555555),
//                                           border: OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                   width: 1,
//                                                   color: MyColor
//                                                       .kFieldBorderColor),
//                                               borderRadius:
//                                                   BorderRadius.circular(7)),
//                                         ),
//                                         keyboardType: TextInputType.text,
//                                         autofillHints: const [
//                                           AutofillHints.name
//                                         ],
//                                         validator: (value) =>
//                                             value != null && value.isNotEmpty
//                                                 ? null
//                                                 : 'Required',
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(
//                                     height: 50,
//                                   ),
//                                   SizedBox(
//                                     width: double.infinity,
//                                     child: ElevatedButton(
//                                         style: ElevatedButton.styleFrom(
//                                             backgroundColor: MyColor.appTheme,
//                                             overlayColor: MyColor.liteOrange,
//                                             enableFeedback: true,
//                                             enabledMouseCursor:
//                                                 MouseCursor.defer,
//                                             elevation: 5,
//                                             shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(
//                                                       10), // Custom shape
//                                             ),
//                                             padding: EdgeInsets.zero),
//                                         onPressed: _isLoading ? null : _searchByIngredients,
//                                         child: Text("Search Dish",
//                                             style: mediumTextStyle(
//                                                 fontSize: 13.0,
//                                                 color: MyColor.white))),
//                                   ),
//                                   const SizedBox(height: 10),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//
//   void _showError(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message, style: TextStyle(color: Colors.black),),
//         backgroundColor: Colors.grey.shade300,
//         behavior: SnackBarBehavior.floating,
//       ),
//     );
//   }
//
//   bool _validateFilters() {
//     if (selectedDishType == null) {
//       _showError("Please select Dish Type");
//       return false;
//     }
//     if (selectedCookingMethod == null) {
//       _showError("Please select Cooking Method");
//       return false;
//     }
//     if (selectedAgeGroup == null) {
//       _showError("Please select Age Group");
//       return false;
//     }
//     if (selectedDifficulty == null) {
//       _showError("Please select Difficulty");
//       return false;
//     }
//     return true;
//   }
//
//
//   Widget _popupFilter({
//     required String label,
//     required String? value,
//     required List<String> options,
//     required ValueChanged<String> onSelected,
//     required IconData icon,
//     Color accentColor = Colors.orange,
//   }) {
//     return PopupMenuButton<String>(
//       onSelected: onSelected,
//       offset: const Offset(0, 55), // ⬇ bigger drop-down spacing
//       constraints: const BoxConstraints(
//         minWidth: 200,
//         maxWidth: 260,
//       ),
//       itemBuilder: (context) {
//         return options.map((e) {
//           return PopupMenuItem<String>(
//             value: e,
//             height: 52, // ⬆ bigger tap area
//             child: Row(
//               children: [
//                 Icon(icon, color: accentColor, size: 22),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Text(
//                     e,
//                     style: const TextStyle(
//                       fontSize: 16, // 👶 kid-friendly
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }).toList();
//       },
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20), // 🎈 funky rounded menu
//       ),
//       color: Colors.white,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//         decoration: BoxDecoration(
//           color: accentColor.withOpacity(0.12),
//           borderRadius: BorderRadius.circular(26),
//           border: Border.all(color: accentColor, width: 1.5),
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(icon, color: accentColor, size: 20),
//             const SizedBox(width: 8),
//             Text(
//               value ?? label,
//               style: TextStyle(
//                 fontSize: 14.5,
//                 fontWeight: FontWeight.w700,
//                 color: value == null ? Colors.grey.shade600 : Colors.black,
//               ),
//             ),
//             const SizedBox(width: 6),
//             const Icon(Icons.arrow_drop_down_rounded, size: 24),
//           ],
//         ),
//       ),
//     );
//   }
//
//
//
//
//
// // --------------------- INGREDIENTS SEARCH ---------------------
//   Future<void> _searchByIngredients() async {
//     /// 🔹 Collect ingredients
//     final ingredients = _ingredientControllers
//         .map((e) => e.text.trim())
//         .where((e) => e.isNotEmpty)
//         .toList();
//
//     /// 🔴 VALIDATION — Ingredients
//     if (ingredients.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please add ingredients")),
//       );
//       return;
//     }
//
//     /// 🔴 VALIDATION — Required popup filters
//     if (selectedDishType == null) {
//       _showError("Please select Dish Type");
//       return;
//     }
//     if (selectedCookingMethod == null) {
//       _showError("Please select Cooking Method");
//       return;
//     }
//     if (selectedAgeGroup == null) {
//       _showError("Please select Age Group");
//       return;
//     }
//     if (selectedDifficulty == null) {
//       _showError("Please select Difficulty");
//       return;
//     }
//
//     /// 🔁 Reset recipe stream
//     recipeStreamNotifier.value = [];
//
//     /// 🚀 Navigate immediately (stream-based screen)
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (_) => DishListScreenBySearch(
//           recipeNotifier: recipeStreamNotifier,
//         ),
//       ),
//     );
//
//     setState(() => _isLoading = true);
//
//     try {
//       /// 🔄 Generate recipes ONE BY ONE
//       for (int i = 0; i < 5; i++) {
//         final recipe =
//         await AiRecipeService().generateSingleRecipeFromIngredients(
//           ingredients: ingredients,
//           index: i + 1,
//           dishType: selectedDishType!,
//           cookingMethod: selectedCookingMethod!,
//           ageGroup: selectedAgeGroup!,
//           difficulty: selectedDifficulty!,
//           notes: notes02Controller.text,
//         );
//
//         /// 🔥 Append immediately to stream
//         recipeStreamNotifier.value = [
//           ...recipeStreamNotifier.value,
//           recipe,
//         ];
//       }
//     } catch (e) {
//       debugPrint("AI recipe generation error: $e");
//       _showError("Something went wrong while generating recipes");
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }
//
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import '../ai_recipe_service/ai_recipe_service.dart';
import '../ai_recipe_service/recipe_model.dart';
import '../constant/my_color.dart';
import '../constant/my_fonts_style.dart';
import 'dish_list_screen_by_search.dart';

final ValueNotifier<List<RecipeModel>> recipeStreamNotifier =
ValueNotifier<List<RecipeModel>>([]);

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final TextEditingController notes01Controller = TextEditingController();
  final TextEditingController notes02Controller = TextEditingController();

  final List<TextEditingController> _ingredientControllers = [
    TextEditingController(),
  ];

  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;

  bool _isLoading = false;

  // ─────────── IMAGE PICKER ───────────
  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _imagePicker.pickImage(
      source: source,
      imageQuality: 80,
    );

    if (image != null) {
      setState(() => _selectedImage = File(image.path));
    }
  }

  void _showImagePickerSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  // ─────────── INGREDIENTS ───────────
  void _addIngredient() {
    setState(() => _ingredientControllers.add(TextEditingController()));
  }

  void _removeIngredient(int index) {
    if (_ingredientControllers.length > 1) {
      _ingredientControllers[index].dispose();
      setState(() => _ingredientControllers.removeAt(index));
    }
  }

  String? selectedDishType;
  String? selectedCookingMethod;
  String? selectedAgeGroup;
  String? selectedDifficulty;

  final dishTypes = ["Hot", "Cold"];
  final cookingMethods = [
    "No Heat",
    "Oven (Adult Supervision)",
    "Gas (Adult Only)",
  ];
  final ageGroups = ["6–8", "9–10", "11–12"];
  final difficulties = ["Easy", "With Parent"];

  @override
  void dispose() {
    for (var controller in _ingredientControllers) {
      controller.dispose();
    }
    notes01Controller.dispose();
    notes02Controller.dispose();
    super.dispose();
  }

  // ─────────── UI ───────────
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isTablet = size.shortestSide > 600;

    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0XFFBCC66F),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(isTablet ? 70.0 : 50.0),
                      bottomRight: Radius.circular(isTablet ? 70.0 : 50.0),
                    ),
                  ),
                  height: isTablet ? 550.0 : 380.0,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: EdgeInsets.only(top: isTablet ? 70.0 : 50.0),
                    child: Image.asset(
                      "assets/images/image 500-Photoroom (1) 1.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
            DraggableScrollableSheet(
              minChildSize: isTablet ? 0.65 : 0.7,
              maxChildSize: isTablet ? 0.85 : 0.9,
              initialChildSize: isTablet ? 0.65 : 0.7,
              expand: true,
              builder: (BuildContext context, ScrollController controller) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isTablet ? 25.0 : 10.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/images/background_bump_image 1.webp",
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: isTablet ? 15.0 : 5.0,
                        left: isTablet ? 15.0 : 5.0,
                      ),
                      child: Column(
                        children: [
                          // Back Button
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: isTablet ? 60.0 : 50.0,
                              margin: EdgeInsets.all(isTablet ? 12.0 : 8.0),
                              width: isTablet ? 60.0 : 50.0,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: MyColor.appTheme,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.black,
                                  width: isTablet ? 2.5 : 2.0,
                                ),
                              ),
                              child: SvgPicture.asset(
                                "assets/images/back-svgrepo-com.svg",
                                width: isTablet ? 40.0 : 35.0,
                                height: isTablet ? 40.0 : 35.0,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          Expanded(
                            child: SingleChildScrollView(
                              controller: controller,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Title
                                  Text(
                                    'Add Manually',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: isTablet ? 28.0 : 24.0,
                                    ),
                                  ),

                                  SizedBox(height: isTablet ? 20.0 : 10.0),

                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      // Add Ingredients Label
                                      Text(
                                        "Add Ingredients",
                                        style: TextStyle(
                                          fontSize: isTablet ? 20.0 : 16.0,
                                          fontWeight: FontWeight.w600,
                                          color: MyColor.black,
                                        ),
                                      ),

                                      // Ingredients List
                                      ListView.separated(
                                        padding: EdgeInsets.only(
                                          top: isTablet ? 25.0 : 20.0,
                                        ),
                                        shrinkWrap: true,
                                        physics:
                                        const NeverScrollableScrollPhysics(),
                                        itemCount:
                                        _ingredientControllers.length,
                                        separatorBuilder: (_, __) =>
                                            SizedBox(height: isTablet ? 16.0 : 12.0),
                                        itemBuilder: (context, index) {
                                          return Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              /// 🔹 TEXT FIELD
                                              Expanded(
                                                child: TextFormField(
                                                  onTapOutside: (v) {
                                                    FocusManager.instance.primaryFocus!.unfocus();
                                                  },
                                                  controller:
                                                  _ingredientControllers[
                                                  index],
                                                  decoration: InputDecoration(
                                                    labelText:
                                                    '${index + 1}. Ingredients',
                                                    floatingLabelBehavior:
                                                    FloatingLabelBehavior
                                                        .always,
                                                    hintText:
                                                    'Enter Ingredient',
                                                    labelStyle: TextStyle(
                                                      fontSize: isTablet ? 16.0 : 14.0,
                                                    ),
                                                    hintStyle: TextStyle(
                                                      fontSize: isTablet ? 16.0 : 14.0,
                                                    ),
                                                    contentPadding: EdgeInsets.symmetric(
                                                      vertical: isTablet ? 18.0 : 16.0,
                                                      horizontal: isTablet ? 16.0 : 12.0,
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          isTablet ? 10.0 : 7.0),
                                                      borderSide: BorderSide(
                                                        width: isTablet ? 1.2 : 1.0,
                                                        color: MyColor
                                                            .kFieldBorderColor,
                                                      ),
                                                    ),
                                                  ),
                                                  style: TextStyle(
                                                    fontSize: isTablet ? 16.0 : 14.0,
                                                  ),
                                                  validator: (value) =>
                                                  value != null &&
                                                      value.isNotEmpty
                                                      ? null
                                                      : 'Required',
                                                ),
                                              ),

                                              /// 🔹 REMOVE BUTTON (except first field)
                                              if (index != 0) ...[
                                                SizedBox(width: isTablet ? 12.0 : 8.0),
                                                GestureDetector(
                                                  onTap: () =>
                                                      _removeIngredient(index),
                                                  child: Icon(
                                                    Icons
                                                        .remove_circle_outline_outlined,
                                                    color: Colors.red,
                                                    size: isTablet ? 26.0 : 20.0,
                                                  ),
                                                ),
                                              ],
                                            ],
                                          );
                                        },
                                      ),

                                      SizedBox(height: isTablet ? 15.0 : 10.0),

                                      /// 🔹 Add Button
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: TextButton(
                                          onPressed: _addIngredient,
                                          style: TextButton.styleFrom(
                                            side: const BorderSide(
                                              color: Colors.black,
                                              width: 1.2,
                                            ),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: isTablet ? 16.0 : 12.0,
                                              vertical: isTablet ? 10.0 : 6.0,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                isTablet ? 10.0 : 8.0,
                                              ),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                'Add',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: MyColor.appTheme,
                                                  fontSize: isTablet ? 18.0 : 14.0,
                                                ),
                                              ),
                                              SizedBox(width: isTablet ? 6.0 : 4.0),
                                              Icon(
                                                Icons.add,
                                                size: isTablet ? 22.0 : 18.0,
                                                color: MyColor.appTheme,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      SizedBox(height: isTablet ? 30.0 : 20.0),

                                      /// 🔹 FILTER POPUPS
                                      Wrap(
                                        spacing: isTablet ? 15.0 : 10.0,
                                        runSpacing: isTablet ? 15.0 : 10.0,
                                        children: [
                                          _popupFilter(
                                            label: "Dish Type",
                                            value: selectedDishType,
                                            options: dishTypes,
                                            onSelected: (v) => setState(() => selectedDishType = v),
                                            icon: Icons.restaurant_menu_rounded,
                                            accentColor: Colors.orangeAccent,
                                            isTablet: isTablet,
                                          ),

                                          _popupFilter(
                                            label: "Cooking Method",
                                            value: selectedCookingMethod,
                                            options: cookingMethods,
                                            onSelected: (v) => setState(() => selectedCookingMethod = v),
                                            icon: Icons.local_fire_department_rounded,
                                            accentColor: Colors.redAccent,
                                            isTablet: isTablet,
                                          ),

                                          _popupFilter(
                                            label: "Age Group",
                                            value: selectedAgeGroup,
                                            options: ageGroups,
                                            onSelected: (v) => setState(() => selectedAgeGroup = v),
                                            icon: Icons.child_care_rounded,
                                            accentColor: Colors.purpleAccent,
                                            isTablet: isTablet,
                                          ),

                                          _popupFilter(
                                            label: "Difficulty",
                                            value: selectedDifficulty,
                                            options: difficulties,
                                            onSelected: (v) => setState(() => selectedDifficulty = v),
                                            icon: Icons.star_rounded,
                                            accentColor: Colors.green,
                                            isTablet: isTablet,
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: isTablet ? 30.0 : 15.0),

                                      // Notes Label
                                      Text(
                                        "Notes",
                                        style: TextStyle(
                                          fontSize: isTablet ? 20.0 : 16.0,
                                          fontWeight: FontWeight.w600,
                                          color: MyColor.black,
                                        ),
                                      ),

                                      SizedBox(height: isTablet ? 15.0 : 10.0),

                                      // Notes TextField
                                      TextFormField(
                                        controller: notes02Controller,
                                        onTapOutside: (v) {
                                          FocusManager.instance.primaryFocus!.unfocus();
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'Enter Notes',
                                          hintStyle: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: isTablet ? 16.0 : 15.0,
                                            color: MyColor.color555555,
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                            vertical: isTablet ? 20.0 : 16.0,
                                            horizontal: isTablet ? 16.0 : 12.0,
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              width: isTablet ? 1.2 : 1.0,
                                              color: MyColor.kFieldBorderColor,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              isTablet ? 10.0 : 7.0,
                                            ),
                                          ),
                                        ),
                                        style: TextStyle(
                                          fontSize: isTablet ? 16.0 : 14.0,
                                        ),
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 3,
                                        minLines: 1,
                                        autofillHints: const [
                                          AutofillHints.name
                                        ],
                                        validator: (value) =>
                                        value != null && value.isNotEmpty
                                            ? null
                                            : 'Required',
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: isTablet ? 70.0 : 50.0),

                                  // Search Dish Button
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: MyColor.appTheme,
                                        overlayColor: MyColor.liteOrange,
                                        enableFeedback: true,
                                        enabledMouseCursor:
                                        MouseCursor.defer,
                                        elevation: 5.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            isTablet ? 14.0 : 10.0,
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          vertical: isTablet ? 20.0 : 16.0,
                                        ),
                                      ),
                                      onPressed: _isLoading ? null : _searchByIngredients,
                                      child: Text(
                                        _isLoading ? "Searching..." : "Search Dish",
                                        style: mediumTextStyle(
                                          fontSize: isTablet ? 18.0 : 13.0,
                                          color: MyColor.white,
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 20.0),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: Colors.grey.shade300,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Widget _popupFilter({
    required String label,
    required String? value,
    required List<String> options,
    required ValueChanged<String> onSelected,
    required IconData icon,
    Color accentColor = Colors.orange,
    required bool isTablet,
  }) {
    return PopupMenuButton<String>(
      onSelected: onSelected,
      offset: Offset(0, isTablet ? 65.0 : 55.0),
      constraints: BoxConstraints(
        minWidth: isTablet ? 240.0 : 200.0,
        maxWidth: isTablet ? 300.0 : 260.0,
      ),
      itemBuilder: (context) {
        return options.map((e) {
          return PopupMenuItem<String>(
            value: e,
            height: isTablet ? 58.0 : 52.0,
            child: Row(
              children: [
                Icon(
                  icon,
                  color: accentColor,
                  size: isTablet ? 26.0 : 22.0,
                ),
                SizedBox(width: isTablet ? 16.0 : 12.0),
                Expanded(
                  child: Text(
                    e,
                    style: TextStyle(
                      fontSize: isTablet ? 18.0 : 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList();
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? 18.0 : 14.0,
          vertical: isTablet ? 16.0 : 12.0,
        ),
        decoration: BoxDecoration(
          color: accentColor.withOpacity(0.12),
          borderRadius: BorderRadius.circular(isTablet ? 30.0 : 26.0),
          border: Border.all(
            color: accentColor,
            width: isTablet ? 2.0 : 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: accentColor,
              size: isTablet ? 24.0 : 20.0,
            ),
            SizedBox(width: isTablet ? 10.0 : 8.0),
            Text(
              value ?? label,
              style: TextStyle(
                fontSize: isTablet ? 16.0 : 14.5,
                fontWeight: FontWeight.w700,
                color: value == null ? Colors.grey.shade600 : Colors.black,
              ),
            ),
            SizedBox(width: isTablet ? 8.0 : 6.0),
            Icon(
              Icons.arrow_drop_down_rounded,
              size: isTablet ? 28.0 : 24.0,
            ),
          ],
        ),
      ),
    );
  }

  // --------------------- INGREDIENTS SEARCH ---------------------
  Future<void> _searchByIngredients() async {
    /// 🔹 Collect ingredients
    final ingredients = _ingredientControllers
        .map((e) => e.text.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    /// 🔴 VALIDATION — Ingredients
    if (ingredients.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please add ingredients")),
      );
      return;
    }

    /// 🔴 VALIDATION — Required popup filters
    if (selectedDishType == null) {
      _showError("Please select Dish Type");
      return;
    }
    if (selectedCookingMethod == null) {
      _showError("Please select Cooking Method");
      return;
    }
    if (selectedAgeGroup == null) {
      _showError("Please select Age Group");
      return;
    }
    if (selectedDifficulty == null) {
      _showError("Please select Difficulty");
      return;
    }

    /// 🔁 Reset recipe stream
    recipeStreamNotifier.value = [];

    /// 🚀 Navigate immediately (stream-based screen)
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DishListScreenBySearch(
          recipeNotifier: recipeStreamNotifier,
        ),
      ),
    );

    setState(() => _isLoading = true);

    try {
      /// 🔄 Generate recipes ONE BY ONE
      for (int i = 0; i < 5; i++) {
        final recipe =
        await AiRecipeService().generateSingleRecipeFromIngredients(
          ingredients: ingredients,
          index: i + 1,
          dishType: selectedDishType!,
          cookingMethod: selectedCookingMethod!,
          ageGroup: selectedAgeGroup!,
          difficulty: selectedDifficulty!,
          notes: notes02Controller.text,
        );

        /// 🔥 Append immediately to stream
        recipeStreamNotifier.value = [
          ...recipeStreamNotifier.value,
          recipe,
        ];
      }
    } catch (e) {
      debugPrint("AI recipe generation error: $e");
      _showError("Something went wrong while generating recipes");
    } finally {
      setState(() => _isLoading = false);
    }
  }
}