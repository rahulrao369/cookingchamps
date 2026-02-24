// import 'package:cooking_champs/constant/my_color.dart';
// import 'package:cooking_champs/constant/sized_box.dart';
// import 'package:cooking_champs/utils/common_widget.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart' as img_picker;
// import 'dart:io';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:image_picker/image_picker.dart';
// import '../ai_recipe_service/ai_recipe_service.dart';
// import '../constant/assets_path.dart';
// import '../constant/my_fonts_style.dart';
// import '../constant/stringfile.dart/language.dart';
// import 'dish_list_screen_by_search.dart';
//
// class AddRecipeScreen extends StatefulWidget {
//   const AddRecipeScreen({super.key});
//
//   @override
//   State<AddRecipeScreen> createState() => _AddRecipeScreenState();
// }
//
// class _AddRecipeScreenState extends State<AddRecipeScreen> {
//   TextEditingController notes01Controller = TextEditingController();
//   TextEditingController notes02Controller = TextEditingController();
//
//   final List<TextEditingController> _ingredientControllers = [
//     TextEditingController(),
//   ];
//
//   void _addIngredient() {
//     setState(() {
//       _ingredientControllers.add(TextEditingController());
//     });
//   }
//
//   @override
//   void dispose() {
//     for (var controller in _ingredientControllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: CommonScaffold(
//           appBar: commonAppBar(
//               context: context,
//               title: "Search Recipe",
//               centerTitle: false),
//           body: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               TabBar(
//                 indicatorColor: MyColor.appTheme,
//                 labelColor: MyColor.appTheme,
//                 unselectedLabelColor: MyColor.black,
//                 indicatorSize: TabBarIndicatorSize.tab,
//                 padding: EdgeInsets.symmetric(horizontal: 7),
//                 labelStyle: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                     color: MyColor.black),
//                 unselectedLabelStyle: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                     color: MyColor.black),
//                 tabs: const [
//                   Tab(
//                     text: "Search Dish by Image",
//                   ),
//                   Tab(text: "Search Dish by Ingredients"),
//                 ],
//               ),
//               Expanded(
//                 child: TabBarView(
//                   children: [
//                     addDishImage(),
//                     addDishManually(),
//                   ],
//                 ),
//               ),
//             ],
//           )),
//     );
//   }
//
//   File? _selectedImage;
//   final ImagePicker _imagePicker = ImagePicker();
//
//   Future<void> _pickImage(ImageSource source) async {
//     final XFile? image = await _imagePicker.pickImage(
//       source: source,
//       imageQuality: 80, // optional compression
//     );
//
//     if (image != null) {
//       setState(() {
//         _selectedImage = File(image.path);
//       });
//     }
//   }
//
//   void _showImagePickerSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (_) {
//         return SafeArea(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 leading: const Icon(Icons.camera_alt),
//                 title: const Text('Camera'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   _pickImage(ImageSource.camera);
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.photo_library),
//                 title: const Text('Gallery'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   _pickImage(ImageSource.gallery);
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Widget addDishImage() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.fromLTRB(15, 38, 15, 15),
//       keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(
//                 child: Text(
//                   Languages.of(context)!.uploadRecipeImage.toString(),
//                   style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w500,
//                       color: MyColor.black),
//                 ),
//               ),
//               hsized10,
//               GestureDetector(
//                 onTap: () => _showImagePickerSheet(context),
//                 child: DottedBorder(
//                   dashPattern: const [6, 3],
//                   radius: const Radius.circular(10),
//                   borderType: BorderType.RRect,
//                   color: MyColor.appTheme,
//                   child: Container(
//                     height: 163,
//                     width: MediaQuery.of(context).size.width,
//                     decoration: BoxDecoration(
//                       color: MyColor.yellowF6F1E1,
//                       borderRadius: BorderRadius.circular(10),
//                       image: _selectedImage != null
//                           ? DecorationImage(
//                               image: FileImage(_selectedImage!),
//                               fit: BoxFit.cover,
//                             )
//                           : null,
//                     ),
//                     alignment: Alignment.center,
//                     child: _selectedImage == null
//                         ? Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Image.asset(
//                                 "assets/images/addimage.png",
//                                 height: 26,
//                                 width: 26,
//                               ),
//                               const SizedBox(height: 6),
//                               Text(
//                                 Languages.of(context)!.addImage.toString(),
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w500,
//                                   color: MyColor.appTheme,
//                                 ),
//                               ),
//                             ],
//                           )
//                         : null,
//                   ),
//                 ),
//               ),
//               hsized20,
//               Text(
//                 "Notes",
//                 style: TextStyle(
//                     fontSize: 15,
//                     fontWeight: FontWeight.w300,
//                     color: MyColor.black),
//               ),
//               hsized2,
//               TextFormField(
//                 controller: notes01Controller,
//                 decoration: InputDecoration(
//                   hintText: 'Enter Notes',
//                   hintStyle: TextStyle(
//                       fontWeight: FontWeight.w300,
//                       fontSize: 15,
//                       color: MyColor.color555555),
//                   border: OutlineInputBorder(
//                       borderSide: BorderSide(
//                           width: 1, color: MyColor.kFieldBorderColor),
//                       borderRadius: BorderRadius.circular(7)),
//                 ),
//                 keyboardType: TextInputType.text,
//                 autofillHints: const [AutofillHints.name],
//                 validator: (value) =>
//                     value != null && value.isNotEmpty ? null : 'Required',
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 50,
//           ),
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                     backgroundColor: MyColor.appTheme,
//                     overlayColor: MyColor.liteOrange,
//                     enableFeedback: true,
//                     enabledMouseCursor: MouseCursor.defer,
//                     elevation: 5,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10), // Custom shape
//                     ),
//                     padding: EdgeInsets.zero),
//                 onPressed: () async {
//                   final ingredients = _ingredientControllers
//                       .map((e) => e.text.trim())
//                       .where((e) => e.isNotEmpty)
//                       .toList();
//
//                   if (ingredients.isEmpty) return;
//
//                   try {
//                     final service = AiRecipeService();
//
//                     final recipe = await service.generateRecipeFromImage(
//                       selectedImageFile, // File object
//                       "Low oil, Indian style",
//                     );
//
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => DishListScreenBySearch(recipe: recipe),
//                       ),
//                     );
//                   } catch (e) {
//                     ScaffoldMessenger.of(context)
//                         .showSnackBar(SnackBar(content: Text(e.toString())));
//                   }
//                 },
//
//                 child: Text("Search Dish",
//                     style:
//                         mediumTextStyle(fontSize: 13.0, color: MyColor.white))),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _removeIngredient(int index) {
//     if (_ingredientControllers.length > 1) {
//       setState(() {
//         _ingredientControllers[index].dispose();
//         _ingredientControllers.removeAt(index);
//       });
//     }
//   }
//
//   Widget addDishManually() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.fromLTRB(15, 38, 15, 15),
//       keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Text(
//                 "Add Ingredients",
//                 style: TextStyle(
//                     fontSize: 15,
//                     fontWeight: FontWeight.w300,
//                     color: MyColor.black),
//               ),
//               hsized15,
//         ListView.separated(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: _ingredientControllers.length,
//           separatorBuilder: (_, __) => const SizedBox(height: 12),
//           itemBuilder: (context, index) {
//             return Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 /// 🔹 TEXT FIELD
//                 Expanded(
//                   child: TextFormField(
//                     controller: _ingredientControllers[index],
//                     decoration: InputDecoration(
//                       labelText: '${index + 1}. Ingredients',
//                       floatingLabelBehavior: FloatingLabelBehavior.always,
//                       hintText: 'Enter Ingredient',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(7),
//                         borderSide: BorderSide(
//                           width: 1,
//                           color: MyColor.kFieldBorderColor,
//                         ),
//                       ),
//                     ),
//                     validator: (value) =>
//                     value != null && value.isNotEmpty ? null : 'Required',
//                   ),
//                 ),
//
//                 /// 🔹 REMOVE BUTTON (except first field)
//                 if (index != 0) ...[
//                   const SizedBox(width: 8),
//                   GestureDetector(
//                     onTap: () => _removeIngredient(index),
//                     child: Icon(
//                       Icons.remove_circle_outline_outlined,
//                       color: Colors.red,
//                       size: 20,
//                     ),
//                   ),
//                 ],
//               ],
//             );
//           },
//         ),
//
//         const SizedBox(height: 16),
//
//               /// 🔹 Add Button
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: TextButton(
//                   onPressed: _addIngredient,
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: const [
//                       Text(
//                         'Add',
//                         style: TextStyle(fontWeight: FontWeight.w600),
//                       ),
//                       SizedBox(width: 4),
//                       Icon(Icons.add, size: 18),
//                     ],
//                   ),
//                 ),
//               ),
//               hsized20,
//               Text(
//                 "Notes",
//                 style: TextStyle(
//                     fontSize: 15,
//                     fontWeight: FontWeight.w300,
//                     color: MyColor.black),
//               ),
//               hsized2,
//               TextFormField(
//                 controller: notes02Controller,
//                 decoration: InputDecoration(
//                   hintText: 'Enter Notes',
//                   hintStyle: TextStyle(
//                       fontWeight: FontWeight.w300,
//                       fontSize: 15,
//                       color: MyColor.color555555),
//                   border: OutlineInputBorder(
//                       borderSide: BorderSide(
//                           width: 1, color: MyColor.kFieldBorderColor),
//                       borderRadius: BorderRadius.circular(7)),
//                 ),
//                 keyboardType: TextInputType.text,
//                 autofillHints: const [AutofillHints.name],
//                 validator: (value) =>
//                     value != null && value.isNotEmpty ? null : 'Required',
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 50,
//           ),
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                     backgroundColor: MyColor.appTheme,
//                     overlayColor: MyColor.liteOrange,
//                     enableFeedback: true,
//                     enabledMouseCursor: MouseCursor.defer,
//                     elevation: 5,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10), // Custom shape
//                     ),
//                     padding: EdgeInsets.zero),
//                 onPressed: () async {
//                   final ingredients = _ingredientControllers
//                       .map((e) => e.text.trim())
//                       .where((e) => e.isNotEmpty)
//                       .toList();
//
//                   if (ingredients.isEmpty) return;
//
//                   try {
//                     final service = AiRecipeService();
//
//                     final recipe = await service.generateFromIngredients(
//                       ingredients: ["Eggs", "Onion", "Tomato"],
//                       notes: "High protein",
//                     );
//
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => DishListScreenBySearch(recipe: recipe),
//                       ),
//                     );
//                   } catch (e) {
//                     ScaffoldMessenger.of(context)
//                         .showSnackBar(SnackBar(content: Text(e.toString())));
//                   }
//                 },
//                 child: Text("Search Dish",
//                     style:
//                         mediumTextStyle(fontSize: 13.0, color: MyColor.white))),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';

import '../ai_recipe_service/ai_recipe_service.dart';
import '../ai_recipe_service/recipe_model.dart';
import '../constant/my_color.dart';
import '../constant/sized_box.dart';
import '../constant/my_fonts_style.dart';
import '../utils/common_widget.dart';
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
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
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
    return
      //   DefaultTabController(
      //   length: 2,
      //   child: CommonScaffold(
      //     appBar: commonAppBar(
      //       context: context,
      //       title: "Search Recipe",
      //       centerTitle: false,
      //     ),
      //     body: Column(
      //       children: [
      //         TabBar(
      //           indicatorColor: MyColor.appTheme,
      //           labelColor: MyColor.appTheme,
      //           unselectedLabelColor: MyColor.black,
      //           tabs: const [
      //             Tab(text: "Search Dish by Image"),
      //             Tab(text: "Search Dish by Ingredients"),
      //           ],
      //         ),
      //         Expanded(
      //           child: TabBarView(
      //             children: [
      //               _buildImageTab(),
      //               _buildIngredientTab(),
      //             ],
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // );
      SafeArea(
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
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                    ),
                    height: 380,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Image.asset(
                        "assets/images/image 500-Photoroom (1) 1.png",
                      ),
                    ),
                  ),
                  // ElevatedButton(
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: Colors.white,
                  //     padding: const EdgeInsets.symmetric(
                  //       horizontal: 16,
                  //       vertical: 12,
                  //     ), // controls button size
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(9),
                  //     ),
                  //   ),
                  //   onPressed: () {
                  //     // Navigator.push(
                  //     //   context,
                  //     //   MaterialPageRoute(
                  //     //     builder: (context) => IngredientsListScreen(),
                  //     //   ),
                  //     // );
                  //   },
                  //   child: Row(
                  //     mainAxisSize: MainAxisSize.min,
                  //     // 👈 makes width fit content
                  //     children: [
                  //       Image.asset(
                  //         "assets/images/add_icon.webp",
                  //         width: 24,
                  //         height: 24,
                  //       ),
                  //       const SizedBox(width: 8), // spacing between icon & text
                  //       Text(
                  //         "Add From List",
                  //         style: TextStyle(
                  //           color: Colors.black,
                  //           fontSize: 14,
                  //           fontWeight: FontWeight.w400,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
              DraggableScrollableSheet(
                minChildSize: 0.7,
                maxChildSize: 0.9,
                initialChildSize: 0.7,
                expand: true,
                builder: (BuildContext context, ScrollController controller) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
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
                        padding: const EdgeInsets.only(right: 5, left: 5, ),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 50,
                                margin: EdgeInsets.all(8),
                                width: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: MyColor.appTheme,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.black,
                                        width: 2
                                    )
                                ),
                                child: SvgPicture.asset(
                                  "assets/images/back-svgrepo-com.svg",
                                  width: 35,
                                  height: 35,
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
                                    Text(
                                      'Add Manually',
                                      style: TextStyle(
                                        color: Colors.black,
                                        // fontFamily: FontFamily.outfitSemiBold,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 24,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    /// Image Picker
                                    // GestureDetector(
                                    //     onTap: () {
                                    //       // _showImageSourcePicker(context);
                                    //     },
                                    //     child: Consumer<AddManuallyProvider>(
                                    //       builder: (context, provider, child) {
                                    //         // Case 1: Local file image selected
                                    //         if (provider.ingredientImageManually != null) {
                                    //           return CircleAvatar(
                                    //             radius: 50,
                                    //             backgroundColor: Colors.grey.shade200,
                                    //             backgroundImage: FileImage(provider.ingredientImageManually!),
                                    //           );
                                    //         }
                                    //
                                    //         // Case 2: Network image available (from API)
                                    //         else if (provider.ingredientImageUrl != null &&
                                    //             provider.ingredientImageUrl!.isNotEmpty) {
                                    //           return CircleAvatar(
                                    //             radius: 50,
                                    //             backgroundColor: Colors.grey.shade200,
                                    //             child: ClipOval(
                                    //               child: AppNetworkImage(
                                    //                 image: provider.ingredientImageUrl,
                                    //                 height: 100,
                                    //                 width: 100,
                                    //                 fit: BoxFit.cover,
                                    //                 placeholder: Center(
                                    //                   child: LoadingAnimationWidget.fourRotatingDots(
                                    //                     color: Colors.grey,
                                    //                     size: 20,
                                    //                   ),
                                    //                 ),
                                    //                 errorWidget: const Icon(
                                    //                   Icons.error,
                                    //                   color: Colors.red,
                                    //                 ),
                                    //               ),
                                    //             ),
                                    //           );
                                    //         }
                                    //
                                    //         // Case 3: Default asset image
                                    //         else {
                                    //           return const CircleAvatar(
                                    //             radius: 50,
                                    //             backgroundColor: Colors.transparent,
                                    //             backgroundImage:
                                    //             AssetImage("assets/images/update_photo_of_ingedient.png"),
                                    //           );
                                    //         }
                                    //       },
                                    //     )
                                    //
                                    // ),

                                    SizedBox(height: 10),

                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Add Ingredients",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: MyColor.black),
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: TextButton(
                                                onPressed: _addIngredient,
                                                style: TextButton.styleFrom(
                                                  side: const BorderSide(
                                                    color: Colors.black, // change color as needed
                                                    width: 1.2,
                                                  ),
                                                  // shape: RoundedRectangleBorder(
                                                  //   borderRadius: BorderRadius.circular(8), // optional
                                                  // ),
                                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                                ),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: const [
                                                    Text(
                                                      'Add',
                                                      style: TextStyle(fontWeight: FontWeight.w600, color: MyColor.appTheme),
                                                    ),
                                                    SizedBox(width: 4),
                                                    Icon(Icons.add, size: 18, color: MyColor.appTheme,),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        ListView.separated(
                                          padding: EdgeInsets.only(top: 20),
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemCount: _ingredientControllers.length,
                                          separatorBuilder: (_, __) => const SizedBox(height: 12),
                                          itemBuilder: (context, index) {
                                            return Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                /// 🔹 TEXT FIELD
                                                Expanded(
                                                  child: TextFormField(
                                                    controller: _ingredientControllers[index],
                                                    decoration: InputDecoration(
                                                      labelText: '${index + 1}. Ingredients',
                                                      floatingLabelBehavior: FloatingLabelBehavior.always,
                                                      hintText: 'Enter Ingredient',
                                                      border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(7),
                                                        borderSide: BorderSide(
                                                          width: 1,
                                                          color: MyColor.kFieldBorderColor,
                                                        ),
                                                      ),
                                                    ),
                                                    validator: (value) =>
                                                    value != null && value.isNotEmpty ? null : 'Required',
                                                  ),
                                                ),

                                                /// 🔹 REMOVE BUTTON (except first field)
                                                if (index != 0) ...[
                                                  const SizedBox(width: 8),
                                                  GestureDetector(
                                                    onTap: () => _removeIngredient(index),
                                                    child: Icon(
                                                      Icons.remove_circle_outline_outlined,
                                                      color: Colors.red,
                                                      size: 20,
                                                    ),
                                                  ),
                                                ],
                                              ],
                                            );
                                          },
                                        ),

                                        const SizedBox(height: 16),

                                        /// 🔹 Add Button

                                        hsized5,
                                        Text(
                                          "Notes",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: MyColor.black),
                                        ),
                                        hsized10,
                                        TextFormField(
                                          controller: notes02Controller,
                                          decoration: InputDecoration(
                                            hintText: 'Enter Notes',
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 15,
                                                color: MyColor.color555555),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1, color: MyColor.kFieldBorderColor),
                                                borderRadius: BorderRadius.circular(7)),
                                          ),
                                          keyboardType: TextInputType.text,
                                          autofillHints: const [AutofillHints.name],
                                          validator: (value) =>
                                          value != null && value.isNotEmpty ? null : 'Required',
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: MyColor.appTheme,
                                              overlayColor: MyColor.liteOrange,
                                              enableFeedback: true,
                                              enabledMouseCursor: MouseCursor.defer,
                                              elevation: 5,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10), // Custom shape
                                              ),
                                              padding: EdgeInsets.zero),
                                          onPressed: () async {
                                            final ingredients = _ingredientControllers
                                                .map((e) => e.text.trim())
                                                .where((e) => e.isNotEmpty)
                                                .toList();

                                            if (ingredients.isEmpty) return;

                                            try {
                                              final service = AiRecipeService();

                                              final recipe = await service.generateFromIngredients(
                                                ingredients: ["Eggs", "Onion", "Tomato"],
                                                notes: "High protein",
                                              );

                                              // Navigator.push(
                                              //   context,
                                              //   MaterialPageRoute(
                                              //     builder: (_) => DishListScreenBySearch(recipe: recipe, recipeNotifier: null,),
                                              //
                                              //   ),
                                              // );
                                            } catch (e) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(content: Text(e.toString())));
                                            }
                                          },
                                          child: Text("Search Dish",
                                              style:
                                              mediumTextStyle(fontSize: 13.0, color: MyColor.white))),
                                    ),

                                    const SizedBox(height: 10),

                                    /// Quantity
                                    // Row(
                                    //   children: [
                                    //     Expanded(
                                    //       flex: 60,
                                    //       child: TextFormField(
                                    //         // controller: quantityController,
                                    //         keyboardType: TextInputType.number,
                                    //         decoration: const InputDecoration(
                                    //           labelText: "Quantity",
                                    //           border: OutlineInputBorder(),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //     const SizedBox(width: 8),
                                    //
                                    //     /// Unit Section
                                    //     // Expanded(
                                    //     //   flex: 40,
                                    //     //   child: Consumer<AddManuallyProvider>(
                                    //     //     builder: (context, provider, _) {
                                    //     //       return DropdownButtonFormField<UnitModel>(
                                    //     //         value: provider.selectedUnitList,
                                    //     //         decoration: const InputDecoration(
                                    //     //           labelText: "Unit",
                                    //     //           border: OutlineInputBorder(),
                                    //     //         ),
                                    //     //         items: provider.unitList.map((unit) {
                                    //     //           return DropdownMenuItem<UnitModel>(
                                    //     //             value: unit,
                                    //     //             child: Text(unit.name.toUpperCase()),
                                    //     //           );
                                    //     //         }).toList(),
                                    //     //         onChanged: provider.unitList.isEmpty
                                    //     //             ? null
                                    //     //             : (value) {
                                    //     //           provider.setSelectedUnit(value);
                                    //     //         },
                                    //     //       );
                                    //     //     },
                                    //     //   ),
                                    //     // ),
                                    //   ],
                                    // ),


                                    const SizedBox(height: 10),

                                    /// Category
                                    // InkWell(
                                    //   onTap: () async {
                                    //     final addProvider = context.read<AddManuallyProvider>();
                                    //
                                    //     // 🔹 Ensure category list is loaded before opening sheet
                                    //     if (addProvider.categoryList.isEmpty && !addProvider.isLoading) {
                                    //       await addProvider.getCategoryListApiResponse();
                                    //     }
                                    //
                                    //     if (!mounted) return;
                                    //
                                    //     final CategoryItem? selected = await showModalBottomSheet<CategoryItem>(
                                    //       context: context,
                                    //       isScrollControlled: true,
                                    //       backgroundColor: Colors.white,
                                    //       shape: const RoundedRectangleBorder(
                                    //         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                                    //       ),
                                    //       builder: (_) {
                                    //         return SizedBox(
                                    //           height: MediaQuery.of(context).size.height * 0.6,
                                    //           child: Consumer<AddManuallyProvider>(
                                    //             builder: (_, provider, __) {
                                    //
                                    //               // 🔹 LOADING STATE
                                    //               if (provider.isLoading && provider.categoryList.isEmpty) {
                                    //                 return const Center(
                                    //                   child: CircularProgressIndicator(),
                                    //                 );
                                    //               }
                                    //
                                    //               // 🔹 EMPTY STATE
                                    //               if (provider.categoryList.isEmpty) {
                                    //                 return const Center(
                                    //                   child: Text(
                                    //                     "No categories found",
                                    //                     style: TextStyle(fontSize: 16),
                                    //                   ),
                                    //                 );
                                    //               }
                                    //
                                    //               return NotificationListener<ScrollNotification>(
                                    //                 onNotification: (scrollInfo) {
                                    //                   if (!provider.isLoading &&
                                    //                       provider.hasMore &&
                                    //                       scrollInfo.metrics.pixels >=
                                    //                           scrollInfo.metrics.maxScrollExtent - 50) {
                                    //                     provider.loadMoreCategories(context);
                                    //                   }
                                    //                   return false;
                                    //                 },
                                    //                 child: ListView.builder(
                                    //                   itemCount: provider.categoryList.length +
                                    //                       (provider.hasMore ? 1 : 0),
                                    //                   itemBuilder: (_, index) {
                                    //
                                    //                     // 🔹 CATEGORY ITEM
                                    //                     if (index < provider.categoryList.length) {
                                    //                       final category = provider.categoryList[index];
                                    //                       return ListTile(
                                    //                         title: Text(category.name),
                                    //                         onTap: () => Navigator.pop(context, category),
                                    //                       );
                                    //                     }
                                    //
                                    //                     // 🔹 PAGINATION LOADER
                                    //                     return const Padding(
                                    //                       padding: EdgeInsets.symmetric(vertical: 16),
                                    //                       child: Center(
                                    //                         child: CircularProgressIndicator(),
                                    //                       ),
                                    //                     );
                                    //                   },
                                    //                 ),
                                    //               );
                                    //             },
                                    //           ),
                                    //         );
                                    //       },
                                    //     );
                                    //
                                    //     // 🔹 APPLY SELECTED CATEGORY
                                    //     if (selected != null) {
                                    //       addProvider.selectedCategory = selected;
                                    //       categoryController.text = selected.name;
                                    //     }
                                    //   },
                                    //
                                    //   // 🔹 DISPLAY FIELD
                                    //   child: AbsorbPointer(
                                    //     child: TextField(
                                    //       controller: categoryController,
                                    //       decoration: const InputDecoration(
                                    //         labelText: "Category",
                                    //         border: OutlineInputBorder(),
                                    //         suffixIcon: Icon(Icons.arrow_drop_down),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),

                                    const SizedBox(height: 10),

                                    /// Calories
                                    // TextField(
                                    //   controller: caloriesController,
                                    //   decoration: const InputDecoration(
                                    //     floatingLabelBehavior:
                                    //     FloatingLabelBehavior.always,
                                    //     labelText: "Calories",
                                    //     hintText: "30 Kcal",
                                    //     hintStyle: TextStyle(
                                    //       fontSize: 15,
                                    //       fontFamily: FontFamily.outfitRegular,
                                    //       color: MyColors.kLightGreyColor,
                                    //     ),
                                    //     border: OutlineInputBorder(),
                                    //   ),
                                    // ),

                                    const SizedBox(height: 10),

                                    /// Expiry Date (DatePicker if empty)
                                    // GestureDetector(
                                    //   onTap: () async {
                                    //     final pickedDate = await showDatePicker(
                                    //       context: context,
                                    //       initialDate: DateTime.now(),
                                    //       firstDate: DateTime.now(),
                                    //       lastDate: DateTime(2100),
                                    //     );
                                    //
                                    //     if (pickedDate != null) {
                                    //       expiryDateController.text =
                                    //       "${pickedDate.day
                                    //           .toString()
                                    //           .padLeft(2, '0')}-${pickedDate.month
                                    //           .toString().padLeft(
                                    //           2, '0')}-${pickedDate.year}";
                                    //     }
                                    //   },
                                    //   child: AbsorbPointer(
                                    //     child: TextField(
                                    //       controller: expiryDateController,
                                    //       decoration: const InputDecoration(
                                    //         floatingLabelBehavior: FloatingLabelBehavior
                                    //             .always,
                                    //         labelText: "Expiry Date",
                                    //         hintText: "DD-MM-YYYY",
                                    //         hintStyle: TextStyle(
                                    //           fontSize: 15,
                                    //           fontFamily: FontFamily
                                    //               .outfitRegular,
                                    //           color: MyColors.kLightGreyColor,
                                    //         ),
                                    //         border: OutlineInputBorder(),
                                    //         suffixIcon: Icon(
                                    //             Icons.calendar_today),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),

                                    SizedBox(height: 10),

                                    /// Submit button
                                    // CustomButton.button(
                                    //   buttonText: widget.isEditing
                                    //       ? "Update Ingredient"
                                    //       : "Add to Pantry",
                                    //   buttonColor: MyColors.kappThemeColor,
                                    //   borderRadius: 15,
                                    //   onTap: () async {
                                    //
                                    //     final provider = context.read<AddManuallyProvider>();
                                    //
                                    //     if (provider.ingredientImageManually == null &&
                                    //         (provider.ingredientImageUrl == null ||
                                    //             provider.ingredientImageUrl!.isEmpty)) {
                                    //       Helper.customToast("Please add image");
                                    //       return;
                                    //     }
                                    //
                                    //     if (_nameController.text.trim().isEmpty) {
                                    //       Helper.customToast("Please enter the ingredient name");
                                    //       return;
                                    //     }
                                    //     if (quantityController.text.trim().isEmpty) {
                                    //       Helper.customToast("Please enter quantity");
                                    //       return;
                                    //     }
                                    //     if (provider.selectedCategory == null && widget.isEditing == false) {
                                    //       Helper.customToast("Please select a category");
                                    //       return;
                                    //     }
                                    //     if (caloriesController.text.trim().isEmpty) {
                                    //       Helper.customToast("Please enter calories");
                                    //       return;
                                    //     }
                                    //     if (expiryDateController.text.trim().isEmpty) {
                                    //       Helper.customToast("Please select expiry date");
                                    //       return;
                                    //     }
                                    //
                                    //     if (widget.isEditing) {
                                    //       final categoryIdToSend =
                                    //           provider.selectedCategory?.id.toString()
                                    //               ?? widget.ingredientData?.categoryId.toString()
                                    //               ?? '';
                                    //
                                    //       final success =
                                    //       await Provider.of<AddManuallyProvider>(context, listen: false)
                                    //           .editIngredientApiResponse(
                                    //         context: context,
                                    //         name: _nameController.text.trim(),
                                    //         quantity: quantityController.text.trim(),
                                    //         categoryId: categoryIdToSend,
                                    //         unit: provider.selectedUnitList?.name ??
                                    //             widget.ingredientData?.unit ??
                                    //             "",
                                    //         expireDate: expiryDateController.text.trim(),
                                    //         type: "Manually",
                                    //         calories: caloriesController.text.trim(),
                                    //         ingredientId: widget.id.toString(),
                                    //         barcode: "",
                                    //       );
                                    //
                                    //       if (success && context.mounted) {
                                    //         Navigator.pop(context, true);
                                    //       }
                                    //     }
                                    //     else {
                                    //       await Provider.of<AddManuallyProvider>(context, listen: false)
                                    //           .addIngredientsManuallyApiResponse(
                                    //         context: context,
                                    //         name: _nameController.text.trim(),
                                    //         quantity: quantityController.text.trim(),
                                    //         categoryId: provider.selectedCategory?.id ?? "",
                                    //         type: "Manually",
                                    //         barcode: "",
                                    //         calories: caloriesController.text.trim(),
                                    //         expireDate: expiryDateController.text.trim(),
                                    //         unit: provider.selectedUnitList?.name ?? "",
                                    //       );
                                    //
                                    //
                                    //       if (context.mounted) {
                                    //         Navigator.pop(context, true);
                                    //       }
                                    //     }
                                    //   },
                                    //   textStyle: TextStyle(
                                    //     color: MyColors.kBackgroundWhiteColor,
                                    //     fontFamily: FontFamily.outfitMedium,
                                    //     fontSize: 16,
                                    //   ),
                                    // ),
                                    SizedBox(height: 20),
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

  // ─────────── IMAGE TAB ───────────
  Widget _buildImageTab() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxHeight = constraints.maxHeight;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => _showImagePickerSheet(context),
                child: DottedBorder(
                  dashPattern: const [6, 3],
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(10),
                  color: MyColor.appTheme,
                  child: Container(
                    height: _selectedImage != null ? maxHeight * 0.5 : 160,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: _selectedImage != null
                          ? DecorationImage(
                          image: FileImage(_selectedImage!),
                          fit: BoxFit.cover)
                          : null,
                    ),
                    alignment: Alignment.center,
                    child: _selectedImage == null
                        ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.add_a_photo),
                        SizedBox(height: 6),
                        Text("Add Image"),
                      ],
                    )
                        : null,
                  ),
                ),
              ),
              hsized20,
              Text(
                "Notes",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: MyColor.black),
              ),
              hsized10,
              TextFormField(
                controller: notes01Controller,
                onTapOutside: (v) {
                  FocusManager.instance.primaryFocus!.unfocus();
                },
                decoration: InputDecoration(
                  hintText: 'Enter Notes',
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                      color: MyColor.color555555),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: MyColor.kFieldBorderColor),
                      borderRadius: BorderRadius.circular(7)),
                ),
                keyboardType: TextInputType.text,
                autofillHints: const [AutofillHints.name],
                validator: (value) =>
                value != null && value.isNotEmpty ? null : 'Required',
              ),
              hsized20,
              _buildButton(
                label: "Search Dish",
                onPressed: _searchByImage,
              ),
            ],
          ),
        );
      },
    );
  }

// --------------------- IMAGE SEARCH ---------------------
  Future<void> _searchByImage() async {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select an image")));
      return;
    }

    setState(() => _isLoading = true);

    // Step 1: Create a ValueNotifier to stream recipes
    final recipeNotifier = ValueNotifier<List<RecipeModel>>([]);

    bool navigated = false;

    try {
      for (int i = 0; i < 5; i++) {
        final recipe = await AiRecipeService().generateRecipeFromImage(
          _selectedImage!,
          "${notes01Controller.text} Please generate a unique version of this dish (#${i + 1})",
        );

        // Step 2: Add recipe to notifier
        recipeNotifier.value = [...recipeNotifier.value, recipe];

        // Step 3: Navigate to the list screen as soon as the first recipe is ready
        if (!navigated) {
          navigated = true;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  DishListScreenBySearch(recipeNotifier: recipeNotifier),
            ),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() => _isLoading = false);
    }
  }

// // --------------------- INGREDIENTS SEARCH ---------------------
//   Future<void> _searchByIngredients() async {
//     final ingredients = _ingredientControllers
//         .map((e) => e.text.trim())
//         .where((e) => e.isNotEmpty)
//         .toList();
//
//     if (ingredients.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please add ingredients")),
//       );
//       return;
//     }
//
//     // 🔁 reset stream
//     recipeStreamNotifier.value = [];
//
//     // 🚀 navigate immediately
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
//       // Generate ONE BY ONE
//       for (int i = 0; i < 5; i++) {
//         final recipe =
//         await AiRecipeService().generateSingleRecipeFromIngredients(
//           ingredients: ingredients,
//           index: i + 1,
//           notes: notes02Controller.text,
//         );
//
//         // 🔥 append immediately
//         recipeStreamNotifier.value = [
//           ...recipeStreamNotifier.value,
//           recipe,
//         ];
//       }
//     } catch (e) {
//       debugPrint(e.toString());
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

  // // ─────────── INGREDIENT TAB ───────────
  // Widget _buildIngredientTab() {
  //   return SingleChildScrollView(
  //     padding: const EdgeInsets.all(15),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           "Add Ingredients",
  //           style: TextStyle(
  //               fontSize: 15,
  //               fontWeight: FontWeight.w600,
  //               color: MyColor.black),
  //         ),
  //         hsized15,
  //         ListView.separated(
  //           shrinkWrap: true,
  //           physics: const NeverScrollableScrollPhysics(),
  //           itemCount: _ingredientControllers.length,
  //           separatorBuilder: (_, __) => const SizedBox(height: 12),
  //           itemBuilder: (context, index) {
  //             return Row(
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 /// 🔹 TEXT FIELD
  //                 Expanded(
  //                   child: TextFormField(
  //                     controller: _ingredientControllers[index],
  //                     decoration: InputDecoration(
  //                       labelText: '${index + 1}. Ingredients',
  //                       floatingLabelBehavior: FloatingLabelBehavior.always,
  //                       hintText: 'Enter Ingredient',
  //                       border: OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(7),
  //                         borderSide: BorderSide(
  //                           width: 1,
  //                           color: MyColor.kFieldBorderColor,
  //                         ),
  //                       ),
  //                     ),
  //                     validator: (value) =>
  //                     value != null && value.isNotEmpty ? null : 'Required',
  //                   ),
  //                 ),
  //
  //                 /// 🔹 REMOVE BUTTON (except first field)
  //                 if (index != 0) ...[
  //                   const SizedBox(width: 8),
  //                   GestureDetector(
  //                     onTap: () => _removeIngredient(index),
  //                     child: Icon(
  //                       Icons.remove_circle_outline_outlined,
  //                       color: Colors.red,
  //                       size: 20,
  //                     ),
  //                   ),
  //                 ],
  //               ],
  //             );
  //           },
  //         ),
  //
  //         const SizedBox(height: 16),
  //
  //         /// 🔹 Add Button
  //         Align(
  //           alignment: Alignment.centerRight,
  //           child: TextButton(
  //             onPressed: _addIngredient,
  //             child: Row(
  //               mainAxisSize: MainAxisSize.min,
  //               children: const [
  //                 Text(
  //                   'Add',
  //                   style: TextStyle(fontWeight: FontWeight.w600),
  //                 ),
  //                 SizedBox(width: 4),
  //                 Icon(Icons.add, size: 18),
  //               ],
  //             ),
  //           ),
  //         ),
  //         hsized20,
  //         Text(
  //           "Notes",
  //           style: TextStyle(
  //               fontSize: 15,
  //               fontWeight: FontWeight.w600,
  //               color: MyColor.black),
  //         ),
  //         hsized10,
  //         TextFormField(
  //           controller: notes02Controller,
  //           onTapOutside: (v) {
  //             FocusManager.instance.primaryFocus!.unfocus();
  //           },
  //           decoration: InputDecoration(
  //             hintText: 'Enter Notes',
  //             hintStyle: TextStyle(
  //                 fontWeight: FontWeight.w300,
  //                 fontSize: 15,
  //                 color: MyColor.color555555),
  //             border: OutlineInputBorder(
  //                 borderSide:
  //                 BorderSide(width: 1, color: MyColor.kFieldBorderColor),
  //                 borderRadius: BorderRadius.circular(7)),
  //           ),
  //           keyboardType: TextInputType.text,
  //           autofillHints: const [AutofillHints.name],
  //           validator: (value) =>
  //           value != null && value.isNotEmpty ? null : 'Required',
  //         ),
  //         hsized20,
  //         _buildButton(label: "Search Dish", onPressed: _searchByIngredients),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildButton(
      {required String label, required VoidCallback onPressed}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColor.appTheme,
          overlayColor: MyColor.liteOrange,
          elevation: 5,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.zero,
        ),
        child: _isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(label, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}
