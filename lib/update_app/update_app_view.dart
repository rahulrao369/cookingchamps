import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/update_app/update_app_services.dart';
import 'package:cooking_champs/utils/navigators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UpdateAppView extends StatefulWidget {
  final String latestVersion;
  final String des;
  final bool isForce;
  const UpdateAppView(
      {super.key,
      required this.latestVersion,
      required this.des,
      required this.isForce});

  @override
  State<UpdateAppView> createState() => _UpdateAppViewState();
}

class _UpdateAppViewState extends State<UpdateAppView> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Material(
        color: Colors.transparent,
        child: Wrap(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                hsized5,
                widget.isForce
                    ? SizedBox.shrink()
                    : Container(
                        padding: EdgeInsets.only(right: 10, top: 10),
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.clear,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                Container(
                  decoration: BoxDecoration(
                      // color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  // color: Colors.red,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                            20), // Adjust the radius as needed
                        topRight: Radius.circular(20),
                      ),
                      child: SvgPicture.asset(
                        AssetsPath.updateAppNew,
                        height: 300,
                        width: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Container(
                  // height: ,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: Column(
                    children: [
                      Text("Update available",
                          style: boldTextStyle(
                              fontSize: 20.0, color: Colors.black)),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(widget.des,
                            textAlign: TextAlign.center,
                            style: lightTextStyle(
                                fontSize: 16.0, color: Colors.black)),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: 20.0, vertical: 20),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       InkWell(
                      //         onTap: () => Navigator.pop(context),
                      //         child: Container(
                      //             decoration: BoxDecoration(
                      //                 color: Colors.white,
                      //                 borderRadius: BorderRadius.circular(10)),
                      //             padding: EdgeInsets.symmetric(
                      //                 horizontal: 20, vertical: 10),
                      //             child: Text("Later",
                      //                 style: boldTextStyle(
                      //                     fontSize: 16.0,
                      //                     color: MyColor.appTheme2))),
                      //       ),
                      //       SizedBox(
                      //         width: 20,
                      //       ),
                      //       InkWell(
                      //         onTap: () {
                      //           Navigator.pop(context);
                      //           UpdateAppServices().launchStore();
                      //         },
                      //         child: Container(
                      //             decoration: BoxDecoration(
                      //                 color: Colors.white,
                      //                 borderRadius: BorderRadius.circular(10)),
                      //             padding: EdgeInsets.symmetric(
                      //                 horizontal: 20, vertical: 10),
                      //             child: Text(
                      //               "Update",
                      //               style: boldTextStyle(
                      //                   fontSize: 16.0, color: MyColor.appTheme2),
                      //             )),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      hsized20,
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          UpdateAppServices().launchStore();
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          alignment: Alignment.center,
                          height: 45,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color(0xFF48335C),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(34))),
                          child: Text(
                            "Update",
                            style: boldTextStyle(
                                fontSize: 16.0, color: MyColor.white),
                          ),
                        ),
                      ),
                      hsized10,
                      GestureDetector(
                        onTap: () {
                          CustomNavigators.popNavigate(context);
                        },
                        child: Text("Skip for now",
                            style: boldTextStyle(
                                fontSize: 16.0, color: MyColor.appTheme2)),
                      ),
                      hsized20,
                    ],
                  ),
                ),
                hsized5,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
