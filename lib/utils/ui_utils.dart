import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/model/static_model/matching_model.dart';
import 'package:cooking_champs/services/api_path.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_popup/flutter_popup.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';

class UiUtils {
  static errorText(String error) {
    return Text(error,
        style: regularTextStyle(fontSize: 14.0, color: MyColor.red));
  }
  static Widget networkProfile(double width, double height, String img) {
    // Check if it's an SVG and hosted under your base URL (but actually pointing to a local asset)
    bool isSvg = img.endsWith('.svg');
    bool isAssetSvg = isSvg && img.startsWith(ApiPath.imageBaseUrl);

    // If it's an SVG from the server, strip the base URL to get the asset path
    if (isAssetSvg) {
      img = img.replaceFirst(ApiPath.imageBaseUrl, '');
    }

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: MyColor.white,
        borderRadius: BorderRadius.circular(500),
      ),
      child: img.isNotEmpty && img != ApiPath.imageBaseUrl
          ? ClipRRect(
        borderRadius: BorderRadius.circular(500),
        child: isSvg
            ? SvgPicture.asset(
          img,
          width: width,
          height: height,
          fit: BoxFit.cover,
        )
            : Image.network(
          img,
          width: width,
          height: height,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return SizedBox(width: width, height: height);
          },
          errorBuilder: (context, error, stackTrace) {
            return SizedBox(width: width, height: height);
          },
        ),
      )
          : SizedBox(width: width, height: height),
    );
  }



  static networkImages(double width, double height, String img,
      {bool isBoxFit = true}) {
    return Container(
        width: width,
        decoration: BoxDecoration(
            // color: MyColor.white,
            borderRadius: BorderRadius.circular(8)),
        child: img.isNotEmpty && img != ApiPath.imageBaseUrl
            ? Image.network(
                img,
                width: width,
                height: height,
                fit: isBoxFit ? BoxFit.cover : null,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Container(
                    decoration: BoxDecoration(color: MyColor.colorFFFED6),
                    height: height,
                    width: width,
                  );
                },
                errorBuilder: (BuildContext context, Object error,
                    StackTrace? stackTrace) {
                  return Container(
                    decoration: BoxDecoration(color: MyColor.colorFFFED6),
                    height: height,
                    width: width,
                  );
                },
              )
            : Container(
                decoration: BoxDecoration(color: MyColor.colorFFFED6),
                height: height,
                width: width,
              ));
  }

  static dividerLine() {
    return Container(
      height: 1.3,
      width: double.infinity,
      color: MyColor.grayLite,
    );
  }

  static tabItem(BuildContext context, var size, String text,bool isTab) {
    return Tab(
      child: SizedBox(
          width: size.width * 0.50,
          child: Center(
              child: Text(text,
                  style: mediumTextStyle(
                      fontSize:isTab ?18.0 : 14.0, color: MyColor.color1C1C1C)))),
    );
  }

  static friendRequestUi(
      String text,
      String detail,
      String img,
      String type,
      Function onCallBack,
      GestureTapCallback onTap,
      String friendRequestStatus,
      Function unFallowTap) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            decoration: BoxDecoration(
              color: MyColor.white,
              borderRadius:
                  BorderRadius.circular(12), // Optional rounded corners
            ),
            alignment:
                Alignment.center, // Centers text vertically and horizontally
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(500),
                  child: UiUtils.networkProfile(60.0, 60.0, img),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(text,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: mediumTextStyle(
                                              fontSize: 16.0,
                                              color: MyColor.black)),
                                    ],
                                  ),
                                  type == "Request"
                                      ? Container()
                                      : friendRequestStatus == "Accepted"
                                          ? Container(
                                              height: 25,
                                              decoration: BoxDecoration(
                                                  color: MyColor.grey3,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(6))),
                                              padding: EdgeInsets.all(5),
                                              margin: EdgeInsets.only(left: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    "assets/images/rightperson.png",
                                                    height: 15,
                                                  ),
                                                  SizedBox(
                                                    width: 2,
                                                  ),
                                                  Text("Friends",
                                                      style:
                                                          regularNormalTextStyleWithoutHeight(
                                                              fontSize: 12.0,
                                                              color: MyColor
                                                                  .black)),
                                                ],
                                              ),
                                            )
                                          : friendRequestStatus == "Pending"
                                              ? InkWell(
                                                  radius: 80,
                                                  onTap: () {
                                                    onTap();
                                                    onCallBack("cancel");
                                                    friendRequestStatus =
                                                        "Request Not Sent";
                                                  },
                                                  child: Container(
                                                    height: 35,
                                                    width: 35,
                                                    decoration: BoxDecoration(
                                                        // color: MyColor
                                                        //     .yellowF6F1E1,
                                                        color: Colors.purple,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    6))),
                                                    padding: EdgeInsets.all(5),
                                                    margin: EdgeInsets.only(
                                                        left: 10),
                                                    child: Image.asset(
                                                      "assets/images/rightperson.png",
                                                      height: 15,
                                                    ),
                                                  ),
                                                )
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 0, right: 5),
                                                  child: CustomPopup(
                                                    content: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: List.generate(
                                                          1,
                                                          (index) => InkWell(
                                                              onTap: () {
                                                                unFallowTap();
                                                                //  onTap();
                                                                //        onCallBack("");
                                                                //        friendRequestStatus = "Pending";
                                                              },
                                                              child: Text(
                                                                  'Unfriend'))),
                                                    ),
                                                    child: const Icon(
                                                        Icons.more_horiz),
                                                  ))
                                ],
                              ),
                              hsized3,
                              Text(detail,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: regularTextStyle(
                                      fontSize: 14.0, color: MyColor.black)),
                            ],
                          ),
                        ),
                        type == "Request"
                            ? Row(
                                children: [
                                  InkWell(
                                      radius: 60,
                                      onTap: () {
                                        onCallBack("Accept");
                                      },
                                      child: SvgPicture.asset(
                                          AssetsPath.fillCheck)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                      radius: 60,
                                      onTap: () {
                                        onCallBack("Reject");
                                      },
                                      child: SvgPicture.asset(
                                          AssetsPath.fillCancel)),
                                ],
                              )
                            : SizedBox.shrink()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }

  static notificationCard(String des, String des1, String img) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 5),
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
        decoration: BoxDecoration(
          color: MyColor.white,
          borderRadius: BorderRadius.circular(12), // Optional rounded corners
        ),
        alignment: Alignment.center, // Centers text vertically and horizontally
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(500),
              child: UiUtils.networkProfile(60.0, 60.0, img),
              //Image.asset(img,height: 60,width: 60,)
              //UiUtils.networkProfile(60.0,60.0, img),
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(des1,
                    style:
                        regularTextStyle(fontSize: 13.0, color: MyColor.black)),
                hsized5,
                Text(des,
                    style: semiBoldTextStyle(
                      fontSize: 15.0,
                      color: MyColor.black,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static questionAnswerUi(
      String img, String question, String answer, int index, {bool isTablet = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: isTablet ? 20 : 15), // iPad ke liye spacing
        img.trim().isEmpty
            ? SizedBox(
          height: isTablet ? 60 : 50, // iPad ke liye size
          width: isTablet ? 120 : 107, // iPad ke liye size
        )
            : Padding(
            padding: EdgeInsets.only(left: isTablet ? 20 : 17), // iPad ke liye padding
            child: Image.asset(
              img,
              height: isTablet ? 90 : 80, // iPad ke liye image height
              width: isTablet ? 120 : 107, // iPad ke liye image width
            )),
        SizedBox(height: isTablet ? 10 : 8), // iPad ke liye spacing
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$index.",
              style: semiBoldTextStyle(
                  fontSize: isTablet ? 20.0 : 14.0, // iPad ke liye thoda bada
                  color: MyColor.red1
              ),
            ),
            SizedBox(width: isTablet ? 12 : 10), // iPad ke liye spacing
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      question,
                      style: semiBoldTextStyle(
                          fontSize: isTablet ? 20.0 : 14.00, // iPad ke liye thoda bada
                          color: MyColor.red1
                      ),
                    ),
                    SizedBox(height: isTablet ? 8 : 5), // iPad ke liye spacing
                    Text(
                      answer,
                      style: regularTextStyle(
                          fontSize: isTablet ? 20.0 : 14.50, // iPad ke liye thoda bada
                          color: MyColor.black
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ],
    );
  }

  foodEnergyAppBar(GestureTapCallback onTap, {String text = "Food is energy"}) {
    return Row(
      children: [
        InkWell(
          onTap: onTap,
          child: const Icon(Icons.arrow_back_ios, size: 24),
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: mediumTextStyle(fontSize: 18.0, color: MyColor.black),
        ),
      ],
    );
  }

  static hygieneAppBar(GestureTapCallback onTap,
      {String text = "All About Hygiene", Color color = MyColor.white}) {
    return Row(
      children: [
        InkWell(
          onTap: onTap,
          child: Icon(
            Icons.arrow_back_ios,
            size: 24,
            color: color,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: mediumTextStyle(fontSize: 18.0, color: color),
        ),
      ],
    );
  }

  static roundedPage() {
    return Align(
        alignment: Alignment.bottomRight,
        child: Image.asset(
          AssetsPath.cornerBg,
          height: 110,
          width: 110,
        ));
  }

  static Widget buildNormalText(String text,
      {double fontSize = 16.0, Color color = MyColor.black}) {
    return Text(
      text,
      style: regularNormalTextStyle(fontSize: fontSize, color: color),
    );
  }

  static Widget buildRegularText(String text,
      {double fontSize = 16.0, Color color = MyColor.black}) {
    return Text(
      text,
      style: regularTextStyle(fontSize: fontSize, color: color),
    );
  }

  static Widget buildBoldText(String text,
      {double fontSize = 16.0,
      Color color = MyColor.black,
      TextAlign textAlign = TextAlign.start}) {
    return Text(
      text,
      textAlign: textAlign,
      style: boldTextStyle(fontSize: fontSize, color: color),
    );
  }

  static Widget buildSemiBoldText(String text,
      {double fontSize = 15.0, Color color = MyColor.black}) {
    return Text(
      text,
      style: semiBoldTextStyle(fontSize: fontSize, color: color),
    );
  }

  static Widget buildMediumText(String text,
      {double fontSize = 16.0, Color color = MyColor.black}) {
    return Text(
      text,
      style: mediumTextStyle(fontSize: fontSize, color: color),
    );
  }

  /// Fun Fact Container
  static Widget buildFunFact(
      {required String title, required String fact, String des = ""}) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: MyColor.darkYellow,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: boldTextStyle(fontSize: 18.0, color: MyColor.red1)),
          const SizedBox(height: 5),
          Text(fact,
              style: boldTextStyle(fontSize: 15.0, color: MyColor.appTheme)),
          Visibility(
            visible: des.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(des,
                  style: boldTextStyle(fontSize: 15.0, color: MyColor.white)),
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widgets
  static Widget buildParagraph(
    String prefix,
    String highlight,
    String suffix, {
    Color color = MyColor.pink,
    Color regularColor = MyColor.black,
    double highlightFontSize = 15.0,
    double regularFontSize = 14.0,
    String highlight1 = "",
    String prefix1 = "",
    String highlight2 = "",
    String prefix2 = "",
  }) {
    return RichText(
      text: TextSpan(
        style: regularTextStyle(fontSize: regularFontSize, color: regularColor),
        children: [
          TextSpan(text: prefix),
          TextSpan(
              text: highlight,
              style: boldTextStyle(fontSize: highlightFontSize, color: color)),
          TextSpan(text: suffix),
          TextSpan(
              text: highlight1,
              style: boldTextStyle(fontSize: highlightFontSize, color: color)),
          TextSpan(text: prefix1),
          TextSpan(
              text: highlight2,
              style: boldTextStyle(fontSize: highlightFontSize, color: color)),
          TextSpan(text: prefix2),
        ],
      ),
    );
  }

  /// Image Widget
  static Widget buildImage(String path, {double height = 160, double? width}) {
    return Center(child: Image.asset(path, height: height));
  }

  /// Joke Section Widget
  static Widget buildJokeSection(String que, String ans,
      {String image = "Girl"}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 0),
      child: Stack(
        children: [
          buildImage(
              image == "Girl"
                  ? AssetsPath.foodChapter4Img5
                  : AssetsPath.logImage1,
              height: 220),
          Container(
            width: 250,
            height: 110,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 30.0, top: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(que,
                    style:
                        semiBoldTextStyle(fontSize: 12.0, color: MyColor.pink)),
                hsized8,
                Text(ans,
                    style: semiBoldTextStyle(
                        fontSize: 12.0, color: MyColor.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Joke Section Widget
  static Widget aboutHygieneBoy(String que, String ans) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 0),
      child: Stack(
        children: [
          Image.asset(
            AssetsPath.hygieneChapter6BoyImg,
            height: 230,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 250,
              height: 110,
              padding: const EdgeInsets.only(
                  left: 10.0, top: 5, right: 15, bottom: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(que,
                      style: semiBoldTextStyle(
                          fontSize: 12.0, color: MyColor.pink)),
                  hsized8,
                  Text(ans,
                      style: semiBoldTextStyle(
                          fontSize: 12.0, color: MyColor.white)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static extensionBox(String des,
      {String title = "",
      String extension = "Extension",
      double imgHeight = 127,
      double rightPadding = 50,
      double topPadding = 35,
      Color titleColor = MyColor.black,
      String subDes = ""}) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(right: rightPadding, top: 10, left: 8),
          // height:110,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: MyColor.appTheme, borderRadius: BorderRadius.circular(11)),
          padding:
              EdgeInsets.only(right: 40, left: 20, top: topPadding, bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: mediumTextStyle(fontSize: 15.0, color: titleColor),
              ),
              hsized2,
              Text(
                des,
                style: mediumTextStyle(fontSize: 13.0, color: MyColor.white),
              ),
              hsized5,
              Text(
                subDes,
                style: mediumTextStyle(fontSize: 13.0, color: MyColor.liteGray),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 12),
          decoration: BoxDecoration(
              color: MyColor.darkYellow,
              borderRadius: BorderRadius.circular(55)),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(
            extension,
            style: boldTextStyle(fontSize: 11.0, color: MyColor.black),
          ),
        ),
        Container(
            padding: EdgeInsets.only(top: rightPadding == 55 ? 30 : 0),
            alignment: Alignment.centerRight,
            child: Image.asset(
              AssetsPath.extensionImg,
              height: imgHeight,
            ))
      ],
    );
  }

  static Widget buildBulletPoints(List<String> points,
      {double bottomPadding = 0}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: points
          .map((point) => Padding(
                padding: EdgeInsets.only(bottom: bottomPadding),
                child: Text("• $point",
                    style: regularNormalTextStyle(
                        fontSize: 16.0, color: MyColor.black)),
              ))
          .toList(),
    );
  }

  static Widget buildSteps(List<String> steps,
      {double bottomPadding = 0.0, String step = ""}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: steps
          .asMap()
          .entries
          .map((entry) => Padding(
                padding: EdgeInsets.only(bottom: bottomPadding),
                child: buildParagraph(
                    step.isNotEmpty ? "" : "$step ${entry.key + 1}",
                    step.isNotEmpty ? "$step ${entry.key + 1}" : "",
                    ".${entry.value}",
                    color: MyColor.black,
                    highlightFontSize: 16.0,
                    regularFontSize: 16.0),
              ))
          .toList(),
    );
  }

  static Widget buildStepsNormal(List<String> steps,
      {double bottomPadding = 0.0, String step = ""}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: steps
          .asMap()
          .entries
          .map((entry) => Padding(
              padding: EdgeInsets.only(bottom: bottomPadding),
              child: buildNormalText(
                  "${step.isNotEmpty ? step : ""} ${entry.key + 1}. ${entry.value}")))
          .toList(),
    );
  }

  static Widget bookReadGirl(Color color, String img, bool isIpad) {
    // Responsive sizes based on isIpad
    final double containerWidth = isIpad ? 120.0 : 90.0;
    final double containerHeight = isIpad ? 100.0 : 76.0;
    final double imageWidth = isIpad ? 120.0 : 90.0;
    final double topMargin = isIpad ? 6.0 : 5.0;
    final double leftPadding = isIpad ? 4.0 : 3.0;

    return Stack(
      children: [
        ClipPath(
          clipper: BottomCutClipper(),
          child: Container(
            margin: EdgeInsets.only(top: topMargin),
            height: containerHeight,
            width: containerWidth,
            color: color,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: leftPadding),
          child: Image.asset(
            img,
            width: imageWidth,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }

  fillInTheBlanks(String text, TextEditingController controller,
      {double fontSize = 16.0}) {
    return Row(
      children: [
        UiUtils.buildNormalText(text, fontSize: fontSize),
        Expanded(child: textFieldFillInTheBlanks(controller))
      ],
    );
  }

  textFieldFillInTheBlanks(TextEditingController controller) {
    return Stack(
      children: [
        for (int i = 0; i < 1; i++)
          Container(
            margin: EdgeInsets.only(
              top: 4 + (i + 1) * 17,
            ),
            decoration: const BoxDecoration(
              border: DashedBorder(
                dashLength: 3,
                left: BorderSide.none,
                top: BorderSide.none,
                right: BorderSide.none,
                bottom: BorderSide(color: Colors.black, width: 1),
              ),
            ),
          ),
        SizedBox(
          height: 18,
          child: TextField(
            controller: controller,
            scrollPhysics: NeverScrollableScrollPhysics(),
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
            cursorHeight: 12,
            onTapOutside: (v) {
              FocusManager.instance.primaryFocus!.unfocus();
            },
            style: TextStyle(
              fontSize: 15.0,
            ),
            keyboardType: TextInputType.text,
            // expands: true,
            maxLines: 1,
          ),
        ),
      ],
    );
  }

  static textField(TextEditingController controller, int maxLine) {
    return Stack(
      children: [
        for (int i = 0; i < maxLine; i++)
          Container(
            margin: maxLine == 9
                ? EdgeInsets.only(
                    top: 4 + (i + 1) * 25,
                  )
                : EdgeInsets.only(
                    top: 4 + (i + 1) * 25,
                  ),
            decoration: const BoxDecoration(
              border: DashedBorder(
                dashLength: 2,
                left: BorderSide.none,
                top: BorderSide.none,
                right: BorderSide.none,
                bottom: BorderSide(color: Colors.black, width: 1),
              ),
            ),
          ),
        SizedBox(
          height: maxLine == 9 ? 500 : 60,
          child: TextField(
            controller: controller,
            scrollPhysics: NeverScrollableScrollPhysics(),
            decoration: InputDecoration(border: InputBorder.none),
            cursorHeight: 22,
            onTapOutside: (v) {
              FocusManager.instance.primaryFocus!.unfocus();
            },
            style: TextStyle(
              fontSize: 15.0,
            ),
            keyboardType: TextInputType.multiline,
            // expands: true,
            maxLines: maxLine,
            minLines: 1,
          ),
        ),
      ],
    );
  }

  static Container indicatorDotsWidget(
      {required Color color, required double width}) {
    return Container(
      height: 10,
      width: width,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
    );
  }

  static quizAnswerUI(String answer) {
    return Container(
      padding: EdgeInsets.only(bottom: 18),
      child: buildBoldText("Answer:- $answer",
          color: MyColor.green, fontSize: 15.0),
    );
  }

  Widget buildDragTargets(List<MatchTheFollowingModel> list,
      List<bool> matchingStatus, List<String> matching, var swapRules) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(list.length, (index) {
        return Row(
          children: [
            buildDragTargetContainer(list[index], matchingStatus[index],
                index: index, swapRules: swapRules, matching: matching[index]),
            Icon(
              Icons.arrow_right_alt_outlined,
              size: 30,
              color: MyColor.colorDADADA,
            )
          ],
        );
        //  buildDragTargets(),
      }),
    );
  }

  Widget buildDraggableItems(List<MatchTheFollowingModel> list,
      List<bool> matchingStatus, List<String> matching, var swapRules) {
    return Expanded(
      child: ReorderableListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: List.generate(
          list.length,
          (int index) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              key: Key('item_$index'), // Assign a unique key for each child
              child: buildRuleContainer(
                index,
                list[index],
                matchingStatus[index],
                matching: matching[index],
              ),
            );
          },
        ),
        onReorder: (int oldIndex, int newIndex) {
          if (newIndex > oldIndex) newIndex -= 1;
          swapRules(oldIndex, newIndex);
        },
      ),
    );
  }

  /* Widget buildDraggableItems(List<MatchTheFollowingModel> list,List<bool> matchingStatus,List<String> matching,var swapRules) {
    return Expanded(
      //flex: 2,
      child: ReorderableListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: List.generate(
            list.length, (int index){
          return buildRuleContainer(index,list[index], matchingStatus[index],matching: matching[index]);
        }),
        // list.asMap()
        //     .map((index, item) => MapEntry(
        //   index, ListTile(
        //     selectedColor: Colors.transparent,
        //     key: Key(item.title),
        //     isThreeLine: false,
        //     title: buildRuleContainer(index,list[index], matchingStatus[index],matching: matching[index]),


            // .values
            // .toList(),
        onReorder: (int oldIndex, int newIndex) {
           if (newIndex > oldIndex) newIndex -= 1;
          swapRules(oldIndex, newIndex);
        },
      ),
    );
  }
*/

  Widget buildRuleContainer(
      int index, MatchTheFollowingModel item, bool isMatched,
      {double height = 75, String matching = ""}) {
    return StatefulBuilder(
      builder: (context, setState) {
        return SizedBox(
          height: height,
          // margin: const EdgeInsets.symmetric(vertical: 8),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: DottedBorder(
                  dashPattern: [4, 2],
                  radius: const Radius.circular(20),
                  strokeCap: StrokeCap.round,
                  color: matching == "Correct"
                      ? MyColor.green
                      : matching == "Wrong"
                          ? MyColor.red
                          : matching == "Drag"
                              ? MyColor.liteGrayB5B5B5
                              : MyColor.liteGrayB5B5B5,
                  //item.color,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(35, 8, 15, 8),
                    child: Text(
                      item.title,
                      style:
                          mediumTextStyle(fontSize: 13.0, color: MyColor.black),
                    ),
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: align(isMatched, MyColor.liteGrayB5B5B5, matching)
                  /*  Draggable<int>(
                  data: index, // Provide the index as draggable data
                  feedback: align(isMatched, MyColor.liteGrayB5B5B5,matching),
                  childWhenDragging: align(isMatched,MyColor.liteGrayB5B5B5,matching),
                  child: align(isMatched,MyColor.liteGrayB5B5B5,matching), // Dot draggable only
                ),*/
                  ),
            ],
          ),
        );
      },
    );
  }

  Widget align(bool isMatched, Color color, String matching) {
    return Image.asset(
      AssetsPath.dots,
      color:
          //isMatched ? MyColor.green
          matching == "Correct"
              ? MyColor.green
              : matching == "Wrong"
                  ? MyColor.red
                  : matching == "Drag"
                      ? MyColor.liteGrayB5B5B5
                      : MyColor.liteGrayB5B5B5,
    );
  }

  Widget buildDragTargetContainer(MatchTheFollowingModel item, bool isMatched,
      {double height = 75,
      int index = 0,
      bool submit = false,
      Function(int, int)? swapRules,
      String matching = "" // Accept swapRules callback
      }) {
    bool isHovered = false; // Track hover state
    return StatefulBuilder(
      builder: (context, setState) {
        return MouseRegion(
          onEnter: (_) =>
              setState(() => isHovered = true), // Hovered state changes to true
          onExit: (_) => setState(
              () => isHovered = false), // Hovered state changes to false
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            height: height,
            width: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 30),
                  child: DottedBorder(
                    radius: Radius.circular(8),
                    dashPattern: [4, 2],
                    color: matching == "Correct"
                        ? MyColor.green
                        : matching == "Wrong"
                            ? MyColor.red
                            : matching == "Drag"
                                ? MyColor
                                    .liteGrayB5B5B5 // Selected answers will have aquamarine color
                                : isHovered
                                    ? MyColor.darkSky // Hover state color
                                    : MyColor.liteGrayB5B5B5, // Default color
                    borderType: BorderType.RRect,
                    child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(right: 10, left: 2),
                        child: Image.asset(item.img, height: 65)),
                  ),
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                      AssetsPath.dots,
                      color: matching == "Correct"
                          ? MyColor.green
                          : matching == "Wrong"
                              ? MyColor.red
                              : matching == "Drag"
                                  ? MyColor.liteGrayB5B5B5
                                  : isHovered
                                      ? MyColor.sky
                                      : MyColor
                                          .liteGrayB5B5B5, // Default color or hover color
                    )
                    /* DragTarget<int>(
                    builder: (context, accepted, rejected) {
                   //   submit = false;
                      isHovered = accepted.isNotEmpty; // Check if an item is being dragged over
                      return Image.asset(
                        AssetsPath.dots,
                        color: matching == "Correct"
                            ? MyColor.green:
                        matching == "Wrong"
                            ? MyColor.red:
                        matching == "Drag"
                            ? MyColor.liteGrayB5B5B5
                            : isHovered
                            ? MyColor.sky
                            : MyColor.liteGrayB5B5B5, // Default color or hover color
                      );
                    },
                    onAcceptWithDetails: (detail){
                      if (swapRules != null) {
                        swapRules(index, detail.data); // Trigger swapping logic
                      }
                    },

                    hitTestBehavior: HitTestBehavior.translucent,
                  ),*/
                    ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class BottomCutClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // Start from the top-left corner
    path.lineTo(0, size.height); // Bottom-left cut (50px up from bottom-left)
    path.lineTo(50, size.height - 18); // Draw diagonal cut to the bottom edge

    path.lineTo(size.width, size.height); // Bottom-right cut (50px up)
    path.lineTo(size.width,
        size.height - 50); // Draw diagonal cut to bottom-right corner

    path.lineTo(size.width, 0); // Top-right corner
    path.close(); // Connect back to top-left

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
