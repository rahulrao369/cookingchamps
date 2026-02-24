import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/utils/navigators.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:flutter/material.dart';

TextEditingController controller1 = TextEditingController();
TextEditingController controller2 = TextEditingController();
TextEditingController controller3 = TextEditingController();
TextEditingController controller4 = TextEditingController();
TextEditingController controller5 = TextEditingController();
TextEditingController controller6 = TextEditingController();
TextEditingController controller7 = TextEditingController();
TextEditingController controller8 = TextEditingController();

class NutsActivity1View extends StatelessWidget {
  const NutsActivity1View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            hsized45,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UiUtils.hygieneAppBar(
                    () => CustomNavigators.popNavigate(context),
                    text: "Activity 9.1",
                    color: MyColor.black),
                UiUtils.bookReadGirl(MyColor.copperRed, AssetsPath.bookReadImg, true)
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UiUtils.buildBoldText("Measuring weight",
                        fontSize: 20.0, color: MyColor.copperRed),

                    UiUtils.buildNormalText(
                        "We know it is good to eat about 30 grams of nuts a day but how many nuts is that?",
                        fontSize: 16.0),

                    UiUtils.buildParagraph("", "You will need: ",
                        "pistachios, cashews, almonds (or other nuts you have available) and Kitchen scales",
                        color: MyColor.black),

                    hsized8,
                    UiUtils.buildParagraph("", "Method: ",
                        "With clean hands, measure out on your kitchen scales. How many nuts make 30 grams? In the space provided draw the number of nuts you needed.",
                        color: MyColor.black),

                    hsized10,
                    questionUi("How many walnuts?",controller1),
                    hsized10,
                    questionUi("How many almonds?",controller2),
                    hsized10,
                    questionUi("How many cashews?",controller3),
                    hsized10,
                    questionUi("How many pistachios?",controller4),
                    hsized10,
                    UiUtils.buildNormalText("Now try making mixed nuts to the weight of 30 grams using all the different nuts."),
                    
                    hsized10,
                    questionUi("How many of each nut did you use to reach 30 grams?",controller5),

                    hsized10,
                    UiUtils.buildNormalText("To answer the next two questions guess first then weigh your selection."),

                    hsized10,
                    fillInTheBlanks("Which nut is the heaviest?", controller6),
                    hsized15,
                    fillInTheBlanks("Which nut is the lightest?", controller7),
                    hsized15,
                    fillInTheBlanks("Were your guesses correct?", controller8),

                    hsized20,
                    UiUtils.extensionBox("Remember the trail mix recipe in chapter 2? Try inventing your own using 30 grams of your favourite nuts.",extension: "Activity 9.1 | Extension"),

                    hsized100



                    // QuizQuestion(questionNumber:"", questionText:"How many walnuts?",maxLine:1,)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  fillInTheBlanks(String text,TextEditingController controller,{double fontSize  = 16.0}){
    return Row(
      children: [
        UiUtils.buildSemiBoldText(text,fontSize:fontSize),
        Expanded(child: UiUtils().textFieldFillInTheBlanks(controller))
      ],
    );
  }

  questionUi(String text,TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UiUtils.buildSemiBoldText(text),
        hsized8,
        UiUtils().textFieldFillInTheBlanks(controller)
      ],
    );
  }
}
