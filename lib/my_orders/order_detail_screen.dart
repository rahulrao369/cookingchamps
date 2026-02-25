import 'package:cooking_champs/constant/apiConnectorConstants.dart';
import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/model/order_detail_model.dart';
import 'package:cooking_champs/utils/all_dialogs.dart';
import 'package:cooking_champs/utils/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cooking_champs/services/api_path.dart';
import 'package:cooking_champs/services/user_prefences.dart';
import 'package:cooking_champs/utils/utility.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'dart:convert' as convert;
import 'dart:developer' as developer;

class OrderDetailsScreen extends StatefulWidget {
  final String selectId ;
  final String deliveredType;
  const OrderDetailsScreen({super.key, required this.selectId, required this.deliveredType});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {

  OrderDetailModel orderDetailData = OrderDetailModel();
  @override
  void initState() {
    // TODO: implement initState
    orderDetailsApi(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appBar: commonAppBar(
        showBack: true,
        backgroundColor: MyColor.yellowF6F1E1,
        context: context,
        title:   "Order Details",
        iconColor: Colors.black,
        centerTitle: false,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Order Header Box
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: MyColor.colorF4F3F5,
                border: Border.all(color: MyColor.colorE5E7EE),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                       Text(
                         "${orderDetailData.data?.uniqueId ?? "--"}",
                        style:boldTextStyle(
                            fontSize: 16.0, color: MyColor.black),
                      ),
                      const Spacer(),
                      SvgPicture.asset(
                        widget.deliveredType == "On The Way" ?   AssetsPath.onTheway:   widget.deliveredType == "New" ?AssetsPath.New:AssetsPath.deliveredIcon,
                        height: 18,
                        width: 18,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.deliveredType,
                        style:mediumTextStyle(
                            fontSize: 13.0, color:widget.deliveredType == "On The Way" ? MyColor.colorE15C0A : Colors.green),
                      )
                    ],
                  ),
                  const SizedBox(height: 6),
                   Text("Order Date",   style:regularNormalTextStyleWithoutHeight(
                      fontSize: 13.0, color: MyColor.black),),
                   Text(
                     Utility.convertDateFormat(orderDetailData.data?.createdAt ?? ""),
                    style:mediumTextStyle(
                        fontSize: 14.0, color: MyColor.black),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            /// Delivery Address
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: MyColor.colorE5E7EE),
                color: MyColor.colorF4F3F5,
                borderRadius: BorderRadius.circular(10),
              ),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Delivery Address",
                    style:semiBoldTextStyle(
                        fontSize: 14.0, color: MyColor.black),
                  ),
                  hsized5,
                  Text(
                    orderDetailData.data?.deliveryAddress?.address ?? "--",

                    style:regularTextStyle(
                        fontSize: 13.0, color: MyColor.black),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            /// Product Items
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: MyColor.colorF4F3F5,
                border: Border.all(color: MyColor.colorE5E7EE),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: List.generate(orderDetailData.data?.orderItem?.length ?? 0, (index){
                  final item = orderDetailData.data!.orderItem![index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'assets/images/man.png', // Replace with real image
                            height: 34,
                            width: 34,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),
                         Expanded(
                           child: Text(item.productName ?? "--",style: semiBoldTextStyle(
                              fontSize: 14.0, color: MyColor.black),),
                        ),
                        Text("\$${item.price ?? "0"}", style: semiBoldTextStyle(
                            fontSize: 14.0, color: MyColor.black),),
                      ],
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 16),

            /// Price Summary
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: MyColor.colorE5E7EE),
                color: MyColor.colorF4F3F5,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children:  [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Subtotal",style: semiBoldTextStyle(
                          fontSize: 14.0, color: MyColor.black),),
                      Text("\$${orderDetailData.data?.totalAmount ?? "0"}",style: semiBoldTextStyle(
                          fontSize: 14.0, color: MyColor.black),),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Tax",style: semiBoldTextStyle(
                          fontSize: 14.0, color: MyColor.black),),
                      Text("+\$${orderDetailData.data?.taxAmount ?? "0"}", style: semiBoldTextStyle(
                          fontSize: 14.0, color: MyColor.black),),
                    ],
                  ),
                  Divider(height: 24,color: MyColor.colorE5E7EE,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total", style: semiBoldTextStyle(
                          fontSize: 16.0, color: MyColor.black),),
                      Text("\$${orderDetailData.data?.netAmount?? "0"}",
                          style: boldTextStyle(
                              fontSize: 16.0, color: MyColor.appTheme),
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

  Future<void> orderDetailsApi(context) async {
    ApiConnectorConstants.accessToken =
        await PreferencesServices.getPreferencesData(
            PreferencesServices.userToken) ??
            "";
    AllDialogs.progressLoadingDialog(context, true);
    try {
      var request = {
        'order_id': widget.selectId,
      };

      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);

      var response = await http.post(
        Uri.parse(ApiPath.orderDetails),
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
        orderDetailData = OrderDetailModel.fromJson(jsonResponse);
        developer.log(convert.jsonEncode(jsonResponse));
        setState(() {
        });
      } else {
        Utility.customToast(context, "${jsonResponse['message']}");
      }
    } catch (error) {
      print("Error in wishListApi: $error");
    }
  }
}
