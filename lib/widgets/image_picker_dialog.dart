import 'dart:io';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../constant/assets_path.dart' as AssetsPath;

class ImagePickerDialog extends StatefulWidget {
  Function onCallBack;
  String? cropStyle;

  ImagePickerDialog({super.key, required this.onCallBack, this.cropStyle});

  @override
  State<ImagePickerDialog> createState() => _ImagePickerDialogState();
}

class _ImagePickerDialogState extends State<ImagePickerDialog> {
  ImagePicker imagePicker = ImagePicker();
  CroppedFile? _croppedFile;
  dynamic image;
  dynamic _image;
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    // Check if device is iPad/tablet
    final bool isTablet = MediaQuery.of(context).size.shortestSide > 600;

    return MediaQuery(
      data: data.copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        bottomSheet: Wrap(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: isTablet ? 40 : 20, // iPad ke liye zyada padding
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(isTablet ? 30 : 20), // iPad ke liye bada border radius
              ),
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  SizedBox(height: isTablet ? 30 : 20),
                  Text(
                    "Choose Product Images",
                    style: mediumTextStyle(
                        fontSize: isTablet ? 24.0 : 20.0, // iPad ke liye bada font
                        color: MyColor.appTheme
                    ),
                  ),
                  SizedBox(height: isTablet ? 30 : 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: button(
                            "camera",
                            Icons.camera,
                            cameraOnTap,
                            isTablet: isTablet
                        ),
                      ),
                      SizedBox(width: isTablet ? 30 : 20), // iPad ke liye zyada spacing
                      Expanded(
                        flex: 1,
                        child: button(
                            "Gallery",
                            Icons.image,
                            galleryOnTap,
                            isTablet: isTablet
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: isTablet ? 40 : 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  button(String text, IconData icon, GestureTapCallback onTap, {bool isTablet = false}) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        side: BorderSide(
            width: isTablet ? 1.5 : 1.0, // iPad ke liye thoda mota border
            color: MyColor.appTheme
        ),
        minimumSize: Size(
            isTablet ? 150 : 110, // iPad ke liye bada button
            isTablet ? 55 : 45     // iPad ke liye bada button
        ),
        maximumSize: Size(
            isTablet ? 160 : 115, // iPad ke liye bada button
            isTablet ? 60 : 45    // iPad ke liye bada button
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(isTablet ? 12 : 8), // iPad ke liye bada border radius
        ),
      ),
      onPressed: onTap,
      icon: Icon(
        icon,
        color: MyColor.appTheme,
        size: isTablet ? 28 : 24, // iPad ke liye bada icon
      ),
      label: Text(
        text,
        style: mediumTextStyle(
            fontSize: isTablet ? 16.0 : 12.0, // iPad ke liye bada font
            color: MyColor.appTheme
        ),
      ),
    );
  }

  Future<void> chooseImage(type) async {
    if (type == "camera") {
      image = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 50);
    } else {
      image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 50);
    }
    if (image != null) {
      cropImage(image.path);
    }
  }

  Future<void> cropImage(String image) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: image,
      compressFormat: ImageCompressFormat.png,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          cropStyle:
          widget.cropStyle == null ? CropStyle.circle : CropStyle.rectangle,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
          ],
        ),
        IOSUiSettings(
          title: 'Cropper',
          cropStyle:
          widget.cropStyle == null ? CropStyle.circle : CropStyle.rectangle,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
          ],
        ),
      ],
    );
    if (croppedFile != null) {
      _croppedFile = croppedFile;
      _image = File(_croppedFile!.path);
      setState(() {});
      if (_image != null) {
        Navigator.pop(context);
        widget.onCallBack(_image);
      }
    }
  }

  void galleryOnTap() {
    chooseImage("Gallery");
  }

  void cameraOnTap() {
    chooseImage("camera");
  }
}

///.............createKIdsDilog

class ImagePickerKIdsDialog extends StatefulWidget {
  final Function(dynamic) onCallBack;
  final String? cropStyle;

  ImagePickerKIdsDialog({super.key, required this.onCallBack, this.cropStyle});

  @override
  State<ImagePickerKIdsDialog> createState() => _ImagePickerKIdsDialogState();
}

class _ImagePickerKIdsDialogState extends State<ImagePickerKIdsDialog> {
  final ImagePicker imagePicker = ImagePicker();
  CroppedFile? _croppedFile;
  File? selectedImage;
  List<dynamic> avatarImages = List.from(AssetsPath.avatarImages); // svg asset paths

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);

    return MediaQuery(
      data: data.copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        bottomSheet: Wrap(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  hsized20,
                  Text(
                    "Profile Photo",
                    style: mediumTextStyle(
                      fontSize: 20.0,
                      color: MyColor.appTheme,
                    ),
                  ),
                  hsized15,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Expanded(
                          child: button("Camera", Icons.camera, cameraOnTap)),
                      const SizedBox(width: 20),
                      Expanded(
                          child: button("Gallery", Icons.image, galleryOnTap)),
                    ],
                  ),
                  hsized15,
                  Text(
                    "Select an avatar",
                    style: mediumTextStyle(
                      fontSize: 20.0,
                      color: MyColor.appTheme,
                    ),
                  ),
                  hsized15,
                  avatarImages.isNotEmpty
                      ? Wrap(
                    spacing: 35,
                    runSpacing: 18,
                    children: avatarImages.map<Widget>((item) {
                      return GestureDetector(
                        onTap: () async {
                          Navigator.pop(context);
                          widget.onCallBack(item); // string (svg) or file
                        },
                        child: ClipOval(
                          child: item is String && item.endsWith('.svg')
                              ? SvgPicture.asset(
                            item,
                            width: 64,
                            height: 64,
                            fit: BoxFit.cover,
                          )
                              : Image.file(
                            item,
                            width: 64,
                            height: 64,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }).toList(),
                  )
                      : const SizedBox.shrink(),
                  hsized30,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget button(String text, IconData icon, GestureTapCallback onTap) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(width: 1.0, color: MyColor.appTheme),
        minimumSize: const Size(110, 40),
        maximumSize: const Size(115, 40),
      ),
      onPressed: onTap,
      icon: Icon(icon, color: MyColor.appTheme),
      label: Text(
        text,
        style: mediumTextStyle(fontSize: 12.0, color: MyColor.appTheme),
      ),
    );
  }

  void cameraOnTap() => chooseImage("camera");

  void galleryOnTap() => chooseImage("gallery");

  Future<void> chooseImage(String sourceType) async {
    final pickedFile = await imagePicker.pickImage(
      source: sourceType == "camera" ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 50,
    );

    if (pickedFile != null) {
      cropImage(pickedFile.path);
    }
  }

  Future<void> cropImage(String imagePath) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imagePath,
      compressFormat: ImageCompressFormat.png,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          cropStyle:
          widget.cropStyle == null ? CropStyle.circle : CropStyle.rectangle,
          aspectRatioPresets: [CropAspectRatioPreset.original],
        ),
        IOSUiSettings(
          title: 'Cropper',
          cropStyle:
          widget.cropStyle == null ? CropStyle.circle : CropStyle.rectangle,
          aspectRatioPresets: [CropAspectRatioPreset.original],
        ),
      ],
    );

    if (croppedFile != null) {
      final imageFile = File(croppedFile.path);
      setState(() {
        avatarImages.add(imageFile);
      });
      Navigator.pop(context);
      widget.onCallBack(imageFile);
    }
  }
}

