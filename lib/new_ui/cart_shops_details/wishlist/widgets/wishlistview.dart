// import 'package:cooking_champs/constant/apiConnectorConstants.dart';
// import 'package:cooking_champs/constant/assets_path.dart';
// import 'package:cooking_champs/constant/sized_box.dart';
// import 'package:cooking_champs/model/dynamic_models/see_all_product.dart';
// import 'package:cooking_champs/new_ui/cart_shops_details/cartscreen/cart_screen.dart';
// import 'package:cooking_champs/new_ui/cart_shops_details/details_screen.dart';
// import 'package:cooking_champs/services/api_path.dart';
// import 'package:cooking_champs/services/user_prefences.dart';
// import 'package:cooking_champs/utils/common_widget.dart';
// import 'package:cooking_champs/utils/navigators.dart';
// import 'package:cooking_champs/utils/utility.dart';
// import 'package:flutter/material.dart';
// import 'package:cooking_champs/constant/my_color.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:pretty_http_logger/pretty_http_logger.dart';
// import 'dart:convert' as convert;
// import 'dart:developer' as developer;
//
// import '../../common/defaulttext.dart';
// class Wishlistofview extends StatefulWidget {
//   final String titleName;
//   final String selectIndexIdCat;
//   final String whoIsProduct;
//   const Wishlistofview(
//       {super.key,
//       required this.titleName,
//       required this.whoIsProduct,
//       required this.selectIndexIdCat});
//
//   @override
//   State<Wishlistofview> createState() => _WishlistofviewState();
// }
//
// class _WishlistofviewState extends State<Wishlistofview> {
//   Set<int> selectedAddIndexes = {};
//   SeeAllProductModel wishList = SeeAllProductModel();
//   List<bool?> favoriteStates = [];
//   String totalPage = "";
//   int currentPage = 1;
//   bool isLoading = false;
//   bool hasMore = true;
//   ScrollController _scrollController = ScrollController();
//
//   @override
//   void initState() {
//     super.initState();
//     wishListApi();
//
//     _scrollController.addListener(() {
//       if (_scrollController.position.pixels >=
//               _scrollController.position.maxScrollExtent - 200 &&
//           !isLoading &&
//           hasMore) {
//         currentPage++;
//         wishListApi();
//       }
//     });
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
//     final newProduct = wishList.data?.items;
//     final screenWidth = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: commonAppBar(
//           context: context, title: widget.titleName, centerTitle: false),
//       body: SafeArea(
//         top: false,
//         child: RefreshIndicator(
//           onRefresh: _refreshProductList,
//           child: Padding(
//             padding: const EdgeInsets.all(10),
//             child: (newProduct == null ||
//                     favoriteStates.length != newProduct.length)
//                 ? const Center(
//                     child: CircularProgressIndicator(
//                     color: MyColor.appTheme,
//                   ))
//                 : newProduct.isEmpty
//                     ? Center(
//                         child: Text(
//                           "No products found in '${widget.titleName}'",
//                           style: TextStyle(fontSize: 16, color: Colors.grey),
//                         ),
//                       )
//                       : GridView.builder(
//                           controller: _scrollController,
//                           itemCount: newProduct.length,
//                           gridDelegate:
//                               const SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 2,
//                             crossAxisSpacing: 10,
//                             childAspectRatio: 0.69,
//                           ),
//                         itemBuilder: (context, index) {
//                           return GestureDetector(
//                             onTap: () {
//                               CustomNavigators.pushNavigate(
//                                   DetailsScreen(
//                                     productId: newProduct[index].id.toString(),
//                                   ),
//                                   context);
//                             },
//                             child: Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 8.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Stack(
//                                     children: [
//                                       ClipRRect(
//                                         borderRadius: const BorderRadius.all(
//                                             Radius.circular(12)),
//                                         child: FadeInImage.assetNetwork(
//                                           placeholder: AssetsPath.imagesList,
//                                           image:
//                                               "${ApiPath.imageBaseUrl}${newProduct[index].image}",
//                                           height: 121,
//                                           width: MediaQuery.of(context)
//                                                   .size
//                                                   .width /
//                                               2.4,
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                       Positioned(
//                                         top: 8,
//                                         right: 8,
//                                         child: GestureDetector(
//                                           onTap: () {
//                                             final currentStatus =
//                                                 newProduct[index]
//                                                         .isFavourite
//                                                         ?.toString() ==
//                                                     "true";
//                                             setState(() {
//                                               newProduct[index].isFavourite =
//                                                   !currentStatus;
//                                             });
//                                             addToWishlistApi(newProduct[index]
//                                                 .id
//                                                 .toString());
//                                           },
//                                           child: Container(
//                                             height: screenWidth * 0.08,
//                                             width: screenWidth * 0.08,
//                                             decoration: const BoxDecoration(
//                                               color: Color(0xffEEE9D9),
//                                               shape: BoxShape.circle,
//                                             ),
//                                             child: Icon(
//                                               (newProduct[index]
//                                                           .isFavourite
//                                                           ?.toString() ==
//                                                       "true")
//                                                   ? Icons.favorite
//                                                   : Icons.favorite_border,
//                                               color: MyColor.purplecolor,
//                                               size: screenWidth * 0.05,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   hsized5,
//                                   Text(
//                                     maxLines: 1,
//                                     newProduct[index].title ?? "",
//                                     style: mediumTextStyle(
//                                         fontSize: 15.0, color: Colors.black),
//                                   ),
//
//                                   if ((newProduct[index].description ?? '')
//                                       .isNotEmpty)
//                                     SizedBox(
//                                       height: 60,
//                                       // color: Colors.green,
//                                       child: Html(
//                                         data: newProduct[index].description!,
//                                         style: {
//                                           "body": Style(
//                                             fontSize: FontSize(12.0),
//                                             color: MyColor.color000000,
//                                             maxLines: 2,
//                                             textOverflow: TextOverflow.ellipsis,
//                                           ),
//                                         },
//                                       ),
//                                     )
//                                   else
//                                     const SizedBox.shrink(),
//
//                                   // const SizedBox(height: 6),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         '\$${newProduct[index]?.sellingPrice}',
//                                         style: mediumTextStyle(
//                                             fontSize: 14.0,
//                                             color: Colors.black),
//                                       ),
//                                       GestureDetector(
//                                         onTap: () {
//                                           final isInCart = selectedAddIndexes
//                                                   .contains(index) ||
//                                               (newProduct[index].isCartAdded ??
//                                                   true);
//
//                                           if (isInCart) {
//                                             Navigator.of(context).push(
//                                                 MaterialPageRoute(
//                                                     builder: (context) =>
//                                                         CartScreen())).then((value) {
//
//                                                             wishListApi();
//
//                                                         },);
//
//                                           } else {
//                                             // Add to cart and update UI
//                                             setState(() {
//                                               addToCartApi(newProduct[index]
//                                                   .id
//                                                   .toString());
//                                               selectedAddIndexes.add(index);
//                                             });
//                                           }
//                                         },
//                                         child: Container(
//                                           padding: EdgeInsets.symmetric(
//                                               vertical: 5, horizontal: 15),
//                                           decoration: BoxDecoration(
//                                             color: (selectedAddIndexes
//                                                         .contains(index) ||
//                                                     (newProduct[index]
//                                                             .isCartAdded ??
//                                                         true))
//                                                 ? MyColor.appTheme
//                                                 : MyColor.yellowF6F1E1,
//                                             borderRadius:
//                                                 BorderRadius.circular(14),
//                                           ),
//                                           child: Center(
//                                             child: Text(
//                                               (selectedAddIndexes
//                                                           .contains(index) ||
//                                                       (newProduct[index]
//                                                               .isCartAdded ??
//                                                           true))
//                                                   ? 'Go to Cart'
//                                                   : 'Add To Cart',
//                                               style: TextStyle(
//                                                 color: (selectedAddIndexes
//                                                             .contains(index) ||
//                                                         (newProduct[index]
//                                                                 .isCartAdded ??
//                                                             true))
//                                                     ? Colors.white
//                                                     : MyColor.appTheme,
//                                                 fontSize: 12.0,
//                                                 fontWeight: FontWeight.w500,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> _refreshProductList() async {
//     setState(() {
//       currentPage = 1;
//       wishListApi();
//     });
//     await Future.delayed(const Duration(seconds: 1));
//   }
//
//   Future<void> wishListApi() async {
//     isLoading = true;
//     ApiConnectorConstants.accessToken =
//         await PreferencesServices.getPreferencesData(
//                 PreferencesServices.userToken) ??
//             "";
//
//     var request = {
//       if (widget.selectIndexIdCat.isNotEmpty) 'cat_id': widget.selectIndexIdCat,
//       'type': widget.whoIsProduct,
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
//         var newData = SeeAllProductModel.fromJson(jsonResponse);
//
//         totalPage = newData.data?.totalPage.toString() ?? "1";
//
//         if (currentPage == 1) {
//           wishList = newData;
//           favoriteStates =
//               List.generate(newData.data?.items?.length ?? 0, (_) => false);
//         } else {
//           wishList.data?.items?.addAll(newData.data?.items ?? []);
//           favoriteStates.addAll(
//               List.generate(newData.data?.items?.length ?? 0, (_) => false));
//         }
//
//         // check if more data available
//         if (currentPage >= int.tryParse(totalPage)!) {
//           hasMore = false;
//         }
//
//         developer.log(convert.jsonEncode(jsonResponse));
//         setState(() {});
//       } else {
//         Utility.customToast(context, "${jsonResponse['message']}");
//       }
//     } catch (error) {
//       print("Error in wishListApi: $error");
//     } finally {
//       isLoading = false;
//     }
//   }
//
//   Future<void> addToWishlistApi(String productId) async {
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
//         wishListApi();
//         setState(() {});
//       } else {
//         Utility.customToast(context, "${jsonResponse['message']}");
//       }
//     } catch (error) {
//       print("Error in wishListApi: $error");
//     } finally {
//       isLoading = false;
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
//         setState(() {});
//       } else {
//         Utility.customToast(context, "${jsonResponse['message']}");
//       }
//     } catch (error) {
//       print("Error in wishListApi: $error");
//     }
//   }
// }


import 'package:cooking_champs/constant/apiConnectorConstants.dart';
import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/model/dynamic_models/see_all_product.dart';
import 'package:cooking_champs/new_ui/cart_shops_details/cartscreen/cart_screen.dart';
import 'package:cooking_champs/new_ui/cart_shops_details/details_screen.dart';
import 'package:cooking_champs/services/api_path.dart';
import 'package:cooking_champs/services/user_prefences.dart';
import 'package:cooking_champs/utils/common_widget.dart';
import 'package:cooking_champs/utils/navigators.dart';
import 'package:cooking_champs/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'dart:convert' as convert;
import 'dart:developer' as developer;

import '../../common/defaulttext.dart';

class Wishlistofview extends StatefulWidget {
  final String titleName;
  final String selectIndexIdCat;
  final String whoIsProduct;
  const Wishlistofview(
      {super.key,
        required this.titleName,
        required this.whoIsProduct,
        required this.selectIndexIdCat});

  @override
  State<Wishlistofview> createState() => _WishlistofviewState();
}

class _WishlistofviewState extends State<Wishlistofview> {
  Set<int> selectedAddIndexes = {};
  SeeAllProductModel wishList = SeeAllProductModel();
  List<bool?> favoriteStates = [];
  String totalPage = "";
  int currentPage = 1;
  bool isLoading = false;
  bool hasMore = true;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    wishListApi();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200 &&
          !isLoading &&
          hasMore) {
        currentPage++;
        wishListApi();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final newProduct = wishList.data?.items;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final bool isIpad = screenWidth > 600;

    // Responsive values
    final double horizontalPadding = isIpad ? 20.0 : 10.0;
    final double gridSpacing = isIpad ? 15.0 : 10.0;
    final double imageHeight = isIpad ? 180.0 : 121.0;
    final double imageWidth = isIpad ? screenWidth / 3.5 : screenWidth / 2.4;
    final double productPadding = isIpad ? 12.0 : 8.0;
    final double borderRadius = isIpad ? 16.0 : 12.0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: commonAppBar(
          context: context,
          title: widget.titleName,
          centerTitle: false,
          titleSize: isIpad ? 22.0 : null),
      body: SafeArea(
        top: false,
        child: RefreshIndicator(
          onRefresh: _refreshProductList,
          child: Padding(
            padding: EdgeInsets.all(horizontalPadding),
            child: (newProduct == null ||
                favoriteStates.length != newProduct.length)
                ? Center(
              child: CircularProgressIndicator(
                color: MyColor.appTheme,
                strokeWidth: isIpad ? 3.0 : 2.0,
              ),
            )
                : newProduct.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: isIpad ? 80.0 : 60.0,
                    color: Colors.grey.shade400,
                  ),
                  SizedBox(height: isIpad ? 20.0 : 15.0),
                  Text(
                    "No products found in '${widget.titleName}'",
                    style: TextStyle(
                      fontSize: isIpad ? 18.0 : 16.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
                : GridView.builder(
              controller: _scrollController,
              itemCount: newProduct.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isIpad ? 3 : 2,
                crossAxisSpacing: gridSpacing,
                mainAxisSpacing: gridSpacing,
                childAspectRatio: isIpad ? 0.9 : 0.69,
              ),
              itemBuilder: (context, index) {
                final product = newProduct[index];
                return GestureDetector(
                  onTap: () {
                    CustomNavigators.pushNavigate(
                        DetailsScreen(
                          productId: product.id.toString(),
                        ),
                        context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(borderRadius),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(productPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product Image with Favorite Icon
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(borderRadius)),
                                child: FadeInImage.assetNetwork(
                                  placeholder: AssetsPath.imagesList,
                                  image:
                                  "${ApiPath.imageBaseUrl}${product.image}",
                                  height: imageHeight,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: isIpad ? 10.0 : 8.0,
                                right: isIpad ? 10.0 : 8.0,
                                child: GestureDetector(
                                  onTap: () {
                                    final currentStatus =
                                        product.isFavourite?.toString() ==
                                            "true";
                                    setState(() {
                                      product.isFavourite =
                                      !currentStatus;
                                    });
                                    addToWishlistApi(product.id.toString());
                                  },
                                  child: Container(
                                    height: isIpad ? 40.0 : screenWidth * 0.08,
                                    width: isIpad ? 40.0 : screenWidth * 0.08,
                                    decoration: BoxDecoration(
                                      color: Color(0xffEEE9D9).withOpacity(0.9),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      (product.isFavourite?.toString() ==
                                          "true")
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: MyColor.purplecolor,
                                      size: isIpad ? 22.0 : screenWidth * 0.05,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: isIpad ? 10.0 : 5.0),

                          // Product Title
                          Text(
                            product.title ?? "",
                            style: mediumTextStyle(
                              fontSize: isIpad ? 16.0 : 15.0,
                              color: Colors.black,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: isIpad ? 8.0 : 4.0),

                          // Product Description
                          if ((product.description ?? '').isNotEmpty)
                            SizedBox(
                              height: isIpad ? 70.0 : 60.0,
                              child: Html(
                                data: product.description!,
                                style: {
                                  "body": Style(
                                    fontSize: FontSize(isIpad ? 13.0 : 12.0),
                                    color: MyColor.color000000,
                                    maxLines: 2,
                                    textOverflow: TextOverflow.ellipsis,
                                    lineHeight: LineHeight(1.3),
                                  ),
                                },
                              ),
                            )
                          else
                            const SizedBox.shrink(),

                          // Spacer to push price and button to bottom


                          // Price and Add to Cart Button
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // Price
                              Text(
                                '\$${product.sellingPrice}',
                                style: mediumTextStyle(
                                  fontSize: isIpad ? 16.0 : 14.0,
                                  color: Colors.black,
                                ),
                              ),

                              // Add to Cart / Go to Cart Button
                              GestureDetector(
                                onTap: () {
                                  final isInCart = selectedAddIndexes
                                      .contains(index) ||
                                      (product.isCartAdded ?? true);

                                  if (isInCart) {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                        builder: (context) =>
                                            CartScreen()))
                                        .then((value) {
                                      wishListApi();
                                    });
                                  } else {
                                    // Add to cart and update UI
                                    setState(() {
                                      addToCartApi(product.id.toString());
                                      selectedAddIndexes.add(index);
                                    });
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: isIpad ? 8.0 : 6.0,
                                    horizontal: isIpad ? 20.0 : 15.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: (selectedAddIndexes
                                        .contains(index) ||
                                        (product.isCartAdded ??
                                            true))
                                        ? MyColor.appTheme
                                        : MyColor.yellowF6F1E1,
                                    borderRadius:
                                    BorderRadius.circular(isIpad ? 16.0 : 14.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      (selectedAddIndexes
                                          .contains(index) ||
                                          (product.isCartAdded ??
                                              true))
                                          ? 'Go to Cart'
                                          : 'Add To Cart',
                                      style: TextStyle(
                                        color: (selectedAddIndexes
                                            .contains(index) ||
                                            (product.isCartAdded ??
                                                true))
                                            ? Colors.white
                                            : MyColor.appTheme,
                                        fontSize: isIpad ? 14.0 : 12.0,
                                        fontWeight: FontWeight.w500,
                                      ),
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
        ),
      ),
    );
  }

  Future<void> _refreshProductList() async {
    setState(() {
      currentPage = 1;
      wishListApi();
    });
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> wishListApi() async {
    isLoading = true;
    ApiConnectorConstants.accessToken =
        await PreferencesServices.getPreferencesData(
            PreferencesServices.userToken) ??
            "";

    var request = {
      if (widget.selectIndexIdCat.isNotEmpty) 'cat_id': widget.selectIndexIdCat,
      'type': widget.whoIsProduct,
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
        var newData = SeeAllProductModel.fromJson(jsonResponse);

        totalPage = newData.data?.totalPage.toString() ?? "1";

        if (currentPage == 1) {
          wishList = newData;
          favoriteStates =
              List.generate(newData.data?.items?.length ?? 0, (_) => false);
        } else {
          wishList.data?.items?.addAll(newData.data?.items ?? []);
          favoriteStates.addAll(
              List.generate(newData.data?.items?.length ?? 0, (_) => false));
        }

        // check if more data available
        if (currentPage >= int.tryParse(totalPage)!) {
          hasMore = false;
        }

        developer.log(convert.jsonEncode(jsonResponse));
        setState(() {});
      } else {
        Utility.customToast(context, "${jsonResponse['message']}");
      }
    } catch (error) {
      print("Error in wishListApi: $error");
    } finally {
      isLoading = false;
    }
  }

  Future<void> addToWishlistApi(String productId) async {
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
        wishListApi();
        setState(() {});
      } else {
        Utility.customToast(context, "${jsonResponse['message']}");
      }
    } catch (error) {
      print("Error in wishListApi: $error");
    } finally {
      isLoading = false;
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
        setState(() {});
      } else {
        Utility.customToast(context, "${jsonResponse['message']}");
      }
    } catch (error) {
      print("Error in wishListApi: $error");
    }
  }
}