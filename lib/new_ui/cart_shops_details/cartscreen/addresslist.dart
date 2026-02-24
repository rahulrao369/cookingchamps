import 'package:cooking_champs/constant/apiConnectorConstants.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/model/dynamic_models/address_list_model.dart';
import 'package:cooking_champs/new_ui/web_view_screen.dart';
import 'package:cooking_champs/services/api_path.dart';
import 'package:cooking_champs/services/user_prefences.dart';
import 'package:cooking_champs/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'dart:convert' as convert;
import 'dart:developer' as developer;
import 'add__new_address.dart';

class AddressList extends StatefulWidget {
  const AddressList({super.key});

  @override
  State<AddressList> createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  AddressListModel addressList = AddressListModel();
  int selectedIndex = 0;
  bool isLoading = true;
  String selectAddressId = "";

  @override
  void initState() {
    // TODO: implement initState
    addressListApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const SizedBox(
        height: 300,
        child: Center(
            child: CircularProgressIndicator(
          color: MyColor.appTheme,
        )),
      );
    }


    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          hsized10,
          Container(
            decoration: BoxDecoration(
                color: MyColor.grayLite,
                borderRadius: BorderRadius.circular(15)),
            height: 5,
            width: 100,
          ),
          hsized15,
          Text('Select Address',
              style: mediumTextStyle(fontSize: 20.0, color: Colors.black)),
          hsized10,
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Select Service Address",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          backgroundColor: MyColor.white,
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          builder: (context) {
                            return DraggableScrollableSheet(
                              expand: false,
                              initialChildSize: 0.6,
                              minChildSize: 0.3,
                              maxChildSize: 0.9,
                              builder: (context, scrollController) {
                                return StatefulBuilder(
                                  builder: (context, setStateBottomSheet) {
                                    return AddNewAddress(type: "Add New Address",);
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
                        // TODO: Implement Add New Address
                      },
                      child: Text("+Add New",
                          style: mediumTextStyle(
                              fontSize: 15.0, color: MyColor.appTheme)),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 320,
                  child: (addressList.data == null || addressList.data!.isEmpty)
                      ? const Center(
                    child: Text(
                      "No address found.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                      : ListView.builder(
                    itemCount: addressList.data?.length,
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final isSelected = index == selectedIndex;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectAddressId = addressList.data?[index].id ?? "";
                            selectedIndex = index;
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF5B2E91)
                                  : Colors.grey.shade300,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                            color: Colors.white,
                          ),
                          child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: MyColor.appTheme,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 3),
                                      child: Text(
                                        addressList.data?[index].addressType ?? "",
                                        style: mediumTextStyle(
                                          fontSize: 13.0,
                                          color: MyColor.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 15.0),
                                    child: Text(
                                      addressList.data?[index].address ?? "",
                                      style: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  hsized15,
                                ],
                              ),
                              if (isSelected)
                                const Positioned(
                                  right: 8,
                                  top: 8,
                                  child: Icon(
                                    size: 25,
                                    Icons.check_circle,
                                    color: MyColor.appTheme,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:
                    selectAddressId.isEmpty
                        ? null
                        : () async {
                      final userId = await PreferencesServices.getPreferencesData(
                        PreferencesServices.userId,
                      );

                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WebViewScreen(
                            type: "order",
                            url: AppUrls.orderStripeURL(
                              userId: userId,
                              shippingAddressId: selectAddressId.toString(),
                            ),
                            title: "Choose Plan",
                          ),
                        ),
                      );

                      if (result != null && result is Map) {
                        final bool status = result['status'] ?? false;
                        final String message = result['message'] ?? "Something went wrong.";

                        // 🔽 Print to console
                        print("Payment Status: $status");
                        print("Payment Message: $message");

                        if (!mounted) return;
                        if (mounted) {
                          Navigator.pop(context, {
                            'status': status,
                            'message': message,
                          }); // Send back data
                        }


                        if (status) {
                          addressListApi(); // Optional: refresh address list
                        }
                      }
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectAddressId.isEmpty
                          ? Colors.grey
                          : MyColor.appTheme,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Continue',
                      style: mediumTextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )


              ],
            ),
          )
        ],
      ),
    );
  }






  Future<void> addressListApi() async {
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
        developer.log(convert.jsonEncode(jsonResponse));
        if (addressList.data != null && addressList.data!.isNotEmpty) {
          selectAddressId = addressList.data!.first.id ?? "";
          selectedIndex = 0;
        }
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
}
