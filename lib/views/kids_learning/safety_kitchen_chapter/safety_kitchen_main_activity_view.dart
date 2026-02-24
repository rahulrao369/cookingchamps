import 'package:cooking_champs/views/kids_learning/safety_kitchen_chapter/activity_one_view.dart';
import 'package:cooking_champs/views/kids_learning/safety_kitchen_chapter/activity_three_view.dart';
import 'package:cooking_champs/views/kids_learning/safety_kitchen_chapter/activity_two_view.dart';
import 'package:flutter/material.dart';
import 'package:cooking_champs/views/kids_learning/common_activity_widget.dart';

class MainSafetyKitchenActivityView extends StatelessWidget {
  const MainSafetyKitchenActivityView({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonPageView(
      pages: const [
      ActivityOneView(),
        ActivityTwoView(),
        ActivityThreeView(),
      ],
      initialIndex: 0,
      bottomNavColor: Colors.white, isBottom: false,
    );
  }
}

/*class MainSafetyKitchenActivityView extends StatefulWidget {
  const MainSafetyKitchenActivityView({super.key});

  @override
  State<MainSafetyKitchenActivityView> createState() => _MainSafetyKitchenActivityViewState();
}
int mainIndex = 0;
final PageController safetyPageController = PageController();
class _MainSafetyKitchenActivityViewState extends State<MainSafetyKitchenActivityView> {

  List<KidsRecipeModel> recipeList = [];
  int itemCount = 3;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:Column(
        children: [
          Expanded(
              child:PageView.builder(
              itemCount:itemCount,
              onPageChanged: omPageChanged,
              controller: safetyPageController,
              itemBuilder: (context,int index){
                return getPages(index);
              })),


        ],
      ),
      bottomNavigationBar: Container(
        alignment: Alignment.topCenter,
        color: MyColor.white,
        height:40,
        //margin: EdgeInsets.only(bottom:20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < itemCount; i++)
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child:  SizedBox(
                      child: UiUtils.indicatorDotsWidget(
                          color: mainIndex == i
                              ? MyColor.appTheme
                              : mainIndex == 2
                              ? MyColor.blueLite1
                              : const Color.fromARGB(255, 219, 217, 217), width: 10),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }



  Widget getPages(int index) {
    switch (index) {
      case 0:
        return ActivityOneView();
      case 1:
        return ActivityTwoView();
        case 2:
        return ActivityThreeView();
      default:
        return Center(child: Text("Page not found"));
    }
  }

  //List<Widget> pageList = List.generate(4, (index) => getPageWidget(index));


  void omPageChanged(int value) {
    setState(() {
      mainIndex = value;
    });
  }
}*/
