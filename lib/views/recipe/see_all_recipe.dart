// import 'package:cooking_champs/constant/my_color.dart';
// import 'package:cooking_champs/constant/my_fonts_style.dart';
// import 'package:cooking_champs/views/recipe/recipe_list_view.dart';
// import 'package:flutter/material.dart';
//
// class SeeAllRecipeView extends StatefulWidget {
//   final String pageType;
//   const SeeAllRecipeView({super.key, required this.pageType});
//   @override
//   State<SeeAllRecipeView> createState() => _SeeAllRecipeViewState();
// }
//
// class _SeeAllRecipeViewState extends State<SeeAllRecipeView> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: MyColor.colorFFFED6,
//           leading: InkWell(
//             onTap: () => Navigator.pop(context),
//             child: Padding(
//               padding: const EdgeInsets.only(left: 20.0),
//               child: Icon(Icons.arrow_back_ios),
//             ),
//           ),
//           title: Text(
//             "Popular Recipe",
//             style: mediumTextStyle(fontSize: 18.0, color: MyColor.black),
//           ),
//           centerTitle: false,
//         ),
//         body:
//             // widget.pageType ==  true?PopularListView(pageType: "dash",):
//             RecipeListView(
//           pageType: widget.pageType,
//         ));
//   }
// }




import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/views/recipe/recipe_list_view.dart';
import 'package:flutter/material.dart';

class SeeAllRecipeView extends StatefulWidget {
  final String pageType;
  const SeeAllRecipeView({super.key, required this.pageType});

  @override
  State<SeeAllRecipeView> createState() => _SeeAllRecipeViewState();
}

class _SeeAllRecipeViewState extends State<SeeAllRecipeView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isIpad = size.width > 600;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyColor.colorFFFED6,
          toolbarHeight: isIpad ? 70.0 : null, // iPad ke liye toolbar height badhao
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Padding(
              padding: EdgeInsets.only(left: isIpad ? 30.0 : 20.0),
              child: Icon(
                Icons.arrow_back_ios,
                size: isIpad ? 28.0 : null, // iPad ke liye icon size badhao
              ),
            ),
          ),
          title: Text(
            "Popular Recipe",
            style: mediumTextStyle(
              fontSize: isIpad ? 22.0 : 18.0, // iPad ke liye font size badhao
              color: MyColor.black,
            ),
          ),
          centerTitle: false,
        ),
        body: RecipeListView(
          pageType: widget.pageType,
        ));
  }
}