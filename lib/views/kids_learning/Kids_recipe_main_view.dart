import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/model/static_model/food_recipe_model.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:cooking_champs/views/kids_learning/kids_recipe_view.dart';
import 'package:flutter/material.dart';

class KidsRecipeMainView extends StatefulWidget {
 final List<KidsRecipeModel> recipeList;
 final String chapter;
  const KidsRecipeMainView({super.key,required this.recipeList,this.chapter = ""});

  @override
  State<KidsRecipeMainView> createState() => _KidsRecipeMainViewState();
}
late PageController recipePageController;
int recipeCurrentIndex = 0;
class _KidsRecipeMainViewState extends State<KidsRecipeMainView> {
  @override
  void initState() {
    super.initState();
    recipeCurrentIndex = 0;
    recipePageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
          Expanded(child:PageView.builder(
              itemCount: widget.recipeList.length,
              controller:recipePageController,
              onPageChanged:onPageChange,
              //physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context,int index){
            return KidsRecipeView(recipeName: widget.recipeList[index].recipeName, chapter:widget.chapter,recipe:  widget.recipeList[index].foodRecipeModel, appBarTitle:widget.recipeList[index].appBarTitle,color:widget.recipeList[index].color,);
          })),

          Container(
              height:50,
              width: double.infinity,
              padding: EdgeInsets.only(bottom: 20,top: 5,left: 20,right:20),
             // alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                    visible:recipeCurrentIndex != 0,
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          recipePageController.jumpToPage(recipeCurrentIndex-1);
                        });
                      },
                      child: Text("Previous",style:mediumTextStyle(fontSize:15.0, color:MyColor.appTheme)),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:List.generate(widget.recipeList.length,(int index){
                      return Padding(
                        padding: const EdgeInsets.only(left:4.0,right: 4),
                        child: UiUtils.indicatorDotsWidget(color: recipeCurrentIndex == index
                            ? MyColor.appTheme
                            : recipeCurrentIndex == 2
                            ? MyColor.blueLite1
                            : const Color.fromARGB(
                            255, 219, 217, 217),
                            width: 10),
                      );
                    }),
                  ),
                  
                  Visibility(
                    visible:recipeCurrentIndex != widget.recipeList.length-1,
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          recipePageController.jumpToPage(recipeCurrentIndex+1);
                        });
                      },
                      child: Text("Next",style:mediumTextStyle(fontSize:15.0, color:MyColor.appTheme),),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }

  void onPageChange(int value) {
    setState(() {
      recipeCurrentIndex = value;
    });
  }
}


class KidsRecipeModel{
  String recipeName;
  String appBarTitle;
  Color color;
 FoodRecipeModel foodRecipeModel;

  KidsRecipeModel(this.recipeName, this.appBarTitle, this.color, this.foodRecipeModel);
}