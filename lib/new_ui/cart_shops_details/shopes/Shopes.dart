// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cooking_champs/constant/apiConnectorConstants.dart';
// import 'package:cooking_champs/constant/assets_path.dart';
// import 'package:cooking_champs/constant/my_color.dart';
// import 'package:cooking_champs/constant/my_fonts_style.dart';
// import 'package:cooking_champs/constant/sized_box.dart';
// import 'package:cooking_champs/constant/stringfile.dart/language.dart';
// import 'package:cooking_champs/model/dynamic_models/shop_categories_model.dart';
// import 'package:cooking_champs/model/dynamic_models/shop_model_new.dart';
// import 'package:cooking_champs/new_ui/cart_shops_details/cartscreen/cart_screen.dart';
// import 'package:cooking_champs/new_ui/cart_shops_details/details_screen.dart';
// import 'package:cooking_champs/new_ui/cart_shops_details/wishlist/widgets/wishlistview.dart';
// import 'package:cooking_champs/services/api_path.dart';
// import 'package:cooking_champs/services/user_prefences.dart';
// import 'package:cooking_champs/utils/common_widget.dart';
// import 'package:cooking_champs/utils/utility.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:html/parser.dart' as html_parser;
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:pretty_http_logger/pretty_http_logger.dart';
// import 'dart:convert';
// import 'dart:convert' as convert;
// import 'dart:developer' as developer;
//
// import 'package:shimmer/shimmer.dart';
//
// class Shopesclass extends StatefulWidget {
//   const Shopesclass({super.key});
//
//   @override
//   State<Shopesclass> createState() => _ShopesclassState();
// }
//
// class _ShopesclassState extends State<Shopesclass> {
//   ShopCategoriesModel shopsCategory = ShopCategoriesModel();
//   ShopListModelNew shopsData = ShopListModelNew();
//   int selectedIndex = -1;
//   String selectIndexIdCat = "";
//
//   ///...
//   Set<int> selectedAddIndexes = {};
//
//   List<bool?> favoriteStates = [];
//   String totalPage = "";
//   int currentPage = 1;
//   bool isLoading = false;
//   bool hasMore = true;
//   ScrollController _scrollController = ScrollController();
//   TextEditingController searchController = TextEditingController();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     shopsDataApi();
//
//     _scrollController.addListener(() {
//       if (_scrollController.position.pixels >=
//               _scrollController.position.maxScrollExtent - 200 &&
//           !isLoading &&
//           hasMore) {
//         currentPage++;
//         shopsDataApi();
//       }
//     });
//     shopsCategoriesApi();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final shopsDataNew = shopsData.data?.products?.items;
//     final screenWidth = MediaQuery.of(context).size.width;
//     final categories = shopsCategory.data ?? [];
//     final screenHeight = MediaQuery.of(context).size.height;
//
//     final double titleFontSize = screenWidth * 0.06;
//
//     final double bodyFontSize = screenWidth * 0.04;
//     return Container(
//       color: MyColor.yellowF6F1E1,
//       child: SafeArea(
//         bottom: false,
//         child: Scaffold(
//           backgroundColor: Colors.white,
//           body: RefreshIndicator(
//             onRefresh: _refreshProductList,
//             child: CustomScrollView(
//               controller: _scrollController,
//               slivers: [
//                 SliverAppBar(
//                   backgroundColor: MyColor.yellowF6F1E1,
//                   floating: true,
//                   snap: true,
//                   pinned: false,
//                   leadingWidth: double.infinity,
//                   automaticallyImplyLeading: false,
//                   leading: commonAppBar(
//                     context: context,
//                     title: Languages.of(context)!.shops,
//                     centerTitle: false,
//                   ),
//                 ),
//                 SliverToBoxAdapter(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 15),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(height: screenHeight * 0.02),
//                         Text(
//                           'Start Exploring Tools for',
//                           style: mediumTextStyle(
//                               fontSize: bodyFontSize, color: Colors.black),
//                         ),
//                         SizedBox(height: screenHeight * 0.01),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Expanded(
//                               child: Text(
//                                 'Tasty Adventures!',
//                                 style: boldTextStyle(
//                                     fontSize: titleFontSize, color: Colors.black),
//                               ),
//                             ),
//                             InkWell(
//                               onTap: () => Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => Wishlistofview(
//                                     selectIndexIdCat: selectIndexIdCat,
//                                     titleName: "Wishlist Products",
//                                     whoIsProduct: "see_all_wishlist_products",
//                                   ),
//                                 ),
//                               ).then((value) {
//                                 currentPage = 1;
//                                 shopsDataApi();
//                               }),
//                               child: (shopsData.data?.totalWishlistItems ?? 0) > 0
//                                   ? Badge.count(
//                                 count: shopsData.data?.totalWishlistItems ?? 0,
//                                 child: SvgPicture.asset(
//                                   AssetsPath.heartIcon,
//                                   width: screenWidth * 0.10,
//                                 ),
//                               )
//                                   : SvgPicture.asset(
//                                 AssetsPath.heartIcon,
//                                 width: screenWidth * 0.10,
//                               ),
//                             ),
//                             SizedBox(width: screenWidth * 0.03),
//                             InkWell(
//                               onTap: () => Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => CartScreen(),
//                                 ),
//                               ).then((value) {
//                                 currentPage = 1;
//                                 shopsDataApi();
//                               }),
//                               child: (shopsData.data?.totalCartItems ?? 0) > 0
//                                   ? Badge.count(
//                                 count: shopsData.data?.totalCartItems ?? 0,
//                                 child: SvgPicture.asset(
//                                   AssetsPath.shopping,
//                                   width: screenWidth * 0.10,
//                                 ),
//                               )
//                                   : SvgPicture.asset(
//                                 AssetsPath.shopping,
//                                 width: screenWidth * 0.10,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: screenHeight * 0.03),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 SliverPersistentHeader(
//                   pinned: true,
//                   delegate: _SliverHeaderDelegate(
//                     height: 160, // or adjust based on your actual UI
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 15),
//                       child: Column(
//                         children: [
//                           Container(
//                             margin: EdgeInsets.only(top: 10),
//                             padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
//                             decoration: BoxDecoration(
//                               color: MyColor.textfeaildcolor,
//                               borderRadius: BorderRadius.circular(12),
//                               border: Border.all(color: Colors.grey.shade300),
//                             ),
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: TextField(
//                                     controller: searchController,
//                                     style: TextStyle(fontSize: bodyFontSize),
//                                     decoration: InputDecoration(
//                                       hintText: 'What Are You Looking For?',
//                                       hintStyle: TextStyle(
//                                           color: Colors.grey.shade600,
//                                           fontWeight: FontWeight.w400,
//                                           fontSize: bodyFontSize),
//                                       border: InputBorder.none,
//                                     ),
//                                     onChanged: (value) {
//                                       currentPage = 1;
//                                       shopsDataApi();
//                                     },
//                                   ),
//                                 ),
//                                 Icon(Icons.search,
//                                     color: Colors.grey.shade600,
//                                     size: screenWidth * 0.06),
//                               ],
//                             ),
//                           ),
//                           hsized15,
//                           Container(
//                             height: 80,
//                             // color: Colors.red,
//                             child: ListView.builder(
//                               scrollDirection: Axis.horizontal,
//                               itemCount: categories.length,
//                               itemBuilder: (context, index) {
//                                 final category = categories[index];
//                                 final isSelected = index == selectedIndex;
//
//                                 return Padding(
//                                   padding: const EdgeInsets.only(right: 10),
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       setState(() {
//                                         if (selectedIndex == index) {
//                                           selectedIndex = -1;
//                                           selectIndexIdCat = "";
//                                         } else {
//                                           selectedIndex = index;
//                                           selectIndexIdCat =
//                                               categories[index].id.toString();
//                                         }
//                                         currentPage = 1;
//                                         shopsDataApi();
//                                       });
//                                     },
//                                     child: Column(
//                                       children: [
//                                         Container(
//                                           padding: EdgeInsets.all(2),
//                                           decoration: BoxDecoration(
//                                             shape: BoxShape.circle,
//                                             border: Border.all(
//                                               color:
//                                               isSelected ? Colors.red : Colors.transparent,
//                                               width: 2,
//                                             ),
//                                           ),
//                                           child: ClipOval(
//                                             child: FadeInImage.assetNetwork(
//                                               placeholder:
//                                               'assets/new_ui_images/listimage.png',
//                                               image:
//                                               "${ApiPath.imageBaseUrl}${category.image}",
//                                               height: 45,
//                                               width: 45,
//                                               fit: BoxFit.cover,
//                                             ),
//                                           ),
//                                         ),
//                                         SizedBox(height: 5),
//                                         Text(
//                                           category.name ?? "",
//                                           style: TextStyle(
//                                               fontSize: 11.0, color: Colors.black),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 SliverToBoxAdapter(
//                   child: (shopsDataNew == null ||
//                           favoriteStates.length != shopsDataNew.length)
//                       ? const Center(
//                           child: CircularProgressIndicator(color: MyColor.appTheme),
//                         )
//                       : shopsDataNew.isEmpty
//                           ? Center(
//                               child: Padding(
//                                 padding: EdgeInsets.only(top: screenHeight / 8),
//                                 child: Text(
//                                   "No products found",
//                                   style:
//                                       TextStyle(fontSize: 16, color: Colors.grey),
//                                 ),
//                               ),
//                             )
//                           : GridView.builder(
//                               shrinkWrap: true,
//                               physics: NeverScrollableScrollPhysics(),
//                               // controller: _scrollController,
//                               itemCount: shopsDataNew.length,
//                               gridDelegate:
//                                   const SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: 2,
//                                 crossAxisSpacing: 10,
//                                 childAspectRatio: 0.73 ,
//                               ),
//                               itemBuilder: (context, index) {
//                                 return GestureDetector(
//                                   onTap: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(builder: (context) =>   DetailsScreen(
//                                         productId:
//                                         shopsDataNew[index].id.toString(),
//                                       ),),).then((value) {
//                                       shopsDataApi();
//                                       },);
//                                     // CustomNavigators.pushNavigate(
//                                     //     DetailsScreen(
//                                     //       productId:
//                                     //           shopsDataNew[index].id.toString(),
//                                     //     ),
//                                     //     context);
//                                   },
//                                   child: Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                       horizontal: 15.0,
//                                     ),
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         hsized15,
//
//                                         Stack(
//                                           children: [
//                                             CachedNetworkImage(
//                                               imageUrl: "${ApiPath.imageBaseUrl}${shopsDataNew[index].image}",
//                                               height: 121,
//                                               width: MediaQuery.of(context).size.width / 2.4,
//                                               fit: BoxFit.cover,
//                                               placeholder: (context, url) => Shimmer.fromColors(
//                                                 baseColor: Colors.grey.shade300,
//                                                 highlightColor: Colors.grey.shade100,
//                                                 child: Container(
//                                                   height: 121,
//                                                   width: MediaQuery.of(context).size.width / 2.4,
//                                                   color: Colors.white,
//                                                 ),
//                                               ),
//                                               errorWidget: (context, url, error) => Container(
//                                                 height: 121,
//                                                 width: MediaQuery.of(context).size.width / 2.4,
//                                                 color: Colors.grey.shade200,
//                                                 child: const Icon(Icons.error, color: Colors.red),
//                                               ),
//                                             ),
//
//                                             Positioned(
//                                               top: 8,
//                                               right: 8,
//                                               child: GestureDetector(
//                                                 onTap: () {
//                                                   final currentStatus =
//                                                       shopsDataNew[index].isFavourite?.toString() == "true";
//                                                   setState(() {
//                                                     shopsDataNew[index].isFavourite = !currentStatus;
//                                                   });
//                                                   addToshopsDataApi(shopsDataNew[index].id.toString());
//                                                 },
//                                                 child: Container(
//                                                   height: screenWidth * 0.08,
//                                                   width: screenWidth * 0.08,
//                                                   decoration: const BoxDecoration(
//                                                     color: Color(0xffEEE9D9),
//                                                     shape: BoxShape.circle,
//                                                   ),
//                                                   child: Icon(
//                                                     (shopsDataNew[index].isFavourite?.toString() == "true")
//                                                         ? Icons.favorite
//                                                         : Icons.favorite_border,
//                                                     color: MyColor.purplecolor,
//                                                     size: screenWidth * 0.05,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//
//                                         Text(
//                                           shopsDataNew[index].title ?? "",
//                                           maxLines: 1,
//                                           overflow: TextOverflow.ellipsis,
//                                           style: mediumTextStyle(fontSize: 15.0, color: Colors.black),
//                                         ),
//                                         SizedBox(
//                                           height: 5,
//                                         ),
//
//                                         /// ✅ FULL DESCRIPTION — NO CUTTING
//                                         Text(
//                                           parseHtml(shopsDataNew[index].description ?? ''),
//                                           maxLines: 2,
//                                           overflow: TextOverflow.ellipsis,
//                                           style: const TextStyle(fontSize: 12),
//                                         ),
//
//                                         SizedBox(
//                                           height: 5,
//                                         ),
//
//                                         Row(
//                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Text(
//                                               '\$${double.parse(shopsDataNew[index].sellingPrice ?? '0').toInt()}',
//                                               style: mediumTextStyle(fontSize: 14.0, color: Colors.black),
//                                             ),
//
//                                             GestureDetector(
//                                               onTap: () {
//                                                 final isInCart = selectedAddIndexes.contains(index) ||
//                                                     (shopsDataNew[index].isCartAdded ?? true);
//
//                                                 if (isInCart) {
//                                                   Navigator.of(context)
//                                                       .push(MaterialPageRoute(builder: (_) => CartScreen()))
//                                                       .then((_) => shopsDataApi());
//                                                 } else {
//                                                   setState(() {
//                                                     addToCartApi(shopsDataNew[index].id.toString());
//                                                     selectedAddIndexes.add(index);
//                                                   });
//                                                 }
//                                               },
//                                               child: Container(
//                                                 padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
//                                                 decoration: BoxDecoration(
//                                                   color: (selectedAddIndexes.contains(index) ||
//                                                       (shopsDataNew[index].isCartAdded ?? true))
//                                                       ? MyColor.appTheme
//                                                       : MyColor.yellowF6F1E1,
//                                                   borderRadius: BorderRadius.circular(14),
//                                                 ),
//                                                 child: Text(
//                                                   (selectedAddIndexes.contains(index) ||
//                                                       (shopsDataNew[index].isCartAdded ?? true))
//                                                       ? 'Go to Cart'
//                                                       : 'Add To Cart',
//                                                   style: TextStyle(
//                                                     color: (selectedAddIndexes.contains(index) ||
//                                                         (shopsDataNew[index].isCartAdded ?? true))
//                                                         ? Colors.white
//                                                         : MyColor.appTheme,
//                                                     fontSize: 12.0,
//                                                     fontWeight: FontWeight.w500,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> _refreshProductList() async {
//     setState(() {
//       shopsData.data?.products?.items?.clear();
//       currentPage = 1;
//       shopsCategoriesApi();
//       shopsDataApi();
//     });
//     await Future.delayed(const Duration(seconds: 1));
//   }
//
//   Future<void> shopsCategoriesApi() async {
//     ApiConnectorConstants.accessToken =
//         await PreferencesServices.getPreferencesData(
//                 PreferencesServices.userToken) ??
//             "";
//
//     HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
//       HttpLogger(logLevel: LogLevel.BODY),
//     ]);
//     // AllDialogs.progressLoadingDialog(context, true);
//     try {
//       var response = await http.get(
//         Uri.parse(ApiPath.productCategories),
//         // body: convert.jsonEncode(request),
//         headers: {
//           "Accept": "application/json",
//           "Content-type": 'application/json',
//           "Authorization": "Bearer ${ApiConnectorConstants.accessToken}"
//         },
//       );
//
//       Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
//       // AllDialogs.progressLoadingDialog(context, false);
//
//       if (jsonResponse['status'] == true) {
//         developer.log(">>>>>>>>>>>>${jsonEncode(jsonResponse)}");
//         shopsCategory = ShopCategoriesModel.fromJson(jsonResponse);
//
//         setState(() {});
//       } else {
//         Utility.customToast(context, "${jsonResponse['message']}");
//       }
//     } catch (error) {
//       print("Error in AddresUpdateApi: $error");
//     }
//   }
//
//   Future<void> shopsDataApi() async {
//     isLoading = true;
//     ApiConnectorConstants.accessToken =
//         await PreferencesServices.getPreferencesData(
//                 PreferencesServices.userToken) ??
//             "";
//
//     var request = {
//       if (selectIndexIdCat.isNotEmpty) 'cat_id': selectIndexIdCat,
//       'search': searchController.text.toString(),
//       'page': currentPage.toString(),
//     };
//
//     HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
//       HttpLogger(logLevel: LogLevel.BODY),
//     ]);
//
//     try {
//       var response = await http.post(
//         Uri.parse(ApiPath.shops),
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
//         developer.log(convert.jsonEncode(jsonResponse));
//         var newData = ShopListModelNew.fromJson(jsonResponse);
//
//         totalPage = newData.data?.products?.totalPage.toString() ?? "1";
//
//         if (currentPage == 1) {
//           shopsData = newData;
//           favoriteStates = List.generate(
//               newData.data?.products?.items?.length ?? 0, (_) => false);
//         } else {
//           shopsData.data?.products?.items
//               ?.addAll(newData.data?.products?.items ?? []);
//           favoriteStates.addAll(List.generate(
//               newData.data?.products?.items?.length ?? 0, (_) => false));
//         }
//
//         // check if more data available
//         if (currentPage >= int.tryParse(totalPage)!) {
//           hasMore = false;
//         }
//
//         setState(() {});
//       } else {
//         Utility.customToast(context, "${jsonResponse['message']}");
//       }
//     } catch (error) {
//       print("Error in shopsDataApi: $error");
//     } finally {
//       isLoading = false;
//     }
//   }
//
//   Future<void> addToshopsDataApi(String productId) async {
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
//         Uri.parse(ApiPath.addToWishlist),
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
//         shopsDataApi();
//         shopsDataApi();
//         setState(() {});
//       } else {
//         Utility.customToast(context, "${jsonResponse['message']}");
//       }
//     } catch (error) {
//       print("Error in shopsDataApi: $error");
//     } finally {
//       isLoading = false;
//     }
//   }
//
//   String parseHtml(String html) {
//     return html_parser.parse(html).body?.text ?? '';
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
//         shopsDataApi();
//         setState(() {});
//       } else {
//         Utility.customToast(context, "${jsonResponse['message']}");
//       }
//     } catch (error) {
//       print("Error in shopsDataApi: $error");
//     }
//   }
// }
//
// ///.........\
// class _SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
//   final Widget child;
//   final double height;
//
//   _SliverHeaderDelegate({required this.child, required this.height});
//
//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return Container(
//       color: Colors.white,
//       child: child,
//     );
//   }
//
//   @override
//   double get maxExtent => height;
//
//   @override
//   double get minExtent => height;
//
//   @override
//   bool shouldRebuild(covariant _SliverHeaderDelegate oldDelegate) {
//     return oldDelegate.child != child || oldDelegate.height != height;
//   }
// }



import 'package:cached_network_image/cached_network_image.dart';
import 'package:cooking_champs/constant/apiConnectorConstants.dart';
import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/constant/stringfile.dart/language.dart';
import 'package:cooking_champs/model/dynamic_models/shop_categories_model.dart';
import 'package:cooking_champs/model/dynamic_models/shop_model_new.dart';
import 'package:cooking_champs/new_ui/cart_shops_details/cartscreen/cart_screen.dart';
import 'package:cooking_champs/new_ui/cart_shops_details/details_screen.dart';
import 'package:cooking_champs/new_ui/cart_shops_details/wishlist/widgets/wishlistview.dart';
import 'package:cooking_champs/services/api_path.dart';
import 'package:cooking_champs/services/user_prefences.dart';
import 'package:cooking_champs/utils/common_widget.dart';
import 'package:cooking_champs/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'dart:convert';
import 'dart:convert' as convert;
import 'dart:developer' as developer;

import 'package:shimmer/shimmer.dart';

class Shopesclass extends StatefulWidget {
  const Shopesclass({super.key});

  @override
  State<Shopesclass> createState() => _ShopesclassState();
}

class _ShopesclassState extends State<Shopesclass> {
  ShopCategoriesModel shopsCategory = ShopCategoriesModel();
  ShopListModelNew shopsData = ShopListModelNew();
  int selectedIndex = -1;
  String selectIndexIdCat = "";

  ///...
  Set<int> selectedAddIndexes = {};

  List<bool?> favoriteStates = [];
  String totalPage = "";
  int currentPage = 1;
  bool isLoading = false;
  bool hasMore = true;
  ScrollController _scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    shopsDataApi();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200 &&
          !isLoading &&
          hasMore) {
        currentPage++;
        shopsDataApi();
      }
    });
    shopsCategoriesApi();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shopsDataNew = shopsData.data?.products?.items;
    final size = MediaQuery.of(context).size;
    final bool isIpad = size.width > 600;
    final categories = shopsCategory.data ?? [];

    return Container(
      color: MyColor.yellowF6F1E1,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: RefreshIndicator(
            onRefresh: _refreshProductList,
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  backgroundColor: MyColor.yellowF6F1E1,
                  floating: true,
                  snap: true,
                  pinned: false,
                  leadingWidth: double.infinity,
                  automaticallyImplyLeading: false,
                  leading: commonAppBar(
                    context: context,
                    title: Languages.of(context)!.shops,
                    centerTitle: false,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isIpad ? 25.0 : 15.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: isIpad ? 25.0 : 20.0),
                        Text(
                          'Start Exploring Tools for',
                          style: mediumTextStyle(
                            fontSize: isIpad ? 20.0 : 16.0,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: isIpad ? 8.0 : 5.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                'Tasty Adventures!',
                                style: boldTextStyle(
                                  fontSize: isIpad ? 28.0 : 24.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Wishlistofview(
                                        selectIndexIdCat: selectIndexIdCat,
                                        titleName: "Wishlist Products",
                                        whoIsProduct: "see_all_wishlist_products",
                                      ),
                                    ),
                                  ).then((value) {
                                    currentPage = 1;
                                    shopsDataApi();
                                  }),
                                  child: (shopsData.data?.totalWishlistItems ?? 0) > 0
                                      ? Badge.count(
                                    count: shopsData.data?.totalWishlistItems ?? 0,
                                    backgroundColor: MyColor.appTheme,
                                    textColor: Colors.white,
                                    child: SvgPicture.asset(
                                      AssetsPath.heartIcon,
                                      width: isIpad ? 35.0 : 30.0,
                                      height: isIpad ? 35.0 : 30.0,
                                    ),
                                  )
                                      : SvgPicture.asset(
                                    AssetsPath.heartIcon,
                                    width: isIpad ? 35.0 : 30.0,
                                    height: isIpad ? 35.0 : 30.0,
                                  ),
                                ),
                                SizedBox(width: isIpad ? 20.0 : 15.0),
                                InkWell(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CartScreen(),
                                    ),
                                  ).then((value) {
                                    currentPage = 1;
                                    shopsDataApi();
                                  }),
                                  child: (shopsData.data?.totalCartItems ?? 0) > 0
                                      ? Badge.count(
                                    count: shopsData.data?.totalCartItems ?? 0,
                                    backgroundColor: MyColor.appTheme,
                                    textColor: Colors.white,
                                    child: SvgPicture.asset(
                                      AssetsPath.shopping,
                                      width: isIpad ? 35.0 : 30.0,
                                      height: isIpad ? 35.0 : 30.0,
                                    ),
                                  )
                                      : SvgPicture.asset(
                                    AssetsPath.shopping,
                                    width: isIpad ? 35.0 : 30.0,
                                    height: isIpad ? 35.0 : 30.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: isIpad ? 25.0 : 20.0),
                      ],
                    ),
                  ),
                ),

                SliverPersistentHeader(
                  pinned: true,
                  delegate: _SliverHeaderDelegate(
                    height: isIpad ? 180.0 : 160.0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isIpad ? 25.0 : 15.0,
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: isIpad ? 15.0 : 10.0),
                            padding: EdgeInsets.symmetric(
                              horizontal: isIpad ? 20.0 : 15.0,
                            ),
                            decoration: BoxDecoration(
                              color: MyColor.textfeaildcolor,
                              borderRadius: BorderRadius.circular(isIpad ? 15.0 : 12.0),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: searchController,
                                    style: TextStyle(
                                      fontSize: isIpad ? 18.0 : 16.0,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'What Are You Looking For?',
                                      hintStyle: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontWeight: FontWeight.w400,
                                        fontSize: isIpad ? 18.0 : 16.0,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    onChanged: (value) {
                                      currentPage = 1;
                                      shopsDataApi();
                                    },
                                  ),
                                ),
                                Icon(
                                  Icons.search,
                                  color: Colors.grey.shade600,
                                  size: isIpad ? 28.0 : 24.0,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: isIpad ? 20.0 : 15.0),
                          Container(
                            height: isIpad ? 100.0 : 80.0,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: categories.length,
                              itemBuilder: (context, index) {
                                final category = categories[index];
                                final isSelected = index == selectedIndex;

                                return Padding(
                                  padding: EdgeInsets.only(
                                    right: isIpad ? 15.0 : 10.0,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (selectedIndex == index) {
                                          selectedIndex = -1;
                                          selectIndexIdCat = "";
                                        } else {
                                          selectedIndex = index;
                                          selectIndexIdCat =
                                              categories[index].id.toString();
                                        }
                                        currentPage = 1;
                                        shopsDataApi();
                                      });
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(isIpad ? 3.0 : 2.0),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: isSelected
                                                  ? MyColor.appTheme
                                                  : Colors.transparent,
                                              width: isIpad ? 3.0 : 2.0,
                                            ),
                                          ),
                                          child: ClipOval(
                                            child: FadeInImage.assetNetwork(
                                              placeholder:
                                              'assets/new_ui_images/listimage.png',
                                              image:
                                              "${ApiPath.imageBaseUrl}${category.image}",
                                              height: isIpad ? 55.0 : 45.0,
                                              width: isIpad ? 55.0 : 45.0,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: isIpad ? 8.0 : 5.0),
                                        Container(
                                          width: isIpad ? 80.0 : 60.0,
                                          child: Text(
                                            category.name ?? "",
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: isIpad ? 14.0 : 11.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: (shopsDataNew == null ||
                      favoriteStates.length != shopsDataNew.length)
                      ? Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: isIpad ? 40.0 : 20.0),
                      child: CircularProgressIndicator(color: MyColor.appTheme),
                    ),
                  )
                      : shopsDataNew.isEmpty
                      ? Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: size.height * 0.2),
                      child: Text(
                        "No products found",
                        style: TextStyle(
                          fontSize: isIpad ? 20.0 : 16.0,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  )
                      : GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: shopsDataNew.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isIpad ? 3 : 2,
                      crossAxisSpacing: isIpad ? 1.0 : 10.0,
                      mainAxisSpacing: isIpad ? 20.0 : 15.0,
                      childAspectRatio: isIpad ? 0.88 : 0.73,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsScreen(
                                productId:
                                shopsDataNew[index].id.toString(),
                              ),
                            ),
                          ).then((value) {
                            shopsDataApi();
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: isIpad ? 10.0 : 15.0,
                          ),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: isIpad ? 10.0 : 5.0),
                                Stack(
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl:
                                      "${ApiPath.imageBaseUrl}${shopsDataNew[index].image}",
                                      height: isIpad ? 180.0 : 121.0,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          Shimmer.fromColors(
                                            baseColor: Colors.grey.shade300,
                                            highlightColor: Colors.grey.shade100,
                                            child: Container(
                                              height: isIpad ? 180.0 : 121.0,
                                              width: double.infinity,
                                              color: Colors.white,
                                            ),
                                          ),
                                      errorWidget: (context, url, error) =>
                                          Container(
                                            height: isIpad ? 180.0 : 121.0,
                                            width: double.infinity,
                                            color: Colors.grey.shade200,
                                            child: Icon(
                                              Icons.error,
                                              color: Colors.red,
                                              size: isIpad ? 30.0 : 24.0,
                                            ),
                                          ),
                                    ),
                                    Positioned(
                                      top: isIpad ? 12.0 : 8.0,
                                      right: isIpad ? 12.0 : 8.0,
                                      child: GestureDetector(
                                        onTap: () {
                                          final currentStatus = shopsDataNew[index]
                                              .isFavourite
                                              ?.toString() ==
                                              "true";
                                          setState(() {
                                            shopsDataNew[index].isFavourite =
                                            !currentStatus;
                                          });
                                          addToshopsDataApi(
                                              shopsDataNew[index].id.toString());
                                        },
                                        child: Container(
                                          height: isIpad ? 40.0 : 30.0,
                                          width: isIpad ? 40.0 : 30.0,
                                          decoration: BoxDecoration(
                                            color: Color(0xffEEE9D9),
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.1),
                                                blurRadius: 4.0,
                                                spreadRadius: 1.0,
                                              ),
                                            ],
                                          ),
                                          child: Icon(
                                            (shopsDataNew[index]
                                                .isFavourite
                                                ?.toString() ==
                                                "true")
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: MyColor.purplecolor,
                                            size: isIpad ? 22.0 : 18.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: isIpad ? 12.0 : 8.0),
                                Text(
                                  shopsDataNew[index].title ?? "",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: mediumTextStyle(
                                    fontSize: isIpad ? 18.0 : 15.0,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: isIpad ? 8.0 : 5.0),
                                Container(
                                  height: isIpad ? 50.0 : 40.0,
                                  child: Text(
                                    parseHtml(
                                        shopsDataNew[index].description ?? ''),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: isIpad ? 14.0 : 12.0,
                                      color: Colors.grey.shade700,
                                      height: 1.3,
                                    ),
                                  ),
                                ),
                                SizedBox(height: isIpad ? 10.0 : 8.0),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '\$${double.parse(shopsDataNew[index].sellingPrice ?? '0').toInt()}',
                                      style: boldTextStyle(
                                        fontSize: isIpad ? 18.0 : 14.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        final isInCart =
                                            selectedAddIndexes.contains(index) ||
                                                (shopsDataNew[index].isCartAdded ??
                                                    true);

                                        if (isInCart) {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                              builder: (_) => CartScreen()))
                                              .then((_) => shopsDataApi());
                                        } else {
                                          setState(() {
                                            addToCartApi(
                                                shopsDataNew[index].id.toString());
                                            selectedAddIndexes.add(index);
                                          });
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: isIpad ? 8.0 : 5.0,
                                          horizontal: isIpad ? 20.0 : 15.0,
                                        ),
                                        decoration: BoxDecoration(
                                          color: (selectedAddIndexes.contains(index) ||
                                              (shopsDataNew[index]
                                                  .isCartAdded ??
                                                  true))
                                              ? MyColor.appTheme
                                              : MyColor.yellowF6F1E1,
                                          borderRadius:
                                          BorderRadius.circular(isIpad ? 16.0 : 14.0),
                                        ),
                                        child: Text(
                                          (selectedAddIndexes.contains(index) ||
                                              (shopsDataNew[index]
                                                  .isCartAdded ??
                                                  true))
                                              ? 'Go to Cart'
                                              : 'Add To Cart',
                                          style: TextStyle(
                                            color: (selectedAddIndexes.contains(index) ||
                                                (shopsDataNew[index]
                                                    .isCartAdded ??
                                                    true))
                                                ? Colors.white
                                                : MyColor.appTheme,
                                            fontSize: isIpad ? 14.0 : 12.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Loading indicator
                // if (isLoading)
                //   SliverToBoxAdapter(
                //     child: Padding(
                //       padding: EdgeInsets.symmetric(vertical: isIpad ? 30.0 : 20.0),
                //       child: Center(
                //         child: CircularProgressIndicator(color: MyColor.appTheme),
                //       ),
                //     ),
                //   ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _refreshProductList() async {
    setState(() {
      shopsData.data?.products?.items?.clear();
      currentPage = 1;
      shopsCategoriesApi();
      shopsDataApi();
    });
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> shopsCategoriesApi() async {
    ApiConnectorConstants.accessToken =
        await PreferencesServices.getPreferencesData(
            PreferencesServices.userToken) ??
            "";

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    try {
      var response = await http.get(
        Uri.parse(ApiPath.productCategories),
        headers: {
          "Accept": "application/json",
          "Content-type": 'application/json',
          "Authorization": "Bearer ${ApiConnectorConstants.accessToken}"
        },
      );

      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);

      if (jsonResponse['status'] == true) {
        developer.log(">>>>>>>>>>>>${jsonEncode(jsonResponse)}");
        shopsCategory = ShopCategoriesModel.fromJson(jsonResponse);

        setState(() {});
      } else {
        Utility.customToast(context, "${jsonResponse['message']}");
      }
    } catch (error) {
      print("Error in AddresUpdateApi: $error");
    }
  }

  Future<void> shopsDataApi() async {
    if (isLoading) return;

    isLoading = true;
    ApiConnectorConstants.accessToken =
        await PreferencesServices.getPreferencesData(
            PreferencesServices.userToken) ??
            "";

    var request = {
      if (selectIndexIdCat.isNotEmpty) 'cat_id': selectIndexIdCat,
      'search': searchController.text.toString(),
      'page': currentPage.toString(),
    };

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    try {
      var response = await http.post(
        Uri.parse(ApiPath.shops),
        body: convert.jsonEncode(request),
        headers: {
          "Accept": "application/json",
          "Content-type": 'application/json',
          "Authorization": "Bearer ${ApiConnectorConstants.accessToken}"
        },
      );

      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);

      if (jsonResponse['status'] == true) {
        developer.log(convert.jsonEncode(jsonResponse));
        var newData = ShopListModelNew.fromJson(jsonResponse);

        totalPage = newData.data?.products?.totalPage.toString() ?? "1";

        if (currentPage == 1) {
          shopsData = newData;
          favoriteStates = List.generate(
              newData.data?.products?.items?.length ?? 0, (_) => false);
        } else {
          shopsData.data?.products?.items
              ?.addAll(newData.data?.products?.items ?? []);
          favoriteStates.addAll(List.generate(
              newData.data?.products?.items?.length ?? 0, (_) => false));
        }

        // check if more data available
        if (currentPage >= int.tryParse(totalPage)!) {
          hasMore = false;
        }

        setState(() {});
      } else {
        Utility.customToast(context, "${jsonResponse['message']}");
      }
    } catch (error) {
      print("Error in shopsDataApi: $error");
    } finally {
      isLoading = false;
    }
  }

  Future<void> addToshopsDataApi(String productId) async {
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
        Uri.parse(ApiPath.addToWishlist),
        body: convert.jsonEncode(request),
        headers: {
          "Accept": "application/json",
          "Content-type": 'application/json',
          "Authorization": "Bearer ${ApiConnectorConstants.accessToken}"
        },
      );

      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);

      if (jsonResponse['status'] == true) {
        shopsDataApi();
        setState(() {});
      } else {
        Utility.customToast(context, "${jsonResponse['message']}");
      }
    } catch (error) {
      print("Error in shopsDataApi: $error");
    } finally {
      isLoading = false;
    }
  }

  String parseHtml(String html) {
    return html_parser.parse(html).body?.text ?? '';
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
        shopsDataApi();
        setState(() {});
      } else {
        Utility.customToast(context, "${jsonResponse['message']}");
      }
    } catch (error) {
      print("Error in shopsDataApi: $error");
    }
  }
}

class _SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;

  _SliverHeaderDelegate({required this.child, required this.height});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: child,
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant _SliverHeaderDelegate oldDelegate) {
    return oldDelegate.child != child || oldDelegate.height != height;
  }
}