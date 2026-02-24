import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/constant/stringfile.dart/language.dart';
import 'package:cooking_champs/utils/navigators.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:cooking_champs/views/kids_learning/common_activity_widget.dart';
import 'package:cooking_champs/widgets/global_button.dart';
import 'package:flutter/material.dart';

class CelebrationActivity1View extends StatefulWidget {
  const CelebrationActivity1View({super.key});

  @override
  State<CelebrationActivity1View> createState() =>
      _CelebrationActivity1ViewState();
}

class _CelebrationActivity1ViewState extends State<CelebrationActivity1View> {
  // Helper function to build TextFields
  Widget _buildTableTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: SizedBox(
        height: 50,
        child: TextField(
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          ),
          style: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }

  // Helper function to build a table row
  TableRow _buildTableRow() {
    return TableRow(
      children: [
        _buildTableTextField(),
        _buildTableTextField(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              hsized45,
              // Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: UiUtils.hygieneAppBar(
                          () => CustomNavigators.popNavigate(context),
                      text: "Activity 10.1",
                      color: MyColor.black,
                    ),
                  ),
                  UiUtils.bookReadGirl(
                      MyColor.purpleNavy, AssetsPath.bookReadImg, true),
                ],
              ),
              // Description Text
              UiUtils.buildNormalText(
                "In a group talk about the special celebrations you have with your family. Why do you have these celebrations? What are you celebrating? Use the table below and make a list of all the special festivities you celebrate over the year. Next to the celebration write what special foods you eat during these special days.",
                color: MyColor.black,
                fontSize: 16.0,
              ),
              hsized15,
              // Table
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: MyColor.purpleNavy),
                ),
                child: Table(
                  border: TableBorder.all(
                    color: MyColor.purpleNavy,
                    width: 1,
                  ),
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(2),
                  },
                  children: [
                    // Header Row
                    TableRow(
                      decoration: BoxDecoration(
                        color: MyColor.purpleNavy,
                      ),
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Name of Celebration',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Special foods',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    // Add Table Rows using helper function
                    for (int i = 0; i < 6; i++) _buildTableRow(),
                  ],
                ),
              ),
              hsized15,
              // Extension Box
              UiUtils.extensionBox(
                "Take a photo of yourself and stick it in your Secret Recipes. Select and write your favourite festivity recipe under your photo.",
                extension: "Activity 10.1 | Extension",
              ),
              hsized50,
              // Submit Button
              GlobalButton(
                Languages.of(context)!.submit,
                MyColor.appTheme,
                MyColor.appTheme,
                55,
                double.infinity,
                    () => setState(() {
                  activityPageController.jumpToPage(activityCurrentIndex + 1);
                }),
                55,
                0,
                0,
                semiBoldTextStyle(fontSize: 16.0, color: MyColor.white),
              ),
              hsized100,
            ],
          ),
        ),
      ),
    );
  }
}
