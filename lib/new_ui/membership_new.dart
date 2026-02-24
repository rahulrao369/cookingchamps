import 'package:cooking_champs/constant/apiConnectorConstants.dart';
import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/model/dynamic_models/membership_list_model.dart';
import 'package:cooking_champs/new_ui/web_view_screen.dart';
import 'package:cooking_champs/services/api_path.dart';
import 'package:cooking_champs/services/user_prefences.dart';
import 'package:cooking_champs/utils/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:cooking_champs/utils/utility.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'dart:convert';
import 'dart:convert' as convert;
import 'dart:developer' as developer;
import 'package:shimmer/shimmer.dart';

class MembershipNew extends StatefulWidget {
  const MembershipNew({super.key});

  @override
  State<MembershipNew> createState() => _MembershipNewState();
}

class _MembershipNewState extends State<MembershipNew> {
  MembershipListModel membershipList = MembershipListModel();
  bool isLoading = true;
  PageController _pageController = PageController(viewportFraction: 0.92);
  int currentIndex = 0;
   String subscriptionId = "";
  @override
  void initState() {
    super.initState();
    membershipDataApi();
  }

  Widget shimmerCard() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade400,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: 380,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isPurchased = membershipList.data?.isNotEmpty == true
        ? membershipList.data![currentIndex].isPlanPurchase ?? false
        : false;

    return CommonScaffold(
      appBar: commonAppBar(
          showBack: true,
          backgroundColor: MyColor.appTheme,
          context: context,
          title: "",
          iconColor: Colors.white,
          centerTitle: false),
      backgroundColor: MyColor.appTheme,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Your Cooking",
                  style: mediumTextStyle(fontSize: 16.0, color: MyColor.white)),
              hsized5,
              Text(
                "Champ is Ready\nto Level Up!",
                textAlign: TextAlign.center,
                style: boldTextStyle(fontSize: 28.0, color: MyColor.white),
              ),
              hsized10,
              Text(
                "Unlock unlimited recipes, interactive guides, cooking games, and special rewards to support your child's culinary adventure.",
                textAlign: TextAlign.center,
                style: regularNormalTextStyle(
                    fontSize: 13.0, color: MyColor.white),
              ),
              hsized20,
              Container(
                height: 55,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(71),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Text("Membership",
                      style: boldTextStyle(
                          fontSize: 24.0, color: MyColor.appTheme)),
                ),
              ),
              hsized20,
              Container(
                height: 243,
                child: isLoading
                    ? ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) => shimmerCard(),
                )
                    : PageView.builder(
                  controller: _pageController,
                  itemCount: membershipList.data?.length ?? 0,
                  onPageChanged: (index) {
                    setState(() {
                      subscriptionId = membershipList.data?[index].stripePriceId ?? "";
                      currentIndex = index;
                    });

                    final purchased = membershipList.data?[index].isPlanPurchase ?? false;
                    if (purchased) {
                      debugPrint("Visible Page Index $index is already purchased.");
                      debugPrint("subscriptionId  $subscriptionId ");
                    }
                  },

                  itemBuilder: (context, index) {
                    final item = membershipList.data![index];
                    final isPurchased =
                        item.isPlanPurchase ?? false;

                    return Opacity(
                      opacity: isPurchased ? 0.4 : 1.0,
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        child: Stack(
                          children: [
                            Image.asset(
                              AssetsPath.membershipBg,
                              fit: BoxFit.fill,
                              width: double.infinity,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  hsized30,
                                  Expanded(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                      NeverScrollableScrollPhysics(),
                                      itemCount: item.subscriptionDetails
                                          ?.length ??
                                          0,
                                      itemBuilder: (context, index1) {
                                        return Padding(
                                          padding:
                                          const EdgeInsets.symmetric(
                                              vertical: 2.0),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.check,
                                                color: Colors.black,
                                                size: 17,
                                              ),
                                              const SizedBox(width: 5),
                                              Expanded(
                                                child: Text(
                                                  item.subscriptionDetails?[index1]
                                                      .title ??
                                                      "",
                                                  style:
                                                  semiBoldTextStyle(
                                                    fontSize: 13.0,
                                                    color: MyColor
                                                        .color000000,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Positioned(
                              right: 0,
                              top: 10,
                              child: Container(
                                margin: const EdgeInsets.only(
                                    right: 50, top: 10),
                                alignment: Alignment.bottomRight,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "\$${item.amount ?? '0'}/",
                                      style: boldMaxLiseTextStyle(
                                        fontSize: 19.0,
                                        color: MyColor.color000000,
                                      ),
                                    ),
                                    Text(
                                      "mo",
                                      style: mediumTextStyle(
                                        fontSize: 19.0,
                                        color: MyColor.color000000,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              hsized20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (currentIndex > 0) {
                        _pageController.previousPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut);
                      }
                    },
                    child: CircleAvatar(
                      backgroundColor: currentIndex == 0 ? Colors.grey.shade300 : Colors.white,
                      radius: 18,
                      child: Icon(
                        Icons.arrow_back_ios_new_sharp,
                        color: currentIndex == 0 ? Colors.grey : MyColor.appTheme,
                        size: 15,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (currentIndex < (membershipList.data?.length ?? 0) - 1) {
                        _pageController.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut);
                      }
                    },
                    child: CircleAvatar(
                      backgroundColor: currentIndex == (membershipList.data?.length ?? 0) - 1
                          ? Colors.grey.shade300
                          : Colors.white,
                      radius: 18,
                      child: Icon(
                        Icons.arrow_forward_ios_sharp,
                        size: 15,
                        color: currentIndex == (membershipList.data?.length ?? 0) - 1
                            ? Colors.grey
                            : MyColor.appTheme,
                      ),
                    ),
                  ),
                ],
              ),

              hsized20,
            ],
          ),
        ),
      ),
      bottomButton: GestureDetector(
        onTap: () async {
          final userId = await PreferencesServices.getPreferencesData(
              PreferencesServices.userId);
          print("userId$userId");

          final selectedItem = membershipList.data?[currentIndex];

          if (selectedItem?.isPlanPurchase == true) {
            Utility.customToast(context, "You have already purchased this plan.");
            return;
          }

          if (userId != null && selectedItem != null )
          {

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WebViewScreen(
                  type: "Memberships",
                  url: AppUrls.getStripeUrl(
                    userId: userId,
                    subscriptionId: subscriptionId.toString(),
                  ),
                  title: "Choose Plan",
                ),
              ),
            ).then((result) {
              if (result != null && result is Map) {
                final bool status = result['status'] ?? false;
                final String message =
                    result['message'] ?? "Something went wrong.";

                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title:
                    Text(status ? "Payment Successful" : "Payment Failed"),
                    content: Text(message),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context, true);
                        },
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                );
              }
            });
          } else {
            Utility.customToast(
                context, "Membership data or User ID not found.");
          }
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 40, left: 15, right: 15),
          height: 50,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isPurchased ? Colors.grey : Colors.white,
            borderRadius: BorderRadius.circular(71),
          ),
          child: Text(
            isPurchased ? "Already Purchased" : "Choose Plan",
            style: mediumTextStyle(
              fontSize: 16.0,
              color: isPurchased ? Colors.white70 : MyColor.appTheme,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> membershipDataApi() async {
    setState(() {
      isLoading = true;
    });
    ApiConnectorConstants.accessToken = await PreferencesServices.getPreferencesData(PreferencesServices.userToken) ?? "";
    try {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);


      var response = await http.get(
        Uri.parse(ApiPath.subscriptionList),
        headers: {
          "Accept": "application/json",
          "Content-type": 'application/json',
          "Authorization": "Bearer ${ApiConnectorConstants.accessToken}"
        },
      );
      Map<String, dynamic> jsonResponse =
      convert.jsonDecode(response.body);
      if (jsonResponse['status'] == true) {
        membershipList = MembershipListModel.fromJson(jsonResponse);
        isLoading = false;
        setState(() {});
      } else {
        Utility.customToast(context, "${jsonResponse['message']}");
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      debugPrint("Error in membershipDataApi: $error");
    }
  }
}
