// /// Old Code
// import 'package:flutter/material.dart';
// import '../constant/my_color.dart';
// import '../constant/my_fonts_style.dart';
//
// import 'package:flutter_html/flutter_html.dart';
//
// class Monthlychallengebanner extends StatefulWidget {
//   String? title;
//   String? description;
//
//   Monthlychallengebanner({super.key, this.title, this.description});
//
//   @override
//   State<Monthlychallengebanner> createState() => _MonthlychallengebannerState();
// }
//
// class _MonthlychallengebannerState extends State<Monthlychallengebanner> {
//   @override
//   Widget build(BuildContext context) {
//     debugPrint(">>>> Description :- ${widget.description} <<<");
//     return Scaffold(
//       appBar: AppBar(
//         leadingWidth: 50,
//         automaticallyImplyLeading: false,
//         backgroundColor: MyColor.yellowF6F1E1,
//         surfaceTintColor: MyColor.yellowF6F1E1,
//         leading: InkWell(
//           borderRadius: BorderRadius.circular(30),
//           radius: 80,
//           onTap: () {
//             Navigator.pop(context);
//             //  widget.onCallBack();
//           },
//           child: Padding(
//             padding: const EdgeInsets.only(left: 20.0),
//             child: const Icon(
//               Icons.arrow_back_ios,
//               size: 28,
//               color: Colors.black,
//             ),
//           ),
//         ),
//         title: Text(widget.title.toString(),
//             // "aldknbaslkdsn alkdinas ",
//             style: mediumTextStyle(fontSize: 18.0, color: MyColor.black)),
//         centerTitle: false,
//         elevation: 0,
//       ),
//         body: Container(
//           padding: const EdgeInsets.all(15),
//           child: widget.description == null ||
//               widget.description!.isEmpty
//               ? const Center(child: CircularProgressIndicator())
//               : SingleChildScrollView(
//             child: Html(
//               data: widget.description!,
//               style: {
//                 "p": Style(fontSize: FontSize(18)),
//               },
//               extensions: [
//                 TagExtension(
//                   tagsToExtend: {"img"},
//                   builder: (context) {
//                     final src = context.attributes['src'];
//
//                     if (src == null) {
//                       return const SizedBox();
//                     }
//
//                     return Padding(
//                       padding:
//                       const EdgeInsets.symmetric(vertical: 12),
//                       child: Image.network(
//                         src,
//                         width: double.infinity,
//                         fit: BoxFit.contain,
//
//                         // ✅ Loader while image loads
//                         loadingBuilder:
//                             (context, child, loadingProgress) {
//                           if (loadingProgress == null) {
//                             return child;
//                           }
//
//                           return const Center(
//                             child: Padding(
//                               padding: EdgeInsets.all(20),
//                               child: CircularProgressIndicator(),
//                             ),
//                           );
//                         },
//
//                         // ✅ Optional: error fallback
//                         errorBuilder:
//                             (context, error, stackTrace) {
//                           return const Center(
//                             child: Icon(Icons.broken_image,
//                                 size: 40),
//                           );
//                         },
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//     );
//   }
// }
//



import 'package:flutter/material.dart';
import '../constant/my_color.dart';
import '../constant/my_fonts_style.dart';
import 'package:flutter_html/flutter_html.dart';

class Monthlychallengebanner extends StatefulWidget {
  String? title;
  String? description;

  Monthlychallengebanner({super.key, this.title, this.description});

  @override
  State<Monthlychallengebanner> createState() => _MonthlychallengebannerState();
}

class _MonthlychallengebannerState extends State<Monthlychallengebanner> {
  @override
  Widget build(BuildContext context) {
    final bool isIpad = MediaQuery.of(context).size.width > 600;

    debugPrint(">>>> Description :- ${widget.description} <<<");
    return Scaffold(
      appBar: AppBar(
        leadingWidth: isIpad ? 60.0 : 50.0,
        automaticallyImplyLeading: false,
        backgroundColor: MyColor.yellowF6F1E1,
        surfaceTintColor: MyColor.yellowF6F1E1,
        leading: InkWell(
          borderRadius: BorderRadius.circular(isIpad ? 40.0 : 30.0),
          radius: isIpad ? 100.0 : 80.0,
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.only(left: isIpad ? 25.0 : 20.0),
            child: Icon(
              Icons.arrow_back_ios,
              size: isIpad ? 32.0 : 28.0,
              color: Colors.black,
            ),
          ),
        ),
        title: Text(
          widget.title.toString(),
          style: mediumTextStyle(
              fontSize: isIpad ? 22.0 : 18.0,
              color: MyColor.black
          ),
        ),
        centerTitle: false,
        elevation: 0,
        toolbarHeight: isIpad ? 80.0 : null,
      ),
      body: Container(
        padding: EdgeInsets.all(isIpad ? 25.0 : 15.0),
        child: widget.description == null || widget.description!.isEmpty
            ? Center(
          child: CircularProgressIndicator(
            color: MyColor.appTheme,
            strokeWidth: isIpad ? 3.0 : 2.0,
          ),
        )
            : SingleChildScrollView(
          child: Html(
            data: widget.description!,
            style: {
              "body": Style(
                fontSize: FontSize(isIpad ? 20.0 : 18.0),
                fontFamily: 'YourFontFamily', // Add your font family if needed
              ),
              "h1": Style(
                fontSize: FontSize(isIpad ? 28.0 : 24.0),
                fontWeight: FontWeight.bold,
              ),
              "h2": Style(
                fontSize: FontSize(isIpad ? 26.0 : 22.0),
                fontWeight: FontWeight.bold,
              ),
              "h3": Style(
                fontSize: FontSize(isIpad ? 24.0 : 20.0),
                fontWeight: FontWeight.bold,
              ),
              "p": Style(
                fontSize: FontSize(isIpad ? 20.0 : 18.0),
                lineHeight: LineHeight(isIpad ? 1.5 : 1.3),
              ),
              "li": Style(
                fontSize: FontSize(isIpad ? 20.0 : 18.0),
              ),
              "strong": Style(
                fontWeight: FontWeight.bold,
                fontSize: FontSize(isIpad ? 20.0 : 18.0),
              ),
              "em": Style(
                fontStyle: FontStyle.italic,
              ),
            },
            extensions: [
              TagExtension(
                tagsToExtend: {"img"},
                builder: (context) {
                  final src = context.attributes['src'];

                  if (src == null) {
                    return const SizedBox();
                  }

                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: isIpad ? 20.0 : 12.0,
                      horizontal: isIpad ? 10.0 : 0,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(isIpad ? 15.0 : 10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: isIpad ? 10.0 : 5.0,
                            spreadRadius: isIpad ? 2.0 : 1.0,
                            offset: Offset(0, isIpad ? 4.0 : 2.0),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(isIpad ? 15.0 : 10.0),
                        child: Image.network(
                          src,
                          width: double.infinity,
                          fit: BoxFit.contain,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: Padding(
                                padding: EdgeInsets.all(isIpad ? 30.0 : 20.0),
                                child: CircularProgressIndicator(
                                  color: MyColor.appTheme,
                                  strokeWidth: isIpad ? 3.0 : 2.0,
                                ),
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: isIpad ? 200.0 : 150.0,
                              color: MyColor.grayLite.withOpacity(0.2),
                              child: Center(
                                child: Icon(
                                  Icons.broken_image,
                                  size: isIpad ? 50.0 : 40.0,
                                  color: MyColor.grayLite,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
            onLinkTap: (url, attributes, element) {
              // Handle link taps if needed
            },
          ),
        ),
      ),
    );
  }
}






// import 'package:flutter/material.dart';
//
// import '../constant/my_color.dart';
// import '../constant/my_fonts_style.dart';
//
// class Monthlychallengebanner extends StatelessWidget {
//     String? title;
//     Monthlychallengebanner({super.key, this.title,});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//
//       // APP BAR
//         appBar: AppBar(
//             leadingWidth: 50,
//             automaticallyImplyLeading: false,
//             backgroundColor: MyColor.yellowF6F1E1,
//             surfaceTintColor: MyColor.yellowF6F1E1,
//             leading: InkWell(
//               borderRadius: BorderRadius.circular(30),
//               radius: 80,
//               onTap: () {
//                 Navigator.pop(context);
//                 //  widget.onCallBack();
//               },
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 20.0),
//                 child: const Icon(
//                   Icons.arrow_back_ios,
//                   size: 28,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//             title: Text(
//                 title.toString(),
//                 // "aldknbaslkdsn alkdinas ",
//                 style: mediumTextStyle(fontSize: 18.0, color: MyColor.black)),
//             centerTitle: false,
//             elevation: 0,
//           ),
//
//       // ✅ SCROLLABLE IMAGE (NO DISTORTION)
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
//           child: Column(
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white
//                 ),
//                 child: Image.asset(
//                   "assets/images/Frame 1171279411.png",
//                   width: MediaQuery.of(context).size.width,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//               SizedBox(
//                 height: 33,
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white
//                 ),
//                 child: Image.asset(
//                   "assets/images/Frame 1171279397.png",
//                   width: MediaQuery.of(context).size.width,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//               SizedBox(
//                 height: 28,
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white
//                 ),
//                 child: Image.asset(
//                   "assets/images/Frame 1171279399.png",
//                   width: MediaQuery.of(context).size.width,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//               SizedBox(
//                 height: 40,
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white
//                 ),
//                 child: Image.asset(
//                   "assets/images/Frame 1171279403.png",
//                   width: MediaQuery.of(context).size.width,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//               SizedBox(
//                 height: 40,
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                     color: Colors.white
//                 ),
//                 child: Image.asset(
//                   "assets/images/Group 1171279314.png",
//                   width: MediaQuery.of(context).size.width,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//               // Image.asset(
//               //   "assets/images/1258351.png",
//               //   width: MediaQuery.of(context).size.width,
//               //   fit: BoxFit.contain,
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
