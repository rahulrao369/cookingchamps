import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/model/static_model/festival_event_model.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:cooking_champs/views/kids_learning/celebrations/celebrations_view.dart';
import 'package:flutter/material.dart';

class CelebrationChapter2View extends StatelessWidget {
  final List<FestivalEventModel> events;

  const CelebrationChapter2View({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:MyColor.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            celebrationCurrentPage == 1?
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UiUtils.buildBoldText("Celebrations around the world", color: MyColor.purpleNavy,fontSize:20.0),
                UiUtils.buildNormalText("Food is an important part of any celebration.",fontSize:16.0),
                hsized20,
                UiUtils.buildNormalText("All around the world people celebrate special events with singing, dancing and sharing food with family and friends, making special days even more special.",fontSize:16.0),

              hsized20,
                UiUtils.buildNormalText("Let’s take a look at some festivals from around the world!",fontSize:16.0,color:MyColor.darkGreen),

              ],
            ):SizedBox.shrink(),
            hsized15,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: events.map((event) => buildEventCard(event)).toList(),
            ),

            hsized30,
            celebrationCurrentPage == 7?
                UiUtils.buildJokeSection("Q. How do you organize a Space party?", "A. You plan et! He! He!"):SizedBox.shrink(),

            hsized100
          ],
        ),
      ),
    );
  }

  Widget buildEventCard(FestivalEventModel event) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UiUtils.buildBoldText(event.title,
            fontSize: 20.0, color: MyColor.darkPink),
        if (event.subtitle.isNotEmpty)
          UiUtils.buildSemiBoldText(event.subtitle,
              fontSize: 17.0, color: event.color),
        UiUtils.buildNormalText(event.description, fontSize: 16.0),
        hsized10,
        Image.asset(event.imagePath),
        hsized25,
      ],
    );
  }
}


// import 'package:cooking_champs/constant/my_color.dart';
// import 'package:cooking_champs/constant/sized_box.dart';
// import 'package:cooking_champs/model/static_model/festival_event_model.dart';
// import 'package:cooking_champs/utils/ui_utils.dart';
// import 'package:cooking_champs/views/kids_learning/celebrations/celebrations_view.dart';
// import 'package:flutter/material.dart';
//
// class CelebrationChapter2View extends StatefulWidget {
//   const CelebrationChapter2View({super.key});
//
//   @override
//   State<CelebrationChapter2View> createState() => _CelebrationChapter2ViewState();
// }
//
// class _CelebrationChapter2ViewState extends State<CelebrationChapter2View> {
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal:20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             UiUtils.buildBoldText("Celebrations around the world", color: MyColor.purpleNavy,fontSize:20.0),
//             hsized15,
//             buildPageContent(),
//             hsized100
//           ],
//         ),
//       ),
//     );
//   }
//
//
//   Widget buildPageContent() {
//     final eventList = eventsData();
//     final halfLength = (eventList.length / 10).ceil();
//
//     // First page = first half of senses, second page = remaining senses
//     final List<FestivalEventModel> pageSenses = celebrationCurrentPage == 2
//         ? eventList.sublist(0, halfLength)
//         : eventList.sublist(halfLength);
//
//     return Column(
//       children: pageSenses.map((event) {
//         return buildSenseCard(event);
//       }).toList(),
//     );
//   }
//
//
//   // Widget to display a sense as a card
//   Widget buildSenseCard(FestivalEventModel sense) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         UiUtils.buildBoldText(sense.title,fontSize:20.0,color: MyColor.darkPink),
//         //hsized5,
//         sense.subtitle.isNotEmpty?UiUtils.buildSemiBoldText(sense.subtitle,fontSize:17.0,color:sense.color):SizedBox.shrink(),
//        // hsized5,
//         UiUtils.buildNormalText(sense.description,fontSize:16.0),
//          hsized10,
//          Image.asset(sense.imagePath,),
//         hsized25,
//       ],
//     );
//   }
// }
