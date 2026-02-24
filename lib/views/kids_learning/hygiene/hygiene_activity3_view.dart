import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/dimen.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/constant/stringfile.dart/language.dart';
import 'package:cooking_champs/utils/navigators.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:cooking_champs/views/kids_learning/hygiene/hygiene_activity4_view.dart';
import 'package:cooking_champs/views/kids_learning/quiz_view.dart';
import 'package:cooking_champs/widgets/dotted_textField.dart';
import 'package:cooking_champs/widgets/global_button.dart';
import 'package:flutter/material.dart';


class HygieneActivity3View extends StatefulWidget {
  const HygieneActivity3View({super.key});

  @override
  State<HygieneActivity3View> createState() => _HygieneActivity3ViewState();

}

class _HygieneActivity3ViewState extends State<HygieneActivity3View> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.white,
      body: Column(
        children: [


          Padding(
            padding: const EdgeInsets.only(
                top: 30.0, bottom: 20, left: 20, right: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UiUtils.hygieneAppBar(() => Navigator.pop(context),
                    color: MyColor.black, text: "Activity 3.3"),
                UiUtils.bookReadGirl(MyColor.green, AssetsPath.bookReadImg, true)
              ],
            ),
          ),

          Expanded(
              child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                UiUtils.buildBoldText(
                    "As a group think about some places germs might hide. List 3 places.",
                    color: MyColor.green,
                    fontSize: 23.0),

                CustomTextFieldWithDottedLines(
                  maxLines: 8, controller:controller, // Example for 8 lines
                ),

                // QuizQuestion(questionNumber:"", questionText:"",controller: controller,maxLine: 8,),

                hsized80,
              ],
            ),
          ))
        ],
      ),
      bottomSheet: Container(
        color: MyColor.white,
          padding: EdgeInsets.only(bottom:45,left:20,right:20),
          child: GlobalButton(
              Languages.of(context)!.submit,
              MyColor.appTheme,
              MyColor.appTheme,
              btnSize55,
              double.infinity,
              () => CustomNavigators.pushNavigate(HygieneActivity4(), context),
              55,
              0,
              0,
              semiBoldTextStyle(fontSize:18.0, color: MyColor.white))),
    );
  }


}
