// import 'package:cooking_champs/constant/apiConnectorConstants.dart';
// import 'package:cooking_champs/constant/my_fonts_style.dart';
// import 'package:cooking_champs/enums/register_enum.dart';
// import 'package:cooking_champs/model/dynamic_models/card_list_model.dart';
// import 'package:cooking_champs/new_ui/cart_shops_details/cartscreen/addresslist.dart';
// import 'package:cooking_champs/services/api_path.dart';
// import 'package:cooking_champs/services/user_prefences.dart';
// import 'package:cooking_champs/utils/all_dialogs.dart';
// import 'package:cooking_champs/utils/common_widget.dart';
// import 'package:cooking_champs/utils/utility.dart';
// import 'package:flutter/material.dart';
// import 'package:cooking_champs/constant/my_color.dart';
// import 'package:pretty_http_logger/pretty_http_logger.dart';
// import 'dart:convert' as convert;
// import 'dart:developer' as developer;
//
// class CartScreen extends StatefulWidget {
//   const CartScreen({super.key});
//
//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }
//
// class _CartScreenState extends State<CartScreen> {
//   CardListModel cardList = CardListModel();
//   bool isLoading = true;
//   bool addCardLod = true;
//
//   ///............inc/den
//   String cartId = "";
//   String productId = "";
//   String action = "";
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     cardListApi();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     var listData = cardList.data?.items;
//     var listDataTex = cardList.data;
//     final textSize = screenWidth * 0.035;
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: commonAppBar(context: context, title: 'Cart', centerTitle: false),
//       body: SafeArea(
//         child: isLoading
//             ? const Center(
//                 child: CircularProgressIndicator(
//                 color: MyColor.appTheme,
//               ))
//             : (listData == null || listData.isEmpty)
//                 ? const Center(
//                     child: Text(
//                       'No items found in cart',
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   )
//                 : Column(
//                     children: [
//                       Expanded(
//                         child: Container(
//                           margin: const EdgeInsets.symmetric(
//                               horizontal: 16, vertical: 10),
//                           padding: const EdgeInsets.symmetric(vertical: 10),
//                           decoration: BoxDecoration(
//                             color: MyColor.colorF4F3F5,
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: ListView.builder(
//                             itemCount: listData.length,
//                             itemBuilder: (context, index) {
//                               return Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 10, vertical: 6),
//                                 child: Row(
//                                   children: [
//                                     ClipOval(
//                                       child: FadeInImage.assetNetwork(
//                                         placeholder:
//                                             'assets/new_ui_images/listimage.png',
//                                         image:
//                                             "${ApiPath.imageBaseUrl}${listData[index].image}",
//                                         width: 34,
//                                         height: 34,
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                     const SizedBox(width: 10),
//                                     Expanded(
//                                       child: Text(
//                                           '${listData[index].productName} (\$${listData[index].price})',
//                                           style: semiBoldTextStyle(
//                                               fontSize: 14.0,
//                                               color: Colors.black)),
//                                     ),
//                                     cardList.data?.role == RegisterType.roleKids.value
//                                         ? Text(
//                                             listData[index].quantity ?? "",
//                                             style:
//                                                 TextStyle(fontSize: textSize),
//                                           )
//                                         : Container(
//                                       // color: Colors.red,
//                                             width: 105,
//                                             padding: const EdgeInsets.symmetric(
//                                                 horizontal: 20, vertical: 0),
//                                             // decoration: BoxDecoration(
//                                             //   border: Border.all(
//                                             //       color: Colors.grey.shade400),
//                                             //   borderRadius:
//                                             //       BorderRadius.circular(10),
//                                             // ),
//                                             child: Row(
//                                               children: [
//                                                 Expanded(
//                                                   flex: 1,
//                                                   child: GestureDetector(
//                                                     onTap: () {
//                                                       cartId = listData[index]
//                                                               .cartId ??
//                                                           "";
//                                                       productId =
//                                                           listData[index]
//                                                                   .productId ??
//                                                               "";
//
//                                                       action =
//                                                           "decrement"; // <-- set action first
//                                                       int currentQty =
//                                                           int.tryParse(listData[
//                                                                           index]
//                                                                       .quantity ??
//                                                                   "1") ??
//                                                               1;
//
//                                                       if (currentQty > 1) {
//                                                         setState(() {
//                                                           listData[index]
//                                                                   .quantity =
//                                                               (currentQty - 1)
//                                                                   .toString();
//                                                         });
//                                                         incrementApi(index);
//                                                       }
//                                                     },
//                                                     child: Text(
//                                                       '-',
//                                                       style: TextStyle(
//                                                           fontSize: 25),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 // const SizedBox(width: 8),
//                                                 Expanded(
//                                                   child: Text(
//                                                     listData[index].quantity ??
//                                                         "",
//                                                     style: TextStyle(
//                                                         fontSize: textSize),
//                                                   ),
//                                                 ),
//                                                 // const SizedBox(width: 8),
//                                                 GestureDetector(
//                                                   onTap: () {
//                                                     cartId = listData[index]
//                                                             .cartId ??
//                                                         "";
//                                                     productId = listData[index]
//                                                             .productId ??
//                                                         "";
//
//                                                     action =
//                                                         "increment"; // <-- set action first
//                                                     int currentQty =
//                                                         int.tryParse(listData[
//                                                                         index]
//                                                                     .quantity ??
//                                                                 "1") ??
//                                                             1;
//
//                                                     setState(() {
//                                                       listData[index].quantity =
//                                                           (currentQty + 1)
//                                                               .toString();
//                                                     });
//                                                     incrementApi(index);
//                                                   },
//                                                   child: Text(
//                                                     '+',
//                                                     style:
//                                                         TextStyle(fontSize: 20),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                     cardList.data?.role ==
//                                             RegisterType.roleKids.value
//                                         ? SizedBox.shrink()
//                                         : InkWell(
//                                             onTap: () {
//                                               removeCardApi(listData[index].productId ?? "");
//                                             },
//                                             child: Icon(Icons.delete_forever,
//                                                 color: Colors.red,
//                                                 size: textSize + 4),
//                                           )
//                                   ],
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 12),
//                       Container(
//                         margin: const EdgeInsets.symmetric(horizontal: 16),
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 12, horizontal: 16),
//                         decoration: BoxDecoration(
//                           color: MyColor.colorF4F3F5,
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Column(
//                           children: [
//                             _rowItem('Subtotal', '\$${listDataTex?.subtotal}',
//                                 textSize),
//                             _rowItem('Tax', '\$${listDataTex?.tax}', textSize),
//                             Divider(height: 20, color: MyColor.grayLite2),
//                             _rowItem(
//                                 'Total', '\$${listDataTex?.total}', textSize,
//                                 isBold: true),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       cardList.data?.role == RegisterType.roleKids.value
//                           ? SizedBox.shrink()
//                           : Container(
//                               margin:
//                                   const EdgeInsets.symmetric(horizontal: 16),
//                               padding: const EdgeInsets.symmetric(
//                                   vertical: 12, horizontal: 16),
//                               decoration: BoxDecoration(
//                                 color: MyColor.colorF4F3F5,
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                               child: Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 16),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Column(
//                                       children: [
//                                         Text('TOTAL',
//                                             style: mediumTextStyle(
//                                                 fontSize: 14.0,
//                                                 color: Colors.black)),
//                                         Text('\$${listDataTex?.total}',
//                                             style: boldTextStyle(
//                                                 fontSize: 22.0,
//                                                 color: Colors.black)),
//                                       ],
//                                     ),
//                                     ElevatedButton(
//                                       onPressed: () {
//                                         showModalBottomSheet(
//                                           backgroundColor: MyColor.white,
//                                           context: context,
//                                           isScrollControlled: true,
//                                           shape: const RoundedRectangleBorder(
//                                             borderRadius: BorderRadius.vertical(
//                                                 top: Radius.circular(20)),
//                                           ),
//                                           builder: (context) {
//                                             return DraggableScrollableSheet(
//                                               expand: false,
//                                               initialChildSize: 0.6,
//                                               minChildSize: 0.3,
//                                               maxChildSize: 0.9,
//                                               builder:
//                                                   (context, scrollController) {
//                                                 return AddressList(); // this will return a Map on pop
//                                               },
//                                             );
//                                           },
//                                         ).then((value) {
//                                           if (value != null && value is Map) {
//                                             final bool status =
//                                                 value['status'] ?? false;
//                                             final String message =
//                                                 value['message'] ?? "";
//
//                                             // ✅ Show Alert Dialog with the payment result
//                                             showDialog(
//                                               context: context,
//                                               builder: (_) => AlertDialog(
//                                                 title: Text(status
//                                                     ? "Payment Successful"
//                                                     : "Payment Failed"),
//                                                 content: Text(message),
//                                                 actions: [
//                                                   TextButton(
//                                                     onPressed: () {
//                                                       Navigator.pop(
//                                                           context); // Close dialog
//                                                     },
//                                                     child: const Text("OK"),
//                                                   ),
//                                                 ],
//                                               ),
//                                             );
//
//                                             if (status) {
//                                               cardListApi(); // ✅ Refresh cart if payment succeeded
//                                             }
//                                           }
//                                         });
//                                       },
//                                       style: ElevatedButton.styleFrom(
//                                         backgroundColor: MyColor.appTheme,
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(20),
//                                         ),
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 35, vertical: 12),
//                                       ),
//                                       child: Text(
//                                         'Placed Orders',
//                                         style: TextStyle(
//                                           fontSize: textSize,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                     ],
//                   ),
//       ),
//     );
//   }
//
//   Widget _rowItem(String title, String value, double fontSize,
//       {bool isBold = false}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(title,
//               style: semiBoldTextStyle(fontSize: 14.0, color: Colors.black)),
//           Text(value,
//               style: semiBoldTextStyle(fontSize: 14.0, color: Colors.black)),
//         ],
//       ),
//     );
//   }
//
//   Future<void> cardListApi() async {
//     setState(() {
//       if (addCardLod) isLoading = true;
//     });
//
//     ApiConnectorConstants.accessToken =
//         await PreferencesServices.getPreferencesData(
//                 PreferencesServices.userToken) ??
//             "";
//
//     HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
//       HttpLogger(logLevel: LogLevel.BODY),
//     ]);
//
//     try {
//       var response = await http.get(
//         Uri.parse(ApiPath.cartList),
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
//         cardList = CardListModel.fromJson(jsonResponse);
//         developer.log(convert.jsonEncode(jsonResponse));
//         print("cardList.data?.role${cardList.data?.role}");
//       } else {
//         Utility.customToast(context, "${jsonResponse['message']}");
//       }
//     } catch (error) {
//       print("Error in cardListApi: $error");
//     }
//
//     setState(() {
//       if (addCardLod) isLoading = false;
//     });
//   }
//
//   Future<void> removeCardApi(String productId) async {
//     try {
//       ApiConnectorConstants.accessToken =
//           await PreferencesServices.getPreferencesData(
//                   PreferencesServices.userToken) ??
//               "";
//       AllDialogs.progressLoadingDialog(context, true);
//       var request = {
//         'product_id': productId.toString(),
//       };
//
//       HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
//         HttpLogger(logLevel: LogLevel.BODY),
//       ]);
//
//       var response = await http.post(
//         Uri.parse(ApiPath.removeCart),
//         body: convert.jsonEncode(request),
//         headers: {
//           "Accept": "application/json",
//           "Content-type": 'application/json',
//           "Authorization": "Bearer ${ApiConnectorConstants.accessToken}"
//         },
//       );
//
//       Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
//       AllDialogs.progressLoadingDialog(context, false);
//       if (jsonResponse['status'] == true) {
//         setState(() {
//           Utility.customToast(context, "Item has been removed successfully");
//
//           addCardLod = false;
//           cardListApi();
//         });
//       } else {
//         Utility.customToast(context, "${jsonResponse['message']}");
//       }
//     } catch (error) {
//       print("Error in wishListApi: $error");
//     }
//   }
//
//   Future<void> incrementApi(int index) async {
//     try {
//       ApiConnectorConstants.accessToken =
//           await PreferencesServices.getPreferencesData(
//                   PreferencesServices.userToken) ??
//               "";
//
//       var request = {
//         'product_id': productId,
//         'cart_id': cartId,
//         'action': action,
//       };
//
//       HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
//         HttpLogger(logLevel: LogLevel.BODY),
//       ]);
//
//       var response = await http.post(
//         Uri.parse(ApiPath.updateQuantity),
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
//         addCardLod = false;
//         cardListApi(); // to update subtotal, tax, total
//       } else {
//         // Revert on failure
//         setState(() {
//           int qty =
//               int.tryParse(cardList.data?.items?[index].quantity ?? "1") ?? 1;
//           if (action == "increment" && qty > 1) {
//             cardList.data?.items?[index].quantity = (qty - 1).toString();
//           } else if (action == "decrement") {
//             cardList.data?.items?[index].quantity = (qty + 1).toString();
//           }
//         });
//         Utility.customToast(
//             context, jsonResponse['message'] ?? "Something went wrong");
//       }
//     } catch (error) {
//       // Revert on exception
//       setState(() {
//         int qty =
//             int.tryParse(cardList.data?.items?[index].quantity ?? "1") ?? 1;
//         if (action == "increment" && qty > 1) {
//           cardList.data?.items?[index].quantity = (qty - 1).toString();
//         } else if (action == "decrement") {
//           cardList.data?.items?[index].quantity = (qty + 1).toString();
//         }
//       });
//       print("Error in incrementApi: $error");
//       Utility.customToast(
//           context, "Failed to update quantity. Please try again.");
//     }
//   }
// }

import 'package:cooking_champs/constant/apiConnectorConstants.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/enums/register_enum.dart';
import 'package:cooking_champs/model/dynamic_models/card_list_model.dart';
import 'package:cooking_champs/new_ui/cart_shops_details/cartscreen/addresslist.dart';
import 'package:cooking_champs/services/api_path.dart';
import 'package:cooking_champs/services/user_prefences.dart';
import 'package:cooking_champs/utils/all_dialogs.dart';
import 'package:cooking_champs/utils/common_widget.dart';
import 'package:cooking_champs/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'dart:convert' as convert;
import 'dart:developer' as developer;

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CardListModel cardList = CardListModel();
  bool isLoading = true;
  bool addCardLod = true;

  ///............inc/den
  String cartId = "";
  String productId = "";
  String action = "";

  @override
  void initState() {
    cardListApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isIpad = size.width > 600;
    var listData = cardList.data?.items;
    var listDataTex = cardList.data;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: commonAppBar(context: context, title: 'Cart', centerTitle: false),
      body: SafeArea(
        child: isLoading
            ? Center(
          child: CircularProgressIndicator(
            color: MyColor.appTheme,
            strokeWidth: isIpad ? 3.0 : 2.0,
          ),
        )
            : (listData == null || listData.isEmpty)
            ? Center(
          child: Text(
            'No items found in cart',
            style: TextStyle(
              fontSize: isIpad ? 22.0 : 16.0,
              color: Colors.grey.shade700,
            ),
          ),
        )
            : Column(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: isIpad ? 25.0 : 16.0,
                  vertical: isIpad ? 15.0 : 10.0,
                ),
                padding: EdgeInsets.symmetric(
                  vertical: isIpad ? 15.0 : 10.0,
                ),
                decoration: BoxDecoration(
                  color: MyColor.colorF4F3F5,
                  borderRadius: BorderRadius.circular(
                    isIpad ? 25.0 : 20.0,
                  ),
                ),
                child: ListView.builder(
                  itemCount: listData.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isIpad ? 15.0 : 10.0,
                        vertical: isIpad ? 10.0 : 6.0,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: FadeInImage.assetNetwork(
                              placeholder:
                              'assets/new_ui_images/listimage.png',
                              image:
                              "${ApiPath.imageBaseUrl}${listData[index].image}",
                              width: isIpad ? 45.0 : 34.0,
                              height: isIpad ? 45.0 : 34.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: isIpad ? 15.0 : 10.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  listData[index].productName ?? "",
                                  style: semiBoldTextStyle(
                                    fontSize: isIpad ? 18.0 : 14.0,
                                    color: Colors.black,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: isIpad ? 3.0 : 2.0),
                                Text(
                                  '\$${listData[index].price}',
                                  style: regularTextStyle(
                                    fontSize: isIpad ? 16.0 : 12.0,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          cardList.data?.role ==
                              RegisterType.roleKids.value
                              ? Text(
                            listData[index].quantity ?? "",
                            style: TextStyle(
                              fontSize: isIpad ? 18.0 : 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                              : Container(
                            width: isIpad ? 130.0 : 105.0,
                            padding: EdgeInsets.symmetric(
                              horizontal: isIpad ? 10.0 : 5.0,
                              vertical: isIpad ? 8.0 : 0.0,
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(
                                isIpad ? 12.0 : 8.0,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    cartId = listData[index]
                                        .cartId ??
                                        "";
                                    productId = listData[index]
                                        .productId ??
                                        "";
                                    action = "decrement";

                                    int currentQty = int.tryParse(
                                        listData[index]
                                            .quantity ??
                                            "1") ??
                                        1;

                                    if (currentQty > 1) {
                                      setState(() {
                                        listData[index]
                                            .quantity =
                                            (currentQty - 1)
                                                .toString();
                                      });
                                      incrementApi(index);
                                    }
                                  },
                                  child: Container(
                                    width: isIpad ? 40.0 : 30.0,
                                    height: isIpad ? 40.0 : 30.0,
                                    decoration: BoxDecoration(
                                      color: Colors.grey
                                          .shade200,
                                      borderRadius:
                                      BorderRadius.circular(
                                          isIpad
                                              ? 10.0
                                              : 8.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '-',
                                        style: TextStyle(
                                          fontSize: isIpad
                                              ? 24.0
                                              : 18.0,
                                          fontWeight:
                                          FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  listData[index].quantity ?? "",
                                  style: TextStyle(
                                    fontSize: isIpad ? 18.0 : 16.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    cartId = listData[index]
                                        .cartId ??
                                        "";
                                    productId = listData[index]
                                        .productId ??
                                        "";
                                    action = "increment";

                                    int currentQty = int.tryParse(
                                        listData[index]
                                            .quantity ??
                                            "1") ??
                                        1;

                                    setState(() {
                                      listData[index].quantity =
                                          (currentQty + 1)
                                              .toString();
                                    });
                                    incrementApi(index);
                                  },
                                  child: Container(
                                    width: isIpad ? 40.0 : 30.0,
                                    height: isIpad ? 40.0 : 30.0,
                                    decoration: BoxDecoration(
                                      color: MyColor.appTheme,
                                      borderRadius:
                                      BorderRadius.circular(
                                          isIpad
                                              ? 10.0
                                              : 8.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '+',
                                        style: TextStyle(
                                          fontSize: isIpad
                                              ? 24.0
                                              : 18.0,
                                          fontWeight:
                                          FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          cardList.data?.role ==
                              RegisterType.roleKids.value
                              ? SizedBox.shrink()
                              : SizedBox(width: isIpad ? 20.0 : 15.0),
                          cardList.data?.role ==
                              RegisterType.roleKids.value
                              ? SizedBox.shrink()
                              : InkWell(
                            onTap: () {
                              removeCardApi(listData[index]
                                  .productId ??
                                  "");
                            },
                            child: Icon(
                              Icons.delete_forever,
                              color: Colors.red,
                              size: isIpad ? 30.0 : 24.0,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: isIpad ? 20.0 : 12.0),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: isIpad ? 25.0 : 16.0,
              ),
              padding: EdgeInsets.symmetric(
                vertical: isIpad ? 18.0 : 12.0,
                horizontal: isIpad ? 20.0 : 16.0,
              ),
              decoration: BoxDecoration(
                color: MyColor.colorF4F3F5,
                borderRadius: BorderRadius.circular(
                  isIpad ? 25.0 : 20.0,
                ),
              ),
              child: Column(
                children: [
                  _rowItem(
                    'Subtotal',
                    '\$${listDataTex?.subtotal}',
                    isIpad,
                  ),
                  SizedBox(height: isIpad ? 8.0 : 4.0),
                  _rowItem(
                    'Tax',
                    '\$${listDataTex?.tax}',
                    isIpad,
                  ),
                  SizedBox(height: isIpad ? 12.0 : 8.0),
                  Divider(
                    height: 1,
                    color: MyColor.grayLite2,
                    thickness: isIpad ? 2.0 : 1.0,
                  ),
                  SizedBox(height: isIpad ? 12.0 : 8.0),
                  _rowItem(
                    'Total',
                    '\$${listDataTex?.total}',
                    isIpad,
                    isBold: true,
                  ),
                ],
              ),
            ),
            SizedBox(height: isIpad ? 25.0 : 20.0),
            cardList.data?.role == RegisterType.roleKids.value
                ? SizedBox.shrink()
                : Container(
              margin: EdgeInsets.symmetric(
                horizontal: isIpad ? 25.0 : 16.0,
              ),
              padding: EdgeInsets.symmetric(
                vertical: isIpad ? 18.0 : 12.0,
                horizontal: isIpad ? 20.0 : 16.0,
              ),
              decoration: BoxDecoration(
                color: MyColor.colorF4F3F5,
                borderRadius: BorderRadius.circular(
                  isIpad ? 25.0 : 20.0,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isIpad ? 20.0 : 16.0,
                ),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          'TOTAL',
                          style: mediumTextStyle(
                            fontSize: isIpad ? 16.0 : 14.0,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        SizedBox(height: isIpad ? 5.0 : 3.0),
                        Text(
                          '\$${listDataTex?.total}',
                          style: boldTextStyle(
                            fontSize: isIpad ? 28.0 : 22.0,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          backgroundColor: MyColor.white,
                          context: context,
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(
                                isIpad ? 30.0 : 20.0,
                              ),
                            ),
                          ),
                          builder: (context) {
                            return DraggableScrollableSheet(
                              expand: false,
                              initialChildSize:
                              isIpad ? 0.7 : 0.6,
                              minChildSize: isIpad ? 0.4 : 0.3,
                              maxChildSize: isIpad ? 0.95 : 0.9,
                              builder:
                                  (context, scrollController) {
                                return AddressList();
                              },
                            );
                          },
                        ).then((value) {
                          if (value != null && value is Map) {
                            final bool status =
                                value['status'] ?? false;
                            final String message =
                                value['message'] ?? "";

                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Text(
                                  status
                                      ? "Payment Successful"
                                      : "Payment Failed",
                                  style: TextStyle(
                                    fontSize: isIpad
                                        ? 22.0
                                        : 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                content: Text(
                                  message,
                                  style: TextStyle(
                                    fontSize: isIpad
                                        ? 18.0
                                        : 14.0,
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "OK",
                                      style: TextStyle(
                                        fontSize: isIpad
                                            ? 18.0
                                            : 16.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );

                            if (status) {
                              cardListApi();
                            }
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColor.appTheme,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            isIpad ? 25.0 : 20.0,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: isIpad ? 45.0 : 35.0,
                          vertical: isIpad ? 16.0 : 12.0,
                        ),
                        elevation: isIpad ? 4.0 : 2.0,
                      ),
                      child: Text(
                        'Place Order',
                        style: TextStyle(
                          fontSize: isIpad ? 18.0 : 16.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: isIpad ? 25.0 : 20.0),
          ],
        ),
      ),
    );
  }

  Widget _rowItem(String title, String value, bool isIpad,
      {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: isBold
              ? boldTextStyle(
            fontSize: isIpad ? 18.0 : 14.0,
            color: Colors.black,
          )
              : mediumTextStyle(
            fontSize: isIpad ? 16.0 : 14.0,
            color: Colors.black,
          ),
        ),
        Text(
          value,
          style: isBold
              ? boldTextStyle(
            fontSize: isIpad ? 20.0 : 14.0,
            color: Colors.black,
          )
              : mediumTextStyle(
            fontSize: isIpad ? 16.0 : 14.0,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Future<void> cardListApi() async {
    setState(() {
      if (addCardLod) isLoading = true;
    });

    ApiConnectorConstants.accessToken =
        await PreferencesServices.getPreferencesData(
            PreferencesServices.userToken) ??
            "";

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    try {
      var response = await http.get(
        Uri.parse(ApiPath.cartList),
        headers: {
          "Accept": "application/json",
          "Content-type": 'application/json',
          "Authorization": "Bearer ${ApiConnectorConstants.accessToken}"
        },
      );

      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);

      if (jsonResponse['status'] == true) {
        cardList = CardListModel.fromJson(jsonResponse);
        developer.log(convert.jsonEncode(jsonResponse));
        print("cardList.data?.role${cardList.data?.role}");
      } else {
        Utility.customToast(context, "${jsonResponse['message']}");
      }
    } catch (error) {
      print("Error in cardListApi: $error");
    }

    setState(() {
      if (addCardLod) isLoading = false;
    });
  }

  Future<void> removeCardApi(String productId) async {
    try {
      ApiConnectorConstants.accessToken =
          await PreferencesServices.getPreferencesData(
              PreferencesServices.userToken) ??
              "";
      AllDialogs.progressLoadingDialog(context, true);
      var request = {
        'product_id': productId.toString(),
      };

      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);

      var response = await http.post(
        Uri.parse(ApiPath.removeCart),
        body: convert.jsonEncode(request),
        headers: {
          "Accept": "application/json",
          "Content-type": 'application/json',
          "Authorization": "Bearer ${ApiConnectorConstants.accessToken}"
        },
      );

      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
      AllDialogs.progressLoadingDialog(context, false);
      if (jsonResponse['status'] == true) {
        setState(() {
          Utility.customToast(context, "Item has been removed successfully");

          addCardLod = false;
          cardListApi();
        });
      } else {
        Utility.customToast(context, "${jsonResponse['message']}");
      }
    } catch (error) {
      print("Error in wishListApi: $error");
    }
  }

  Future<void> incrementApi(int index) async {
    try {
      ApiConnectorConstants.accessToken =
          await PreferencesServices.getPreferencesData(
              PreferencesServices.userToken) ??
              "";

      var request = {
        'product_id': productId,
        'cart_id': cartId,
        'action': action,
      };

      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);

      var response = await http.post(
        Uri.parse(ApiPath.updateQuantity),
        body: convert.jsonEncode(request),
        headers: {
          "Accept": "application/json",
          "Content-type": 'application/json',
          "Authorization": "Bearer ${ApiConnectorConstants.accessToken}"
        },
      );

      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);

      if (jsonResponse['status'] == true) {
        addCardLod = false;
        cardListApi();
      } else {
        // Revert on failure
        setState(() {
          int qty =
              int.tryParse(cardList.data?.items?[index].quantity ?? "1") ?? 1;
          if (action == "increment" && qty > 1) {
            cardList.data?.items?[index].quantity = (qty - 1).toString();
          } else if (action == "decrement") {
            cardList.data?.items?[index].quantity = (qty + 1).toString();
          }
        });
        Utility.customToast(
            context, jsonResponse['message'] ?? "Something went wrong");
      }
    } catch (error) {
      // Revert on exception
      setState(() {
        int qty =
            int.tryParse(cardList.data?.items?[index].quantity ?? "1") ?? 1;
        if (action == "increment" && qty > 1) {
          cardList.data?.items?[index].quantity = (qty - 1).toString();
        } else if (action == "decrement") {
          cardList.data?.items?[index].quantity = (qty + 1).toString();
        }
      });
      print("Error in incrementApi: $error");
      Utility.customToast(
          context, "Failed to update quantity. Please try again.");
    }
  }
}