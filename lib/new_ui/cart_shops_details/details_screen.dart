// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cooking_champs/constant/apiConnectorConstants.dart';
// import 'package:cooking_champs/constant/assets_path.dart';
// import 'package:cooking_champs/constant/my_color.dart';
// import 'package:cooking_champs/constant/sized_box.dart';
// import 'package:cooking_champs/model/dynamic_models/product_detail_model.dart';
// import 'package:cooking_champs/services/api_path.dart';
// import 'package:cooking_champs/services/user_prefences.dart';
// import 'package:cooking_champs/utils/all_dialogs.dart';
// import 'package:cooking_champs/utils/utility.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:pretty_http_logger/pretty_http_logger.dart';
//
// import 'common/defaulttext.dart';
// import 'dart:convert' as convert;
// import 'dart:developer' as developer;
//
// class DetailsScreen extends StatefulWidget {
//   final String productId;
//   const DetailsScreen({super.key, required this.productId});
//   @override
//   State<DetailsScreen> createState() => _DetailsScreenState();
// }
//
// class _DetailsScreenState extends State<DetailsScreen> {
//   ProductDetailModel productDetail = ProductDetailModel();
//   bool isAddedToCart = false;
//   bool isCartLoading = false;
//
//   @override
//   void initState() {
//     wishListApi();
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         top: false,
//         child: Column(
//           children: [
//             Stack(
//               children: [
//                 CachedNetworkImage(
//                   imageUrl:
//                       "${ApiPath.imageBaseUrl}${productDetail.data?.image ?? ''}",
//                   placeholder: (context, url) => Image.asset(
//                     AssetsPath.activityImg1,
//                     height: 433,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                   ),
//                   errorWidget: (context, url, error) => const Icon(Icons.error),
//                   height: 433,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                 ),
//                 SafeArea(
//                   child: GestureDetector(
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                       child: SvgPicture.asset(
//                           "assets/new_ui_images/backArrow.svg"),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: Text(
//                     productDetail.data?.title ?? "",
//                     // 'Aprons',
//                     style:
//                         semiBoldTextStyle(fontSize: 25.0, color: MyColor.black),
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                   child: Html(
//                     data: productDetail.data?.description ?? "",
//                     style: {
//                       "body": Style(
//                         fontSize: FontSize(13.0),
//                         color: MyColor.color000000,
//                         // maxLines: 2,
//                         // textOverflow: TextOverflow.ellipsis,
//                       ),
//                     },
//                   ),
//                 ),
//               ],
//             ),
//
//             const Spacer(),
//
//             ///............ Price & Add to Cart
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
//               child: Row(
//                 children: [
//                   Column(
//                     children: [
//                       Text(
//                         'Price',
//                         style: regularTextStyle(
//                             fontSize: 14.0, color: MyColor.black),
//                       ),
//                       Text(
//                         '\$${productDetail.data?.sellingPrice ?? 0}',
//                         style: boldTextStyle(
//                             fontSize: 23.0, color: MyColor.appTheme),
//                       ),
//                     ],
//                   ),
//                   wSized10,
//                   Expanded(
//                     child: GestureDetector(
//                       onTap: () async {
//                         if (isAddedToCart ||
//                             (productDetail.data?.isCartAdded ?? false)) {
//                         } else {
//                           setState(() {
//                             isCartLoading = true;
//                           });
//                           await addToCartApi(
//                               productDetail.data?.id.toString() ?? "");
//                           setState(() {
//                             isCartLoading = false;
//                           });
//                         }
//                       },
//                       child: Container(
//                         height: 50,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(34),
//                           color: (isAddedToCart ||
//                                   (productDetail.data?.isCartAdded ?? false))
//                               ? MyColor.grayLite
//                               : MyColor.yellowF6F1E1,
//                         ),
//                         child: Center(
//                           child: isCartLoading
//                               ? SizedBox(
//                                   height: 20,
//                                   width: 20,
//                                   child: CircularProgressIndicator(
//                                     strokeWidth: 2,
//                                     valueColor: AlwaysStoppedAnimation<Color>(
//                                       (isAddedToCart ||
//                                               (productDetail
//                                                       .data?.isCartAdded ??
//                                                   false))
//                                           ? MyColor.liteGray
//                                           : MyColor.appTheme,
//                                     ),
//                                   ),
//                                 )
//                               : Text(
//                                   (isAddedToCart || (productDetail.data?.isCartAdded ?? false))
//                                       ? 'Added to Cart'
//                                       : 'Add To Cart',
//                                   style: boldTextStyle(
//                                     fontSize: 16.0,
//                                     color: (isAddedToCart ||
//                                             (productDetail.data?.isCartAdded ??
//                                                 false))
//                                         ? MyColor.liteGray
//                                         : MyColor.appTheme,
//                                   ),
//                                 ),
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> wishListApi() async {
//     ApiConnectorConstants.accessToken =
//         await PreferencesServices.getPreferencesData(
//                 PreferencesServices.userToken) ??
//             "";
//
//     HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
//       HttpLogger(logLevel: LogLevel.BODY),
//     ]);
//     AllDialogs.progressLoadingDialog(context, true);
//     try {
//       final uri =
//           Uri.parse("${ApiPath.productDetail}?product_id=${widget.productId}");
//
//       var response = await http.get(
//         uri,
//         headers: {
//           "Accept": "application/json",
//           "Content-type": "application/json",
//           "Authorization": "Bearer ${ApiConnectorConstants.accessToken}",
//         },
//       );
//
//       Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
//       AllDialogs.progressLoadingDialog(context, false);
//       if (jsonResponse['status'] == true) {
//         productDetail = ProductDetailModel.fromJson(jsonResponse);
//         developer.log(convert.jsonEncode(jsonResponse));
//
//         setState(() {});
//       } else {
//         Utility.customToast(context, jsonResponse['message'].toString());
//       }
//     } catch (error) {
//       print("Error in wishListApi: $error");
//     }
//   }
//
//   Future<void> addToCartApi(String productId) async {
//     ApiConnectorConstants.accessToken =
//         await PreferencesServices.getPreferencesData(
//                 PreferencesServices.userToken) ??
//             "";
//
//     var request = {
//       'product_id': productId.toString(),
//     };
//
//     HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
//       HttpLogger(logLevel: LogLevel.BODY),
//     ]);
//
//     try {
//       var response = await http.post(
//         Uri.parse(ApiPath.addToCart),
//         body: convert.jsonEncode(request),
//         headers: {
//           "Accept": "application/json",
//           "Content-type": 'application/json',
//           "Authorization": "Bearer ${ApiConnectorConstants.accessToken}"
//         },
//       );
//
//       Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
//
//       if (jsonResponse['status'] == true) {
//         setState(() {
//           isAddedToCart = true;
//         });
//       } else {
//         Utility.customToast(context, "${jsonResponse['message']}");
//       }
//     } catch (error) {
//       print("Error in wishListApi: $error");
//     }
//   }
// }



import 'package:cached_network_image/cached_network_image.dart';
import 'package:cooking_champs/constant/apiConnectorConstants.dart';
import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/model/dynamic_models/product_detail_model.dart';
import 'package:cooking_champs/services/api_path.dart';
import 'package:cooking_champs/services/user_prefences.dart';
import 'package:cooking_champs/utils/all_dialogs.dart';
import 'package:cooking_champs/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import 'common/defaulttext.dart';
import 'dart:convert' as convert;


class DetailsScreen extends StatefulWidget {
  final String productId;
  const DetailsScreen({super.key, required this.productId});
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  ProductDetailModel productDetail = ProductDetailModel();
  bool isAddedToCart = false;
  bool isCartLoading = false;

  @override
  void initState() {
    wishListApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final bool isTablet = size.shortestSide > 600;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            // Product Image with Back Button
            Stack(
              children: [
                CachedNetworkImage(
                  imageUrl:
                  "${ApiPath.imageBaseUrl}${productDetail.data?.image ?? ''}",
                  placeholder: (context, url) => Image.asset(
                    AssetsPath.activityImg1,
                    height: isTablet ? 600.0 : 433.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: isTablet ? 500.0 : 433.0,
                    color: Colors.grey.shade200,
                    child: Center(
                      child: Icon(
                        Icons.image,
                        size: isTablet ? 60.0 : 40.0,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                  height: isTablet ? 500.0 : 433.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),

                // Back Button
                SafeArea(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isTablet ? 20.0 : 8.0,
                        vertical: isTablet ? 15.0 : 8.0,
                      ),
                      child: Container(
                        padding: EdgeInsets.all(isTablet ? 10.0 : 8.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          "assets/new_ui_images/backArrow.svg",
                          width: isTablet ? 24.0 : 20.0,
                          height: isTablet ? 24.0 : 20.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Product Details Section
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 30.0 : 16.0,
                  vertical: isTablet ? 25.0 : 16.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Title
                    Text(
                      productDetail.data?.title ?? "",
                      style: semiBoldTextStyle(
                        fontSize: isTablet ? 32.0 : 25.0,
                        color: MyColor.black,
                      ),
                    ),

                    SizedBox(height: isTablet ? 15.0 : 8.0),

                    // Product Description
                    Html(
                      data: productDetail.data?.description ?? "",
                      style: {
                        "body": Style(
                          fontSize: FontSize(isTablet ? 20.0 : 13.0),
                          color: MyColor.color000000,
                          lineHeight: LineHeight(isTablet ? 1.6 : 1.4),
                        ),
                        "p": Style(
                        ),
                        "h1": Style(fontSize: FontSize(isTablet ? 28.0 : 22.0)),
                        "h2": Style(fontSize: FontSize(isTablet ? 24.0 : 20.0)),
                        "h3": Style(fontSize: FontSize(isTablet ? 20.0 : 18.0)),
                      },
                    ),

                    // Extra spacing
                    SizedBox(height: isTablet ? 30.0 : 20.0),
                  ],
                ),
              ),
            ),

            // Price & Add to Cart Section
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: isTablet ? 15.0 : 10.0,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(
                horizontal: isTablet ? 30.0 : 16.0,
                vertical: isTablet ? 25.0 : 24.0,
              ),
              child: Row(
                children: [
                  // Price Section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Price',
                        style: regularTextStyle(
                          fontSize: isTablet ? 16.0 : 14.0,
                          color: MyColor.black,
                        ),
                      ),
                      SizedBox(height: isTablet ? 5.0 : 2.0),
                      Text(
                        '\$${productDetail.data?.sellingPrice ?? 0}',
                        style: boldTextStyle(
                          fontSize: isTablet ? 28.0 : 23.0,
                          color: MyColor.appTheme,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(width: isTablet ? 20.0 : 10.0),

                  // Add to Cart Button
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        if (isAddedToCart ||
                            (productDetail.data?.isCartAdded ?? false)) {
                          // Already added, do nothing
                        } else {
                          setState(() {
                            isCartLoading = true;
                          });
                          await addToCartApi(
                              productDetail.data?.id.toString() ?? "");
                          setState(() {
                            isCartLoading = false;
                          });
                        }
                      },
                      child: Container(
                        height: isTablet ? 60.0 : 50.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            isTablet ? 40.0 : 34.0,
                          ),
                          color: (isAddedToCart ||
                              (productDetail.data?.isCartAdded ?? false))
                              ? MyColor.grayLite
                              : MyColor.yellowF6F1E1,
                        ),
                        child: Center(
                          child: isCartLoading
                              ? SizedBox(
                            height: isTablet ? 26.0 : 20.0,
                            width: isTablet ? 26.0 : 20.0,
                            child: CircularProgressIndicator(
                              strokeWidth: isTablet ? 3.0 : 2.0,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                (isAddedToCart ||
                                    (productDetail
                                        .data?.isCartAdded ??
                                        false))
                                    ? MyColor.liteGray
                                    : MyColor.appTheme,
                              ),
                            ),
                          )
                              : Text(
                            (isAddedToCart ||
                                (productDetail.data?.isCartAdded ?? false))
                                ? 'Added to Cart'
                                : 'Add To Cart',
                            style: boldTextStyle(
                              fontSize: isTablet ? 18.0 : 16.0,
                              color: (isAddedToCart ||
                                  (productDetail.data?.isCartAdded ??
                                      false))
                                  ? MyColor.liteGray
                                  : MyColor.appTheme,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> wishListApi() async {
    ApiConnectorConstants.accessToken =
        await PreferencesServices.getPreferencesData(
            PreferencesServices.userToken) ??
            "";

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    AllDialogs.progressLoadingDialog(context, true);
    try {
      final uri =
      Uri.parse("${ApiPath.productDetail}?product_id=${widget.productId}");

      var response = await http.get(
        uri,
        headers: {
          "Accept": "application/json",
          "Content-type": "application/json",
          "Authorization": "Bearer ${ApiConnectorConstants.accessToken}",
        },
      );

      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
      AllDialogs.progressLoadingDialog(context, false);
      if (jsonResponse['status'] == true) {
        productDetail = ProductDetailModel.fromJson(jsonResponse);
         print(convert.jsonEncode(jsonResponse));

        setState(() {});
      } else {
        Utility.customToast(context, jsonResponse['message'].toString());
      }
    } catch (error) {
      print("Error in wishListApi: $error");
    }
  }

  Future<void> addToCartApi(String productId) async {
    ApiConnectorConstants.accessToken =
        await PreferencesServices.getPreferencesData(
            PreferencesServices.userToken) ??
            "";

    var request = {
      'product_id': productId.toString(),
    };

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    try {
      var response = await http.post(
        Uri.parse(ApiPath.addToCart),
        body: convert.jsonEncode(request),
        headers: {
          "Accept": "application/json",
          "Content-type": 'application/json',
          "Authorization": "Bearer ${ApiConnectorConstants.accessToken}"
        },
      );

      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);

      if (jsonResponse['status'] == true) {
        setState(() {
          isAddedToCart = true;
        });
      } else {
        Utility.customToast(context, "${jsonResponse['message']}");
      }
    } catch (error) {
      print("Error in wishListApi: $error");
    }
  }
}