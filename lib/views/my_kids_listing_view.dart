import 'package:cached_network_image/cached_network_image.dart';
import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/dimen.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/constant/stringfile.dart/language.dart';
import 'package:cooking_champs/model/dynamic_models/my_child_listing_model.dart';
import 'package:cooking_champs/model/post_model/update_kid_profile_model.dart';
import 'package:cooking_champs/new_ui/let_create_your_kid.dart';
import 'package:cooking_champs/new_ui/web_view_screen.dart';
import 'package:cooking_champs/services/api_path.dart';
import 'package:cooking_champs/services/api_services.dart';
import 'package:cooking_champs/services/user_prefences.dart';
import 'package:cooking_champs/utils/all_dialogs.dart';
import 'package:cooking_champs/utils/navigators.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:cooking_champs/views/authentication/kids_registerd_view.dart';
import 'package:cooking_champs/views/dashboard.dart';
import 'package:cooking_champs/widgets/delete_kid_popup.dart';
import 'package:cooking_champs/widgets/global_button.dart';
import 'package:cooking_champs/widgets/view_full_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:shimmer/shimmer.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';

import 'kids_learning/payment/kids_learning_payment.dart';

class MyKidsListingView extends StatefulWidget {
  final String pageType;
  final Function? onCallBack;

  const MyKidsListingView({super.key, required this.pageType, this.onCallBack});

  @override
  State<MyKidsListingView> createState() => _MyKidsListingViewState();
}

class _MyKidsListingViewState extends State<MyKidsListingView> {
  List<Items> myChildList = [];
  MyChildListNew? subscriptionDetail;
  Items myChildModel = Items();

  ///.............payment.........
  String kidId = "";
  String selectChild = "";
  String userId = "";
  String subscriptionId = "";

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      myChildListApi(true);
    });
    super.initState();
  }

  myChildListApi(bool load) async {
    var jsonResponse = await ApiServices.myChildListRequest(context, load);
    if (jsonResponse != null && mounted) {
      setState(() {
        subscriptionDetail = MyChildListNew.fromJson(jsonResponse);
        if (subscriptionDetail?.status == true &&
            subscriptionDetail?.data != null &&
            subscriptionDetail?.data!.items != null) {
          myChildList.clear();
          if (subscriptionDetail?.data?.items != null) {
            for (var item in subscriptionDetail!.data!.items!) {
              myChildList.add(item);
              print("👧 Child: ${item.name}, ID: ${item.id}");
            }
          } else {
            print("⚠️ No children found in the API response.");
          }
        } else {
          print("⚠️ No valid items found.");
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isSvgAsset(String? image) {
      return image != null &&
          image.endsWith('.svg') &&
          image.contains('assets/');
    }

    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: widget.pageType == "MyKids"
          ? AppBar(
              leadingWidth: 0,
              automaticallyImplyLeading: false,
              backgroundColor: MyColor.yellowF6F1E1,
              surfaceTintColor: MyColor.yellowF6F1E1,
              title: Padding(
                padding: const EdgeInsets.only(left: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TouchRippleEffect(
                      borderRadius: BorderRadius.circular(30),
                      rippleColor: Colors.white,
                      onTap: () {
                        Navigator.pop(context);
                        if (widget.onCallBack != null) {
                          widget.onCallBack!();
                        }
                        // isTabExplore = false;
                        setState(() {});
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        size: 22,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      Languages.of(context)!.myKids,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontFamily: Fonts.beVietnamProRegular,
                        color: MyColor.black,
                      ),
                    ),
                  ],
                ),
              ),
              centerTitle: true,
              elevation: 0,
            )
          : null,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // hsized30,
              Image.asset(
                width: 110,
                height: 60,
                AssetsPath.antapanta,
                fit: BoxFit.contain,
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Text(Languages.of(context)!.letCreateYourKidChampProfile,
                  textAlign: TextAlign.center,
                  style:
                      semiBoldTextStyle(fontSize: 20.0, color: MyColor.black)),
              SizedBox(
                height: size.height * 0.02,
              ),
              myChildList.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Text(
                          "No data available",
                          style: mediumTextStyle(
                              fontSize: 16.0, color: MyColor.black),
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: myChildList.length,
                      itemBuilder: (BuildContext context, index) {
                        Items model = myChildList[index];

                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 8, bottom: 8),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            height: 120,
                            decoration: BoxDecoration(
                              color: MyColor.colorF8F0FF,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        AllDialogs.customDialog(
                                          context,
                                          ViewFullImage(
                                            image: isSvgAsset(model.image)
                                                ? model.image.toString()
                                                : ApiPath.imageBaseUrl + model.image.toString(),
                                          ),
                                        );
                                      },
                                      child: buildProfileImage(
                                        isSvgAsset(model.image)
                                            ? model.image.toString()
                                            : ApiPath.imageBaseUrl + model.image.toString(),
                                        model.isPurchaseSubscription ?? false,
                                      ),
                                    ),

                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              model.name ?? "",
                                              style: mediumTextStyle(
                                                  fontSize: 16.0,
                                                  color: MyColor.black),
                                            ),
                                            hsized3,
                                            Text(
                                              [
                                                model.day?.toString(),
                                                model.month,
                                                model.year?.toString(),
                                              ]
                                                  .where((e) =>
                                                      e != null &&
                                                      e != "null" &&
                                                      e.trim().isNotEmpty)
                                                  .join(" "),
                                              style: regularTextStyle(
                                                fontSize: 14.0,
                                                color: MyColor.black,
                                              ),
                                            ),
                                            hsized3,
                                            Text(myChildList[index].grade ?? "",
                                                style: regularTextStyle(
                                                    fontSize: 14.0,
                                                    color: MyColor.black)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        hsized5,
                                        Row(
                                          children: [
                                            iconButton(AssetsPath.editfullback,
                                                () {
                                              editOnTap(myChildList[index]);
                                            }),
                                            SizedBox(width: 10),
                                            iconButton(
                                                AssetsPath.deletefullback, () {
                                              kidId = myChildList[index].id.toString();
                                              deleteOnTap(myChildList[index]);
                                            }),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                hsized5,
                                if (myChildList[index].isPurchaseSubscription ==
                                    false)
                                  GestureDetector(
                                    onTap: () async {
                                      kidId = myChildList[index].id ?? "";
                                      userId = myChildList[index].parentId ?? "";
                                      selectChild = myChildList[index].name ?? "";
                                      subscriptionId = subscriptionDetail?.data?.subscriptionAmount?.id.toString() ?? "";
                                      debugPrint("Subscription ID :- $subscriptionId");
                                      // _showLockedDialog(context);
                                      Future.delayed(Duration.zero, () {
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                                            KidsLearningPayment(kidId:kidId ,
                                            parentId: userId,
                                            subscriptionAmountId: subscriptionId,
                                            subscriptionAmount: subscriptionDetail?.data?.subscriptionAmount?.amount.toString() ?? ""),)).then((value) {
                                          if (value) {
                                            myChildListApi(false);
                                          }
                                        });

                                        // _showLockedDialog(context);
                                      });
                                    },
                                    child: Text(
                                      "Unlock kid learning chapters",
                                      style: boldTextStyle(
                                              fontSize: 15.0,
                                              color: MyColor.black).copyWith(
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
              hsized40,
            ],
          ),
        ),
      ),
      bottomNavigationBar: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 18.0, left: 20, right: 20),
            child: GlobalButton(
                Languages.of(context)!.addKidsMore.toString(),
                MyColor.appTheme,
                MyColor.appTheme,
                btnSize55,
                double.infinity,
                addKidOnTap,
                55,
                5,
                0,
                semiBoldTextStyle(fontSize: 16.0, color: MyColor.white)),
          ),
          widget.pageType == "MyKids"
              ? Container(
                  height: 20,
                )
              : Padding(
                  padding: const EdgeInsets.only(
                    bottom: 30.0,
                    left: 20,
                    right: 20,
                  ),
                  child: GlobalButton(
                      Languages.of(context)!.gotoHome.toString(),
                      MyColor.white,
                      MyColor.appTheme,
                      btnSize55,
                      double.infinity,
                      goToHomeOnTap,
                      55,
                      5,
                      1,
                      semiBoldTextStyle(
                          fontSize: 16.0, color: MyColor.appTheme)),
                ),
        ],
      ),
    );
  }

  void _showLockedDialog(BuildContext context) {
    AllDialogs.alertDialog(
      context,
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Unlock Chapters",
                    style:
                        mediumTextStyle(fontSize: 18.0, color: MyColor.black),
                  ),
                ),
                const Divider(height: 30),
                Center(
                    child: Image.asset(
                  AssetsPath.notoCoin,
                  height: 105,
                  width: 105,
                )),
                hsized15,
                const SizedBox(height: 8),
                const SizedBox(height: 12),
                Center(
                  child: Text(
                    "Amount:  \$${subscriptionDetail?.data?.subscriptionAmount?.amount}",
                    style:
                        mediumTextStyle(fontSize: 23.0, color: MyColor.black),
                  ),
                ),
                Center(
                  child: Text(
                    "Buy this chapter for $selectChild",
                    style: regularTextStyle(
                      fontSize: 13.0,
                      color: MyColor.black,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColor.appTheme,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(31),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () async {
                      debugPrint('kidId: $kidId');
                      debugPrint('userId: $userId');
                      debugPrint('subscriptionId: $subscriptionId');
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WebViewScreen(
                            type: "purchasePlan",
                            url: AppUrls.purchasePlanKidURL(
                              kidId: kidId,
                              userId: userId,
                              subscriptionId: subscriptionId,
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
                        ).then(
                          (value) {
                            if (value) {
                              Navigator.pop(
                                context,
                              );
                              myChildListApi(false);
                            }
                          },
                        );
                      }
                    },
                    child: Text(
                      "Pay Now",
                      style:
                          mediumTextStyle(fontSize: 14.0, color: MyColor.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildProfileImage(String imagePath, bool isMember) {
    bool isSvgAsset = imagePath.endsWith('.svg') && imagePath.contains('assets/');
    print("pathdcdcfdfddfdfd$imagePath");

    return Stack(
      alignment: Alignment.center,
      children: [
        if (isMember != false)
          Container(
            alignment: Alignment.center,
            width: 62,
            height: 95,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: MyColor.orange, width: 3),
            ),
          ),

        // Profile Image (SVG or Network)
        ClipOval(
          child: isSvgAsset
              ? SvgPicture.asset(
            imagePath,
            width: 54,
            height: 54,
            fit: BoxFit.cover,
          )
              : CachedNetworkImage(
            imageUrl: imagePath,
            width: 54,
            height: 54,
            fit: BoxFit.cover,
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              width: 54,
              height: 54,
              color: Colors.grey.shade200,
              child: const Icon(Icons.error, color: Colors.red),
            ),
          ),
        ),

        if (isMember != false)
          Positioned(
            bottom: 12,
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: MyColor.orange,
              ),
              child: Icon(
                Icons.star,
                color: Colors.white,
                size: 12,
              ),
            ),
          ),
      ],
    );
  }


  Future<void> onRefresh() async {
    Future.delayed(Duration.zero, () {
      myChildListApi(true);
    });
  }

  iconButton(String icon, GestureTapCallback ontap) {
    return InkWell(
      onTap: ontap,
      child: Image.asset(
        icon,
        width: 30,
      ),
    );
  }

  void editOnTap(Items item) {
    myChildModel = item;
    CustomNavigators.pushNavigate(
        LetCreateYourKid(
          check: true,
          editCheck: true,
          myChildModel: myChildModel,
          onCallBack: onCallBack,
        ),
        context);
    // CustomNavigators.pushNavigate(KidsRegisterScreen(check: true, editCheck: true, myChildModel: myChildModel, onCallBack: onCallBack,), context);
  }

  void deleteOnTap(Items kid) {
    if (mounted) {
      setState(() {
        myChildModel = kid;
      });
    }
    AllDialogs.customDialog(
        context,
        DeleteKidPopup(
          onCallBack: onDelete,
        ));
  }

  onDelete() async {
    print("kidIddddddd.....$kidId");
    if (kidId != null && int.tryParse(kidId) != null) {
      int parsedKidId = int.parse(kidId);
      UpdateKidProfile model = UpdateKidProfile(kidId: parsedKidId);

      await ApiServices.deleteKid(context, model).then((onValue) {
        if (mounted && onValue.status == true) {
          setState(() {
            myChildList.remove(myChildModel);
          });
        }
      });
    } else {
      debugPrint("Invalid kidId: $kidId");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Something went wrong. Please try again.")),
      );
    }
  }


  void addKidOnTap() {
    CustomNavigators.pushNavigate(
        // KidsRegisterScreen(check: true, onCallBack: onCallBack), context);
        LetCreateYourKid(check: true, onCallBack: onCallBack),
        context);
  }

  void goToHomeOnTap() {
    CustomNavigators.pushRemoveUntil(
        DashBoardView(
          pageIndex: 0,
        ),
        context);
  }

  onCallBack() {
    Future.delayed(Duration.zero, () {
      myChildListApi(false);
    });
  }
}
