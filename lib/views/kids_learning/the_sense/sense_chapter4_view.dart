import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/model/static_model/sense_model.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:cooking_champs/views/kids_learning/the_sense/the_sense_view.dart';
import 'package:flutter/material.dart';

class SenseChapter4View extends StatelessWidget {
  final List<SenseModel> senseList;
  const SenseChapter4View({super.key,required this.senseList});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal:20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UiUtils.buildBoldText("Let’s Look", color: MyColor.red1,fontSize:20.0),
            hsized15,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: senseList.map((event) => buildSenseCard(event)).toList(),
            ),
           hsized20,
            eventCurrentPage == 4?
           UiUtils.buildFunFact(title:"Fun Fact", fact:"The human tongue has on average 3,000 - 10,000 taste buds! WOW!"):SizedBox.shrink(),

           // buildPageContent(),
            hsized100
          ],
        ),
      ),
    );
  }


  Widget buildPageContent() {
    final senses = getSenseList();
    final halfLength = (senses.length / 3).ceil();

    // First page = first half of senses, second page = remaining senses
    final List<SenseModel> pageSenses = eventCurrentPage == 2
        ? senses.sublist(0, halfLength)
        : senses.sublist(halfLength);

    return Column(
      children: pageSenses.map((sense) {
        return buildSenseCard(sense);
      }).toList(),
    );
  }

  // Widget to display a sense as a card
  Widget buildSenseCard(SenseModel sense) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(sense.imagePath, width:83, height:83),
        hsized5,
        UiUtils.buildParagraph("", sense.title, " ${sense.description}",color:sense.color,regularColor:sense.color,highlightFontSize:20.0,regularFontSize: 16.0,),
        hsized25,
      ],
    );
  }
}
