import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/stringfile.dart/language.dart';
import 'package:cooking_champs/views/recipe/recipe_list_view.dart';
import 'package:flutter/material.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';

class BookmarkRecipeView extends StatefulWidget {
  const BookmarkRecipeView({super.key});

  @override
  State<BookmarkRecipeView> createState() => _BookmarkRecipeViewState();
}

class _BookmarkRecipeViewState extends State<BookmarkRecipeView> {
  var favourite = 0;

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
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
                    size: MediaQuery.of(context).size.width > 600 ? 36 : 30,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width > 600 ? 15 : 10),
                Text(
                    Languages.of(context)!.bookmarkRecipes,
                    style: mediumTextStyle(
                        fontSize: MediaQuery.of(context).size.width > 600 ? 28.0 : 18.0,
                        color: MyColor.black
                    )
                ),
              ],
            ),
          ),
          centerTitle: true,
          elevation: 0,
          toolbarHeight: MediaQuery.of(context).size.width > 600 ? 80 : 56,
        ),
      body: RecipeListView(pageType: 'Favorite',)

    );
  }
}
