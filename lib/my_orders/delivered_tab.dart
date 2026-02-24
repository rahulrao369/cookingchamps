import 'package:cooking_champs/constant/apiConnectorConstants.dart';
import 'package:cooking_champs/model/dynamic_models/new_order_model.dart';
import 'package:cooking_champs/my_orders/order_detail_screen.dart';
import 'package:cooking_champs/new_ui/cart_shops_details/common/defaulttext.dart';
import 'package:cooking_champs/utils/navigators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/services/api_path.dart';
import 'package:cooking_champs/services/user_prefences.dart';
import 'package:cooking_champs/utils/utility.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'dart:convert';
import 'dart:developer' as developer;

class DeliveredTab extends StatefulWidget {
  const DeliveredTab({super.key});

  @override
  State<DeliveredTab> createState() => _DeliveredTabState();
}

class _DeliveredTabState extends State<DeliveredTab> {
  bool isLoading = true;
  NewOrderModel deliveredOrderList = NewOrderModel();

  @override
  void initState() {
    deliveredApi();
    super.initState();
  }
  Widget buildDeliveredCard(Data order) {
    return GestureDetector(
      onTap: () {

        CustomNavigators.pushNavigate(OrderDetailsScreen(selectId:order.id ?? "", deliveredType: "Delivered" ,), context);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: MyColor.colorF4F6FF,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                DefaultText(
                  title: order.uniqueId ?? "",
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                ),
                Container(
                  color: MyColor.color8C8886,
                  height: 20,
                  width: 2,
                ),
                wSized3,
                DefaultText(
                  title: "₹${order.totalAmount ?? "0"}",
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                ),
                const Spacer(),
                SvgPicture.asset(
                  AssetsPath.deliveredIcon,
                  height: 18,
                  width: 18,
                ),
                const SizedBox(width: 4),
                DefaultText(
                  title: "Delivered",
                  fontSize: 12.0,
                  color: MyColor.appTheme,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            hsized3,
            DefaultText(
              title: "Order Date",
              fontSize: 13.0,
              fontWeight: FontWeight.w300,
              color: MyColor.black,
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                DefaultText(
                  title: order.orderDate ?? "",
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    // handle view details
                  },
                  child: DefaultText(
                    title: "View Details>>",
                    fontSize: 14.0,
                    color: MyColor.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator(color: MyColor.appTheme,));
    }

    if (deliveredOrderList.data == null || deliveredOrderList.data!.isEmpty) {
      return const Center(child: DefaultText(title: "No Delivered Orders Yet!", fontSize: 16.0));
    }

    return ListView.builder(
      itemCount: deliveredOrderList.data!.length,
      itemBuilder: (context, index) {
        return buildDeliveredCard(deliveredOrderList.data![index]);
      },
    );
  }


  Future<void> deliveredApi() async {
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
        Uri.parse("${ApiPath.myOrders}?type=delivered"),
        headers: {
          "Accept": "application/json",
          "Content-type": 'application/json',
          "Authorization": "Bearer ${ApiConnectorConstants.accessToken}"
        },
      );

      Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      if (jsonResponse['status'] == true) {
        developer.log(">>>>>>>>>>>>${jsonEncode(jsonResponse)}");
        deliveredOrderList = NewOrderModel.fromJson(jsonResponse);
        isLoading = false;
        setState(() {});
      } else {
        Utility.customToast(context, "${jsonResponse['message']}");
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      debugPrint("Error in membershipDataApi: $error");
    }
  }
}
