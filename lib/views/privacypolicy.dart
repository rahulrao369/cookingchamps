// import 'dart:io';
// import 'package:cooking_champs/constant/my_fonts_style.dart';
// import 'package:cooking_champs/constant/sized_box.dart';
// import 'package:cooking_champs/model/dynamic_models/help_and_support_model.dart';
// import 'package:cooking_champs/services/api_services.dart';
// import 'package:cooking_champs/utils/utility.dart';
// import 'package:cooking_champs/constant/my_color.dart';
// import 'package:cooking_champs/constant/stringfile.dart/language.dart';
// import 'package:flutter/material.dart';
// import 'package:touch_ripple_effect/touch_ripple_effect.dart';
//
// class PrivacyPolicyView extends StatefulWidget {
//   const PrivacyPolicyView({super.key});
//
//
//   @override
//   State<PrivacyPolicyView> createState() => _PrivacyPolicyViewState();
// }
//
// class _PrivacyPolicyViewState extends State<PrivacyPolicyView> {
//   List<HelpAndSupportModel> helpAndSupportList =[];
// dynamic data;
//   @override
//   void initState() {
//     data = '';
//     Future.delayed(Duration.zero,getprivacypolicy);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context);
//     return MediaQuery(
//       data: size.copyWith(textScaleFactor: 1.0),
//       child: Scaffold(
//         appBar: AppBar(
//           leadingWidth: 0, automaticallyImplyLeading: false,
//           backgroundColor: MyColor.yellowF6F1E1,
//           surfaceTintColor: MyColor.yellowF6F1E1,
//           title: Padding(
//             padding: const EdgeInsets.only(left: 0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 TouchRippleEffect(
//                   borderRadius: BorderRadius.circular(30),
//                   rippleColor: Colors.white,
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                   child: const Icon(
//                     Icons.arrow_back_ios,
//                     size: 30,
//                     color: Colors.black,
//                   ),
//                 ),
//
//                 Text(
//                     Languages.of(context)!.privacypolicy,
//                     style:mediumTextStyle(fontSize:18.0, color:MyColor.black)
//                 ),
//               ],
//             ),
//           ),
//           centerTitle: true,
//           elevation: 0,
//         ),
//         body:  Padding(
//           padding: const EdgeInsets.symmetric(horizontal:10.0),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//              Container(child: Text(data),),
//
//                 hsized30
//
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   getprivacypolicy()async{
//     await ApiServices.getprivacypolicy(context, true).then((onValue){
//       if(mounted){
//         setState(() {
//           if(onValue.status == true){
//             if(onValue.data != null) {
//               // for(var privacy in onValue.data["description"]){
//                 print("privacy>>>>>${ onValue.data["description"]}");
//                 data = onValue.data["description"];
//                 // HelpAndSupportModel model = HelpAndSupportModel.fromJson(help);
//                 // helpAndSupportList.add(model);
//               // }
//
//             }
//           }
//         });
//       }
//     });
//   }
// }


import 'dart:io';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/model/dynamic_models/help_and_support_model.dart';
import 'package:cooking_champs/services/api_services.dart';
import 'package:cooking_champs/utils/utility.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/stringfile.dart/language.dart';
import 'package:flutter/material.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';

class PrivacyPolicyView extends StatefulWidget {
  const PrivacyPolicyView({super.key});

  @override
  State<PrivacyPolicyView> createState() => _PrivacyPolicyViewState();
}

class _PrivacyPolicyViewState extends State<PrivacyPolicyView> {
  List<HelpAndSupportModel> helpAndSupportList = [];
  dynamic data;

  @override
  void initState() {
    data = '';
    Future.delayed(Duration.zero, getprivacypolicy);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context);
    final bool isIpad = MediaQuery.of(context).size.width > 600;

    return MediaQuery(
      data: size.copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
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
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: isIpad ? 36 : 30,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: isIpad ? 15 : 10),
                Text(
                  Languages.of(context)!.privacypolicy,
                  style: mediumTextStyle(
                    fontSize: isIpad ? 28.0 : 18.0,
                    color: MyColor.black,
                  ),
                ),
              ],
            ),
          ),
          centerTitle: true,
          elevation: 0,
          toolbarHeight: isIpad ? 80 : 56,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isIpad ? 20.0 : 10.0,
            vertical: isIpad ? 20.0 : 0,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(isIpad ? 0.0 : 0),
                  child: Text(
                    data ?? '',
                    style: regularTextStyle(
                      fontSize: isIpad ? 22.0 : 14.0,
                      color: MyColor.black.withOpacity(0.7),
                      height: isIpad ? 1.8 : 1.6,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(height: isIpad ? 50 : 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getprivacypolicy() async {
    await ApiServices.getprivacypolicy(context, true).then((onValue) {
      if (mounted) {
        setState(() {
          if (onValue.status == true) {
            if (onValue.data != null) {
              print("privacy>>>>>${onValue.data["description"]}");
              data = onValue.data["description"];
            }
          }
        });
      }
    });
  }
}