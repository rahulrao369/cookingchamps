import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/model/static_model/sense_model.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:cooking_champs/views/kids_learning/celebrations/celebration_chapter1_view.dart';
import 'package:cooking_champs/views/kids_learning/the_sense/sense_chapter1_view.dart';
import 'package:cooking_champs/views/kids_learning/the_sense/sense_chapter2_view.dart';
import 'package:cooking_champs/views/kids_learning/the_sense/sense_chapter3_view.dart';
import 'package:cooking_champs/views/kids_learning/the_sense/sense_chapter4_view.dart';
import 'package:flutter/material.dart';

int eventCurrentPage = 0;
List<String> skillList = [];
class TheSenseView extends StatefulWidget {
  const TheSenseView({super.key});

  @override
  State<TheSenseView> createState() => _TheSenseViewState();
}


final PageController _pageController = PageController();

class _TheSenseViewState extends State<TheSenseView> {
  late List<Widget> pageList;

  @override
  void initState() {
    pageList = [
      SenseChapter1View(),
      SenseChapter2View(),
      SenseChapter3View(),
      ...buildEventPages(getSenseList()),
    ];
    super.initState();
  }

  List<Widget> buildEventPages(List<SenseModel> sense) {
    List<Widget> eventPages = [];
    if (sense.isNotEmpty) {
      // First page: 2 events (or all events if fewer than 2)
      List<SenseModel> firstPageItems = sense.sublist(0, sense.length > 2 ? 2 : sense.length);
      eventPages.add(SenseChapter4View(senseList: firstPageItems));

      // Second page: Remaining events (if any)
      if (sense.length > 2) {
        List<SenseModel> remainingItems = sense.sublist(2);
        eventPages.add(SenseChapter4View(senseList: remainingItems));
      }
    }
    return eventPages;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.orange,
      body: Stack(
        children: [
          Column(
            children: [

              Container(
                color:eventCurrentPage == 0?MyColor.red1:MyColor.white,
                padding: const EdgeInsets.only(top:45.0,left:20,right: 20,bottom: 20),
                child:UiUtils.hygieneAppBar(()=> Navigator.pop(context),text: "The Sense",color: eventCurrentPage == 0?MyColor.white:MyColor.black),
              ),

              Expanded(
                child: PageView.builder(
                    itemCount: pageList.length,
                    controller: _pageController,
                    onPageChanged: onPageChanged,
                    itemBuilder: (context, int index) {
                      eventCurrentPage = index;
                      return Container(child: pageList[eventCurrentPage]);
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
                                    color: eventCurrentPage == i
                                        ? MyColor.appTheme
                                        : eventCurrentPage == 2
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
      eventCurrentPage = value;
    });
  }


}
