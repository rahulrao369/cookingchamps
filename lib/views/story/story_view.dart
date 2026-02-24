// import 'package:cooking_champs/constant/my_fonts_style.dart';
// import 'package:cooking_champs/constant/sized_box.dart';
// import 'package:cooking_champs/model/dynamic_models/my_story_model.dart';
// import 'package:cooking_champs/services/api_path.dart';
// import 'package:cooking_champs/services/api_services.dart';
// import 'package:cooking_champs/utils/navigators.dart';
// import 'package:cooking_champs/utils/ui_utils.dart';
// import 'package:cooking_champs/constant/assets_path.dart';
// import 'package:cooking_champs/constant/my_color.dart';
// import 'package:cooking_champs/constant/stringfile.dart/language.dart';
// import 'package:cooking_champs/views/story/add_your_stories_view.dart';
// import 'package:cooking_champs/views/story/storie_detials.dart';
// import 'package:flutter/material.dart';
// import 'package:touch_ripple_effect/touch_ripple_effect.dart';
//
// class OurMemoryView extends StatefulWidget {
//   final Function? onCallBack;
//   const OurMemoryView({super.key,this.onCallBack});
//
//   @override
//   State<OurMemoryView> createState() => _OurMemoryViewState();
// }
//
// class _OurMemoryViewState extends State<OurMemoryView> {
//   List<StoryModel> storyList = [];
//   List<StoryModel> featuredStoryList = [];
//   bool isLoading = false; // To prevent multiple calls
//   bool hasMoreData = true; // To track if there is more data to load
//   int totalPage = 1;
//   int page = 1;
//   int pageRecipe = 1;
//   bool load = false;
//
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(Duration.zero,getStories);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Column(
//         children: [
//           Expanded(
//             child: storyUi(size),
//           ),
//         ],
//       ),
//       floatingActionButton: TouchRippleEffect(
//         borderRadius: BorderRadius.circular(27),
//         rippleColor: Colors.white,
//         onTap: () {
//             CustomNavigators.pushNavigate(AddYourStoriesView(onCallback: onCallBackStory, onCallScreen: false,), context);
//         },
//         child: const CircleAvatar(
//           radius: 35,
//           backgroundColor: MyColor.appTheme,
//           child: Icon(
//             Icons.add,
//             size: 40,
//             color: MyColor.white,
//           ),
//         ),
//       ),
//     );
//   }
//
//   void onCallBackStory(StoryModel model) {
//     if (mounted) {
//       setState(() {
//         storyList.insert(0, model); // Add `model` at the first index
//       });
//     }
//   }
//
//   Future<void> getStories() async {
//     if (isLoading || !hasMoreData) return;
//     setState(() {
//       isLoading = true; // Start loading
//     });
//
//     bool load = (page == 1); // Set `load` to true for the first page, false otherwise
//
//     try {
//       final onValue = await ApiServices.getStoryList(context, page.toString(), load);
//
//       if (mounted && onValue.status == true) {
//         setState(() {
//           if (onValue.data['total_page'] != null) {
//             totalPage = onValue.data['total_page'];
//           }
//           var featuredStories = onValue.data['best_from_the_champs'] as List<dynamic>? ?? [];
//
//
//           if(featuredStories.isNotEmpty){
//             featuredStoryList.clear();
//             var storyModels = featuredStories.map((item) => StoryModel.fromJson(item)).toList();
//             storyModels.sort((a, b) => b.id!.compareTo(a.id!));
//             featuredStoryList.addAll(storyModels);
//             debugPrint("featuredStoryList...${featuredStoryList.length}");
//           }
//
//           var items = onValue.data['items'] as List<dynamic>? ?? []; // Safely cast items to List<dynamic>
//
//           if (page == 1) {
//             storyList.clear(); // Clear the list only on the first page
//           }
//
//           if (items.isNotEmpty) {
//             // Convert items to StoryModel and add to the list
//             var storyModels = items.map((item) => StoryModel.fromJson(item)).toList();
//
//             // Sort by `id` in descending order (replace with `a.id.compareTo(b.id)` for ascending order)
//             storyModels.sort((a, b) => b.id!.compareTo(a.id!));
//
//             storyList.addAll(storyModels);
//             page++; // Increment the page number for the next call
//           }
//           else {
//             hasMoreData = false; // No more data to load
//           }
//
//
//         });
//       }
//     } catch (e) {
//       debugPrint('Error fetching stories: $e');
//     } finally {
//       setState(() {
//         isLoading = false; // End loading
//       });
//     }
//   }
//
//   storyUi(var size) {
//     return Padding(
//       padding: EdgeInsets.only(top: 15, left: 15, right: 15),
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(Languages.of(context)!.bestFromTheChamps,
//                 style: mediumTextStyle(fontSize: 18.0, color: MyColor.black)),
//             featuredStoryList.isNotEmpty
//                 ?      SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: List.generate(featuredStoryList.length, (index) {
//                   return storyItemUi(featuredStoryList[index], size);
//                                 }),
//                               ),
//                 )
//                 :
//             noStory(size,Languages.of(context)!.nostoriesYet,AssetsPath.nostories, Languages.of(context)!.youhaventaddedanystoriesyet),
//
//             hsized15,
//             Text(Languages.of(context)!.yourStories,
//                 style: mediumTextStyle(fontSize: 18.0, color: MyColor.black)),
//
//             storyList.isEmpty ?
//             noStory(size,Languages.of(context)!.nostoriesYet,AssetsPath.nostories, Languages.of(context)!.youhaventaddedanystoriesyet)
//                 :
//             NotificationListener<ScrollNotification>(
//                 onNotification: (ScrollNotification scrollInfo) {
//                   if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent && !isLoading) {
//                     getStories(); // Load more data when scrolled to the bottom
//                   }
//                   return false;
//                 },
//                 child:  Container(
//                     height: 230,
//                     margin: const EdgeInsets.only(bottom: 5, top:0),
//                     child: SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: List.generate(storyList.length, (index) {
//                               return storyItemUi(storyList[index], size);
//                             }),
//                           ),
//
//                           isLoading?idLoading():SizedBox.shrink()
//                         ],
//                       ),
//                     ))
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget storyItemUi(StoryModel model, var size) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 5, right: 5, bottom: 0, top: 10),
//       child: TouchRippleEffect(
//         borderRadius: BorderRadius.circular(10),
//         rippleColor: Colors.white,
//         onTap: () {
//           CustomNavigators.pushNavigate(StoriesDetailsView(model:model, type: '',), context);
//         },
//         child: Container(
//           decoration: const BoxDecoration(
//               color: MyColor.white,
//               borderRadius: BorderRadius.all(Radius.circular(10))),
//           width: size.width * 0.44,
//           height: 230,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(10),
//                 child: UiUtils.networkImages(size.width * 0.44, 100,
//                     model.image != null?   ApiPath.imageBaseUrl + model.image.toString():""),
//               ),
//               hsized8,
//               Padding(
//                 padding: EdgeInsets.only(left: 5.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(model.title ?? "",
//                         maxLines: 1,
//                         style: mediumTextStyle(
//                             fontSize: 15.0, color: MyColor.black)),
//                     hsized8,
//                     Text(model.description ?? "",
//                         maxLines: 2,
//                         style: regularTextStyle(
//                             fontSize: 11.0, color: MyColor.black))
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   noStory(var size,String title,String img,String des) {
//     return Container(
//       padding: EdgeInsets.only(top: 5),
//       height: 220,
//       child: Center(
//         child: Container(
//             width: size.width * 0.90,
//             height: 180,
//             decoration: const BoxDecoration(
//                 color: MyColor.yellowF6F1E1,
//                 borderRadius:
//                 BorderRadius.all(Radius.circular(20))),
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 children: [
//                   Image.asset(img, height: 45,),
//
//                   hsized10,
//
//                   Text(title,
//                       style: mediumTextStyle(fontSize: 14.0, color: MyColor.black)),
//
//                   hsized5,
//
//                   Text(
//                       des,
//                       textAlign: TextAlign.center,
//                       style: regularTextStyle(
//                           fontSize: 12.0, color: MyColor.black)),
//                 ],
//               ),
//             )),
//       ),
//     );
//   }
//
//   idLoading() {
//     return Container(
//         height: 120,
//         alignment: Alignment.center,
//         padding: const EdgeInsets.only(left: 15,right: 30),
//         child: CircularProgressIndicator());
//   }
// }



import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/model/dynamic_models/my_story_model.dart';
import 'package:cooking_champs/services/api_path.dart';
import 'package:cooking_champs/services/api_services.dart';
import 'package:cooking_champs/utils/navigators.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:cooking_champs/constant/assets_path.dart';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/stringfile.dart/language.dart';
import 'package:cooking_champs/views/story/add_your_stories_view.dart';
import 'package:cooking_champs/views/story/storie_detials.dart';
import 'package:flutter/material.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';

class OurMemoryView extends StatefulWidget {
  final Function? onCallBack;
  const OurMemoryView({super.key, this.onCallBack});

  @override
  State<OurMemoryView> createState() => _OurMemoryViewState();
}

class _OurMemoryViewState extends State<OurMemoryView> {
  List<StoryModel> storyList = [];
  List<StoryModel> featuredStoryList = [];
  bool isLoading = false;
  bool hasMoreData = true;
  int totalPage = 1;
  int page = 1;
  int pageRecipe = 1;
  bool load = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, getStories);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final bool isTablet = size.shortestSide > 600;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: storyUi(size, isTablet),
          ),
        ],
      ),
      floatingActionButton: TouchRippleEffect(
        borderRadius: BorderRadius.circular(isTablet ? 35.0 : 27.0),
        rippleColor: Colors.white,
        onTap: () {
          CustomNavigators.pushNavigate(
            AddYourStoriesView(onCallback: onCallBackStory, onCallScreen: false),
            context,
          );
        },
        child: CircleAvatar(
          radius: isTablet ? 45.0 : 35.0,
          backgroundColor: MyColor.appTheme,
          child: Icon(
            Icons.add,
            size: isTablet ? 50.0 : 40.0,
            color: MyColor.white,
          ),
        ),
      ),
    );
  }

  void onCallBackStory(StoryModel model) {
    if (mounted) {
      setState(() {
        storyList.insert(0, model);
      });
    }
  }

  Future<void> getStories() async {
    if (isLoading || !hasMoreData) return;
    setState(() {
      isLoading = true;
    });

    bool load = (page == 1);

    try {
      final onValue = await ApiServices.getStoryList(context, page.toString(), load);

      if (mounted && onValue.status == true) {
        setState(() {
          if (onValue.data['total_page'] != null) {
            totalPage = onValue.data['total_page'];
          }

          var featuredStories = onValue.data['best_from_the_champs'] as List<dynamic>? ?? [];

          if (featuredStories.isNotEmpty) {
            featuredStoryList.clear();
            var storyModels = featuredStories.map((item) => StoryModel.fromJson(item)).toList();
            storyModels.sort((a, b) => b.id!.compareTo(a.id!));
            featuredStoryList.addAll(storyModels);
          }

          var items = onValue.data['items'] as List<dynamic>? ?? [];

          if (page == 1) {
            storyList.clear();
          }

          if (items.isNotEmpty) {
            var storyModels = items.map((item) => StoryModel.fromJson(item)).toList();
            storyModels.sort((a, b) => b.id!.compareTo(a.id!));
            storyList.addAll(storyModels);
            page++;
          } else {
            hasMoreData = false;
          }
        });
      }
    } catch (e) {
      debugPrint('Error fetching stories: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget storyUi(var size, bool isTablet) {
    return Padding(
      padding: EdgeInsets.only(
        top: isTablet ? 25.0 : 15.0,
        left: isTablet ? 25.0 : 15.0,
        right: isTablet ? 25.0 : 15.0,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Featured Stories Title
            Text(
              Languages.of(context)!.bestFromTheChamps,
              style: mediumTextStyle(
                fontSize: isTablet ? 24.0 : 18.0,
                color: MyColor.black,
              ),
            ),

            SizedBox(height: isTablet ? 20.0 : 15.0),

            // Featured Stories Horizontal List
            featuredStoryList.isNotEmpty
                ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  featuredStoryList.length,
                      (index) => storyItemUi(featuredStoryList[index], size, isTablet),
                ),
              ),
            )
                : noStory(size, Languages.of(context)!.nostoriesYet, AssetsPath.nostories,
                Languages.of(context)!.youhaventaddedanystoriesyet, isTablet),

            SizedBox(height: isTablet ? 30.0 : 15.0),

            // Your Stories Title
            Text(
              Languages.of(context)!.yourStories,
              style: mediumTextStyle(
                fontSize: isTablet ? 24.0 : 18.0,
                color: MyColor.black,
              ),
            ),

            SizedBox(height: isTablet ? 20.0 : 15.0),

            // Your Stories Horizontal List
            storyList.isEmpty
                ? noStory(size, Languages.of(context)!.nostoriesYet, AssetsPath.nostories,
                Languages.of(context)!.youhaventaddedanystoriesyet, isTablet)
                : NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent && !isLoading) {
                  getStories();
                }
                return false;
              },
              child: Container(
                //height: isTablet ? 280.0 : 230.0,
               // color: Colors.red,
                margin: EdgeInsets.only(
                  bottom: isTablet ? 10.0 : 5.0,
                  top: isTablet ? 10.0 : 0.0,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                          storyList.length,
                              (index) => storyItemUi(storyList[index], size, isTablet),
                        ),
                      ),
                      isLoading ? idLoading(isTablet) : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: isTablet ? 40.0 : 30.0),
          ],
        ),
      ),
    );
  }

  Widget storyItemUi(StoryModel model, var size, bool isTablet) {
    return Padding(
      padding: EdgeInsets.only(
        left: isTablet ? 10.0 : 5.0,
        right: isTablet ? 10.0 : 5.0,
        bottom: isTablet ? 15.0 : 0.0,
        top: isTablet ? 15.0 : 10.0,
      ),
      child: TouchRippleEffect(
        borderRadius: BorderRadius.circular(isTablet ? 14.0 : 10.0),
        rippleColor: Colors.white,
        onTap: () {
          CustomNavigators.pushNavigate(
            StoriesDetailsView(model: model, type: ''),
            context,
          );
        },
        child: Container(
          decoration: const BoxDecoration(
            color: MyColor.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          width: size.width * (isTablet ? 0.32 : 0.44),
          height: isTablet ? 280.0 : 230.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Story Image
              ClipRRect(
                borderRadius: BorderRadius.circular(isTablet ? 14.0 : 10.0),
                child: UiUtils.networkImages(
                  size.width * (isTablet ? 0.32 : 0.44),
                  isTablet ? 150.0 : 100.0,
                  model.image != null ? ApiPath.imageBaseUrl + model.image.toString() : "",
                ),
              ),

              SizedBox(height: isTablet ? 12.0 : 8.0),

              // Story Content
              Padding(
                padding: EdgeInsets.only(
                  left: isTablet ? 10.0 : 5.0,
                  right: isTablet ? 10.0 : 5.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      model.title ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: mediumTextStyle(
                        fontSize: isTablet ? 21.0 : 15.0,
                        color: MyColor.black,
                      ),
                    ),

                    SizedBox(height: isTablet ? 10.0 : 8.0),

                    // Description
                    Text(
                      model.description ?? "",
                      maxLines: isTablet ? 3 : 2,
                      overflow: TextOverflow.ellipsis,
                      style: regularTextStyle(
                        fontSize: isTablet ? 16.0 : 11.0,
                        color: MyColor.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget noStory(var size, String title, String img, String des, bool isTablet) {
    return Container(
      padding: EdgeInsets.only(top: isTablet ? 15.0 : 5.0),
      height: isTablet ? 300.0 : 220.0,
      child: Center(
        child: Container(
          width: size.width * (isTablet ? 0.85 : 0.90),
          height: isTablet ? 250.0 : 180.0,
          decoration: const BoxDecoration(
            color: MyColor.yellowF6F1E1,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Padding(
            padding: EdgeInsets.all(isTablet ? 30.0 : 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon/Image
                Image.asset(
                  img,
                  height: isTablet ? 65.0 : 45.0,
                ),

                SizedBox(height: isTablet ? 15.0 : 10.0),

                // Title
                Text(
                  title,
                  style: mediumTextStyle(
                    fontSize: isTablet ? 20.0 : 14.0,
                    color: MyColor.black,
                  ),
                ),

                SizedBox(height: isTablet ? 10.0 : 5.0),

                // Description
                Text(
                  des,
                  textAlign: TextAlign.center,
                  style: regularTextStyle(
                    fontSize: isTablet ? 16.0 : 12.0,
                    color: MyColor.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget idLoading(bool isTablet) {
    return Container(
      height: isTablet ? 150.0 : 120.0,
      alignment: Alignment.center,
      padding: EdgeInsets.only(
        left: isTablet ? 20.0 : 15.0,
        right: isTablet ? 40.0 : 30.0,
      ),
      child: CircularProgressIndicator(
        color: MyColor.appTheme,
        strokeWidth: isTablet ? 3.0 : 2.0,
      ),
    );
  }
}