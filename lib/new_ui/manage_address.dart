// import 'package:cooking_champs/constant/assets_path.dart';
// import 'package:cooking_champs/constant/my_color.dart';
// import 'package:cooking_champs/new_ui/cart_shops_details/cartscreen/add__new_address.dart';
// import 'package:cooking_champs/utils/common_widget.dart';
// import 'package:cooking_champs/widgets/delete_account_popup.dart';
// import 'package:flutter/material.dart';
// import 'package:cooking_champs/constant/apiConnectorConstants.dart';
// import 'package:cooking_champs/constant/my_fonts_style.dart';
// import 'package:cooking_champs/constant/sized_box.dart';
// import 'package:cooking_champs/model/dynamic_models/address_list_model.dart';
// import 'package:cooking_champs/services/api_path.dart';
// import 'package:cooking_champs/services/user_prefences.dart';
// import 'package:cooking_champs/utils/utility.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:pretty_http_logger/pretty_http_logger.dart';
// import 'dart:convert' as convert;
//
// class ManageAddress extends StatefulWidget {
//   const ManageAddress({super.key});
//
//   @override
//   State<ManageAddress> createState() => _ManageAddressState();
// }
//
// class _ManageAddressState extends State<ManageAddress> {
//   AddressListModel addressList = AddressListModel();
//   String selectAddressId = "";
//   String addressId  ="";
//   bool isLoading = true;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     addressListApi();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//       final bool isTablet = MediaQuery.of(context).size.width > 600;
//     return CommonScaffold(
//       appBar: commonAppBar(
//         showBack: true,
//         backgroundColor: MyColor.yellowF6F1E1,
//         context: context,
//         title: "Manage Address",
//         iconColor: Colors.black,
//         centerTitle: false,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
//         child: Column(
//           children: [
//             Expanded(
//               child: isLoading
//                   ? const Center(child: CircularProgressIndicator())
//                   : (addressList.data == null || addressList.data!.isEmpty)
//                   ? Center(
//                 child: Text(
//                   "No address found.",
//                   style: mediumTextStyle(fontSize:isTablet ? 24.0 : 16.0, color: Colors.black54),
//                 ),
//               )
//                   : ListView.builder(
//                 itemCount: addressList.data?.length ?? 0,
//                 shrinkWrap: true,
//                 physics: const AlwaysScrollableScrollPhysics(),
//                 itemBuilder: (context, index) {
//                   return GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         selectAddressId = addressList.data?[index].id ?? "";
//                       });
//                     },
//                     child: Container(
//                       width: double.infinity,
//                       margin: const EdgeInsets.only(bottom: 12),
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: Colors.grey.shade300,
//                           width: 2,
//                         ),
//                         borderRadius: BorderRadius.circular(12),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.shade200,
//                             blurRadius: 6,
//                             offset: const Offset(0, 2),
//                           ),
//                         ],
//                         color: MyColor.colorF4F3F5,
//                       ),
//                       child: Stack(
//                         children: [
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Container(
//                                     decoration: BoxDecoration(
//                                       color: MyColor.appTheme,
//                                       borderRadius: const BorderRadius.only(
//                                           topLeft: Radius.circular(4)),
//                                     ),
//                                     child: Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 8.0, vertical: 3),
//                                       child: Text(
//                                         addressList.data?[index].addressType ??
//                                             "",
//                                         style: mediumTextStyle(
//                                           fontSize: 13.0,
//                                           color: MyColor.white,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   const Spacer(),
//                                   IconButton(
//                                     padding: EdgeInsets.zero,
//                                     onPressed: () {
//                                       showModalBottomSheet(
//                                         backgroundColor: MyColor.white,
//                                         context: context,
//                                         isScrollControlled: true,
//                                         shape: const RoundedRectangleBorder(
//                                           borderRadius: BorderRadius.vertical(
//                                               top: Radius.circular(20)),
//                                         ),
//                                         builder: (context) {
//                                           return DraggableScrollableSheet(
//                                             expand: false,
//                                             initialChildSize: 0.6,
//                                             minChildSize: 0.3,
//                                             maxChildSize: 0.9,
//                                             builder:
//                                                 (context, scrollController) {
//                                               return StatefulBuilder(
//                                                 builder: (context,
//                                                     setStateBottomSheet) {
//                                                   return AddNewAddress(
//                                                     type: "Edit Address",
//                                                     name: addressList
//                                                         .data?[index].name ??
//                                                         "",
//                                                     address: addressList
//                                                         .data?[index]
//                                                         .address ??
//                                                         "",
//                                                     addressType: addressList
//                                                         .data?[index]
//                                                         .addressType ??
//                                                         "",
//                                                     addressId: addressList
//                                                         .data?[index].id ??
//                                                         "",
//                                                   );
//                                                 },
//                                               );
//                                             },
//                                           );
//                                         },
//                                       ).then((value) {
//                                         if (value) {
//                                           addressListApi();
//                                         }
//                                       });
//                                     },
//                                     icon: SvgPicture.asset(
//                                       AssetsPath.editIcon,
//                                       height: 22,
//                                     ),
//                                   ),
//                                   IconButton(
//                                     padding: EdgeInsets.zero,
//                                     onPressed: () {
//                                       addressId =
//                                           addressList.data?[index].id ?? "";
//                                       deleteAddressOnTap();
//                                     },
//                                     icon: SvgPicture.asset(
//                                       AssetsPath.deleteIcon,
//                                       height: 22,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Padding(
//                                 padding:
//                                 const EdgeInsets.symmetric(horizontal: 15.0),
//                                 child: Text(
//                                   addressList.data?[index].address ?? "",
//                                   style: const TextStyle(
//                                     color: Colors.black87,
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                               ),
//                               hsized15,
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//
//             commonButton(
//               text: "Add New",
//               onTap: () {
//                 showModalBottomSheet(
//                   backgroundColor: MyColor.white,
//                   context: context,
//                   isScrollControlled: true,
//                   shape: const RoundedRectangleBorder(
//                     borderRadius:
//                         BorderRadius.vertical(top: Radius.circular(20)),
//                   ),
//                   builder: (context) {
//                     return DraggableScrollableSheet(
//                       expand: false,
//                       initialChildSize: 0.6,
//                       minChildSize: 0.3,
//                       maxChildSize: 0.9,
//                       builder: (context, scrollController) {
//                         return StatefulBuilder(
//                           builder: (context, setStateBottomSheet) {
//                             return AddNewAddress(
//                               type: "Add New Address",
//                             );
//                           },
//                         );
//                       },
//                     );
//                   },
//                 ).then(
//                   (value) {
//                     if (value) {
//                       addressListApi();
//                     }
//                   },
//                 );
//                 // TODO: Implement Add New Address
//               },
//               backgroundColor: MyColor.color48335CB2,
//               textColor: MyColor.white,
//               isTablet: isTablet
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> addressListApi() async {
//     setState(() {
//       isLoading = true;
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
//         Uri.parse(ApiPath.addressList),
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
//         addressList = AddressListModel.fromJson(jsonResponse);
//       } else {
//         Utility.customToast(context, "${jsonResponse['message']}");
//       }
//     } catch (error) {
//       print("Error in addressListApi: $error");
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//   void deleteAddressOnTap() {
//     showDialog(
//       context: context,
//       builder: (context) => DeleteAddressPopup(
//         onCallBack: (confirmation) {
//           if (confirmation == "confirm") {
//             onDeleteAddress();
//           }
//         },
//       ),
//     );
//   }
//   void onDeleteAddress() {
//     debugPrint("Confirmed delete address ID: $addressId");
//     addressDeleteApi(); // No need for Future.delayed or passing unused string
//   }
//
//   Future<void> addressDeleteApi() async {
//     ApiConnectorConstants.accessToken =
//         await PreferencesServices.getPreferencesData(
//             PreferencesServices.userToken) ??
//             "";
//
//     final request = {
//       'address_id': addressId,
//     };
//
//     final http = HttpWithMiddleware.build(middlewares: [
//       HttpLogger(logLevel: LogLevel.BODY),
//     ]);
//
//     try {
//       final response = await http.post(
//         Uri.parse(ApiPath.deleteAddress),
//         body: convert.jsonEncode(request),
//         headers: {
//           "Accept": "application/json",
//           "Content-type": "application/json",
//           "Authorization": "Bearer ${ApiConnectorConstants.accessToken}",
//         },
//       );
//
//       final jsonResponse = convert.jsonDecode(response.body);
//
//       if (jsonResponse['status'] == true) {
//         await addressListApi(); // Refresh list
//       } else {
//         Utility.customToast(context, jsonResponse['message'] ?? "Something went wrong.");
//       }
//     } catch (error) {
//       print("Error in addressDeleteApi: $error");
//       Utility.customToast(context, "Failed to delete address.");
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
// }


import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/new_ui/cart_shops_details/cartscreen/add__new_address.dart';
import 'package:cooking_champs/utils/common_widget.dart';
import 'package:cooking_champs/widgets/delete_account_popup.dart';
import 'package:flutter/material.dart';
import 'package:cooking_champs/constant/apiConnectorConstants.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/model/dynamic_models/address_list_model.dart';
import 'package:cooking_champs/services/api_path.dart';
import 'package:cooking_champs/services/user_prefences.dart';
import 'package:cooking_champs/utils/utility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'dart:convert' as convert;

class ManageAddress extends StatefulWidget {
  const ManageAddress({super.key});

  @override
  State<ManageAddress> createState() => _ManageAddressState();
}

class _ManageAddressState extends State<ManageAddress> {
  AddressListModel addressList = AddressListModel();
  String selectAddressId = "";
  String addressId = "";
  bool isLoading = true;

  @override
  void initState() {
    addressListApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width > 600;

    return CommonScaffold(
      appBar: commonAppBar(
        showBack: true,
        backgroundColor: MyColor.yellowF6F1E1,
        context: context,
        title: "Manage Address",
        iconColor: Colors.black,
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? 25.0 : 15.0,
          vertical: isTablet ? 25.0 : 15.0,
        ),
        child: Column(
          children: [
            Expanded(
              child: isLoading
                  ? Center(
                child: CircularProgressIndicator(
                  color: MyColor.appTheme,
                  strokeWidth: isTablet ? 3.0 : 2.0,
                ),
              )
                  : (addressList.data == null || addressList.data!.isEmpty)
                  ? Center(
                child: Text(
                  "No address found.",
                  style: mediumTextStyle(
                    fontSize: isTablet ? 20.0 : 16.0,
                    color: Colors.black54,
                  ),
                ),
              )
                  : ListView.builder(
                itemCount: addressList.data?.length ?? 0,
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectAddressId =
                            addressList.data?[index].id ?? "";
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(
                        bottom: isTablet ? 16.0 : 12.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: isTablet ? 2.5 : 2.0,
                        ),
                        borderRadius: BorderRadius.circular(
                          isTablet ? 16.0 : 12.0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: isTablet ? 8.0 : 6.0,
                            offset: const Offset(0, 2),
                          ),
                        ],
                        color: MyColor.colorF4F3F5,
                      ),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: MyColor.appTheme,
                                      borderRadius:
                                      BorderRadius.only(
                                        topLeft:
                                        Radius.circular(
                                            isTablet ? 6.0 : 4.0),
                                      ),
                                    ),
                                    child: Padding(
                                      padding:
                                      EdgeInsets.symmetric(
                                        horizontal:
                                        isTablet ? 12.0 : 8.0,
                                        vertical:
                                        isTablet ? 5.0 : 3.0,
                                      ),
                                      child: Text(
                                        addressList.data?[index]
                                            .addressType ??
                                            "",
                                        style: mediumTextStyle(
                                          fontSize:
                                          isTablet ? 15.0 : 13.0,
                                          color: MyColor.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    iconSize: isTablet ? 28.0 : 22.0,
                                    onPressed: () {
                                      _showEditAddressSheet(
                                        context,
                                        index,
                                        isTablet,
                                      );
                                    },
                                    icon: SvgPicture.asset(
                                      AssetsPath.editIcon,
                                      height: isTablet ? 26.0 : 22.0,
                                      width: isTablet ? 26.0 : 22.0,
                                    ),
                                  ),
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    iconSize: isTablet ? 28.0 : 22.0,
                                    onPressed: () {
                                      addressId = addressList
                                          .data?[index].id ??
                                          "";
                                      deleteAddressOnTap();
                                    },
                                    icon: SvgPicture.asset(
                                      AssetsPath.deleteIcon,
                                      height: isTablet ? 26.0 : 22.0,
                                      width: isTablet ? 26.0 : 22.0,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: isTablet ? 20.0 : 15.0,
                                  vertical: isTablet ? 10.0 : 8.0,
                                ),
                                child: Text(
                                  addressList.data?[index].address ??
                                      "",
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: isTablet ? 16.0 : 14.0,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                              SizedBox(height: isTablet ? 20.0 : 15.0),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Add New Button
            commonButton(
              text: "Add New",
              onTap: () {
                _showAddAddressSheet(context, isTablet);
              },
              backgroundColor: MyColor.color48335CB2,
              textColor: MyColor.white,
              isTablet: isTablet,
            ),
          ],
        ),
      ),
    );
  }

  // Method to show Add New Address bottom sheet
  void _showAddAddressSheet(BuildContext context, bool isTablet) {
    showModalBottomSheet(
      backgroundColor: MyColor.white,
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      useSafeArea: true,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(isTablet ? 30.0 : 20.0),
          topRight: Radius.circular(isTablet ? 30.0 : 20.0),
        ),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: isTablet ? 0.75 : 0.6,
          minChildSize: isTablet ? 0.45 : 0.3,
          maxChildSize: isTablet ? 0.95 : 0.9,
          builder: (context, scrollController) {
            return StatefulBuilder(
              builder: (context, setStateBottomSheet) {
                return AddNewAddress(
                  type: "Add New Address",
                  isTablet: isTablet,
                );
              },
            );
          },
        );
      },
    ).then(
          (value) {
        if (value) {
          addressListApi();
        }
      },
    );
  }

  // Method to show Edit Address bottom sheet
  void _showEditAddressSheet(
      BuildContext context, int index, bool isTablet) {
    showModalBottomSheet(
      backgroundColor: MyColor.white,
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(isTablet ? 30.0 : 20.0),
          topRight: Radius.circular(isTablet ? 30.0 : 20.0),
        ),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: isTablet ? 0.75 : 0.6,
          minChildSize: isTablet ? 0.45 : 0.3,
          maxChildSize: isTablet ? 0.95 : 0.9,
          builder: (context, scrollController) {
            return StatefulBuilder(
              builder: (context, setStateBottomSheet) {
                return AddNewAddress(
                  type: "Edit Address",
                  name: addressList.data?[index].name ?? "",
                  address: addressList.data?[index].address ?? "",
                  addressType: addressList.data?[index].addressType ?? "",
                  addressId: addressList.data?[index].id ?? "",
                );
              },
            );
          },
        );
      },
    ).then((value) {
      if (value) {
        addressListApi();
      }
    });
  }

  Future<void> addressListApi() async {
    setState(() {
      isLoading = true;
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
        Uri.parse(ApiPath.addressList),
        headers: {
          "Accept": "application/json",
          "Content-type": 'application/json',
          "Authorization": "Bearer ${ApiConnectorConstants.accessToken}"
        },
      );

      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);

      if (jsonResponse['status'] == true) {
        addressList = AddressListModel.fromJson(jsonResponse);
      } else {
        Utility.customToast(context, "${jsonResponse['message']}");
      }
    } catch (error) {
      print("Error in addressListApi: $error");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void deleteAddressOnTap() {
    showDialog(
      context: context,
      builder: (context) => DeleteAddressPopup(
        onCallBack: (confirmation) {
          if (confirmation == "confirm") {
            onDeleteAddress();
          }
        },
      ),
    );
  }

  void onDeleteAddress() {
    debugPrint("Confirmed delete address ID: $addressId");
    addressDeleteApi();
  }

  Future<void> addressDeleteApi() async {
    ApiConnectorConstants.accessToken =
        await PreferencesServices.getPreferencesData(
            PreferencesServices.userToken) ??
            "";

    final request = {
      'address_id': addressId,
    };

    final http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    try {
      final response = await http.post(
        Uri.parse(ApiPath.deleteAddress),
        body: convert.jsonEncode(request),
        headers: {
          "Accept": "application/json",
          "Content-type": "application/json",
          "Authorization": "Bearer ${ApiConnectorConstants.accessToken}",
        },
      );

      final jsonResponse = convert.jsonDecode(response.body);

      if (jsonResponse['status'] == true) {
        await addressListApi();
      } else {
        Utility.customToast(
            context, jsonResponse['message'] ?? "Something went wrong.");
      }
    } catch (error) {
      print("Error in addressDeleteApi: $error");
      Utility.customToast(context, "Failed to delete address.");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}