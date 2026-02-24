// import 'package:flutter/material.dart';
// import 'package:cooking_champs/constant/my_color.dart';
// import 'package:cooking_champs/utils/common_widget.dart';
// import '../new_ui/cart_shops_details/common/defaulttext.dart';
// import 'new_order_tab.dart';
// import 'delivered_tab.dart';
//
// class MyOrdersNew extends StatefulWidget {
//   const MyOrdersNew({super.key});
//
//   @override
//   State<MyOrdersNew> createState() => _MyOrdersNewState();
// }
//
// class _MyOrdersNewState extends State<MyOrdersNew>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//
//   @override
//   void initState() {
//     _tabController = TabController(length: 2, vsync: this);
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return CommonScaffold(
//       appBar: commonAppBar(
//         showBack: true,
//         backgroundColor: MyColor.yellowF6F1E1,
//         context: context,
//         title: "My Orders",
//         iconColor: Colors.black,
//         centerTitle: false,
//       ),
//       body: Column(
//         children: [
//           Container(
//             color: Colors.white,
//             child: TabBar(
//               controller: _tabController,
//               labelColor: MyColor.appTheme,
//               unselectedLabelColor: MyColor.black,
//               labelStyle: mediumTextStyle(fontSize: 16.0),
//               indicator: UnderlineTabIndicator(
//                 borderSide: BorderSide(width: 2, color: MyColor.appTheme),
//                 insets: const EdgeInsets.symmetric(horizontal: -40),
//               ),
//               tabs: const [
//                 Tab(text: "New Order"),
//                 Tab(text: "Delivered"),
//               ],
//             ),
//           ),
//           Expanded(
//             child: TabBarView(
//               controller: _tabController,
//               children: const [
//                 NewOrderTab(),
//                 DeliveredTab(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/utils/common_widget.dart';
import '../new_ui/cart_shops_details/common/defaulttext.dart';
import 'new_order_tab.dart';
import 'delivered_tab.dart';

class MyOrdersNew extends StatefulWidget {
  const MyOrdersNew({super.key});

  @override
  State<MyOrdersNew> createState() => _MyOrdersNewState();
}

class _MyOrdersNewState extends State<MyOrdersNew>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Check if device is iPad/tablet
    final bool isTablet = MediaQuery.of(context).size.shortestSide > 600;

    return CommonScaffold(
      appBar: commonAppBar(
        showBack: true,
        backgroundColor: MyColor.yellowF6F1E1,
        context: context,
        title: "My Orders",
        iconColor: Colors.black,
        centerTitle: false,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              labelColor: MyColor.appTheme,
              unselectedLabelColor: MyColor.black,
              labelStyle: mediumTextStyle(
                fontSize: isTablet ? 20.0 : 16.0, // iPad ke liye 20, mobile ke liye 16
              ),
              unselectedLabelStyle: mediumTextStyle(
                fontSize: isTablet ? 18.0 : 16.0, // iPad ke liye 18, mobile ke liye 16
              ),
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  width: isTablet ? 3.0 : 2.0, // iPad ke liye 3, mobile ke liye 2
                  color: MyColor.appTheme,
                ),
                insets: isTablet
                    ? const EdgeInsets.symmetric(horizontal: -60) // iPad ke liye -60
                    : const EdgeInsets.symmetric(horizontal: -40), // Mobile ke liye -40 (same as before)
              ),
              tabs: const [
                Tab(text: "New Order"),
                Tab(text: "Delivered"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                NewOrderTab(),
                DeliveredTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}