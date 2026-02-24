// import 'dart:io';
// import 'package:cooking_champs/constant/assets_path.dart';
// import 'package:cooking_champs/constant/dimen.dart';
// import 'package:cooking_champs/constant/my_color.dart';
// import 'package:cooking_champs/constant/my_fonts_style.dart';
// import 'package:cooking_champs/constant/sized_box.dart';
// import 'package:cooking_champs/constant/stringfile.dart/language.dart';
// import 'package:cooking_champs/model/dynamic_models/recipe_model.dart';
// import 'package:cooking_champs/model/dynamic_models/recipe_tools_model.dart';
// import 'package:cooking_champs/model/post_model/add_recipe_request.dart';
// import 'package:cooking_champs/services/api_services.dart';
// import 'package:cooking_champs/utils/all_dialogs.dart';
// import 'package:cooking_champs/utils/ui_utils.dart';
// import 'package:cooking_champs/utils/utility.dart';
// import 'package:cooking_champs/widgets/global_button.dart';
// import 'package:cooking_champs/widgets/image_picker_dialog.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:touch_ripple_effect/touch_ripple_effect.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
//
// import '../services/api_path.dart';
//
// class AddYourRecipeView extends StatefulWidget {
//   final Function onCallBack;
//   final bool?  onCallScreen;
//   final String?  recipeId;
//   final String?  recipevideolink;
//   const AddYourRecipeView({super.key,required this.onCallBack,this.onCallScreen,this.recipeId,this.recipevideolink});
//
//   @override
//   State<AddYourRecipeView> createState() => _AddYourRecipeViewState();
// }
//
// class _AddYourRecipeViewState extends State<AddYourRecipeView> {
//   TextEditingController recipeNameController = TextEditingController();
//   TextEditingController recipevideolinkController = TextEditingController();
//   TextEditingController ingredientsController = TextEditingController();
//   TextEditingController cookController = TextEditingController();
//
//   List<RecipeToolsModel> recipeToolsList = [];
//   List<RecipeModel> recipeList = [];
//
//   List<XFile> imageFileList = [];
//   List cookList = [];
//   List ingredientsList = [];
//   List<String> selectedRecipeToolsList = [];
//   List<String> selectedItems = [];
//   File? selectedImage;
//
//   dynamic image;
//   dynamic isFocusColor = '';
//
//   bool isTools = false;
//   bool isUpdateIngredients = false;
//   bool isUpdateCook = false;
//   int ingredientsIndex = 0;
//   int cookIndex = 0;
//
//
//
//   // Maximum number of selections allowed
//   final int maxSelection = 3;
//
//   @override
//   void initState() {
//     super.initState();selectedRecipeToolsList.clear();
//     recipevideolinkController.text = widget.recipevideolink??"";
//     Future.delayed(Duration.zero, () {
//       getRecipeTools(true);
//       widget.onCallScreen == true?editRecipe(true):null;
//
//     });
//     if (widget.onCallScreen == true) {
//       // Trigger callback safely after build
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         widget.onCallBack();
//       });
//     }
//     cookList.clear();
//     ingredientsList.clear();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         leadingWidth: 50,
//         automaticallyImplyLeading: false,
//         backgroundColor: MyColor.yellowF6F1E1,
//         surfaceTintColor: MyColor.yellowF6F1E1,
//         leading: InkWell(
//           borderRadius: BorderRadius.circular(30),
//           radius: 80,
//           onTap: () {
//             Navigator.pop(context);
//           //  widget.onCallBack();
//           },
//           child: Padding(
//             padding: const EdgeInsets.only(left: 20.0),
//             child: const Icon(
//               Icons.arrow_back_ios,
//               size: 28,
//               color: Colors.black,
//             ),
//           ),
//         ),
//         title: Text( widget.onCallScreen == true?Languages.of(context)!.editYourRecipe: Languages.of(context)!.addYourRecipe,
//             style: mediumTextStyle(fontSize: 18.0, color: MyColor.black)),
//         centerTitle: false,
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.only(bottom: 15, top: 15),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(widget.onCallScreen == true?Languages.of(context)!.editYourRecentCookingMoments:  Languages.of(context)!.addYourRecentCookingMoments,
//                         style: mediumTextStyle(
//                             fontSize: 18.0, color: MyColor.black)),
//                     Text(
//                         Languages.of(context)!
//                             .openyourphotogallerytorecentrecipe,
//                         style: regularNormalTextStyle(fontSize: 14.0, color: MyColor.black)),
//                     hsized30,
//                     imgUi(size),
//                     hsized30,
//                     Text(Languages.of(context)!.recipeName,
//                         style: regularTextStyle(
//                             fontSize: 15.0, color: MyColor.black)),
//                     hsized10,
//                     commonTextField(
//                         recipeNameController,
//                         Languages.of(context)!
//                             .enterTheNameIfYourRecipe
//                             .toString(),
//                         TextInputAction.done,
//                         TextInputType.text,
//                         "Recipe Name",
//                         2,
//                         1),
//                   ],
//                 ),
//               ),
//
//               hsized10,
//               UiUtils.dividerLine(),
//
//               Padding(
//                 padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     hsized20,
//                     Text(Languages.of(context)!.toolsUsed,
//                         style: regularTextStyle(
//                             fontSize: 15.0, color: MyColor.black)),
//                     hsized15,
//                     Center(
//                       child: DropdownButtonHideUnderline(
//                         child: DropdownButton2(
//                           isExpanded: true,
//                           // Ensure dropdown occupies full width
//                           hint: Text(
//                             selectedItems.isEmpty ? "Select Tools" : selectedItems.join(', '),
//                             style: regularTextStyle(fontSize: 14.0, color: selectedItems.isEmpty ? MyColor.grayLite1 : MyColor.appTheme),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                           items: recipeToolsList.map((tool) {
//                             return DropdownMenuItem(
//                               value: tool.toolName ?? "",
//                               child: StatefulBuilder(
//                                 builder: (
//                                   context,
//                                   menuSetState,
//                                 ) {
//                                   final isSelected = selectedItems
//                                       .contains(tool.toolName ?? "");
//
//                                   return Wrap(
//                                     children: [
//                                       ListTile(
//                                         minTileHeight: 30,
//                                         contentPadding: EdgeInsets.zero,
//                                         title: SizedBox(
//                                           height: 20,
//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Transform.scale(
//                                                 scale: 1.5,
//                                                 // Scale to make the checkbox larger
//                                                 child: Checkbox(
//                                                   shape: const CircleBorder(
//                                                     side: BorderSide.none,
//                                                   ),
//                                                   value: isSelected,
//                                                   activeColor: Colors.white,
//                                                   checkColor: MyColor.appTheme,
//                                                   fillColor:
//                                                       MaterialStateProperty.all(
//                                                           Colors.transparent),
//                                                   side: MaterialStateBorderSide
//                                                       .resolveWith(
//                                                     (states) =>
//                                                         const BorderSide(
//                                                       color: MyColor.appTheme,
//                                                       width: 1,
//                                                     ),
//                                                   ),
//                                                   onChanged: (value) {
//                                                     menuSetState(() {
//                                                       if (value == true) {
//                                                         selectedItems.add(tool.toolName ?? "");
//                                                         selectedRecipeToolsList.add(tool.id.toString());
//                                                       } else if (value == false) {
//                                                         selectedItems.remove(tool.toolName ?? "");
//                                                         selectedRecipeToolsList.remove(tool.id.toString());
//                                                       }
//                                                     });
//                                                   },
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                 child: Text(tool.toolName ?? "",
//                                                     style: mediumTextStyle(
//                                                         fontSize: 14.0,
//                                                         color:
//                                                             MyColor.appTheme)),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                       hsized10,
//                                     ],
//                                   );
//                                 },
//                               ),
//                             );
//                           }).toList(),
//                           value: null,
//                           // Leave value null for multiple selections
//                           onMenuStateChange: (isOpen) {
//                             setState(() {
//                               isTools = isOpen;
//                               isFocusColor = "dropdwon";
//                             });
//                           },
//
//                           onChanged: (value) {
//                             isFocusColor = "dropdwon";
//                             setState(() {
//                             //
//                             // if (selectedItems.contains(value) == false) {
//                             //   selectedItems.add(value!);
//                             // } else {
//                             //     selectedItems.remove(value);
//                             // }
//                           });
//                           },
//                           // No action needed here
//                           buttonStyleData: ButtonStyleData(
//                             height: 52,
//                             width: size.width * 0.95,
//                             // Ensure button is wide
//                             padding: const EdgeInsets.only(left: 14, right: 14),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               color: Colors.transparent,
//                               border: Border.all(
//                                   color: isFocusColor == "dropdwon" ? MyColor.liteOrange : MyColor.grayLite),
//                             ),
//                             elevation: 0,
//                           ),
//                           iconStyleData: IconStyleData(
//                             icon: isTools == true
//                                 ? const Icon(Icons.arrow_drop_up_sharp)
//                                 : const Icon(Icons.arrow_drop_down),
//                             iconSize: 20,
//                             iconEnabledColor: MyColor.appTheme,
//                             iconDisabledColor: MyColor.grayLite,
//                           ),
//                           dropdownStyleData: DropdownStyleData(
//                             maxHeight: 250,
//                             width: size.width * 0.93,
//                             // Set dropdown width
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(14),
//                               color: MyColor.white,
//                               border: Border.all(color: MyColor.grayLite),
//                             ),
//                             offset: const Offset(0, 0),
//                             scrollbarTheme: ScrollbarThemeData(
//                               radius: const Radius.circular(20),
//                               thickness: WidgetStateProperty.all<double>(6),
//                               thumbVisibility:
//                                   WidgetStateProperty.all<bool>(true),
//                             ),
//                           ),
//                           menuItemStyleData: const MenuItemStyleData(
//                             height: 40,
//                             padding: EdgeInsets.only(left: 1, right: 1),
//                           ),
//                         ),
//                       ),
//                     ),
//                     hsized10,
//                   ],
//                 ),
//               ),
//
//               UiUtils.dividerLine(),
//               Padding(
//                 padding: const EdgeInsets.only(
//                     left: 15, right: 15, bottom: 10, top: 15),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(Languages.of(context)!.ingredients,
//                             style: regularTextStyle(
//                                 fontSize: 15.0, color: MyColor.black)),
//                         InkWell(
//                           onTap: () {
//                             setState(() {
//                               if( ingredientsController.text.trim().isNotEmpty && ingredientsList.contains(ingredientsController.text.trim()) == false){
//                                 if(!isUpdateIngredients) {
//                                   ingredientsList.add(ingredientsController.text.trim());
//                                 }else{
//                                   ingredientsList[ingredientsIndex] = ingredientsController.text.trim(); // Replace the item at the specified index with a new value
//                                 }
//                               }
//                               isUpdateIngredients = false;
//                               ingredientsController.clear();
//                             });
//                           },
//                           child: Text(!isUpdateIngredients?"${Languages.of(context)!.add}+":Languages.of(context)!.update,
//                               style: regularTextStyle(
//                                   fontSize: 14.0, color: MyColor.appTheme)),
//                         ),
//                       ],
//                     ),
//                     hsized15,
//
//                     commonTextField(
//                         ingredientsController,
//                         Languages.of(context)!.enterIngredients.toString(),
//                         TextInputAction.done,
//                         TextInputType.text,
//                         "ingredients",
//                         10,
//                         3),
//
//                     Padding(
//                       padding: const EdgeInsets.only(top:0.0, left: 0, right: 15, bottom:10),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           ListView.builder(
//                             padding: const EdgeInsets.only(top: 08),
//                             itemCount: ingredientsList.length,
//                             shrinkWrap: true,
//                             physics: const NeverScrollableScrollPhysics(),
//                             itemBuilder: (context, index) {
//                               return Padding(
//                                 padding: const EdgeInsets.only(top: 8),
//                                 child: Row(
//                                   children: [
//                                     Expanded(
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           Image.asset(
//                                               height: 19, width: 20, AssetsPath.dots),
//                                           Expanded(
//                                             child: Text(
//                                               ingredientsList[index],
//                                               style: regularTextStyle(fontSize: 14.0, color:MyColor.black)
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//
//                                     Row(
//                                       children: [
//                                         InkWell(
//                                           onTap: (){
//                                             ingredientsIndex = index;
//                                             setState(() {});
//                                             AllDialogs.globalBottomSheet(context,UpdateDeletePopup(onUpdate:onUpdateDeleteIngredient, text:ingredientsList[index], title: 'Ingredients',),(){});
//                                           },
//                                           child:  Icon(Icons.more_vert,color: MyColor.black,size: 18,)
//                                         ),
//
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               );
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
// //              hsized15,
//
//               UiUtils.dividerLine(),
//
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 15,
//                   vertical: 15,
//                 ),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(Languages.of(context)!.howtoCook,
//                             style: regularTextStyle(
//                                 fontSize: 13.0, color: MyColor.black)),
//                         InkWell(
//                           onTap: () {
//                             if (cookController.text.trim().isNotEmpty && cookList.contains(cookController.text.trim()) == false && !isUpdateCook) {
//                             cookList.add(cookController.text.trim());
//                             }else{
//                               cookList[cookIndex] = cookController.text.trim();
//                             }
//                             isUpdateCook = false;
//                             cookController.clear();
//                             setState(() {});
//                           },
//                           child: Text(!isUpdateCook?"${Languages.of(context)!.add}+":Languages.of(context)!.update,
//                               style: regularTextStyle(
//                                   fontSize: 14.0, color: MyColor.appTheme)),
//                         ),
//                       ],
//                     ),
//                     hsized15,
//                     commonTextField(
//                         cookController,
//                         Languages.of(context)!.enterCookYourRecipe.toString(),
//                         TextInputAction.done,
//                         TextInputType.text,
//                         "cook",
//                         10,
//                         3),
//                     Padding(
//                       padding: const EdgeInsets.only(
//                           top: 10.0, right: 15, bottom: 0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           ListView.builder(
//                             padding: const EdgeInsets.only(top: 08),
//                             itemCount: cookList.length,
//                             shrinkWrap: true,
//                             physics: const NeverScrollableScrollPhysics(),
//                             itemBuilder: (context, index) {
//                               return Padding(
//                                 padding: const EdgeInsets.only(top: 8),
//                                 child: Row(
//                                   children: [
//                                     Expanded(
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           Text("Step ${(index + 1)} - ",
//                                               style: regularTextStyle(
//                                                   fontSize: 14.0,
//                                                   color: MyColor.appTheme)),
//                                           Expanded(
//                                             child: Text(cookList[index],
//                                                 style: regularTextStyle(
//                                                     fontSize: 14.0,
//                                                     color: MyColor.appTheme)),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                     InkWell(
//                                         onTap: (){
//                                           cookIndex = index;
//                                           setState(() {});
//                                           AllDialogs.globalBottomSheet(context,UpdateDeletePopup(onUpdate:onUpdateDeleteCook, text:cookList[index], title: 'How to cook',),(){});
//                                         },
//                                         child:  Icon(Icons.more_vert,color: MyColor.black,size: 18,)
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               UiUtils.dividerLine(),
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 15,
//                   vertical: 15,
//                 ),
//                 child: Column(children: [
//                   hsized10,
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         child: Text(Languages.of(context)!.recepividocontant,
//                             maxLines: 2,
//                             style: regularTextStyle(
//                                 fontSize: 15.0, color: MyColor.black)),
//                       ),
//                     ],
//                   ),
//
//                   hsized10,
//                   commonTextField(
//                       recipevideolinkController,
//                       Languages.of(context)!
//                           .enterTheNameIfYourvideolink
//                           .toString(),
//                       TextInputAction.done,
//                       TextInputType.text,
//                       "Recipe Name",
//                       2,
//                       1),
//                   hsized15,],),
//               ),
//
//
//               Padding(
//                 padding:
//                     const EdgeInsets.only(left: 20.0, right: 20, bottom: 10),
//                 child: GlobalButton(
//                     widget.onCallScreen == true?Languages.of(context)!.edit:    Languages.of(context)!.add.toString(),
//                     MyColor.appTheme,
//                     MyColor.appTheme,
//                     btnSize55,
//                     double.infinity,
//                     checkValidation,
//                     55,
//                     5,
//                     0,
//                     mediumTextStyle(fontSize: 15.0, color: MyColor.white)),
//               ),
//
//               hsized30,
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   onCallBackImage(dynamic file) {
//     setState(() {
//       selectedImage = File(file.path);
//       image = file;
//     });
//   }
//
//   imgUi(var size) {
//     return DottedBorder(
//         color: MyColor.liteGray,
//         strokeWidth: 2,
//         borderType: BorderType.RRect,
//         radius: const Radius.circular(10),
//         dashPattern: selectedImage != null ? [200, 0] : const [04, 5],
//         child: TouchRippleEffect(
//           backgroundColor: Colors.transparent,
//           borderRadius: BorderRadius.circular(10),
//           rippleColor: MyColor.appTheme.withOpacity(0.8),
//           onTap: () {
//             AllDialogs.globalBottomSheet(context, ImagePickerDialog(onCallBack: onCallBackImage, cropStyle: "rectangle"), () {});
//           },
//           child:
//           selectedImage != null
//               ? Container(
//                   height: size.height * 0.19,
//                   width: size.width,
//                   decoration: const BoxDecoration(
//                     color: MyColor.yellowF6F1E1,
//                   ),
//                   child: Stack(
//                     alignment: Alignment.topRight,
//                     children: [
//                       Image.file(
//                         selectedImage!,
//                         fit: BoxFit.cover,
//                           width: size.width
//                       ),
//                       InkWell(
//                         onTap: (){
//                           setState(() {
//                             selectedImage = null;
//                           });
//                         },
//                         child: Icon(Icons.cancel,color: MyColor.red,),
//                       )
//                     ],
//                   ),
//                 )
//               :
//           recipeModel.bannerImage == null?
//           Container(
//                   // margin: const EdgeInsets.all(2),
//                   height: size.height * 0.19,
//                   width: size.width * 0.90,
//                   decoration: const BoxDecoration(
//                     color: MyColor.yellowF6F1E1,
//                   ),
//                   child: Center(
//                       child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Image.asset(width: 35, height: 35, AssetsPath.addimage),
//                       Text(Languages.of(context)!.addImage,
//                           style: mediumTextStyle(
//                               fontSize: 12.0, color: MyColor.appTheme)),
//                     ],
//                   )))
//                 :  Container(
//           // margin: const EdgeInsets.all(2),
//           height: size.height * 0.19,
//           width: size.width * 0.90,
//           decoration: const BoxDecoration(
//             color: MyColor.yellowF6F1E1,
//           ),
//           child:Image.network(ApiPath.imageBaseUrl+recipeModel!.bannerImage!,  fit: BoxFit.cover,
//               width: size.width)),
//         ));
//   }
//
//   commonTextField(
//       TextEditingController controller,
//       String labelText,
//       TextInputAction textInputAction,
//       TextInputType textInputType,
//       String type,
//       int maxLines,
//       int minLine) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(
//             color:
//                 isFocusColor == type ? MyColor.liteOrange : MyColor.grayLite),
//         color: MyColor.white,
//         borderRadius: const BorderRadius.all(Radius.circular(12)),
//       ),
//       alignment: Alignment.center,
//       padding: const EdgeInsets.fromLTRB(12, 5, 0, 15),
//       child: TextField(
//         textCapitalization: TextCapitalization.sentences,
//         onTap: () {
//           if (mounted) {
//             setState(() {
//               isFocusColor = type;
//             });
//           }
//         },
//         buildCounter: (BuildContext context,
//                 {required int currentLength,
//                 int? maxLength,
//                 required bool isFocused}) =>
//             null,
//         controller: controller,
//         onTapOutside: (v) {
//           FocusManager.instance.primaryFocus!.unfocus();
//         },
//         textInputAction: textInputAction,
//         keyboardType: textInputType,
//         style: regularTextStyle(fontSize: 14.0, color: MyColor.black),
//         decoration: InputDecoration(
//           border: InputBorder.none,
//           hintText: labelText,
//           hintStyle: regularTextStyle(fontSize: 14.0, color: MyColor.grayLite1),
//           counter: const Offstage(),
//           isDense: true,
//           // this will remove the default content padding
//           contentPadding: const EdgeInsets.only(
//             top: 10,
//           ),
//         ),
//         maxLines: maxLines,
//         minLines: minLine,
//         cursorColor: MyColor.black,
//       ),
//     );
//   }
//
//   void addOnTap() {}
//
//   getRecipeTools(bool load) async {
//     await ApiServices.getRecipeTools(context, load).then((onValue) {
//       if (mounted) {
//         setState(() {
//           if (onValue.status == true) {
//             if (onValue.data != null) {
//               var recipe = onValue.data as List<dynamic>? ?? [];
//               recipeToolsList
//                   .addAll(recipe.map((r) => RecipeToolsModel.fromJson(r)));
//             }
//           }
//         });
//       }
//     });
//   }
//   getRecipedetials(bool load) async {
//     await ApiServices.getRecipeTools(context, load).then((onValue) {
//       if (mounted) {
//         setState(() {
//           if (onValue.status == true) {
//             if (onValue.data != null) {
//               var recipe = onValue.data as List<dynamic>? ?? [];
//               recipeToolsList
//                   .addAll(recipe.map((r) => RecipeToolsModel.fromJson(r)));
//             }
//           }
//         });
//       }
//     });
//   }
//   // editrecipe
//
//   checkValidation()async{
//     print("widget.recipeId>>>>>>>${widget.recipeId??"23"}");
//     print("recipeNameController.text.trim()>>>>${recipeNameController.text.trim()}");
//     print("selectedRecipeToolsList>>>>>>${selectedRecipeToolsList.length}");
//     print("ingredientsList>>>>>${ingredientsList.length}");
//     print("cookList>>>>>>${cookList.length}");
//     if(recipeNameController.text.trim().isEmpty){
//       Utility.customToast(context, "Please enter recipe name");
//     }
//     else if(selectedRecipeToolsList.isEmpty){
//       Utility.customToast(context, "Please select recipe tools");
//     }else if(ingredientsList.isEmpty){
//       Utility.customToast(context, "Please select ingredient");
//     }else if(cookList.isEmpty){
//       Utility.customToast(context, "Please enter how to cook step");
//     }else{
//
//       // print("widget.recipeId>>>>>>>${widget.recipeId}");
//       // print("recipeNameController.text.trim()>>>>${recipeNameController.text.trim()}");
//       // print("selectedRecipeToolsList>>>>>>${selectedRecipeToolsList.length}");
//       // print("ingredientsList>>>>>${ingredientsList.length}");
//       // print("cookList>>>>>>${cookList.length}");
//
//       widget.onCallScreen == true?editRecipe(false):  Future.delayed(Duration.zero,addRecipe);
//
//
//     }
//   }
//
// addRecipe()async{
//     AddRecipeRequest addRecipeRequest = AddRecipeRequest(
//       recipeName:recipeNameController.text.trim(),
//       recipeTools: selectedRecipeToolsList.join(', '),
//       ingredients:ingredientsList.join(', '),
//        recipeSteps:cookList.join(', '),
//       recipeVideolink: recipevideolinkController.text ??"",
//     );
//     await ApiServices.addRecipe(context, addRecipeRequest, image).then((onValue){
//       if(mounted){
//         setState(() {
//
//           if(onValue.status == true){
//               var data = RecipeModel.fromJson(onValue.data);
//             Navigator.pop(context);
//             widget.onCallBack(data);
//           }
//
//         });
//       }
//     });
// }
//   RecipeModel recipeModel = RecipeModel();
//   editRecipe(bool check)async{
//     print("recipevideolinkController.text>>>>>>>${recipevideolinkController.text}");
//     print("check>>>>>>>${check}");
//     print("widget.recipeId>>>>>>>${widget.recipeId}");
//     print("recipeNameController.text.trim()>>>>${recipeNameController.text.trim()}");
//     print("selectedRecipeToolsList>>>>>>${selectedRecipeToolsList}");
//     print("ingredientsList>>>>>${ingredientsList}");
//     print("cookList>>>>>>${cookList}");
//     AddRecipeRequest addRecipeRequest = AddRecipeRequest(
//
//       recipeId: widget.recipeId??"23",
//       recipeName: recipeNameController.text.trim().isNotEmpty
//           ? recipeNameController.text.trim()
//           : "",
//     recipeTools: (selectedRecipeToolsList.isNotEmpty)
//     ? selectedRecipeToolsList.join(', ')
//         : "",
//     ingredients: (ingredientsList.isNotEmpty)
//     ? ingredientsList.join(', ')
//         : "",
//     recipeSteps: (cookList.isNotEmpty)
//     ? cookList.join(', ')
//         : "",
//       recipeVideolink: recipevideolinkController.text ,
//     );
//     await ApiServices.editRecipe(context, addRecipeRequest, image).then((onValue){
//       if (  mounted){
//         setState(() {
// print("onValue>>111>>>${onValue}");
//           if(onValue.status == true){
//             print("onValue>>111>111>>${onValue.data['video_link']}");
//             recipeModel = RecipeModel.fromJson(onValue.data);
//             print("recipeModel.videolink.toString()>>>>>>>${recipeModel.videolink.toString()}");
//        if(check  ==  true )     {
//               // selectedItems.join(', ')
// recipevideolinkController.text =recipeModel.videolink.toString();
//          recipeNameController.text = recipeModel.name?.toString() ?? "";
//          for (int i = 0; i < recipeModel.recipeTools!.length; i++) {
//            selectedRecipeToolsList.add( recipeModel.recipeTools![i].id.toString());
//          }
//
//
//
//            for (int i = 0; i < recipeModel.recipeTools!.length; i++) {
//              selectedItems.add( recipeModel.recipeTools![i].toolName.toString());
//            }
//
//
//
//            for (int i = 0; i < recipeModel.recipeIngredient!.length; i++) {
//              ingredientsList.add(recipeModel.recipeIngredient![i].name?.toString() ?? "");
//              print("ingredientsList>>>>>>$i>>>>>>>>${recipeModel.recipeIngredient![i].name}");
//            }
//
//
//
//            for (int i = 0; i < recipeModel.recipeSteps!.length; i++) {
//              cookList.add(recipeModel.recipeSteps![i].name?.toString() ?? "");
//            }
//
//
//        }
//
//        if (widget.onCallScreen == true) {
//               // Trigger callback safely after build
//               WidgetsBinding.instance.addPostFrameCallback((_) {
//                 widget.onCallBack();
//               });
//             }
//             setState(() {
//
//              });
//              // ingredientsList
//
//             check ==false?  Navigator.pop(context):null;
//             // widget.onCallBack(data);
//           }
//
//         });
//       }
//     });
//   }
//   // editRecipe
// onUpdateDeleteIngredient(String type){
//   setState(() {
//   if(type == "Delete"){
//     ingredientsList.removeAt(ingredientsIndex);
//   }else{
//     isUpdateIngredients = true;
//       ingredientsController.text = ingredientsList[ingredientsIndex];
//   }
//   });
// }
//
//   onUpdateDeleteCook(String type){
//     setState(() {
//       if(type == "Delete"){
//         cookList.removeAt(cookIndex);
//       }else{
//         isUpdateCook = true;
//         cookController.text = cookList[cookIndex];
//       }
//     });
//   }
//
// }
//
// class UpdateDeletePopup extends StatelessWidget {
//   final Function onUpdate;
//   final String text;
//   final String title;
//   const UpdateDeletePopup({super.key,required this.onUpdate,required this.text,required this.title});
//
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       backgroundColor: Colors.transparent,
//       bottomSheet: Wrap(
//         children: [
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Column(
//               children: [
//                 Align(
//                   alignment: Alignment.topRight,
//                   child:  InkWell(
//                       onTap: (){
//                         Navigator.pop(context);
//                       },
//                       child: Padding(
//                         padding: const EdgeInsets.only(right:10.0,top: 5),
//                         child: Icon(Icons.clear,color: MyColor.liteGray,size: 30,),
//                       )
//                   ),
//                 ),
//                 SizedBox(height: 15),
//                 Text(title,style:mediumTextStyle(fontSize:18.0, color:MyColor.black),),
//                 hsized5,
//                 Text(text,style:mediumTextStyle(fontSize:16.0, color:MyColor.black),),
//                 hsized30,
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     InkWell(
//                         onTap: (){
//                           Navigator.pop(context);
//                           onUpdate("Delete");
//                         },
//                         child:  Container(
//                             padding: EdgeInsets.symmetric(horizontal:25,vertical:8),
//                             decoration: BoxDecoration(
//                                 color: MyColor.red,
//                                 borderRadius: BorderRadius.circular(8)
//                             ),
//                             child: Text("Delete",style:mediumTextStyle(fontSize:15.0, color:MyColor.white),))
//                     ),
//
//                     SizedBox(width: 10),
//                     InkWell(
//                         onTap: (){
//                          Navigator.pop(context);
//                          onUpdate("Edit");
//                         },
//                         child: Container(
//                             padding: EdgeInsets.symmetric(horizontal:25,vertical:8),
//                             decoration: BoxDecoration(
//                                 color: MyColor.appTheme,
//                                 borderRadius: BorderRadius.circular(8)
//                             ),
//                             child: Text("Edit",style:mediumTextStyle(fontSize:15.0, color:MyColor.white),))
//                       //Icon(Icons.edit,color: MyColor.red,size: 18,),
//                     )
//                   ],
//                 ),
//                 hsized30,
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }


import 'dart:io';
import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/dimen.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/constant/stringfile.dart/language.dart';
import 'package:cooking_champs/model/dynamic_models/recipe_model.dart';
import 'package:cooking_champs/model/dynamic_models/recipe_tools_model.dart';
import 'package:cooking_champs/model/post_model/add_recipe_request.dart';
import 'package:cooking_champs/services/api_services.dart';
import 'package:cooking_champs/utils/all_dialogs.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:cooking_champs/utils/utility.dart';
import 'package:cooking_champs/widgets/global_button.dart';
import 'package:cooking_champs/widgets/image_picker_dialog.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../services/api_path.dart';

class AddYourRecipeView extends StatefulWidget {
  final Function onCallBack;
  final bool?  onCallScreen;
  final String?  recipeId;
  final String?  recipevideolink;
  const AddYourRecipeView({super.key,required this.onCallBack,this.onCallScreen,this.recipeId,this.recipevideolink});

  @override
  State<AddYourRecipeView> createState() => _AddYourRecipeViewState();
}

class _AddYourRecipeViewState extends State<AddYourRecipeView> {
  TextEditingController recipeNameController = TextEditingController();
  TextEditingController recipevideolinkController = TextEditingController();
  TextEditingController ingredientsController = TextEditingController();
  TextEditingController cookController = TextEditingController();

  List<RecipeToolsModel> recipeToolsList = [];
  List<RecipeModel> recipeList = [];

  List<XFile> imageFileList = [];
  List cookList = [];
  List ingredientsList = [];
  List<String> selectedRecipeToolsList = [];
  List<String> selectedItems = [];
  File? selectedImage;

  dynamic image;
  dynamic isFocusColor = '';

  bool isTools = false;
  bool isUpdateIngredients = false;
  bool isUpdateCook = false;
  int ingredientsIndex = 0;
  int cookIndex = 0;

  final int maxSelection = 3;

  @override
  void initState() {
    super.initState();
    selectedRecipeToolsList.clear();
    recipevideolinkController.text = widget.recipevideolink??"";
    Future.delayed(Duration.zero, () {
      getRecipeTools(true);
      widget.onCallScreen == true?editRecipe(true):null;
    });
    if (widget.onCallScreen == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onCallBack();
      });
    }
    cookList.clear();
    ingredientsList.clear();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    bool isIpad = size.width > 600; // iPad detection

    return Scaffold(
      appBar: AppBar(
        leadingWidth: isIpad ? 60.0 : 50.0,
        toolbarHeight: isIpad ? 70:40,
        automaticallyImplyLeading: false,
        backgroundColor: MyColor.yellowF6F1E1,
        surfaceTintColor: MyColor.yellowF6F1E1,
        leading: InkWell(
          borderRadius: BorderRadius.circular(isIpad ? 40.0 : 30.0),
          radius: isIpad ? 80.0 : 60.0,
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.only(left: isIpad ? 25.0 : 20.0),
            child: Icon(
              Icons.arrow_back_ios,
              size: isIpad ? 36.0 : 30.0,
              color: Colors.black,
            ),
          ),
        ),
        title: Text(
            widget.onCallScreen == true ? Languages.of(context)!.editYourRecipe : Languages.of(context)!.addYourRecipe,
            style: mediumTextStyle(
                fontSize: isIpad ? 28.0 : 18.0,
                color: MyColor.black
            )
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.only(
            bottom: isIpad ? 25.0 : 15.0,
            top: isIpad ? 25.0 : 15.0
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: isIpad ? 25.0 : 15.0,
                    right: isIpad ? 25.0 : 15.0,
                    bottom: isIpad ? 20.0 : 10.0
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        widget.onCallScreen == true ?
                        Languages.of(context)!.editYourRecentCookingMoments :
                        Languages.of(context)!.addYourRecentCookingMoments,
                        style: mediumTextStyle(
                            fontSize: isIpad ? 25.0 : 18.0,
                            color: MyColor.black
                        )
                    ),
                    hsized10,
                    Text(
                        Languages.of(context)!.openyourphotogallerytorecentrecipe,
                        style: regularNormalTextStyle(
                            fontSize: isIpad ? 18.0 : 14.0,
                            color: MyColor.black
                        )
                    ),
                    hsized30,
                    imgUi(size, isIpad),
                    hsized30,
                    Text(
                        Languages.of(context)!.recipeName,
                        style: regularTextStyle(
                            fontSize: isIpad ? 20.0 : 15.0,
                            color: MyColor.black
                        )
                    ),
                    hsized10,
                    commonTextField(
                        recipeNameController,
                        Languages.of(context)!.enterTheNameIfYourRecipe.toString(),
                        TextInputAction.done,
                        TextInputType.text,
                        "Recipe Name",
                        2,
                        1,
                        isIpad
                    ),
                  ],
                ),
              ),

              hsized10,
              UiUtils.dividerLine(),

              Padding(
                padding: EdgeInsets.only(
                    left: isIpad ? 25.0 : 15.0,
                    right: isIpad ? 25.0 : 15.0,
                    bottom: isIpad ? 25.0 : 15.0
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    hsized20,
                    Text(
                        Languages.of(context)!.toolsUsed,
                        style: regularTextStyle(
                            fontSize: isIpad ? 20.0 : 15.0,
                            color: MyColor.black
                        )
                    ),
                    hsized15,
                    Center(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          hint: Text(
                            selectedItems.isEmpty ? "Select Tools" : selectedItems.join(', '),
                            style: regularTextStyle(
                                fontSize: isIpad ? 18.0 : 14.0,
                                color: selectedItems.isEmpty ? MyColor.grayLite1 : MyColor.appTheme
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          items: recipeToolsList.map((tool) {
                            return DropdownMenuItem(
                              value: tool.toolName ?? "",
                              child: StatefulBuilder(
                                builder: (context, menuSetState) {
                                  final isSelected = selectedItems.contains(tool.toolName ?? "");
                                  return Wrap(
                                    children: [
                                      ListTile(
                                        minTileHeight: isIpad ? 40.0 : 30.0,
                                        contentPadding: EdgeInsets.zero,
                                        title: SizedBox(
                                          height: isIpad ? 30.0 : 20.0,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Transform.scale(
                                                scale: isIpad ? 1.8 : 1.5,
                                                child: Checkbox(
                                                  shape: const CircleBorder(
                                                    side: BorderSide.none,
                                                  ),
                                                  value: isSelected,
                                                  activeColor: Colors.white,
                                                  checkColor: MyColor.appTheme,
                                                  fillColor: MaterialStateProperty.all(Colors.transparent),
                                                  side: MaterialStateBorderSide.resolveWith(
                                                        (states) => const BorderSide(
                                                      color: MyColor.appTheme,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  onChanged: (value) {
                                                    menuSetState(() {
                                                      if (value == true) {
                                                        selectedItems.add(tool.toolName ?? "");
                                                        selectedRecipeToolsList.add(tool.id.toString());
                                                      } else if (value == false) {
                                                        selectedItems.remove(tool.toolName ?? "");
                                                        selectedRecipeToolsList.remove(tool.id.toString());
                                                      }
                                                    });
                                                  },
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                    tool.toolName ?? "",
                                                    style: mediumTextStyle(
                                                        fontSize: isIpad ? 18.0 : 14.0,
                                                        color: MyColor.appTheme
                                                    )
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      hsized10,
                                    ],
                                  );
                                },
                              ),
                            );
                          }).toList(),
                          value: null,
                          onMenuStateChange: (isOpen) {
                            setState(() {
                              isTools = isOpen;
                              isFocusColor = "dropdwon";
                            });
                          },
                          onChanged: (value) {
                            isFocusColor = "dropdwon";
                            setState(() {});
                          },
                          buttonStyleData: ButtonStyleData(
                            height: isIpad ? 62.0 : 52.0,
                            width: size.width * (isIpad ? 0.95 : 0.95),
                            padding: EdgeInsets.only(
                                left: isIpad ? 20.0 : 14.0,
                                right: isIpad ? 20.0 : 14.0
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(isIpad ? 15.0 : 10.0),
                              color: Colors.transparent,
                              border: Border.all(
                                  color: isFocusColor == "dropdwon" ? MyColor.liteOrange : MyColor.grayLite
                              ),
                            ),
                            elevation: 0,
                          ),
                          iconStyleData: IconStyleData(
                            icon: isTools == true
                                ? const Icon(Icons.arrow_drop_up_sharp)
                                : const Icon(Icons.arrow_drop_down),
                            iconSize: isIpad ? 28.0 : 20.0,
                            iconEnabledColor: MyColor.appTheme,
                            iconDisabledColor: MyColor.grayLite,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            maxHeight: isIpad ? 350.0 : 250.0,
                            width: size.width * (isIpad ? 0.93 : 0.93),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(isIpad ? 18.0 : 14.0),
                              color: MyColor.white,
                              border: Border.all(color: MyColor.grayLite),
                            ),
                            offset: const Offset(0, 0),
                            scrollbarTheme: ScrollbarThemeData(
                              radius: Radius.circular(isIpad ? 25.0 : 20.0),
                              thickness: WidgetStateProperty.all<double>(isIpad ? 8.0 : 6.0),
                              thumbVisibility: WidgetStateProperty.all<bool>(true),
                            ),
                          ),
                          menuItemStyleData: MenuItemStyleData(
                            height: isIpad ? 50.0 : 40.0,
                            padding: EdgeInsets.only(left: 1, right: 1),
                          ),
                        ),
                      ),
                    ),
                    hsized10,
                  ],
                ),
              ),

              UiUtils.dividerLine(),

              Padding(
                padding: EdgeInsets.only(
                    left: isIpad ? 25.0 : 15.0,
                    right: isIpad ? 25.0 : 15.0,
                    bottom: isIpad ? 20.0 : 10.0,
                    top: isIpad ? 20.0 : 15.0
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            Languages.of(context)!.ingredients,
                            style: regularTextStyle(
                                fontSize: isIpad ? 20.0 : 15.0,
                                color: MyColor.black
                            )
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              if(ingredientsController.text.trim().isNotEmpty && ingredientsList.contains(ingredientsController.text.trim()) == false){
                                if(!isUpdateIngredients) {
                                  ingredientsList.add(ingredientsController.text.trim());
                                }else{
                                  ingredientsList[ingredientsIndex] = ingredientsController.text.trim();
                                }
                              }
                              isUpdateIngredients = false;
                              ingredientsController.clear();
                            });
                          },
                          child: Text(
                              !isUpdateIngredients ? "${Languages.of(context)!.add}+" : Languages.of(context)!.update,
                              style: regularTextStyle(
                                  fontSize: isIpad ? 18.0 : 14.0,
                                  color: MyColor.appTheme
                              )
                          ),
                        ),
                      ],
                    ),
                    hsized15,
                    commonTextField(
                        ingredientsController,
                        Languages.of(context)!.enterIngredients.toString(),
                        TextInputAction.done,
                        TextInputType.text,
                        "ingredients",
                        10,
                        3,
                        isIpad
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: isIpad ? 15.0 : 0.0,
                          left: 0,
                          right: isIpad ? 15.0 : 15.0,
                          bottom: isIpad ? 15.0 : 10.0
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.builder(
                            padding: EdgeInsets.only(top: isIpad ? 12.0 : 8.0),
                            itemCount: ingredientsList.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(top: isIpad ? 12.0 : 8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                              AssetsPath.dots,
                                              height: isIpad ? 24.0 : 19.0,
                                              width: isIpad ? 25.0 : 20.0
                                          ),
                                          SizedBox(width: isIpad ? 10.0 : 8.0),
                                          Expanded(
                                            child: Text(
                                                ingredientsList[index],
                                                style: regularTextStyle(
                                                    fontSize: isIpad ? 18.0 : 14.0,
                                                    color: MyColor.black
                                                )
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                            onTap: (){
                                              ingredientsIndex = index;
                                              setState(() {});
                                              AllDialogs.globalBottomSheet(
                                                  context,
                                                  UpdateDeletePopup(
                                                      onUpdate: onUpdateDeleteIngredient,
                                                      text: ingredientsList[index],
                                                      title: 'Ingredients',
                                                      isIpad: isIpad
                                                  ),
                                                      (){}
                                              );
                                            },
                                            child: Icon(
                                                Icons.more_vert,
                                                color: MyColor.black,
                                                size: isIpad ? 25.0 : 18.0
                                            )
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              UiUtils.dividerLine(),

              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isIpad ? 25.0 : 15.0,
                  vertical: isIpad ? 20.0 : 15.0,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            Languages.of(context)!.howtoCook,
                            style: regularTextStyle(
                                fontSize: isIpad ? 20.0 : 13.0,
                                color: MyColor.black
                            )
                        ),
                        InkWell(
                          onTap: () {
                            if (cookController.text.trim().isNotEmpty && cookList.contains(cookController.text.trim()) == false && !isUpdateCook) {
                              cookList.add(cookController.text.trim());
                            } else {
                              cookList[cookIndex] = cookController.text.trim();
                            }
                            isUpdateCook = false;
                            cookController.clear();
                            setState(() {});
                          },
                          child: Text(
                              !isUpdateCook ? "${Languages.of(context)!.add}+" : Languages.of(context)!.update,
                              style: regularTextStyle(
                                  fontSize: isIpad ? 18.0 : 14.0,
                                  color: MyColor.appTheme
                              )
                          ),
                        ),
                      ],
                    ),
                    hsized15,
                    commonTextField(
                        cookController,
                        Languages.of(context)!.enterCookYourRecipe.toString(),
                        TextInputAction.done,
                        TextInputType.text,
                        "cook",
                        10,
                        3,
                        isIpad
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: isIpad ? 15.0 : 10.0,
                          right: isIpad ? 15.0 : 15.0,
                          bottom: 0
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.builder(
                            padding: EdgeInsets.only(top: isIpad ? 12.0 : 8.0),
                            itemCount: cookList.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(top: isIpad ? 12.0 : 8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "Step ${(index + 1)} - ",
                                              style: regularTextStyle(
                                                  fontSize: isIpad ? 18.0 : 14.0,
                                                  color: MyColor.appTheme
                                              )
                                          ),
                                          Expanded(
                                            child: Text(
                                                cookList[index],
                                                style: regularTextStyle(
                                                    fontSize: isIpad ? 18.0 : 14.0,
                                                    color: MyColor.appTheme
                                                )
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                        onTap: (){
                                          cookIndex = index;
                                          setState(() {});
                                          AllDialogs.globalBottomSheet(
                                              context,
                                              UpdateDeletePopup(
                                                  onUpdate: onUpdateDeleteCook,
                                                  text: cookList[index],
                                                  title: 'How to cook',
                                                  isIpad: isIpad
                                              ),
                                                  (){}
                                          );
                                        },
                                        child: Icon(
                                            Icons.more_vert,
                                            color: MyColor.black,
                                            size: isIpad ? 25.0 : 18.0
                                        )
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              UiUtils.dividerLine(),

              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isIpad ? 25.0 : 15.0,
                  vertical: isIpad ? 20.0 : 15.0,
                ),
                child: Column(
                  children: [
                    hsized10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                              Languages.of(context)!.recepividocontant,
                              maxLines: 2,
                              style: regularTextStyle(
                                  fontSize: isIpad ? 20.0 : 15.0,
                                  color: MyColor.black
                              )
                          ),
                        ),
                      ],
                    ),
                    hsized10,
                    commonTextField(
                        recipevideolinkController,
                        Languages.of(context)!.enterTheNameIfYourvideolink.toString(),
                        TextInputAction.done,
                        TextInputType.text,
                        "Recipe Name",
                        2,
                        1,
                        isIpad
                    ),
                    hsized15,
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                    left: isIpad ? 30.0 : 20.0,
                    right: isIpad ? 30.0 : 20.0,
                    bottom: isIpad ? 20.0 : 10.0
                ),
                child: GlobalButton(
                    widget.onCallScreen == true ? Languages.of(context)!.edit : Languages.of(context)!.add.toString(),
                    MyColor.appTheme,
                    MyColor.appTheme,
                    btnSize55,
                    double.infinity,
                    checkValidation,
                    isIpad ? 65.0 : 55.0,
                    isIpad ? 8.0 : 5.0,
                    0,
                    mediumTextStyle(
                        fontSize: isIpad ? 20.0 : 15.0,
                        color: MyColor.white
                    )
                ),
              ),

              hsized30,
            ],
          ),
        ),
      ),
    );
  }

  onCallBackImage(dynamic file) {
    setState(() {
      selectedImage = File(file.path);
      image = file;
    });
  }

  imgUi(var size, bool isIpad) {
    return DottedBorder(
      color: MyColor.liteGray,
      strokeWidth: isIpad ? 3 : 2,
      borderType: BorderType.RRect,
      radius: Radius.circular(isIpad ? 15.0 : 10.0),
      dashPattern: selectedImage != null ? [200, 0] : const [04, 5],
      child: TouchRippleEffect(
        backgroundColor: Colors.transparent,
        borderRadius: BorderRadius.circular(isIpad ? 15.0 : 10.0),
        rippleColor: MyColor.appTheme.withOpacity(0.8),
        onTap: () {
          AllDialogs.globalBottomSheet(
              context,
              ImagePickerDialog(onCallBack: onCallBackImage, cropStyle: "rectangle"),
                  () {}
          );
        },
        child: selectedImage != null
            ? Container(
          height: isIpad ? 250.0 : size.height * 0.19,
          width: size.width,
          decoration: const BoxDecoration(
            color: MyColor.yellowF6F1E1,
          ),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Image.file(
                  selectedImage!,
                  fit: BoxFit.cover,
                  width: size.width
              ),
              InkWell(
                onTap: (){
                  setState(() {
                    selectedImage = null;
                  });
                },
                child: Icon(
                  Icons.cancel,
                  color: MyColor.red,
                  size: isIpad ? 35.0 : 24.0,
                ),
              )
            ],
          ),
        )
            : recipeModel.bannerImage == null
            ? Container(
            height: isIpad ? 250.0 : size.height * 0.19,
            width: size.width * 0.90,
            decoration: const BoxDecoration(
              color: MyColor.yellowF6F1E1,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AssetsPath.addimage,
                    width: isIpad ? 50.0 : 35.0,
                    height: isIpad ? 50.0 : 35.0,
                  ),
                  SizedBox(height: isIpad ? 15.0 : 10.0),
                  Text(
                    Languages.of(context)!.addImage,
                    style: mediumTextStyle(
                      fontSize: isIpad ? 18.0 : 12.0,
                      color: MyColor.appTheme,
                    ),
                  ),
                ],
              ),
            )
        )
            : Container(
            height: isIpad ? 250.0 : size.height * 0.19,
            width: size.width * 0.90,
            decoration: const BoxDecoration(
              color: MyColor.yellowF6F1E1,
            ),
            child: Image.network(
                ApiPath.imageBaseUrl + recipeModel!.bannerImage!,
                fit: BoxFit.cover,
                width: size.width
            )
        ),
      ),
    );
  }

  commonTextField(
      TextEditingController controller,
      String labelText,
      TextInputAction textInputAction,
      TextInputType textInputType,
      String type,
      int maxLines,
      int minLine,
      bool isIpad
      ) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            color: isFocusColor == type ? MyColor.liteOrange : MyColor.grayLite
        ),
        color: MyColor.white,
        borderRadius: BorderRadius.all(Radius.circular(isIpad ? 15.0 : 12.0)),
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(
          isIpad ? 16.0 : 12.0,
          isIpad ? 8.0 : 5.0,
          0,
          isIpad ? 20.0 : 15.0
      ),
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        onTap: () {
          if (mounted) {
            setState(() {
              isFocusColor = type;
            });
          }
        },
        buildCounter: (BuildContext context,
            {required int currentLength,
              int? maxLength,
              required bool isFocused}) =>
        null,
        controller: controller,
        onTapOutside: (v) {
          FocusManager.instance.primaryFocus!.unfocus();
        },
        textInputAction: textInputAction,
        keyboardType: textInputType,
        style: regularTextStyle(
            fontSize: isIpad ? 18.0 : 14.0,
            color: MyColor.black
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: labelText,
          hintStyle: regularTextStyle(
              fontSize: isIpad ? 18.0 : 14.0,
              color: MyColor.grayLite1
          ),
          counter: const Offstage(),
          isDense: true,
          contentPadding: EdgeInsets.only(top: isIpad ? 15.0 : 10.0),
        ),
        maxLines: maxLines,
        minLines: minLine,
        cursorColor: MyColor.black,
      ),
    );
  }

  void addOnTap() {}

  getRecipeTools(bool load) async {
    await ApiServices.getRecipeTools(context, load).then((onValue) {
      if (mounted) {
        setState(() {
          if (onValue.status == true) {
            if (onValue.data != null) {
              var recipe = onValue.data as List<dynamic>? ?? [];
              recipeToolsList.addAll(recipe.map((r) => RecipeToolsModel.fromJson(r)));
            }
          }
        });
      }
    });
  }

  getRecipedetials(bool load) async {
    await ApiServices.getRecipeTools(context, load).then((onValue) {
      if (mounted) {
        setState(() {
          if (onValue.status == true) {
            if (onValue.data != null) {
              var recipe = onValue.data as List<dynamic>? ?? [];
              recipeToolsList.addAll(recipe.map((r) => RecipeToolsModel.fromJson(r)));
            }
          }
        });
      }
    });
  }

  checkValidation() async {
    print("widget.recipeId>>>>>>>${widget.recipeId??"23"}");
    print("recipeNameController.text.trim()>>>>${recipeNameController.text.trim()}");
    print("selectedRecipeToolsList>>>>>>${selectedRecipeToolsList.length}");
    print("ingredientsList>>>>>${ingredientsList.length}");
    print("cookList>>>>>>${cookList.length}");

    if(recipeNameController.text.trim().isEmpty){
      Utility.customToast(context, "Please enter recipe name");
    } else if(selectedRecipeToolsList.isEmpty){
      Utility.customToast(context, "Please select recipe tools");
    } else if(ingredientsList.isEmpty){
      Utility.customToast(context, "Please select ingredient");
    } else if(cookList.isEmpty){
      Utility.customToast(context, "Please enter how to cook step");
    } else {
      widget.onCallScreen == true ? editRecipe(false) : Future.delayed(Duration.zero, addRecipe);
    }
  }

  addRecipe() async {
    AddRecipeRequest addRecipeRequest = AddRecipeRequest(
      recipeName: recipeNameController.text.trim(),
      recipeTools: selectedRecipeToolsList.join(', '),
      ingredients: ingredientsList.join(', '),
      recipeSteps: cookList.join(', '),
      recipeVideolink: recipevideolinkController.text ?? "",
    );

    await ApiServices.addRecipe(context, addRecipeRequest, image).then((onValue){
      if(mounted){
        setState(() {
          if(onValue.status == true){
            var data = RecipeModel.fromJson(onValue.data);
            Navigator.pop(context);
            widget.onCallBack(data);
          }
        });
      }
    });
  }

  RecipeModel recipeModel = RecipeModel();

  editRecipe(bool check) async {
    AddRecipeRequest addRecipeRequest = AddRecipeRequest(
      recipeId: widget.recipeId??"23",
      recipeName: recipeNameController.text.trim().isNotEmpty
          ? recipeNameController.text.trim()
          : "",
      recipeTools: (selectedRecipeToolsList.isNotEmpty)
          ? selectedRecipeToolsList.join(', ')
          : "",
      ingredients: (ingredientsList.isNotEmpty)
          ? ingredientsList.join(', ')
          : "",
      recipeSteps: (cookList.isNotEmpty)
          ? cookList.join(', ')
          : "",
      recipeVideolink: recipevideolinkController.text,
    );

    await ApiServices.editRecipe(context, addRecipeRequest, image).then((onValue){
      if (mounted){
        setState(() {
          if(onValue.status == true){
            recipeModel = RecipeModel.fromJson(onValue.data);
            if(check == true) {
              recipevideolinkController.text = recipeModel.videolink.toString();
              recipeNameController.text = recipeModel.name?.toString() ?? "";

              for (int i = 0; i < recipeModel.recipeTools!.length; i++) {
                selectedRecipeToolsList.add(recipeModel.recipeTools![i].id.toString());
              }

              for (int i = 0; i < recipeModel.recipeTools!.length; i++) {
                selectedItems.add(recipeModel.recipeTools![i].toolName.toString());
              }

              for (int i = 0; i < recipeModel.recipeIngredient!.length; i++) {
                ingredientsList.add(recipeModel.recipeIngredient![i].name?.toString() ?? "");
              }

              for (int i = 0; i < recipeModel.recipeSteps!.length; i++) {
                cookList.add(recipeModel.recipeSteps![i].name?.toString() ?? "");
              }
            }

            if (widget.onCallScreen == true) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                widget.onCallBack();
              });
            }

            check == false ? Navigator.pop(context) : null;
          }
        });
      }
    });
  }

  onUpdateDeleteIngredient(String type){
    setState(() {
      if(type == "Delete"){
        ingredientsList.removeAt(ingredientsIndex);
      } else {
        isUpdateIngredients = true;
        ingredientsController.text = ingredientsList[ingredientsIndex];
      }
    });
  }

  onUpdateDeleteCook(String type){
    setState(() {
      if(type == "Delete"){
        cookList.removeAt(cookIndex);
      } else {
        isUpdateCook = true;
        cookController.text = cookList[cookIndex];
      }
    });
  }
}

class UpdateDeletePopup extends StatelessWidget {
  final Function onUpdate;
  final String text;
  final String title;
  final bool isIpad;

  const UpdateDeletePopup({
    super.key,
    required this.onUpdate,
    required this.text,
    required this.title,
    required this.isIpad
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      bottomSheet: Wrap(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 15.0, top: 10.0),
                        child: Icon(
                          Icons.clear,
                          color: MyColor.liteGray,
                          size: isIpad ? 35.0 : 30.0,
                        ),
                      )
                  ),
                ),
                SizedBox(height: isIpad ? 20.0 : 15.0),
                Text(
                  title,
                  style: mediumTextStyle(
                      fontSize: isIpad ? 22.0 : 18.0,
                      color: MyColor.black
                  ),
                ),
                SizedBox(height: isIpad ? 10.0 : 5.0),
                Text(
                  text,
                  style: mediumTextStyle(
                      fontSize: isIpad ? 20.0 : 16.0,
                      color: MyColor.black
                  ),
                ),
                SizedBox(height: isIpad ? 40.0 : 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: (){
                          Navigator.pop(context);
                          onUpdate("Delete");
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: isIpad ? 35.0 : 25.0,
                                vertical: isIpad ? 12.0 : 8.0
                            ),
                            decoration: BoxDecoration(
                                color: MyColor.red,
                                borderRadius: BorderRadius.circular(isIpad ? 12.0 : 8.0)
                            ),
                            child: Text(
                                "Delete",
                                style: mediumTextStyle(
                                    fontSize: isIpad ? 18.0 : 15.0,
                                    color: MyColor.white
                                )
                            )
                        )
                    ),
                    SizedBox(width: isIpad ? 20.0 : 10.0),
                    InkWell(
                        onTap: (){
                          Navigator.pop(context);
                          onUpdate("Edit");
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: isIpad ? 35.0 : 25.0,
                                vertical: isIpad ? 12.0 : 8.0
                            ),
                            decoration: BoxDecoration(
                                color: MyColor.appTheme,
                                borderRadius: BorderRadius.circular(isIpad ? 12.0 : 8.0)
                            ),
                            child: Text(
                                "Edit",
                                style: mediumTextStyle(
                                    fontSize: isIpad ? 18.0 : 15.0,
                                    color: MyColor.white
                                )
                            )
                        )
                    )
                  ],
                ),
                SizedBox(height: isIpad ? 40.0 : 30.0),
              ],
            ),
          )
        ],
      ),
    );
  }
}
