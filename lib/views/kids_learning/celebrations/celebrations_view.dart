import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/model/static_model/festival_event_model.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:cooking_champs/views/kids_learning/celebrations/celebration_activity3_view.dart';
import 'package:cooking_champs/views/kids_learning/celebrations/celebration_chapter10_view.dart';
import 'package:cooking_champs/views/kids_learning/celebrations/celebration_chapter1_view.dart';
import 'package:cooking_champs/views/kids_learning/celebrations/celebration_chapter2_view.dart';
import 'package:cooking_champs/views/kids_learning/celebrations/celebration_chapter9_view.dart';
import 'package:flutter/material.dart';


int celebrationCurrentPage = 0;
final PageController _pageController = PageController();

class CelebrationsView extends StatefulWidget {
  const CelebrationsView({super.key});

  @override
  State<CelebrationsView> createState() => _CelebrationsViewState();
}

class _CelebrationsViewState extends State<CelebrationsView> {
  late List<Widget> pageList;

  @override
  void initState() {
    super.initState();
    // Initialize all pages: Static pages + paginated events
    pageList = [
      CelebrationChapter1View(),
      ...buildEventPages(eventsData()),
      CelebrationChapter9View(),
      CelebrationChapter10View(),
      CelebrationActivity3View(),
    ];
  }

  List<Widget> buildEventPages(List<FestivalEventModel> events) {
    List<Widget> eventPages = [];
    if (events.isNotEmpty) {
      eventPages.add(
          CelebrationChapter2View(events: [events[0]])); // First page: 1 event
      int startIndex = 1;
      while (startIndex < events.length) {
        List<FestivalEventModel> subEvents = events.sublist(
            startIndex,
            startIndex + 2 <= events.length ? startIndex + 2 : events.length);
        eventPages.add(CelebrationChapter2View(events: subEvents));
        startIndex += 2;
      }
    }
    return eventPages;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.purpleNavy,
      body: Column(
        children: [
          _buildAppBar(),
          Expanded(
            child: Stack(
              children: [
                PageView.builder(
                  itemCount: pageList.length,
                  controller: _pageController,
                  onPageChanged: (index) => setState(() {
                    celebrationCurrentPage = index;
                  }),
                  itemBuilder: (context, index) {
                    celebrationCurrentPage = index;
                    return pageList[index];
                  },
                ),

                UiUtils.roundedPage()
              ],
            ),
          ),
          _buildPageIndicator(),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      color: celebrationCurrentPage == 0 ? MyColor.purpleNavy : MyColor.white,
      padding: const EdgeInsets.only(top: 50.0, left: 20, right: 20, bottom: 20),
      child: UiUtils.hygieneAppBar(() => Navigator.pop(context),
          text: "Celebrations",
          color: celebrationCurrentPage == 0 ? MyColor.white : MyColor.black),
    );
  }

  Widget _buildPageIndicator() {
    return Container(
      color: MyColor.white,
      height: 50,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < pageList.length; i++)
            _indicatorDotsWidget(
                color: celebrationCurrentPage == i
                    ? MyColor.appTheme
                    : const Color(0xFFDBD9D9),
                width: 10),
        ],
      ),
    );
  }

  Container _indicatorDotsWidget({required Color color, required double width}) {
    return Container(
      margin: const EdgeInsets.all(4),
      height: 10,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}




// import 'package:cooking_champs/constant/my_color.dart';
// import 'package:cooking_champs/utils/ui_utils.dart';
// import 'package:cooking_champs/views/kids_learning/celebrations/celebration_chapter1_view.dart';
// import 'package:cooking_champs/views/kids_learning/celebrations/celebration_chapter2_view.dart';
// import 'package:flutter/material.dart';
//
// int celebrationCurrentPage = 0;
// List<String> skillList = [];
// class CelebrationsView extends StatefulWidget {
//   const CelebrationsView({super.key});
//
//   @override
//   State<CelebrationsView> createState() => _CelebrationsViewState();
// }
//
//
// final PageController _pageController = PageController();
//
// class _CelebrationsViewState extends State<CelebrationsView> {
//   List<Widget> pageList = [
//     CelebrationChapter1View(),
//     CelebrationChapter2View(),
//   ];
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context);
//     return Scaffold(
//       backgroundColor: MyColor.purpleNavy,
//       body: Stack(
//         children: [
//           Column(
//             children: [
//               celebrationCurrentPage == 2?const SizedBox.shrink():
//               Container(
//                 color:celebrationCurrentPage == 0?MyColor.purpleNavy:MyColor.white,
//                 padding: const EdgeInsets.only(top:50.0,left:20,right: 20,bottom: 20),
//                 child:UiUtils.hygieneAppBar(()=> Navigator.pop(context),text: "Celebrations",color: celebrationCurrentPage == 0?MyColor.white:MyColor.black),
//               ),
//               Expanded(
//                 child: PageView.builder(
//                     itemCount: pageList.length,
//                     controller: _pageController,
//                     onPageChanged: onPageChanged,
//                     itemBuilder: (context, int index) {
//                       celebrationCurrentPage = index;
//                       return Container(child: pageList[celebrationCurrentPage]);
//                     }),
//               ),
//             ],
//           ),
//
//
//           UiUtils.roundedPage()
//
//         ],
//       ),
//       bottomNavigationBar: Container(
//         color: MyColor.white,
//         height: 50,
//         child: Container(
//           alignment: Alignment.center,
//           color: MyColor.white,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               for (int i = 0; i < pageList.length; i++)
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Wrap(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(5.0),
//                           child: Row(
//                             children: [
//                               SizedBox(
//                                 child: _indicatorDotsWidget(
//                                     color: celebrationCurrentPage == i
//                                         ? MyColor.appTheme
//                                         : celebrationCurrentPage == 2
//                                         ? MyColor.blueLite1
//                                         : const Color.fromARGB(
//                                         255, 219, 217, 217),
//                                     width: 10),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//
//   Container _indicatorDotsWidget(
//       {required Color color, required double width}) {
//     return Container(
//       height: 10,
//       width: width,
//       decoration:
//       BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
//     );
//   }
//
//   void onPageChanged(int value) {
//     setState(() {
//       celebrationCurrentPage = value;
//     });
//   }
//
//
// }
