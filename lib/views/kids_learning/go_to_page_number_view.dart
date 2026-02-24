import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/dimen.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/constant/stringfile.dart/language.dart';
import 'package:cooking_champs/utils/navigators.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:cooking_champs/views/kids_learning/all_about_vegetables/about_vegetable_view.dart';
import 'package:cooking_champs/views/kids_learning/hygiene/hygiene_activity3_view.dart';
import 'package:cooking_champs/views/kids_learning/hygiene/hygine_view.dart';
import 'package:cooking_champs/widgets/global_button.dart';
import 'package:flutter/material.dart';

class GoToPageNumberView extends StatefulWidget {
  String text;
  Color color;
  Color textColor;
  String appBarTitle;

  GoToPageNumberView(
      {super.key,
      required this.text,
      required this.color,
      required this.appBarTitle,
      this.textColor = MyColor.green});

  @override
  State<GoToPageNumberView> createState() => _GoToPageNumberViewState();
}

class _GoToPageNumberViewState extends State<GoToPageNumberView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top:45.0, bottom: 20, left: 20, right: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: UiUtils.hygieneAppBar(() => Navigator.pop(context),
                        color: MyColor.black, text: widget.appBarTitle)),

                UiUtils.bookReadGirl(widget.color, AssetsPath.readBookBoy, true)
              ],
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                UiUtils.buildBoldText(widget.text,
                    color: widget.textColor, fontSize: 23.0),
                hsized40,

                Visibility(
                    visible: widget.appBarTitle == "Activity 6.5",
                    child: UiUtils.buildFunFact(
                        title: "Fun Fact",
                        fact:
                            "If you eat large amounts of pumpkin and carrot your skin can go yellowish orange!! Yaiks!!")),

              ],
            ),
          ))
        ],
      ),
      bottomNavigationBar: Wrap(
        children: [
          Visibility(
              visible: widget.appBarTitle == "Activity 8.2",
              child: Container(
                padding: EdgeInsets.only(left:20,right:20,bottom:40 ),
                //height: 150,
                alignment: Alignment.bottomCenter,
                child: UiUtils.buildJokeSection(
                    "Q. What letter makes honey?",
                    "A. B!",image: "Boy"),
              )),

          widget.appBarTitle == "Activity 6.6" ||
              widget.appBarTitle == "Activity 6.5" ||
              widget.appBarTitle == "Activity 8.3"||
              widget.appBarTitle == "Activity 9.3" || widget.appBarTitle == "Activity 3.2"|| widget.appBarTitle == "Activity 3.6"|| widget.appBarTitle == "Activity 4.2"|| widget.appBarTitle == "Activity 6.3"|| widget.appBarTitle == "Activity 6.4"|| widget.appBarTitle == "Activity 8.2"
              ? SizedBox.shrink()
              : Padding(
              padding: EdgeInsets.only(bottom: 50, left: 20, right: 20),
              child: GlobalButton(
                  widget.appBarTitle == "Activity 3.6"
                      ? Languages.of(context)!.submit
                      : Languages.of(context)!.next,
                  widget.color,
                  widget.color,
                  btnSize55,
                  double.infinity,
                  onTap,
                  55,
                  0,
                  0,
                  semiBoldTextStyle(fontSize: 18.0, color: MyColor.white))),
        ],
      )

    );
  }

  onTap() {
    if (widget.appBarTitle == "Activity 3.6") {
      setState(() {
        hygieneCurrentPage = 0;
      });
      CustomNavigators.pushReplacementNavigate(AllAboutHygieneView(), context);
    } else if (widget.appBarTitle == "Activity 6.5") {
      setState(() {
        widget.appBarTitle = "Activity 6.6";
        widget.text = "Go to page 202 and colour in your own garden";
        widget.color = MyColor.darkSky;
        widget.textColor = MyColor.darkSky;
      });
    } else if (widget.appBarTitle == "Activity 6.6") {
      Navigator.pop(context);
      // CustomNavigators.pushReplacementNavigate(AboutVegetableView(), context);
    } else {
     // CustomNavigators.pushNavigate(HygieneActivity3View(), context);
    }
  }
}
