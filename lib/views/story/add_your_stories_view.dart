// import 'dart:io';
//
// import 'package:cooking_champs/constant/assets_path.dart';
// import 'package:cooking_champs/constant/dimen.dart';
// import 'package:cooking_champs/constant/my_color.dart';
// import 'package:cooking_champs/constant/my_fonts_style.dart';
// import 'package:cooking_champs/constant/sized_box.dart';
// import 'package:cooking_champs/constant/stringfile.dart/language.dart';
// import 'package:cooking_champs/model/dynamic_models/my_story_model.dart';
// import 'package:cooking_champs/model/post_model/add_stories_request.dart';
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
//
// import '../../services/api_path.dart';
//
// class AddYourStoriesView extends StatefulWidget {
//   final String? storyid;
//   final Function onCallback;
//   final bool? onCallScreen;
//   final String? storyvideolink;
//   const AddYourStoriesView(
//       {this.storyid,
//       super.key,
//       required this.onCallback,
//       this.onCallScreen,
//       this.storyvideolink});
//
//   @override
//   State<AddYourStoriesView> createState() => _AddYourStoriesViewState();
// }
//
// class _AddYourStoriesViewState extends State<AddYourStoriesView> {
//   List<XFile> imageFileList = [];
//   dynamic image;
//   File? selectedImage1;
//   File? selectedImage2;
//
//   int wordCount = 0; // Initialize word count
//   int titleCount = 0; // Initialize word count
//   bool isValidate = false;
//   bool isImage = false;
//   bool isImage1 = false;
//   String titleError = "";
//   String imageError = "";
//   String storyError = "";
//
//   dynamic _isFocusColor = '';
//
//   TextEditingController titleController = TextEditingController();
//   TextEditingController storyvideolinkController = TextEditingController();
//
//   TextEditingController storyController = TextEditingController();
//   @override
//   void initState() {
//     super.initState();
//     // Listen for changes in the TextField
//
//     storyvideolinkController.text = widget.storyvideolink ?? "";
//     editStories(false);
//     storyController.addListener(() {
//       setState(() {
//         wordCount = _countWords(storyController.text);
//       });
//     });
//     titleController.addListener(() {
//       setState(() {
//         titleCount = _countWords(titleController.text);
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     titleController.dispose();
//     storyController.dispose();
//     super.dispose();
//   }
//
//   int _countWords(String text) {
//     if (text.trim().isEmpty) return 0;
//     // Split text by spaces and remove empty strings
//     return text.trim().split(RegExp(r'\s+')).length;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         leadingWidth: 0,
//         automaticallyImplyLeading: false,
//         backgroundColor: MyColor.yellowF6F1E1,
//         surfaceTintColor: MyColor.yellowF6F1E1,
//         title: Padding(
//           padding: const EdgeInsets.only(left: 0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               TouchRippleEffect(
//                 borderRadius: BorderRadius.circular(30),
//                 rippleColor: Colors.white,
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//                 child: const Icon(
//                   Icons.arrow_back_ios,
//                   size: 30,
//                   color: Colors.black,
//                 ),
//               ),
//               SizedBox(width: 10),
//               Text(
//                   widget.onCallScreen == true
//                       ? Languages.of(context)!.editYourStories
//                       : Languages.of(context)!.addYourStories,
//                   style: mediumTextStyle(fontSize: 18.0, color: MyColor.black)),
//             ],
//           ),
//         ),
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                   widget.onCallScreen == true
//                       ? Languages.of(context)!.editarecentmoment
//                       : Languages.of(context)!.addarecentmoment,
//                   style: mediumTextStyle(fontSize: 18.0, color: MyColor.black)),
//               Text(Languages.of(context)!.openyourphotogalleryto,
//                   style:
//                       regularTextStyle(fontSize: 14.0, color: MyColor.black)),
//               const SizedBox(
//                 height: 20,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   DottedBorder(
//                       color: isImage ? Colors.red : MyColor.appTheme,
//                       strokeWidth: 2,
//                       borderType: BorderType.RRect,
//                       radius: const Radius.circular(10),
//                       dashPattern:
//                           selectedImage1 != null ? [200, 0] : const [1, 6],
//                       child: TouchRippleEffect(
//                         backgroundColor: Colors.transparent,
//                         borderRadius: BorderRadius.circular(10),
//                         rippleColor: MyColor.appTheme.withOpacity(0.8),
//                         onTap: () {
//                           AllDialogs.globalBottomSheet(
//                               context,
//                               ImagePickerDialog(
//                                   onCallBack: onCallBackImage1,
//                                   cropStyle: "rectangle"),
//                               () {});
//                         },
//                         child: selectedImage1 != null
//                             ? Stack(
//                                 alignment: Alignment.topRight,
//                                 children: [
//                                   Container(
//                                     height: size.height * 0.19,
//                                     width: size.width * 0.80,
//                                     decoration: const BoxDecoration(
//                                       color: MyColor.yellowF6F1E1,
//                                     ),
//                                     child: Image.file(
//                                       selectedImage1!,
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                   Container(
//                                     padding:
//                                         EdgeInsets.only(right: 0, bottom: 5),
//                                     child: InkWell(
//                                       onTap: () {
//                                         setState(() {
//                                           selectedImage1 = null;
//                                         });
//                                       },
//                                       child: Icon(
//                                         Icons.cancel,
//                                         color: MyColor.white,
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               )
//                             : storyModel.image != null
//                                 ? Container(
//                                     height: size.height * 0.19,
//                                     width: size.width * 0.80,
//                                     decoration: const BoxDecoration(
//                                       color: MyColor.yellowF6F1E1,
//                                     ),
//                                     child: Image.network(
//                                       ApiPath.imageBaseUrl + storyModel.image!,
//                                       fit: BoxFit.cover,
//                                     ),
//                                   )
//                                 : Container(
//                                     height: size.height * 0.19,
//                                     width: size.width * 0.80,
//                                     decoration: const BoxDecoration(
//                                       color: MyColor.yellowF6F1E1,
//                                     ),
//                                     child: Center(
//                                         child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Image.asset(
//                                             width: 35,
//                                             height: 35,
//                                             AssetsPath.addimage),
//                                         Text(
//                                           Languages.of(context)!.addImage,
//                                           style: const TextStyle(
//                                             color: MyColor.appTheme,
//                                             fontWeight: FontWeight.w500,
//                                             fontSize: 12,
//                                             fontFamily:
//                                                 Fonts.beVietnamProRegular,
//                                           ),
//                                         ),
//                                       ],
//                                     ))),
//                       )),
//
//                   //
//                   // DottedBorder(
//                   //     color: isImage1?Colors.red:MyColor.appTheme,
//                   //     strokeWidth: 2,
//                   //     borderType: BorderType.RRect,
//                   //     radius: const Radius.circular(10),
//                   //     dashPattern: selectedImage2 != null
//                   //         ? [200, 0]
//                   //         : const [1, 6],
//                   //     child: TouchRippleEffect(
//                   //       backgroundColor: Colors.transparent,
//                   //       borderRadius: BorderRadius.circular(10),
//                   //       rippleColor: MyColor.appTheme.withOpacity(0.8),
//                   //       onTap: () {
//                   //         AllDialogs.globalBottomSheet(context,ImagePickerDialog(onCallBack: onCallBackImage2,cropStyle:"rectangle"),(){});
//                   //       },
//                   //       child: selectedImage2 != null ? Stack(
//                   //         alignment: Alignment.topRight,
//                   //         children: [
//                   //           Container(
//                   //             height: size.height * 0.19,
//                   //             width: size.width * 0.40,
//                   //             decoration: const BoxDecoration(
//                   //               color: MyColor.yellowF6F1E1,
//                   //             ),
//                   //             child: Image.file(
//                   //               selectedImage2!,
//                   //               fit: BoxFit.cover,
//                   //             ),
//                   //           ),
//                   //
//                   //           Container(
//                   //             padding: EdgeInsets.only(right:0,bottom: 5),
//                   //             child: InkWell(
//                   //               onTap: (){
//                   //                 setState(() {
//                   //                   selectedImage2 = null;
//                   //                   imageFileList.clear();
//                   //                 });
//                   //               },
//                   //               child: Icon(Icons.cancel,color: MyColor.white,),
//                   //             ),
//                   //           )
//                   //         ],
//                   //       )
//                   //           : Container(
//                   //           height: size.height * 0.19,
//                   //           width: size.width * 0.40,
//                   //           decoration:  BoxDecoration(
//                   //             color: MyColor.yellowF6F1E1,
//                   //           ),
//                   //           child: Center(
//                   //               child: Column(
//                   //                 mainAxisAlignment:
//                   //                 MainAxisAlignment.center,
//                   //                 children: [
//                   //                   Image.asset(
//                   //                       width: 35,
//                   //                       height: 35,
//                   //                       AssetsPath.addimage),
//                   //                   Text(
//                   //                     Languages.of(context)!.addImage,
//                   //                     style: const TextStyle(
//                   //                       color: MyColor.appTheme,
//                   //                       fontWeight: FontWeight.w500,
//                   //                       fontSize: 12,
//                   //                       fontFamily: Fonts.beVietnamProRegular,
//                   //                     ),
//                   //                   ),
//                   //                 ],
//                   //               ))),
//                   //     )),
//                 ],
//               ),
//               imageError.isNotEmpty
//                   ? Container(
//                       padding: EdgeInsets.only(top: 5),
//                       alignment: Alignment.centerRight,
//                       child: UiUtils.errorText(imageError))
//                   : SizedBox.shrink(),
//               hsized30,
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(Languages.of(context)!.momentStoryTitle,
//                       style: mediumTextStyle(
//                           fontSize: 15.0, color: MyColor.black)),
//                   Text(Languages.of(context)!.max15Words,
//                       style: regularTextStyle(
//                           fontSize: 14.0,
//                           color: titleError.isNotEmpty
//                               ? MyColor.red
//                               : MyColor.appTheme)),
//                 ],
//               ),
//               hsized15,
//               Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                       color: _isFocusColor == "Enter title"
//                           ? MyColor.liteOrange
//                           : MyColor.grayLite),
//                   color: MyColor.white,
//                   borderRadius: const BorderRadius.all(Radius.circular(12)),
//                 ),
//                 alignment: Alignment.center,
//                 padding: const EdgeInsets.fromLTRB(12, 5, 0, 15),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     TextField(
//                       minLines: 1,
//                       textCapitalization: TextCapitalization.sentences,
//                       onTap: () {
//                         setState(() {
//                           _isFocusColor = "Enter title";
//                         });
//                       },
//                       onChanged: (v) {
//                         List<String> words = titleController.text.split(' ');
//                         if (words.length > 15) {
//                           // Truncate to 15 words
//                           titleController.text = words.sublist(0, 15).join(' ');
//                           titleController.selection =
//                               TextSelection.fromPosition(
//                             TextPosition(offset: titleController.text.length),
//                           );
//                         }
//                       },
//                       controller: titleController,
//                       onTapOutside: (v) {
//                         FocusManager.instance.primaryFocus!.unfocus();
//                       },
//                       textInputAction: TextInputAction.newline,
//                       keyboardType: TextInputType.multiline,
//                       style: regularTextStyle(
//                           fontSize: 14.0, color: MyColor.black),
//                       decoration: InputDecoration(
//                         border: InputBorder.none,
//                         hintText: Languages.of(context)!.entertitle.toString(),
//                         hintStyle: regularTextStyle(
//                             fontSize: 14.0, color: MyColor.grayLite1),
//                         isDense: true,
//                         contentPadding: const EdgeInsets.only(top: 10),
//                       ),
//                       maxLines: null,
//                       cursorColor: MyColor.black,
//                     ),
//                     const SizedBox(height: 0),
//                     titleCount == 0
//                         ? SizedBox.shrink()
//                         : Align(
//                             alignment: Alignment.bottomRight,
//                             child: Text(
//                               '$titleCount words  ', // Display the word count
//                               style: regularTextStyle(
//                                   fontSize: 12.0, color: MyColor.grayLite1),
//                             ),
//                           ),
//                   ],
//                 ),
//               ),
//               hsized30,
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(Languages.of(context)!.yourStoryMoment,
//                       style: regularTextStyle(
//                           fontSize: 15.0, color: MyColor.black)),
//                   Text(Languages.of(context)!.min100Words,
//                       style: regularTextStyle(
//                           fontSize: 14.0,
//                           color: storyError.isNotEmpty
//                               ? MyColor.red
//                               : MyColor.appTheme)),
//                 ],
//               ),
//               hsized15,
//               Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                       color: _isFocusColor == "writehere"
//                           ? MyColor.liteOrange
//                           : MyColor.grayLite),
//                   color: MyColor.white,
//                   borderRadius: const BorderRadius.all(Radius.circular(12)),
//                 ),
//                 alignment: Alignment.center,
//                 padding: const EdgeInsets.fromLTRB(12, 5, 0, 15),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     TextField(
//                       minLines: 5,
//                       textCapitalization: TextCapitalization.sentences,
//                       onTap: () {
//                         setState(() {
//                           _isFocusColor = "writehere";
//                         });
//                       },
//                       onChanged: (value) {
//                         List<String> words = storyController.text.split(' ');
//                         if (words.length > 100) {
//                           // Truncate to 15 words
//                           storyController.text =
//                               words.sublist(0, 100).join(' ');
//                           storyController.selection =
//                               TextSelection.fromPosition(
//                             TextPosition(offset: storyController.text.length),
//                           );
//                         }
//                       },
//                       controller: storyController,
//                       onTapOutside: (v) {
//                         FocusManager.instance.primaryFocus!.unfocus();
//                       },
//                       textInputAction: TextInputAction.newline,
//                       keyboardType: TextInputType.multiline,
//                       style: regularTextStyle(
//                           fontSize: 14.0, color: MyColor.black),
//                       decoration: InputDecoration(
//                         border: InputBorder.none,
//                         hintText: Languages.of(context)!.writehere.toString(),
//                         hintStyle: regularTextStyle(
//                             fontSize: 14.0, color: MyColor.grayLite1),
//                         isDense: true,
//                         contentPadding: const EdgeInsets.only(top: 10),
//                       ),
//                       maxLines: null,
//                       cursorColor: MyColor.black,
//                     ),
//                     const SizedBox(height: 10),
//                     Align(
//                       alignment: Alignment.bottomRight,
//                       child: Text(
//                         '$wordCount words  ', // Display the word count
//                         style: regularTextStyle(
//                             fontSize: 12.0, color: MyColor.grayLite1),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 0,
//                   vertical: 15,
//                 ),
//                 child: Column(
//                   children: [
//                     hsized10,
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Expanded(
//                           child: Text(Languages.of(context)!.storyVidoContant,
//                               style: regularTextStyle(
//                                   fontSize: 15.0, color: MyColor.black)),
//                         ),
//                       ],
//                     ),
//                     hsized10,
//                     commonTextField(
//                         storyvideolinkController,
//                         Languages.of(context)!
//                             .enterTheNameIfYourvideolink
//                             .toString(),
//                         TextInputAction.done,
//                         TextInputType.text,
//                         "Recipe Name",
//                         2,
//                         1),
//                     hsized15,
//                   ],
//                 ),
//               ),
//               hsized30,
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: Container(
//         //height: 80,
//         padding: const EdgeInsets.only(bottom: 30.0, left: 20, right: 20),
//         child: GlobalButton(
//             widget.onCallScreen == true
//                 ? Languages.of(context)!.edit
//                 : Languages.of(context)!.add.toString(),
//             MyColor.appTheme,
//             MyColor.appTheme,
//             btnSize55,
//             double.infinity,
//             addOnTap,
//             55,
//             5,
//             0,
//             mediumTextStyle(fontSize: 16.0, color: MyColor.white)),
//       ),
//     );
//   }
//
//   dynamic isFocusColor = '';
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
//   void addOnTap() {
//     setState(() {
//       isValidate = true;
//
//       // Validate Image 1
//       if (storyModel.image == null && selectedImage1 == null) {
//         imageError = "Please add image";
//         isImage = true;
//         isValidate = false;
//       } else {
//         isImage = false;
//         imageError = "";
//       }
//
//       // Validate Image List
//       if (storyModel.image == null && imageFileList.isEmpty) {
//         imageError = "Please add image";
//         isImage1 = true;
//         isValidate = false;
//       } else {
//         isImage1 = false;
//         imageError = "";
//       }
//
//       // Validate Title
//       final titleValidationResult = validateTitle(titleController.text.trim());
//       if (titleValidationResult != null) {
//         titleError = titleValidationResult;
//         isValidate = false;
//       }
//
//       // Validate Story
//       final storyValidationResult = validateStory(storyController.text.trim());
//       if (storyValidationResult != null) {
//         storyError = storyValidationResult;
//         isValidate = false;
//       }
//     });
//
//     // Proceed to add the story if validation passes
//     if (isValidate) {
//       // Future.delayed(Duration.zero, addStories);
//       widget.onCallScreen == true
//           ? editStories(true)
//           : Future.delayed(Duration.zero, addStories);
//     }
//   }
//
//   void addOnTap1() {
//     isValidate = true;
//
//     setState(() {
//       if (selectedImage1 == null) {
//         imageError = "Please add image";
//         isImage = true;
//         isValidate = false;
//       } else {
//         isImage = false;
//         imageError = "";
//       }
//       // if(imageFileList.isEmpty){
//       //   imageError = "Please add image";
//       //   isImage1 = true;
//       //   isValidate = false;
//       // }else{
//       //   isImage1 = false;
//       //   imageError = "";
//       // }
//       // Validate Title
//       final titleValidationResult = validateTitle(titleController.text.trim());
//       if (titleValidationResult != null) {
//         titleError = titleValidationResult;
//         isValidate = false;
//       } else {
//         titleError = "";
//       }
//
//       // Validate Story
//       final storyValidationResult = validateStory(storyController.text.trim());
//       if (storyValidationResult != null) {
//         storyError = storyValidationResult;
//         isValidate = false;
//       } else {
//         storyError = "";
//       }
//     }); // Update UI once after all validations
//
//     // If everything is valid, proceed to add the story
//     if (isValidate) {
//       Future.delayed(Duration.zero, addStories);
//     }
//   }
//
//   /// Validation function for Story
//   String? validateStory(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return "Story cannot be empty.";
//     }
//     if (Utility().countWords(value) < 100) {
//       return "Story must have at least 100 words.";
//     }
//     return null; // Validation passed
//   }
//
//   /// Validation function for Title
//   String? validateTitle(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return "Title cannot be empty.";
//     }
//     if (Utility().countWords(value) > 30) {
//       return "Title must not exceed 30 words.";
//     }
//     return null; // Validation passed
//   }
//
//   addStories() async {
//     AddStoriesRequest addStoriesRequest = AddStoriesRequest(
//         title: titleController.text,
//         description: storyController.text,
//         storiesVideolink: storyvideolinkController.text);
//     await ApiServices.addStories(
//             context, addStoriesRequest, selectedImage1, imageFileList)
//         .then((onValue) {
//       if (onValue.status == true) {
//         var data = StoryModel.fromJson(onValue.data);
//         Navigator.pop(context);
//         widget.onCallback(data);
//       }
//     });
//   }
//
//   StoryModel storyModel = StoryModel();
//   editStories(bool check) async {
//     if (widget.storyid.toString() != "null") {
//       AddStoriesRequest addStoriesRequest = AddStoriesRequest(
//           storyid: widget.storyid!.toString(),
//           title: titleController.text,
//           description: storyController.text,
//           storiesVideolink: storyvideolinkController.text);
//       await ApiServices.editStories(
//               context, addStoriesRequest, selectedImage1, imageFileList)
//           .then((onValue) {
//         print("oncall>>>>>>>${onValue}");
//         if (onValue.status == true) {
//           storyModel = StoryModel.fromJson(onValue.data);
//           var data = StoryModel.fromJson(onValue.data);
//           // selectedImage1 = File(storyModel.image.toString());
//           titleController.text = storyModel.title.toString();
//           storyController.text = storyModel.description.toString();
//           widget.onCallback();
//           check == true ? Navigator.pop(context) : null;
//         }
//       });
//     }
//   }
//
//   onCallBackImage1(var file) {
//     setState(() {
//       imageFileList.clear();
//       selectedImage1 = File(file.path);
//       imageFileList.add(XFile(selectedImage1!.path));
//     });
//   }
//
//   onCallBackImage2(var file) {
//     setState(() {
//       selectedImage2 = File(file.path);
//       imageFileList.add(XFile(selectedImage2!.path));
//     });
//   }
// }


import 'dart:io';

import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/dimen.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/constant/stringfile.dart/language.dart';
import 'package:cooking_champs/model/dynamic_models/my_story_model.dart';
import 'package:cooking_champs/model/post_model/add_stories_request.dart';
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

import '../../services/api_path.dart';

class AddYourStoriesView extends StatefulWidget {
  final String? storyid;
  final Function onCallback;
  final bool? onCallScreen;
  final String? storyvideolink;
  const AddYourStoriesView(
      {this.storyid,
        super.key,
        required this.onCallback,
        this.onCallScreen,
        this.storyvideolink});

  @override
  State<AddYourStoriesView> createState() => _AddYourStoriesViewState();
}

class _AddYourStoriesViewState extends State<AddYourStoriesView> {
  List<XFile> imageFileList = [];
  dynamic image;
  File? selectedImage1;
  File? selectedImage2;

  int wordCount = 0; // Initialize word count
  int titleCount = 0; // Initialize word count
  bool isValidate = false;
  bool isImage = false;
  bool isImage1 = false;
  String titleError = "";
  String imageError = "";
  String storyError = "";

  dynamic _isFocusColor = '';

  TextEditingController titleController = TextEditingController();
  TextEditingController storyvideolinkController = TextEditingController();

  TextEditingController storyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Listen for changes in the TextField

    storyvideolinkController.text = widget.storyvideolink ?? "";
    editStories(false);
    storyController.addListener(() {
      setState(() {
        wordCount = _countWords(storyController.text);
      });
    });
    titleController.addListener(() {
      setState(() {
        titleCount = _countWords(titleController.text);
      });
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    storyController.dispose();
    super.dispose();
  }

  int _countWords(String text) {
    if (text.trim().isEmpty) return 0;
    // Split text by spaces and remove empty strings
    return text.trim().split(RegExp(r'\s+')).length;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final bool isIpad = MediaQuery.of(context).size.width > 600;

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
                child: Icon(
                  Icons.arrow_back_ios,
                  size: isIpad ? 36 : 30,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: isIpad ? 15 : 10),
              Text(
                widget.onCallScreen == true
                    ? Languages.of(context)!.editYourStories
                    : Languages.of(context)!.addYourStories,
                style: mediumTextStyle(
                    fontSize: isIpad ? 28.0 : 18.0,
                    color: MyColor.black
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: isIpad ? 80 : 56,
      ),
      body: Padding(
        padding: EdgeInsets.only(
            top: isIpad ? 25 : 15,
            right: isIpad ? 25 : 15,
            left: isIpad ? 25 : 15
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.onCallScreen == true
                    ? Languages.of(context)!.editarecentmoment
                    : Languages.of(context)!.addarecentmoment,
                style: mediumTextStyle(
                    fontSize: isIpad ? 28.0 : 18.0,
                    color: MyColor.black
                ),
              ),
              SizedBox(height: isIpad ? 8 : 5),
              Text(
                Languages.of(context)!.openyourphotogalleryto,
                style: regularTextStyle(
                    fontSize: isIpad ? 20.0 : 14.0,
                    color: MyColor.black
                ),
              ),
              SizedBox(height: isIpad ? 30 : 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DottedBorder(
                    color: isImage ? Colors.red : MyColor.appTheme,
                    strokeWidth: 2,
                    borderType: BorderType.RRect,
                    radius: Radius.circular(isIpad ? 15 : 10),
                    dashPattern: selectedImage1 != null ? [200, 0] : const [1, 6],
                    child: TouchRippleEffect(
                      backgroundColor: Colors.transparent,
                      borderRadius: BorderRadius.circular(isIpad ? 15 : 10),
                      rippleColor: MyColor.appTheme.withOpacity(0.8),
                      onTap: () {
                        AllDialogs.globalBottomSheet(
                          context,
                          ImagePickerDialog(
                              onCallBack: onCallBackImage1,
                              cropStyle: "rectangle"
                          ),
                              () {},
                        );
                      },
                      child: selectedImage1 != null
                          ? Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Container(
                            height: isIpad ? size.height * 0.25 : size.height * 0.19,
                            width: size.width * (isIpad ? 0.90 : 0.80),
                            decoration: const BoxDecoration(
                              color: MyColor.yellowF6F1E1,
                            ),
                            child: Image.file(
                              selectedImage1!,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                right: isIpad ? 10 : 0,
                                bottom: isIpad ? 10 : 5
                            ),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  selectedImage1 = null;
                                });
                              },
                              child: Icon(
                                Icons.cancel,
                                color: MyColor.white,
                                size: isIpad ? 32 : 24,
                              ),
                            ),
                          )
                        ],
                      )
                          : storyModel.image != null
                          ? Container(
                        height: isIpad ? size.height * 0.25 : size.height * 0.19,
                        width: size.width * (isIpad ? 0.90 : 0.80),
                        decoration: const BoxDecoration(
                          color: MyColor.yellowF6F1E1,
                        ),
                        child: Image.network(
                          ApiPath.imageBaseUrl + storyModel.image!,
                          fit: BoxFit.cover,
                        ),
                      )
                          : Container(
                        height: isIpad ? size.height * 0.25 : size.height * 0.19,
                        width: size.width * (isIpad ? 0.90 : 0.80),
                        decoration: const BoxDecoration(
                          color: MyColor.yellowF6F1E1,
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                  width: isIpad ? 45 : 35,
                                  height: isIpad ? 45 : 35,
                                  AssetsPath.addimage
                              ),
                              SizedBox(height: isIpad ? 8 : 5),
                              Text(
                                Languages.of(context)!.addImage,
                                style: TextStyle(
                                  color: MyColor.appTheme,
                                  fontWeight: FontWeight.w500,
                                  fontSize: isIpad ? 18 : 12,
                                  fontFamily: Fonts.beVietnamProRegular,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              imageError.isNotEmpty
                  ? Container(
                padding: EdgeInsets.only(top: isIpad ? 10 : 5),
                alignment: Alignment.centerRight,
                child: UiUtils.errorText(imageError),
              )
                  : SizedBox.shrink(),
              SizedBox(height: isIpad ? 40 : 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Languages.of(context)!.momentStoryTitle,
                    style: mediumTextStyle(
                        fontSize: isIpad ? 22.0 : 15.0,
                        color: MyColor.black
                    ),
                  ),
                  Text(
                    Languages.of(context)!.max15Words,
                    style: regularTextStyle(
                      fontSize: isIpad ? 20.0 : 14.0,
                      color: titleError.isNotEmpty ? MyColor.red : MyColor.appTheme,
                    ),
                  ),
                ],
              ),
              SizedBox(height: isIpad ? 20 : 15),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: _isFocusColor == "Enter title"
                          ? MyColor.liteOrange
                          : MyColor.grayLite
                  ),
                  color: MyColor.white,
                  borderRadius: BorderRadius.all(Radius.circular(isIpad ? 16 : 12)),
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(
                    isIpad ? 16 : 12,
                    isIpad ? 8 : 5,
                    0,
                    isIpad ? 20 : 15
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      minLines: 1,
                      textCapitalization: TextCapitalization.sentences,
                      onTap: () {
                        setState(() {
                          _isFocusColor = "Enter title";
                        });
                      },
                      onChanged: (v) {
                        List<String> words = titleController.text.split(' ');
                        if (words.length > 15) {
                          // Truncate to 15 words
                          titleController.text = words.sublist(0, 15).join(' ');
                          titleController.selection = TextSelection.fromPosition(
                            TextPosition(offset: titleController.text.length),
                          );
                        }
                      },
                      controller: titleController,
                      onTapOutside: (v) {
                        FocusManager.instance.primaryFocus!.unfocus();
                      },
                      textInputAction: TextInputAction.newline,
                      keyboardType: TextInputType.multiline,
                      style: regularTextStyle(
                          fontSize: isIpad ? 20.0 : 14.0,
                          color: MyColor.black
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: Languages.of(context)!.entertitle.toString(),
                        hintStyle: regularTextStyle(
                            fontSize: isIpad ? 20.0 : 14.0,
                            color: MyColor.grayLite1
                        ),
                        isDense: true,
                        contentPadding: EdgeInsets.only(top: isIpad ? 15 : 10),
                      ),
                      maxLines: null,
                      cursorColor: MyColor.black,
                    ),
                    SizedBox(height: isIpad ? 5 : 0),
                    titleCount == 0
                        ? SizedBox.shrink()
                        : Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: isIpad ? 12 : 0),
                        child: Text(
                          '$titleCount words  ',
                          style: regularTextStyle(
                              fontSize: isIpad ? 18.0 : 12.0,
                              color: MyColor.grayLite1
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: isIpad ? 40 : 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Languages.of(context)!.yourStoryMoment,
                    style: regularTextStyle(
                        fontSize: isIpad ? 22.0 : 15.0,
                        color: MyColor.black
                    ),
                  ),
                  Text(
                    Languages.of(context)!.min100Words,
                    style: regularTextStyle(
                      fontSize: isIpad ? 20.0 : 14.0,
                      color: storyError.isNotEmpty ? MyColor.red : MyColor.appTheme,
                    ),
                  ),
                ],
              ),
              SizedBox(height: isIpad ? 20 : 15),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: _isFocusColor == "writehere"
                          ? MyColor.liteOrange
                          : MyColor.grayLite
                  ),
                  color: MyColor.white,
                  borderRadius: BorderRadius.all(Radius.circular(isIpad ? 16 : 12)),
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(
                    isIpad ? 16 : 12,
                    isIpad ? 8 : 5,
                    0,
                    isIpad ? 20 : 15
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      minLines: isIpad ? 8 : 5,
                      textCapitalization: TextCapitalization.sentences,
                      onTap: () {
                        setState(() {
                          _isFocusColor = "writehere";
                        });
                      },
                      onChanged: (value) {
                        List<String> words = storyController.text.split(' ');
                        if (words.length > 100) {
                          // Truncate to 100 words
                          storyController.text = words.sublist(0, 100).join(' ');
                          storyController.selection = TextSelection.fromPosition(
                            TextPosition(offset: storyController.text.length),
                          );
                        }
                      },
                      controller: storyController,
                      onTapOutside: (v) {
                        FocusManager.instance.primaryFocus!.unfocus();
                      },
                      textInputAction: TextInputAction.newline,
                      keyboardType: TextInputType.multiline,
                      style: regularTextStyle(
                          fontSize: isIpad ? 20.0 : 14.0,
                          color: MyColor.black
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: Languages.of(context)!.writehere.toString(),
                        hintStyle: regularTextStyle(
                            fontSize: isIpad ? 20.0 : 14.0,
                            color: MyColor.grayLite1
                        ),
                        isDense: true,
                        contentPadding: EdgeInsets.only(top: isIpad ? 15 : 10),
                      ),
                      maxLines: null,
                      cursorColor: MyColor.black,
                    ),
                    SizedBox(height: isIpad ? 15 : 10),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: isIpad ? 12 : 0),
                        child: Text(
                          '$wordCount words  ',
                          style: regularTextStyle(
                              fontSize: isIpad ? 18.0 : 12.0,
                              color: MyColor.grayLite1
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: isIpad ? 25 : 15,
                ),
                child: Column(
                  children: [
                    SizedBox(height: isIpad ? 15 : 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            Languages.of(context)!.storyVidoContant,
                            style: regularTextStyle(
                                fontSize: isIpad ? 22.0 : 15.0,
                                color: MyColor.black
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: isIpad ? 15 : 10),
                    commonTextField(
                      storyvideolinkController,
                      Languages.of(context)!.enterTheNameIfYourvideolink.toString(),
                      TextInputAction.done,
                      TextInputType.text,
                      "Recipe Name",
                      2,
                      1,
                      isIpad,
                    ),
                    SizedBox(height: isIpad ? 20 : 15),
                  ],
                ),
              ),
              SizedBox(height: isIpad ? 40 : 30),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          bottom: isIpad ? 40.0 : 30.0,
          left: isIpad ? 30 : 20,
          right: isIpad ? 30 : 20,
          top: isIpad ? 20 : 0,
        ),
        child: GlobalButton(
          widget.onCallScreen == true
              ? Languages.of(context)!.edit
              : Languages.of(context)!.add.toString(),
          MyColor.appTheme,
          MyColor.appTheme,
          isIpad ? btnSize55 * 1.3 : btnSize55,
          double.infinity,
          addOnTap,
          isIpad ? 70 : 55,
          isIpad ? 8 : 5,
          0,
          mediumTextStyle(
              fontSize: isIpad ? 22.0 : 16.0,
              color: MyColor.white
          ),
        ),
      ),
    );
  }

  dynamic isFocusColor = '';

  Widget commonTextField(
      TextEditingController controller,
      String labelText,
      TextInputAction textInputAction,
      TextInputType textInputType,
      String type,
      int maxLines,
      int minLine,
      bool isIpad,
      ) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            color: isFocusColor == type ? MyColor.liteOrange : MyColor.grayLite
        ),
        color: MyColor.white,
        borderRadius: BorderRadius.all(Radius.circular(isIpad ? 16 : 12)),
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(
          isIpad ? 16 : 12,
          isIpad ? 8 : 5,
          0,
          isIpad ? 20 : 15
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
            fontSize: isIpad ? 20.0 : 14.0,
            color: MyColor.black
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: labelText,
          hintStyle: regularTextStyle(
              fontSize: isIpad ? 20.0 : 14.0,
              color: MyColor.grayLite1
          ),
          counter: const Offstage(),
          isDense: true,
          contentPadding: EdgeInsets.only(top: isIpad ? 15 : 10),
        ),
        maxLines: maxLines,
        minLines: minLine,
        cursorColor: MyColor.black,
      ),
    );
  }

  void addOnTap() {
    setState(() {
      isValidate = true;

      // Validate Image 1
      if (storyModel.image == null && selectedImage1 == null) {
        imageError = "Please add image";
        isImage = true;
        isValidate = false;
      } else {
        isImage = false;
        imageError = "";
      }

      // Validate Image List
      if (storyModel.image == null && imageFileList.isEmpty) {
        imageError = "Please add image";
        isImage1 = true;
        isValidate = false;
      } else {
        isImage1 = false;
        imageError = "";
      }

      // Validate Title
      final titleValidationResult = validateTitle(titleController.text.trim());
      if (titleValidationResult != null) {
        titleError = titleValidationResult;
        isValidate = false;
      }

      // Validate Story
      final storyValidationResult = validateStory(storyController.text.trim());
      if (storyValidationResult != null) {
        storyError = storyValidationResult;
        isValidate = false;
      }
    });

    // Proceed to add the story if validation passes
    if (isValidate) {
      // Future.delayed(Duration.zero, addStories);
      widget.onCallScreen == true
          ? editStories(true)
          : Future.delayed(Duration.zero, addStories);
    }
  }

  void addOnTap1() {
    isValidate = true;

    setState(() {
      if (selectedImage1 == null) {
        imageError = "Please add image";
        isImage = true;
        isValidate = false;
      } else {
        isImage = false;
        imageError = "";
      }
      // if(imageFileList.isEmpty){
      //   imageError = "Please add image";
      //   isImage1 = true;
      //   isValidate = false;
      // }else{
      //   isImage1 = false;
      //   imageError = "";
      // }
      // Validate Title
      final titleValidationResult = validateTitle(titleController.text.trim());
      if (titleValidationResult != null) {
        titleError = titleValidationResult;
        isValidate = false;
      } else {
        titleError = "";
      }

      // Validate Story
      final storyValidationResult = validateStory(storyController.text.trim());
      if (storyValidationResult != null) {
        storyError = storyValidationResult;
        isValidate = false;
      } else {
        storyError = "";
      }
    }); // Update UI once after all validations

    // If everything is valid, proceed to add the story
    if (isValidate) {
      Future.delayed(Duration.zero, addStories);
    }
  }

  /// Validation function for Story
  String? validateStory(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Story cannot be empty.";
    }
    if (Utility().countWords(value) < 100) {
      return "Story must have at least 100 words.";
    }
    return null; // Validation passed
  }

  /// Validation function for Title
  String? validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Title cannot be empty.";
    }
    if (Utility().countWords(value) > 30) {
      return "Title must not exceed 30 words.";
    }
    return null; // Validation passed
  }

  addStories() async {
    AddStoriesRequest addStoriesRequest = AddStoriesRequest(
        title: titleController.text,
        description: storyController.text,
        storiesVideolink: storyvideolinkController.text);
    await ApiServices.addStories(
        context, addStoriesRequest, selectedImage1, imageFileList)
        .then((onValue) {
      if (onValue.status == true) {
        var data = StoryModel.fromJson(onValue.data);
        Navigator.pop(context);
        widget.onCallback(data);
      }
    });
  }

  StoryModel storyModel = StoryModel();
  editStories(bool check) async {
    if (widget.storyid.toString() != "null") {
      AddStoriesRequest addStoriesRequest = AddStoriesRequest(
          storyid: widget.storyid!.toString(),
          title: titleController.text,
          description: storyController.text,
          storiesVideolink: storyvideolinkController.text);
      await ApiServices.editStories(
          context, addStoriesRequest, selectedImage1, imageFileList)
          .then((onValue) {
        print("oncall>>>>>>>${onValue}");
        if (onValue.status == true) {
          storyModel = StoryModel.fromJson(onValue.data);
          var data = StoryModel.fromJson(onValue.data);
          // selectedImage1 = File(storyModel.image.toString());
          titleController.text = storyModel.title.toString();
          storyController.text = storyModel.description.toString();
          widget.onCallback();
          check == true ? Navigator.pop(context) : null;
        }
      });
    }
  }

  onCallBackImage1(var file) {
    setState(() {
      imageFileList.clear();
      selectedImage1 = File(file.path);
      imageFileList.add(XFile(selectedImage1!.path));
    });
  }

  onCallBackImage2(var file) {
    setState(() {
      selectedImage2 = File(file.path);
      imageFileList.add(XFile(selectedImage2!.path));
    });
  }
}