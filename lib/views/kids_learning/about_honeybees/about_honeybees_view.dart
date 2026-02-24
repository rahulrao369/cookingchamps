import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:cooking_champs/views/kids_learning/about_honeybees/honey_bee_chapter3.dart';
import 'package:cooking_champs/views/kids_learning/about_honeybees/honey_chapter6_view.dart';
import 'package:cooking_champs/views/kids_learning/about_honeybees/honey_chapter7_view.dart';
import 'package:cooking_champs/views/kids_learning/about_honeybees/honey_chapter9_view.dart';
import 'package:cooking_champs/views/kids_learning/about_honeybees/honey_chpater8_view.dart';
import 'package:flutter/material.dart';
import 'honey_bee_chapter2.dart';
import 'honey_bee_chapter4.dart';
import 'honey_bee_chapter5.dart';
import 'honey_bees_chapter1.dart';

int honeyCurrentPage = 0;
List<String> skillList = [];
class AboutHoneyBeesView extends StatefulWidget {
  const AboutHoneyBeesView({super.key});

  @override
  State<AboutHoneyBeesView> createState() => _AboutHoneyBeesViewState();
}


final PageController _pageController = PageController();

class _AboutHoneyBeesViewState extends State<AboutHoneyBeesView> {
  List<Widget> pageList = [
    HoneyBeeChapter1View(),
    HoneyViewChapter2(),
    HoneyBeeChapter3(),
    HoneyBeeChapter4(),
    HoneyBeeChapter5(),
    HoneyChapter6View(),
    HoneyChapter7View(),
    HoneyChapter8View(),
    HoneyChapter9View(),
  ];


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: MyColor.neonColor,
      body: Stack(
        children: [
          Column(
            children: [
              honeyCurrentPage == 3 || honeyCurrentPage == 4?const SizedBox.shrink():
              Container(
                color:honeyCurrentPage == 0?MyColor.neonColor:MyColor.white,
                padding: const EdgeInsets.only(top:50.0,left:20,right: 20,bottom: 20),
                child:UiUtils.hygieneAppBar(()=> Navigator.pop(context),text: "All About Honeybees and Honey",color: honeyCurrentPage == 0?MyColor.white:MyColor.black),
              ),
              Expanded(
                child: PageView.builder(
                    itemCount: pageList.length,
                    controller: _pageController,
                    onPageChanged: onPageChanged,
                    itemBuilder: (context, int index) {
                      honeyCurrentPage = index;
                      return Container(child: pageList[honeyCurrentPage]);
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
                                    color: honeyCurrentPage == i
                                        ? MyColor.appTheme
                                        : honeyCurrentPage == 2
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
      honeyCurrentPage = value;
    });
  }


}
