import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/dimen.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/stringfile.dart/language.dart';
import 'package:cooking_champs/utils/navigators.dart';
import 'package:cooking_champs/widgets/global_button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../constant/my_color.dart';

class DeleteAccountPopup extends StatefulWidget {
  final Function onCallBack;
  const DeleteAccountPopup({super.key, required this.onCallBack});

  @override
  State<DeleteAccountPopup> createState() => _DeleteAccountPopupState();
}

class _DeleteAccountPopupState extends State<DeleteAccountPopup> {
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    final size = data.size;
    final bool isIpad = MediaQuery.of(context).size.width > 600;

    return MediaQuery(
      data: data.copyWith(textScaleFactor: 1.0),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: isIpad ? 40 : 20),
        alignment: Alignment.center,
        child: Wrap(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(
                isIpad ? 30 : 20,
                isIpad ? 20 : 10,
                isIpad ? 30 : 20,
                isIpad ? 35 : 25,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(isIpad ? 25 : 20),
                color: Colors.white,
              ),
              child: Wrap(
                children: [
                  Container(
                    child: Lottie.asset(
                      AssetsPath.deleteGif,
                      height: MediaQuery.of(context).size.height *
                          (isIpad ? 0.20 : 0.17),
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(bottom: isIpad ? 10.0 : 5.0),
                    child: Text(
                      Languages.of(context)!.deleteAccount,
                      textAlign: TextAlign.center,
                      style: mediumTextStyle(
                        fontSize: isIpad ? 26.0 : 20.0,
                        color: MyColor.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: isIpad ? 30.0 : 25.0),
                    child: Text(
                      Languages.of(context)!.areYouSureDeleteAccount,
                      textAlign: TextAlign.center,
                      style: regularTextStyle(
                        fontSize: isIpad ? 20.0 : 15.0,
                        color: MyColor.black,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * (isIpad ? 0.04 : 0.03)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 1,
                        child: GlobalButton(
                          Languages.of(context)!.yes.toString(),
                          MyColor.white,
                          MyColor.red,
                          isIpad ? btnSize55 * 1.2 : btnSize55,
                          double.infinity,
                          yesOnTap,
                          isIpad ? 40 : 34,
                          isIpad ? 7 : 5,
                          1.7,
                          mediumTextStyle(
                            fontSize: isIpad ? 20.0 : 16.0,
                            color: MyColor.appTheme,
                          ),
                        ),
                      ),
                      SizedBox(width: isIpad ? 15 : 10),
                      Expanded(
                        flex: 1,
                        child: GlobalButton(
                          Languages.of(context)!.no.toString(),
                          MyColor.red,
                          MyColor.red,
                          isIpad ? btnSize55 * 1.2 : btnSize55,
                          double.infinity,
                          noOnTap,
                          isIpad ? 40 : 34,
                          isIpad ? 8 : 6,
                          0,
                          mediumTextStyle(
                            fontSize: isIpad ? 20.0 : 16.0,
                            color: MyColor.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void yesOnTap() async {
    debugPrint("yes");
    widget.onCallBack("test");
    CustomNavigators.popNavigate(context);
  }

  void noOnTap() {
    CustomNavigators.popNavigate(context);
  }
}



class DeleteAddressPopup extends StatelessWidget {
  final Function(String) onCallBack;
  const DeleteAddressPopup({super.key, required this.onCallBack});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              AssetsPath.deleteGif,
              height: size.height * 0.17,
              width: size.width,
            ),
            const SizedBox(height: 10),
            Text(
             "Delete Address",
              textAlign: TextAlign.center,
              style: mediumTextStyle(fontSize: 20.0, color: MyColor.black),
            ),
            const SizedBox(height: 10),
            Text(
              "Are you sure you want to delete this address?",
              textAlign: TextAlign.center,
              style: regularTextStyle(fontSize: 15.0, color: MyColor.black),
            ),
            const SizedBox(height: 25),
            Row(
              children: [
                Expanded(
                  child: GlobalButton(
                    Languages.of(context)!.yes ?? "Yes",
                    MyColor.white,
                    MyColor.red,
                    50,
                    double.infinity,
                        () {
                      onCallBack("confirm");
                      CustomNavigators.popNavigate(context);
                    },
                    34,
                    5,
                    1.7,
                    mediumTextStyle(fontSize: 16.0, color: MyColor.appTheme),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GlobalButton(
                    Languages.of(context)!.no ?? "No",
                    MyColor.red,
                    MyColor.red,
                    50,
                    double.infinity,
                        () => CustomNavigators.popNavigate(context),
                    34,
                    6,
                    0,
                    mediumTextStyle(fontSize: 16.0, color: MyColor.white),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

