import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/constant/stringfile.dart/language.dart';
import 'package:cooking_champs/new_ui/web_view_screen.dart';
import 'package:cooking_champs/services/api_path.dart';
import 'package:cooking_champs/services/user_prefences.dart';
import 'package:cooking_champs/utils/all_dialogs.dart';
import 'package:cooking_champs/utils/navigators.dart';
import 'package:flutter/material.dart';

class KidsLearningPayment extends StatefulWidget {
  final String parentId;
  final String kidId;
  final String subscriptionAmount;
  final String subscriptionAmountId;
  const KidsLearningPayment({super.key, required this.parentId, required this.subscriptionAmountId, required this.subscriptionAmount, required this.kidId});

  @override
  State<KidsLearningPayment> createState() => _KidsLearningPaymentState();
}

class _KidsLearningPaymentState extends State<KidsLearningPayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      AssetsPath.kidsLearningPaymentBg,
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                      child: Column(
                        children: [
                          hsized25,
                          Text(
                            textAlign: TextAlign.center,
                            "Unlock a Full Year of Cooking Champs!",
                            style: boldTextStyle(
                                fontSize: 22.0, color: MyColor.white),
                          ),
                          hsized5,
                          Text(
                            textAlign: TextAlign.center,
                            "One-time payment of just \$${widget.subscriptionAmount}/year per child",
                            style: mediumTextStyle(
                                fontSize: 16.0, color: MyColor.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                hsized30,
                Text(
                  "With one easy payment, your child gets access to all 12 fun, interactive chapters for the whole year:",
                  style: semiBoldTextStyle(
                      fontSize: 16.0, color: MyColor.color48335CB2),
                ),
                hsized15,
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        height: 110,
                        decoration: BoxDecoration(
                            color: MyColor.blueLite,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AssetsPath.checkIcon,
                              height: 20,
                            ),
                            hsized10,
                            Text(
                              textAlign: TextAlign.center,
                              "Learn kitchen safety, nutrition & healthy habits",
                              style: regularTextStyle(
                                  fontSize: 14.0, color: MyColor.color555555),
                            ),
                          ],
                        ),
                      ),
                    ),
                    wSized20,
                    Expanded(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        height: 110,
                        decoration: BoxDecoration(
                            color: MyColor.liteOrange,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AssetsPath.checkIcon,
                              height: 20,
                            ),
                            hsized10,
                            Text(
                              textAlign: TextAlign.center,
                              "Explore global cuisines & food groups",
                              style: regularTextStyle(
                                  fontSize: 14.0, color: MyColor.color555555),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                hsized15,
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        height: 110,
                        decoration: BoxDecoration(
                            color: MyColor.colorFFFED6,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AssetsPath.checkIcon,
                              height: 20,
                            ),
                            hsized10,
                            Text(
                              textAlign: TextAlign.center,
                              "Build confidence with hands-on cooking",
                              style: regularTextStyle(
                                  fontSize: 14.0, color: MyColor.color555555),
                            ),
                          ],
                        ),
                      ),
                    ),
                    wSized20,
                    Expanded(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        height: 110,
                        decoration: BoxDecoration(
                            color: MyColor.colorE2FFE4,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AssetsPath.checkIcon,
                              height: 20,
                            ),
                            hsized10,
                            Text(
                              textAlign: TextAlign.center,
                              "Earn badges, certificates & rewards",
                              style: regularTextStyle(
                                  fontSize: 14.0, color: MyColor.color555555),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                hsized40,
                Image.asset(
                  AssetsPath.kidsLearningBottomBg,
                ),
                hsized50,
                GestureDetector(
                  onTap: () {
                    _showLockedDialog(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    height: 46,
                    decoration: BoxDecoration(
                        color: MyColor.color48335CB2,
                        borderRadius: BorderRadius.all(Radius.circular(0))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.lock,
                          color: Colors.white,
                        ),
                        wSized15,
                        Text(
                          textAlign: TextAlign.center,
                          "Start Full Course for \$${widget.subscriptionAmount}/year",
                          style: regularTextStyle(
                              fontSize: 14.0, color: MyColor.white),
                        ),
                      ],
                    ),
                  ),
                ),
                hsized10,
                Image.asset(
                  AssetsPath.secure,
                ),
                hsized10,
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _showLockedDialog(BuildContext context) {
    AllDialogs.alertDialog(
      onValue: (value) {
        if (value == true) {
          Navigator.pop(context, true);
        }
      },
      contentPadding: const EdgeInsets.all(5),
      insetPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      context,
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            hsized20,
            Divider(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Image.asset(AssetsPath.champsLogo, height: 72),
                  hsized30,
                  Text(
                    "Let’s Create Your Child’s Cooking Champs Journey!",
                    style: semiBoldTextStyle(
                      fontSize: 24.0,
                      color: MyColor.color555555,
                    ),
                  ),
                  hsized15,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(AssetsPath.checkIcon, height: 15),
                      wSized5,
                      Expanded(
                        child: Text(
                          "Unlock all 12 interactive learning chapters for only \$${widget.subscriptionAmount}/year per child.",
                          style: regularTextStyle(
                            fontSize: 14.0,
                            color: MyColor.color555555,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(AssetsPath.checkIcon, height: 15),
                      wSized5,
                      Expanded(
                        child: Text(
                          "Full access, rewards & lifetime cooking skills.",
                          style: regularTextStyle(
                            fontSize: 14.0,
                            color: MyColor.color555555,
                          ),
                        ),
                      ),
                    ],
                  ),
                  hsized30,
                  GestureDetector(
                    onTap: () async {
                      final String? userId =
                      await PreferencesServices.getPreferencesData(
                          PreferencesServices.userId);

                      if (userId == null || userId.isEmpty) {
                        debugPrint("❌ userId missing");
                        return;
                      }

                      final String effectiveParentId =
                      (widget.parentId.trim().isNotEmpty &&
                          widget.parentId != "null")
                          ? widget.parentId
                          : userId;

                      // 🔍 DEBUG PRINTS
                      debugPrint("🧾 PURCHASE DETAILS");
                      debugPrint("User ID        -> $userId");
                      debugPrint("Parent ID      -> $effectiveParentId");
                      debugPrint("Subscription ID-> ${widget.subscriptionAmountId}");
                      debugPrint("Amount (UI)    -> ${widget.subscriptionAmount}");

                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WebViewScreen(
                            type: "purchasePlan",
                            url: AppUrls.purchasePlanParentURL(
                              parentId: effectiveParentId,
                              subscriptionId: widget.subscriptionAmountId,
                            ),
                            title: "Purchase Plan",
                          ),
                        ),
                      );

                      if (result != null && result is Map) {
                        final bool isSuccess = result['status'] ?? false;
                        final String message = result['message'] ?? '';

                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text(isSuccess ? "Success" : "Failed"),
                            content: Text(message),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text("OK"),
                              ),
                            ],
                          ),
                        ).then((value) {
                          if (value == true) {
                            Navigator.pop(context, true);
                          }
                        });
                      }
                    },


                    child: Container(
                      height: 46,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        color: MyColor.color48335CB2,
                        borderRadius: const BorderRadius.all(Radius.circular(31)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.lock, color: Colors.white),
                          wSized15,
                          Text(
                            "Start Now – \$${widget.subscriptionAmount}/year",
                            style: regularTextStyle(
                              fontSize: 14.0,
                              color: MyColor.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      barrierColor: Colors.black54, // dim behind
      backgroundColor: Colors.white, // alert box itself
    );
  }


  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leadingWidth: 0,
      automaticallyImplyLeading: false,
      backgroundColor: MyColor.yellowF6F1E1,
      surfaceTintColor: MyColor.yellowF6F1E1,
      title: Row(
        children: [
          InkWell(
            radius: 80,
            borderRadius: BorderRadius.circular(30),
            onTap: () {
              CustomNavigators.popNavigate(context);
            },
            child: const Padding(
              padding: EdgeInsets.only(left: 5.0, right: 10),
              child: Icon(
                Icons.arrow_back_ios,
                size: 28,
                color: Colors.black,
              ),
            ),
          ),
          Text(
            Languages.of(context)!.kidsLearning,
            style: mediumTextStyle(fontSize: 18.0, color: MyColor.black),
          ),
        ],
      ),
      centerTitle: true,
      elevation: 0,
    );
  }
}
