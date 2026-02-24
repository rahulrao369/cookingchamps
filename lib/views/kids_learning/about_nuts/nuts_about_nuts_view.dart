import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:cooking_champs/views/kids_learning/about_nuts/nuts_chapter1_view.dart';
import 'package:cooking_champs/views/kids_learning/about_nuts/nuts_chapter2_view.dart';
import 'package:cooking_champs/views/kids_learning/about_nuts/nuts_chapter3_view.dart';
import 'package:cooking_champs/views/kids_learning/about_nuts/nuts_chapter4_view.dart';
import 'package:cooking_champs/views/kids_learning/about_nuts/nuts_chapter5_view.dart';
import 'package:cooking_champs/views/kids_learning/about_nuts/nuts_chapter6_view.dart';
import 'package:flutter/material.dart';

int nutsCurrentPage = 0;
List<String> skillList = [];
class AboutNutsView extends StatefulWidget {
  const AboutNutsView({super.key});

  @override
  State<AboutNutsView> createState() => _AboutNutsViewState();
}


final PageController _pageController = PageController();

class _AboutNutsViewState extends State<AboutNutsView> {
  List<Widget> pageList = [
    NutsChapter1View(),
    NutsChapter2View(),
    NutsChapter3View(),
    NutsChapter4View(),
    NutsChapter5View(),
    NutsChapter6View()
  ];


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: MyColor.copperRed,
      body: Stack(
        children: [
          Column(
            children: [
              nutsCurrentPage == 2?const SizedBox.shrink():
              Container(
                color:nutsCurrentPage == 0?MyColor.copperRed:MyColor.white,
                padding: const EdgeInsets.only(top:50.0,left:20,right: 20,bottom: 20),
                child:UiUtils.hygieneAppBar(()=> Navigator.pop(context),text: "Nuts About Nuts",color: nutsCurrentPage == 0?MyColor.white:MyColor.black),
              ),
              Expanded(
                child: PageView.builder(
                    itemCount: pageList.length,
                    controller: _pageController,
                    onPageChanged: onPageChanged,
                    itemBuilder: (context, int index) {
                      nutsCurrentPage = index;
                      return Container(child: pageList[nutsCurrentPage]);
                    }),
              ),
            ],
          ),


          UiUtils.roundedPage()

        ],
      ),
      bottomNavigationBar: Container(
        color: MyColor.white,
        height: 50,
        child: Container(
          alignment: Alignment.center,
          color: MyColor.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < pageList.length; i++)
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Wrap(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            children: [
                              SizedBox(
                                child: _indicatorDotsWidget(
                                    color: nutsCurrentPage == i
                                        ? MyColor.appTheme
                                        : nutsCurrentPage == 2
                                        ? MyColor.blueLite1
                                        : const Color.fromARGB(
                                        255, 219, 217, 217),
                                    width: 10),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }


  Container _indicatorDotsWidget(
      {required Color color, required double width}) {
    return Container(
      height: 10,
      width: width,
      decoration:
      BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
    );
  }

  void onPageChanged(int value) {
    setState(() {
      nutsCurrentPage = value;
    });
  }


}
