import 'dart:io';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/utils/navigators.dart';
import 'package:flutter/material.dart';

class DeleteAdsImageAlertDialog extends StatefulWidget {
  // Function onCallBack;
  String title;
  DeleteAdsImageAlertDialog({super.key,required this.title});

  @override
  State<DeleteAdsImageAlertDialog> createState() => _DeleteAdsImageAlertDialogState();
}

class _DeleteAdsImageAlertDialogState extends State<DeleteAdsImageAlertDialog> {
  String status = "";


  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return MediaQuery(
      data: data.copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        backgroundColor:Colors.transparent,
        body: Align(
          alignment: Alignment.center,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            margin: const EdgeInsets.only(left: 25, right: 25),
            child: Wrap(
              children: [

                Container(
                  decoration: BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.circular(20)),
                  margin: const EdgeInsets.only(top: 12, left: 15, right: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      hsized20,


                      /// Title...........................
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                        child:  Text(
                          widget.title,
                          textAlign: TextAlign.center,
                          style: semiBoldTextStyle(fontSize:19.0, color:MyColor.black)
                        ),
                      ),

                      hsized20,
                    ],
                  ),
                ),


                Container(
                  margin:
                  const EdgeInsets.only( bottom: 30, top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// No Button...........................
                      GestureDetector(
                        onTap:noOnTap,
                        child: Container(
                            width:130,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color:MyColor.appTheme
                            ),
                            child:  Text(
                              "No",
                              style:semiBoldTextStyle(fontSize:18.0, color:MyColor.white)
                            )),
                      ),

                      const SizedBox(width: 15,),

                      /// Yes Button...........................
                      GestureDetector(
                        onTap:yesTap,
                        child: Container(
                            width:130,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color:MyColor.appTheme
                            ),
                            child:  Text(
                              "Yes",
                              style:semiBoldTextStyle(fontSize:18.0, color:MyColor.white)
                            )),
                      ),
                    ],
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }


  void noOnTap() {
    CustomNavigators.popNavigate(context);
  }

  void yesTap() {
  exit(0);
  }

}

