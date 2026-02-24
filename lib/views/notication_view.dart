// import 'package:cooking_champs/constant/my_color.dart';
// import 'package:cooking_champs/constant/my_fonts_style.dart';
// import 'package:cooking_champs/constant/sized_box.dart';
// import 'package:cooking_champs/model/dynamic_models/notification_model.dart';
// import 'package:cooking_champs/services/api_path.dart';
// import 'package:cooking_champs/services/api_services.dart';
// import 'package:cooking_champs/utils/navigators.dart';
// import 'package:cooking_champs/utils/ui_utils.dart';
// import 'package:cooking_champs/views/friend_request.dart';
// import 'package:flutter/material.dart';
//
// class NotificationView extends StatefulWidget {
//   const NotificationView({super.key});
//
//   @override
//   State<NotificationView> createState() => _NotificationViewState();
// }
//
// class _NotificationViewState extends State<NotificationView> {
//   List<NotificationModel> notificationList = [];
//   int page = 1;
//   int totalPage = 1;
//   bool isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(Duration.zero, getNotification);
//   }
//
//   Future<void> getNotification() async {
//     if (isLoading || page > totalPage) return;
//
//     setState(() {
//       isLoading = true;
//     });
//
//     try {
//       final response = await ApiServices.getNotification(context, true, page);
//
//       if (response.status == true) {
//         if (mounted) {
//           setState(() {
//             totalPage = response.data['total_page'];
//             final items = response.data['items'] as List;
//             if (page == 1) {
//               notificationList.clear();
//             }
//             for (var n in items) {
//               NotificationModel model = NotificationModel.fromJson(n);
//               notificationList.add(model);
//             }
//
//             page++;
//           });
//         }
//       }
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//   onDeleteNotification(String? id) async {
//     await ApiServices.deleteNotification(context, id).then((onValue) {
//       if (mounted && onValue.status == true) {
//         setState(() {
//           // page = 1;
//           notificationList.clear();
//         });
//         getNotification();
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final  bool  isTab = MediaQuery.of(context).size.width > 600 ;
//
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         scrolledUnderElevation: 0,
//         surfaceTintColor: MyColor.yellowF6F1E1,
//         backgroundColor: MyColor.yellowF6F1E1,
//         leadingWidth: isTab ? 60 : 40,
//         toolbarHeight: isTab ? 80 : 60,
//         leading: InkWell(
//           radius: 80,
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: Padding(
//             padding: const EdgeInsets.only(left: 20),
//             child: Icon(Icons.arrow_back_ios,size: isTab ?35 :30,),
//           ),
//         ),
//         title: Text(
//           "Notifications",
//           style: mediumTextStyle(fontSize: isTab ? 25.0 :18.0, color: MyColor.black),
//
//         ),
//         actions: [
//           // InkWell(
//           //   borderRadius: BorderRadius.circular(27),
//           //   onTap: () {
//           //     setState(() {
//           //       notificationList.clear();
//           //       page = 1;
//           //     });
//           //     getNotification(); // Clear notifications and reload
//           //   },
//           //   child: Padding(
//           //     padding: const EdgeInsets.only(right: 15.0),
//           //     child: Text(
//           //       "Clear all",
//           //       style: regularTextStyle(fontSize: 15.0, color: MyColor.red),
//           //     ),
//           //   ),
//           // )
//         ],
//       ),
//       body: NotificationListener<ScrollNotification>(
//         onNotification: (scrollInfo) {
//           if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
//               !isLoading &&
//               page <= totalPage) {
//             getNotification();
//           }
//           return false;
//         },
//         child: NotificationListener<ScrollNotification>(
//           onNotification: (scrollInfo) {
//             if (scrollInfo.metrics.pixels ==
//                     scrollInfo.metrics.maxScrollExtent &&
//                 !isLoading &&
//                 page <= totalPage) {
//               getNotification();
//             }
//             return false;
//           },
//           child: ListView.builder(
//             shrinkWrap: true,
//             padding: const EdgeInsets.only(top: 20),
//             itemCount: notificationList.length + (isLoading ? 1 : 0),
//             itemBuilder: (context, index) {
//               if (index == notificationList.length) {
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: page == 1
//                       ? const SizedBox.shrink()
//                       : const CircularProgressIndicator(),
//                 );
//               }
//
//               var notification = notificationList[index];
//
//               return Column(
//                 children: [
//                   Dismissible(
//                     key: Key(notification.id.toString()),
//                     direction: DismissDirection.endToStart,
//                     onDismissed: (direction) {
//                       final notificationId = notification.id;
//                       setState(() {
//                         notificationList.removeAt(index);
//                       });
//                       onDeleteNotification(notificationId);
//                     },
//                     background: Container(
//                       alignment: Alignment.centerRight,
//                       padding: const EdgeInsets.symmetric(horizontal: 20),
//                       color: Colors.red.withOpacity(0.3),
//                       child: const Icon(Icons.delete, color: Colors.white),
//                     ),
//                     child: InkWell(
//                       onTap: () {
//                         if (notification.type.toString() ==
//                             "Accept Friend Request") {
//                           CustomNavigators.pushNavigate(
//                             FriendRequestView(type: ''),
//                             context,
//                           );
//                         }
//                       },
//                       child: UiUtils.notificationCard(
//                         notification.message ?? "",
//                         notification.title ?? "",
//                         notification.userDetails?.image != null
//                             ? ApiPath.imageBaseUrl +
//                                 notification.userDetails!.image
//                             : "",
//                       ),
//                     ),
//                   ),
//                   hsized5,
//                   UiUtils.dividerLine(),
//                   hsized5,
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/model/dynamic_models/notification_model.dart';
import 'package:cooking_champs/services/api_path.dart';
import 'package:cooking_champs/services/api_services.dart';
import 'package:cooking_champs/utils/navigators.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:cooking_champs/views/friend_request.dart';
import 'package:flutter/material.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  List<NotificationModel> notificationList = [];
  int page = 1;
  int totalPage = 1;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, getNotification);
  }

  Future<void> getNotification() async {
    if (isLoading || page > totalPage) return;

    setState(() {
      isLoading = true;
    });

    try {
      final response = await ApiServices.getNotification(context, true, page);

      if (response.status == true) {
        if (mounted) {
          setState(() {
            totalPage = response.data['total_page'];
            final items = response.data['items'] as List;
            if (page == 1) {
              notificationList.clear();
            }
            for (var n in items) {
              NotificationModel model = NotificationModel.fromJson(n);
              notificationList.add(model);
            }

            page++;
          });
        }
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  onDeleteNotification(String? id) async {
    await ApiServices.deleteNotification(context, id).then((onValue) {
      if (mounted && onValue.status == true) {
        setState(() {
          notificationList.clear();
        });
        getNotification();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isIpad = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: MyColor.yellowF6F1E1,
        backgroundColor: MyColor.yellowF6F1E1,
        leadingWidth: isIpad ? 80.0 : 40.0,
        toolbarHeight: isIpad ? 90.0 : 60.0,
        leading: InkWell(
          radius: isIpad ? 100.0 : 80.0,
          borderRadius: BorderRadius.circular(isIpad ? 40.0 : 30.0),
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.only(left: isIpad ? 25.0 : 20.0),
            child: Icon(
              Icons.arrow_back_ios,
              size: isIpad ? 35.0 : 30.0,
              color: MyColor.black,
            ),
          ),
        ),
        title: Text(
          "Notifications",
          style: mediumTextStyle(
              fontSize: isIpad ? 28.0 : 18.0,
              color: MyColor.black
          ),
        ),
        actions: [
          // Optional: Clear all button
          // InkWell(
          //   borderRadius: BorderRadius.circular(isIpad ? 35.0 : 27.0),
          //   onTap: () {
          //     setState(() {
          //       notificationList.clear();
          //       page = 1;
          //     });
          //     getNotification();
          //   },
          //   child: Padding(
          //     padding: EdgeInsets.only(right: isIpad ? 20.0 : 15.0),
          //     child: Text(
          //       "Clear all",
          //       style: regularTextStyle(
          //         fontSize: isIpad ? 18.0 : 15.0,
          //         color: MyColor.red
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
              !isLoading &&
              page <= totalPage) {
            getNotification();
          }
          return false;
        },
        child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.only(
            top: isIpad ? 30.0 : 20.0,
            left: isIpad ? 20.0 : 0,
            right: isIpad ? 20.0 : 0,
          ),
          itemCount: notificationList.length + (isLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == notificationList.length) {
              return Padding(
                padding: EdgeInsets.all(isIpad ? 15.0 : 8.0),
                child: page == 1
                    ? const SizedBox.shrink()
                    : CircularProgressIndicator(
                  color: MyColor.appTheme,
                  strokeWidth: isIpad ? 3.0 : 2.0,
                ),
              );
            }

            var notification = notificationList[index];

            return Column(
              children: [
                Dismissible(
                  key: Key(notification.id.toString()),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    final notificationId = notification.id;
                    setState(() {
                      notificationList.removeAt(index);
                    });
                    onDeleteNotification(notificationId);
                  },
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: isIpad ? 30.0 : 20.0),
                    color: Colors.red.withOpacity(0.3),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: isIpad ? 35.0 : 24.0,
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      if (notification.type.toString() == "Accept Friend Request") {
                        CustomNavigators.pushNavigate(
                          FriendRequestView(type: ''),
                          context,
                        );
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        vertical: isIpad ? 10.0 : 5.0,
                        horizontal: isIpad ? 15.0 : 8.0,
                      ),
                      child: _buildNotificationCard(notification, isIpad),
                    ),
                  ),
                ),
                SizedBox(height: isIpad ? 10.0 : 5.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: isIpad ? 25.0 : 15.0),
                  child: Divider(
                    height: 1,
                    color: MyColor.grayLite.withOpacity(0.5),
                  ),
                ),
                SizedBox(height: isIpad ? 10.0 : 5.0),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildNotificationCard(NotificationModel notification, bool isIpad) {
    return Container(
      padding: EdgeInsets.all(isIpad ? 20.0 : 12.0),
      decoration: BoxDecoration(
        color: MyColor.white,
        borderRadius: BorderRadius.circular(isIpad ? 20.0 : 15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: isIpad ? 15.0 : 10.0,
            spreadRadius: isIpad ? 3.0 : 1.0,
            offset: Offset(0, isIpad ? 5.0 : 3.0),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(isIpad ? 20.0 : 15.0),
            child: Container(
              width: isIpad ? 80.0 : 50.0,
              height: isIpad ? 80.0 : 50.0,
              color: MyColor.grayLite.withOpacity(0.2),
              child: notification.userDetails?.image != null
                  ? Image.network(
                ApiPath.imageBaseUrl + notification.userDetails!.image!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.person,
                    size: isIpad ? 40.0 : 24.0,
                    color: MyColor.grayLite,
                  );
                },
              )
                  : Icon(
                Icons.person,
                size: isIpad ? 40.0 : 24.0,
                color: MyColor.grayLite,
              ),
            ),
          ),
          SizedBox(width: isIpad ? 20.0 : 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title ?? "Notification",
                  style: mediumTextStyle(
                    fontSize: isIpad ? 20.0 : 16.0,
                    color: MyColor.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: isIpad ? 8.0 : 4.0),
                Text(
                  notification.message ?? "",
                  style: regularTextStyle(
                    fontSize: isIpad ? 18.0 : 14.0,
                    color: MyColor.black.withOpacity(0.7),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: isIpad ? 8.0 : 4.0),
                if (notification.createdAt != null)
                  Text(
                    notification.createdAt!.split(" ").first,
                    style: regularTextStyle(
                      fontSize: isIpad ? 16.0 : 12.0,
                      color: MyColor.grayLite,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}