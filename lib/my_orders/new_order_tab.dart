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
import 'package:cooking_champs/services/api_path.dart';
import 'package:cooking_champs/services/user_prefences.dart';
import 'package:cooking_champs/utils/utility.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'dart:convert';
import 'dart:developer' as developer;

class NewOrderTab extends StatefulWidget {
  const NewOrderTab({super.key});

  @override
  State<NewOrderTab> createState() => _NewOrderTabState();
}

class _NewOrderTabState extends State<NewOrderTab> {
  NewOrderModel newOrderList = NewOrderModel();
  bool isLoading = true;
  String selectDeliveredType = "";

  @override
  void initState() {
    super.initState();
    newOrderApi();
  }




  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return  Center(child: CircularProgressIndicator(color: MyColor.appTheme,));
    }

    if (newOrderList.data == null || newOrderList.data!.isEmpty) {
      return const Center(child: Text("No New Orders Yet!"));
    }

    return ListView.builder(
      itemCount: newOrderList.data!.length,
      itemBuilder: (context, index) {
        final order = newOrderList.data![index];

        return GestureDetector(
          onTap: () {
            selectDeliveredType = (order.deliveryStatus.toString() == "0") ? "New" : (order.deliveryStatus.toString() == "1") ? "Order Received" : (order.deliveryStatus.toString() == "2") ? "Shipped" : (order.deliveryStatus.toString() == "4") ? "Cancelled" : "On The Way";
            CustomNavigators.pushNavigate(OrderDetailsScreen(selectId:order.id ?? "", deliveredType: selectDeliveredType ,), context);
          },
          child: buildOrderCard(
            uniqueId: order.uniqueId ?? '',
            amount: order.totalAmount ?? '0',
            orderDate: order.orderDate ?? '',
            status:(order.deliveryStatus.toString() == "0") ?"New" : (order.deliveryStatus.toString() == "1") ? "Order Received" : (order.deliveryStatus.toString() == "2") ? "Shipped" : (order.deliveryStatus.toString() == "4") ? "Canceled" : "On The Way",
            statusColor: (order.deliveryStatus.toString() == "0") ? Colors.green : (order.deliveryStatus.toString() == "1") ? Color(0XFF7941AA) : (order.deliveryStatus.toString() == "2") ? Color(0XFFE15C0A) : (order.deliveryStatus.toString() == "4") ? Color(0XFFF30000 ) : MyColor.colorE15C0A,
            bgColor:  (order.deliveryStatus.toString() == "0") ? MyColor.colorF3FFF2 : (order.deliveryStatus.toString() == "1") ? Color(0XFFF2ECF7) : (order.deliveryStatus.toString() == "2") ? Color(0XFFFFF8F4) : (order.deliveryStatus.toString() == "4") ? Color(0XFFFEE6E6)  : MyColor.colorFFF8F4,
            icon: (order.deliveryStatus.toString() == "0") ? AssetsPath.New : (order.deliveryStatus.toString() == "1") ? AssetsPath.orderReceivedIconNew : (order.deliveryStatus.toString() == "2") ? AssetsPath.shippedIconNew : (order.deliveryStatus.toString() == "4") ? AssetsPath.cancelledIconNew : AssetsPath.onTheway,
          ),
        );
      },
    );
  }

  Widget buildOrderCard({
    required String uniqueId,
    required String amount,
    required String orderDate,
    required String status,
    required Color statusColor,
    required Color bgColor,
    required String icon,
  }) {
    return Container(
      height: 108,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              DefaultText(
                title: uniqueId,
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
              ),
              wSized5,
              Container(
                color: MyColor.color8C8886,
                height: 20,
                width: 2,
              ),
              wSized5,
              DefaultText(
                title: "\$$amount",
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
              ),
              const Spacer(),
              SvgPicture.asset(icon, height: 16, width: 16),
              const SizedBox(width: 4),
              DefaultText(
                title: status,
                fontSize: 12.0,
                color: statusColor,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          hsized3,
          Divider(color: MyColor.colorDBE5DA),
          hsized3,
          DefaultText(
            title: "Order Date",
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade600,
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              DefaultText(
                title: orderDate,
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  // View Details Action
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: DefaultText(
                    title: "View Details >>",
                    fontSize: 14.0,
                    color: MyColor.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  Future<void> newOrderApi() async {
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
        Uri.parse("${ApiPath.myOrders}?type=orders"),
        headers: {
          "Accept": "application/json",
          "Content-type": 'application/json',
          "Authorization": "Bearer ${ApiConnectorConstants.accessToken}"
        },
      );

      Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      if (jsonResponse['status'] == true) {
        developer.log(">>>>>>>>>>>>${jsonEncode(jsonResponse)}");
        newOrderList = NewOrderModel.fromJson(jsonResponse);
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
      debugPrint("Error in newOrderApi: $error");
    }
  }

}
