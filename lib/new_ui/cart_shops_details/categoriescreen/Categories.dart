import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/new_ui/cart_shops_details/common/defaulttext.dart';
import 'package:flutter/material.dart';

import 'widgets/categorieslist.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final List<Map<String, String>> categories = [
    {'name': 'Aprons', 'image': AssetsPath.cookies},
    {'name': 'Plates', 'image': AssetsPath.pan},
    {'name': 'Cleaning', 'image': AssetsPath.listImage},
    {'name': 'Cookware', 'image': AssetsPath.imagesList},
    {'name': 'Glassware', 'image': AssetsPath.cookies},
    {'name': 'Utensils', 'image': AssetsPath.pan},
  ];

  final List<Color> bgColors = [
    Color(0xFFFFF0F0),
    Color(0xFFFFF5E5),
    Color(0xFFF0F3FF),
    Color(0xFFE5FFE8),
    Color(0xFFFFFBE5),
    Color(0xFFFFE5F0),
    Color(0xFFF0FFFF),
    Color(0xFFE8E5FF),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;

    final headerFontSize = screenWidth * 0.045;



    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: MyColor.appbarbg,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.keyboard_arrow_left_rounded, size: 40),
        ),
        centerTitle: false,
        title: Text(
          'Categories',
          style: mediumTextStyle(
            fontSize: headerFontSize,
            color: Colors.black,
          ),
        ),
      ),
      body: Categorieslist(),
    );
  }
}
