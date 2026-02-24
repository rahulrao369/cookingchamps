// import 'package:cooking_champs/constant/apiConnectorConstants.dart';
// import 'package:cooking_champs/constant/my_color.dart';
// import 'package:cooking_champs/constant/my_fonts_style.dart';
// import 'package:cooking_champs/constant/sized_box.dart';
// import 'package:cooking_champs/services/api_path.dart';
// import 'package:cooking_champs/services/user_prefences.dart';
// import 'package:cooking_champs/utils/all_dialogs.dart';
// import 'package:cooking_champs/utils/common_widget.dart';
// import 'package:cooking_champs/utils/navigators.dart';
// import 'package:cooking_champs/utils/utility.dart';
// import 'package:flutter/material.dart';
// import 'package:pretty_http_logger/pretty_http_logger.dart';
// import 'dart:convert' as convert;
//
// class AddNewAddress extends StatefulWidget {
//   final String type;
//   String? addressType;
//   String? addressId;
//   String? name;
//   String? address;
//
//   AddNewAddress({
//     super.key,
//     required this.type,
//     this.addressType,
//     this.address,
//     this.name,
//     this.addressId,
//   });
//
//   @override
//   State<AddNewAddress> createState() => _AddNewAddressState();
// }
//
// class _AddNewAddressState extends State<AddNewAddress> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController addressController = TextEditingController();
//
//   String? selectedAddressType;
//   final List<String> addressTypes = ['Home', 'Office'];
//
//   @override
//   void initState() {
//     super.initState();
//     selectedAddressType = widget.addressType;
//     nameController.text = widget.name ?? "";
//     addressController.text = widget.address ?? "";
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(15),
//           topRight: Radius.circular(15),
//         ),
//       ),
//       child: SafeArea(
//         top: false,
//         child: Padding(
//           padding: MediaQuery.of(context).viewInsets,
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 hsized10,
//                 Container(
//                   decoration: BoxDecoration(
//                     color: MyColor.grayLite,
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   height: 5,
//                   width: 100,
//                 ),
//                 hsized15,
//                 Text(
//                   widget.type,
//                   style: mediumTextStyle(fontSize: 20.0, color: Colors.black),
//                 ),
//                 hsized10,
//                 const Divider(),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       hsized15,
//                       Text(
//                         'Select Type',
//                         style: regularTextStyle(
//                             fontSize: 15.0, color: Colors.black),
//                       ),
//                       hsized2,
//                       DropdownButtonFormField<String>(
//                         value: selectedAddressType,
//                         decoration: InputDecoration(
//                           hintText: 'Address Type',
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide: BorderSide(color: MyColor.colorDCD8E0),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide: BorderSide(color: MyColor.colorDCD8E0),
//                           ),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide: BorderSide(color: MyColor.colorDCD8E0),
//                           ),
//                         ),
//                         items: addressTypes.map((type) {
//                           return DropdownMenuItem<String>(
//                             value: type,
//                             child: Text(type),
//                           );
//                         }).toList(),
//                         onChanged: (value) {
//                           setState(() {
//                             selectedAddressType = value;
//                           });
//                         },
//                       ),
//                       const SizedBox(height: 16),
//                       commonTextField(
//                         controller: nameController,
//                         labelText: 'Name',
//                         hintText: 'Enter name',
//                         textInputAction: TextInputAction.next,
//                         textInputType: TextInputType.text,
//                       ),
//                       const SizedBox(height: 16),
//                       commonTextField(
//                         controller: addressController,
//                         labelText: 'Address',
//                         hintText: 'Enter Address',
//                         textInputAction: TextInputAction.done,
//                         textInputType: TextInputType.text,
//                       ),
//                       SizedBox(height: MediaQuery.of(context).size.height / 13),
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             if (selectedAddressType == null) {
//                               Utility.customToast(
//                                   context, "Please select address type");
//                               return;
//                             }
//                             addAddressApi();
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: MyColor.appTheme,
//                             padding: const EdgeInsets.symmetric(vertical: 14),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                           ),
//                           child: Text(
//                             'Continue',
//                             style: mediumTextStyle(
//                                 fontSize: 16.0, color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> addAddressApi() async {
//     ApiConnectorConstants.accessToken =
//         await PreferencesServices.getPreferencesData(
//             PreferencesServices.userToken) ??
//             "";
//     AllDialogs.progressLoadingDialog(context, true);
//     try {
//       var request = {
//         'name': nameController.text.trim(),
//         'address': addressController.text.trim(),
//         'address_type': selectedAddressType ?? "",
//       };
//
//       if (widget.type == "Edit Address" && widget.addressId != null) {
//         request['address_id'] = widget.addressId!;
//       }
//
//       HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
//         HttpLogger(logLevel: LogLevel.BODY),
//       ]);
//
//       var response = await http.post(
//         Uri.parse(widget.type == "Edit Address"
//             ? ApiPath.editAddress
//             : ApiPath.addAddress),
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
//         Navigator.pop(context, true);
//       } else {
//         Utility.customToast(context, "${jsonResponse['message']}");
//       }
//     } catch (error) {
//       AllDialogs.progressLoadingDialog(context, false);
//       print("Error in addAddressApi: $error");
//     }
//   }
// }


import 'package:cooking_champs/constant/apiConnectorConstants.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/services/api_path.dart';
import 'package:cooking_champs/services/user_prefences.dart';
import 'package:cooking_champs/utils/all_dialogs.dart';
import 'package:cooking_champs/utils/common_widget.dart';
import 'package:cooking_champs/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'dart:convert' as convert;

class AddNewAddress extends StatefulWidget {
  final String type;
  final String? addressType;
  final String? addressId;
  final String? name;
  final String? address;
  final bool isTablet; // ✅ New parameter

  AddNewAddress({
    super.key,
    required this.type,
    this.addressType,
    this.address,
    this.name,
    this.addressId,
    this.isTablet = false, // ✅ Default false
  });

  @override
  State<AddNewAddress> createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  String? selectedAddressType;
  final List<String> addressTypes = ['Home', 'Office'];

  @override
  void initState() {
    super.initState();
    selectedAddressType = widget.addressType;
    nameController.text = widget.name ?? "";
    addressController.text = widget.address ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // ✅ Full width for tablet
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(widget.isTablet ? 25.0 : 15.0),
          topRight: Radius.circular(widget.isTablet ? 25.0 : 15.0),
        ),
        color: Colors.white,
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Drag Handle
                SizedBox(height: widget.isTablet ? 15.0 : 10.0),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: MyColor.grayLite,
                      borderRadius: BorderRadius.circular(
                        widget.isTablet ? 20.0 : 15.0,
                      ),
                    ),
                    height: widget.isTablet ? 7.0 : 5.0,
                    width: widget.isTablet ? 150.0 : 100.0,
                  ),
                ),
                SizedBox(height: widget.isTablet ? 25.0 : 15.0),

                // Title
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: widget.isTablet ? 30.0 : 15.0,
                  ),
                  child: Text(
                    widget.type,
                    style: mediumTextStyle(
                      fontSize: widget.isTablet ? 26.0 : 20.0,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: widget.isTablet ? 15.0 : 10.0),

                // Divider
                Divider(
                  thickness: widget.isTablet ? 1.5 : 1.0,
                  color: Colors.grey.shade300,
                ),

                // Form Content
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: widget.isTablet ? 40.0 : 15.0,
                    vertical: widget.isTablet ? 20.0 : 0.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: widget.isTablet ? 25.0 : 15.0),

                      // Address Type Dropdown
                      Text(
                        'Select Type',
                        style: regularTextStyle(
                          fontSize: widget.isTablet ? 18.0 : 15.0,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: widget.isTablet ? 10.0 : 2.0),
                      DropdownButtonFormField<String>(
                        value: selectedAddressType,
                        decoration: InputDecoration(
                          hintText: 'Address Type',
                          hintStyle: regularTextStyle(
                            fontSize: widget.isTablet ? 16.0 : 14.0,
                            color: Colors.grey.shade600,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: widget.isTablet ? 20.0 : 15.0,
                            vertical: widget.isTablet ? 20.0 : 16.0,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              widget.isTablet ? 16.0 : 12.0,
                            ),
                            borderSide: BorderSide(
                              color: MyColor.colorDCD8E0,
                              width: widget.isTablet ? 1.5 : 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              widget.isTablet ? 16.0 : 12.0,
                            ),
                            borderSide: BorderSide(
                              color: MyColor.appTheme,
                              width: widget.isTablet ? 2.0 : 1.5,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              widget.isTablet ? 16.0 : 12.0,
                            ),
                            borderSide: BorderSide(
                              color: MyColor.colorDCD8E0,
                              width: widget.isTablet ? 1.5 : 1.0,
                            ),
                          ),
                        ),
                        dropdownColor: Colors.white,
                        iconSize: widget.isTablet ? 28.0 : 24.0,
                        style: regularTextStyle(
                          fontSize: widget.isTablet ? 16.0 : 14.0,
                          color: Colors.black,
                        ),
                        items: addressTypes.map((type) {
                          return DropdownMenuItem<String>(
                            value: type,
                            child: Text(
                              type,
                              style: regularTextStyle(
                                fontSize: widget.isTablet ? 16.0 : 14.0,
                                color: Colors.black,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedAddressType = value;
                          });
                        },
                      ),
                      SizedBox(height: widget.isTablet ? 25.0 : 16.0),

                      // Name TextField
                      commonTextField(
                        controller: nameController,
                        labelText: 'Name',
                        hintText: 'Enter name',
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.text,
                        isTablet: widget.isTablet, // ✅ Pass isTablet
                      ),
                      SizedBox(height: widget.isTablet ? 25.0 : 16.0),

                      // Address TextField
                      commonTextField(
                        controller: addressController,
                        labelText: 'Address',
                        hintText: 'Enter Address',
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.text,
                        isTablet: widget.isTablet, // ✅ Pass isTablet
                      ),
                      SizedBox(
                        height: widget.isTablet
                            ? MediaQuery.of(context).size.height / 8
                            : MediaQuery.of(context).size.height / 13,
                      ),

                      // Continue Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (selectedAddressType == null) {
                              Utility.customToast(
                                  context, "Please select address type");
                              return;
                            }
                            addAddressApi();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyColor.appTheme,
                            padding: EdgeInsets.symmetric(
                              vertical: widget.isTablet ? 18.0 : 14.0,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                widget.isTablet ? 35.0 : 30.0,
                              ),
                            ),
                            elevation: widget.isTablet ? 4.0 : 2.0,
                          ),
                          child: Text(
                            'Continue',
                            style: mediumTextStyle(
                              fontSize: widget.isTablet ? 18.0 : 16.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      // Extra bottom spacing for tablet
                      SizedBox(height: widget.isTablet ? 40.0 : 20.0),
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

  Future<void> addAddressApi() async {
    ApiConnectorConstants.accessToken =
        await PreferencesServices.getPreferencesData(
            PreferencesServices.userToken) ??
            "";
    AllDialogs.progressLoadingDialog(context, true);
    try {
      var request = {
        'name': nameController.text.trim(),
        'address': addressController.text.trim(),
        'address_type': selectedAddressType ?? "",
      };

      if (widget.type == "Edit Address" && widget.addressId != null) {
        request['address_id'] = widget.addressId!;
      }

      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);

      var response = await http.post(
        Uri.parse(widget.type == "Edit Address"
            ? ApiPath.editAddress
            : ApiPath.addAddress),
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
        Navigator.pop(context, true);
      } else {
        Utility.customToast(context, "${jsonResponse['message']}");
      }
    } catch (error) {
      AllDialogs.progressLoadingDialog(context, false);
      print("Error in addAddressApi: $error");
    }
  }
}