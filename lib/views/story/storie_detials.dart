// import 'dart:io';
// import 'package:cooking_champs/constant/my_color.dart';
// import 'package:cooking_champs/constant/my_fonts_style.dart';
// import 'package:cooking_champs/constant/sized_box.dart';
// import 'package:cooking_champs/model/dynamic_models/my_story_model.dart';
// import 'package:cooking_champs/services/api_path.dart';
// import 'package:cooking_champs/services/api_services.dart';
// import 'package:cooking_champs/utils/all_dialogs.dart';
// import 'package:cooking_champs/utils/navigators.dart';
// import 'package:cooking_champs/utils/ui_utils.dart';
// import 'package:cooking_champs/views/dashboard.dart';
// import 'package:cooking_champs/views/story/share_story_view.dart';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
//
// import 'add_your_stories_view.dart';
//
// class StoriesDetailsView extends StatefulWidget {
//    StoryModel model;
//    String type;
//    StoriesDetailsView({super.key,required this.model,required this.type});
//
//   @override
//   State<StoriesDetailsView> createState() => _StoriesDetailsViewState();
// }
//
// class _StoriesDetailsViewState extends State<StoriesDetailsView> {
//   List<StoryImages> storyImagesList = [];
//   StoryImages storyImageModel = StoryImages();
//   StoryModel storyModel = StoryModel();
//   int currentIndex = 0;
//
//   @override
//   void initState() {
//     setStoryImage();
//     Future.delayed(Duration.zero, getStoriesDetail);
//     super.initState();
//   }
//   @override
//   void dispose() {
//     storyModel.videolink != "" ?  _controller!.pause():null;
//
//     super.dispose();
//   }
//   bool _mounted = false;
//   bool isVideoError = false;
//
//   void _initializeController(String link) async {
//     // Dispose previous controller if it exists
//     if (_controller != null) {
//       await _controller!.dispose();
//       _controller = null; // Ensure it's fully reset
//     }
//
//     // Set loading state
//     setState(() {
//       isVideoError = true; // Reset error flag
//     });
//
//     try {
//       // Create new video player controller
//       _controller = VideoPlayerController.networkUrl(
//         Uri.parse(link),
//         videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
//       );
//
//       // Try to initialize the controller
//       await _controller!.initialize();
//
//       // Start playing after initialization
//       _controller!.pause();
//
//       if (_mounted) {
//         setState(() {
//           isVideoError = false; // No error, video loaded successfully
//         });
//       }
//
//       _controller!.addListener(() {
//         if (_mounted) {
//           setState(() {});
//         }
//       });
//     } catch (e) {
//       print("Error initializing video controller: $e");
//
//       if (_mounted) {
//         setState(() {
//           isVideoError = true; // Flag to show error UI
//         });
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery
//         .of(context)
//         .size;
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//
//               Stack(
//                 children: [
//
//                   Visibility(
//                     visible: storyImagesList.isNotEmpty,
//                     child: SizedBox(
//                       width: size.width,
//                       height: size.height * 0.35,
//                       child: Stack(
//                         alignment: Alignment.bottomCenter,
//                         children: [
//
//                           PageView.builder(
//                               itemCount: storyImagesList.length,
//                               onPageChanged: (v) {
//                                 if (mounted) {
//                                   setState(() {
//                                     currentIndex = v;
//                                   });
//                                 }
//                               },
//                               itemBuilder: (context, int index) {
//                                 return Container(
//                                     width: size.width,
//                                     height: size.height * 0.35,
//                                     decoration: BoxDecoration(
//                                         color: Colors.amber,
//                                         borderRadius: BorderRadius.only(
//                                             bottomRight: Radius.circular(20),
//                                             bottomLeft: Radius.circular(20))),
//                                     child: UiUtils.networkImages(
//                                         double.infinity, size.height * 0.35,
//                                         storyImagesList[index].images != null
//                                             ? ApiPath.imageBaseUrl +
//                                             storyImagesList[index].images
//                                                 .toString()
//                                             : "")
//                                 );
//                               }),
//
//                           Container(
//                             padding: EdgeInsets.only(bottom: 20),
//                             child: SingleChildScrollView(
//                               scrollDirection: Axis.horizontal,
//                               child: Row(
//                                 children: List.generate(
//                                     storyImagesList.length, (index) {
//                                   return Container(
//                                     margin: EdgeInsets.only(right: 5),
//                                     height: 8,
//                                     width: currentIndex == index ? 18 : 8,
//                                     decoration: BoxDecoration(
//                                       color: currentIndex == index ? MyColor
//                                           .blue1 : MyColor.liteGray,
//                                       borderRadius: BorderRadius.circular(100),
//                                       // shape: BoxShape.circle
//                                     ),
//                                   );
//                                 }),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(top: 20, left: 15),
//                         child: InkWell(
//                           radius: 80,
//                           borderRadius: BorderRadius.circular(30),
//                           onTap: () {
//                             if (widget.type == "Notification") {
//                               setState(() {
//                                 tabCheck = "";
//                                 pageIndex = 0;
//                                 isTabExplore = false;
//                               });
//
//                               CustomNavigators.pushRemoveUntil(
//                                   DashBoardView(pageIndex: 0), context);
//                             } else {
//                               Navigator.pop(context);
//                             }
//                           },
//                           child: CircleAvatar(
//                             backgroundColor: Colors.white,
//                             radius: 20,
//                             child: Padding(
//                               padding: const EdgeInsets.only(left: 8),
//                               child: Icon(
//                                 Icons.arrow_back_ios,
//                                 color: Colors.black,
//                                 size: 20,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//
//
//                      Padding(
//                         padding: const EdgeInsets.only(top: 20, right: 15),
//                         child: InkWell(
//                           radius: 80,
//                           borderRadius: BorderRadius.circular(30),
//                           onTap: () {
//                             CustomNavigators.pushNavigate(
//                                 AddYourStoriesView(onCallback: () {
//                                   getStoriesDetail();
//                                 },
//                                   onCallScreen: true,
//                                   storyid: storyModel.id.toString(),
//                                   storyvideolink: storyModel.videolink,),
//                                 context);
//                           },
//                           child: CircleAvatar(
//                             backgroundColor: MyColor.purple,
//                             radius: 20,
//                             child: Padding(
//                               padding: const EdgeInsets.only(left: 1),
//                               child: Icon(
//                                 Icons.edit,
//                                 color: Colors.white,
//                                 size: 20,
//                               ),
//                             ),
//                           ),
//                         ),
//                       )
//                     ],
//                   )
//                 ],
//               ),
//
//               hsized15,
//               Padding(
//                 padding: const EdgeInsets.only(left: 15.0, top: 10),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                         widget.model.title ?? "",
//                         style: mediumTextStyle(
//                             fontSize: 20.0, color: MyColor.black)
//                     ),
//
//                     hsized15,
//                     Text(
//                         widget.model.description ?? "",
//                         style: regularNormalTextStyle(
//                             fontSize: 15.0, color: MyColor.black)
//                     ),
//
//                   ],
//                 ),
//               ),
//               hsized20,
//               storyModel.videolink != "" && isVideoError == true ? Container(
//
//                 margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
//                 padding: EdgeInsets.only(
//                     right: 13, left: 13, top: 5, bottom: 8),
//                 width: size.width * 0.95,
//                 height: size.height * 0.30,
//                 // color: Colors.amber,
//                 child:
//                 _buildVideoPlayer(0),) : Container(),
//               hsized30
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: InkWell(
//         onTap: () {
//           setState(() {
//             tabCheck = "";
//           });
//           AllDialogs.globalBottomSheet(
//               context, ShareStoryView(storyId: widget.model.id ?? "",), () {});
//         },
//         child: Container(
//           height: Platform.isAndroid ? 70 : 80,
//           width: double.infinity,
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//               color: MyColor.appTheme
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.share_outlined, color: Colors.white,),
//               SizedBox(width: 12,),
//               Text("Share",
//                 style: mediumTextStyle(fontSize: 18.0, color: MyColor.white),),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> getStoriesDetail() async {
//     try {
//       await ApiServices.getStoryDetail(
//           context, true, widget.model.id.toString()).then((onValue) {
//         if (mounted && onValue.status == true) {
//           setState(() {
//             if (onValue.data != null) {
//               storyModel = StoryModel.fromJson(onValue.data);
//               widget.model = storyModel;
//               storyModel.videolink != "" ? _initializeController(
//                   storyModel.videolink.toString()) : null;
//               setStoryImage();
//             }
//           });
//         }
//       });
//     } catch (e) {
//       debugPrint('Error fetching stories: $e');
//     }
//   }
//
//   void setStoryImage() {
//     if (mounted) {
//       setState(() {
//         storyImagesList.clear();
//         if (widget.model.image != null) {
//           storyImageModel = StoryImages(id: "0",
//               storyId: widget.model.id,
//               images: widget.model.image,
//               createdAt: widget.model.createdAt,
//               updatedAt: widget.model.updatedAt);
//           storyImagesList.add(storyImageModel);
//         }
//         if (widget.model.storyImages != null) {
//           //storyImageModel = StoryImages.fromJson(json)
//           storyImagesList.addAll(widget.model.storyImages!);
//         }
//       });
//     }
//   }
//
//   VideoPlayerController? _controller;
//
//   Widget _buildVideoPlayer(int index) {
//     final data = MediaQuery.of(context);
//     final double width = data.size.width;
//     final double height = data.size.height;
//     final double aspectRatio = width / height;
//
//     return InkWell(
//       onTap: () {
//         print("object");
//         // _controller!.value.isPlaying
//         //     ? _controller!.pause()
//         //     :
//         // _controller!.play();
//         print("_controller>>>>>>>>>>>${_controller!.value.isPlaying}");
//       },
//       child: Container(
//         // color: Colors.red,
//         child: AspectRatio(
//           aspectRatio: _controller!.value.aspectRatio,
//           child: Stack(
//             alignment: Alignment.bottomCenter,
//             children: <Widget>[
//               VideoPlayer(_controller!),
//               ClosedCaption(text: _controller!.value.caption.text),
//               _ControlsOverlay(controller: _controller!),
//               VideoProgressIndicator(
//                 _controller!,
//                 colors: VideoProgressColors(
//                   playedColor: MyColor.color1C1C1C,
//                   bufferedColor: Colors.white,
//                   backgroundColor: Colors.white,
//                 ),
//                 allowScrubbing: true,
//               ),
//             ],
//           ),
//         ),
//         // child: AspectRatio(
//         //   aspectRatio: _controller!.value.aspectRatio,
//         //   child: VideoPlayer(_controller!),
//         // )
//         // : Container(child: Text("data"),),
//       ),
//     );
//   }
//
// }
// class _ControlsOverlay extends StatefulWidget {
//   const _ControlsOverlay({required this.controller});
//
//   static const List<Duration> _exampleCaptionOffsets = <Duration>[
//     Duration(seconds: -10),
//     Duration(seconds: -3),
//     Duration(seconds: -1, milliseconds: -500),
//     Duration(milliseconds: -250),
//     Duration.zero,
//     Duration(milliseconds: 250),
//     Duration(seconds: 1, milliseconds: 500),
//     Duration(seconds: 3),
//     Duration(seconds: 10),
//   ];
//   static const List<double> _examplePlaybackRates = <double>[
//     0.25,
//     0.5,
//     1.0,
//     1.5,
//     2.0,
//     3.0,
//     5.0,
//     10.0,
//   ];
//
//   final VideoPlayerController controller;
//
//   @override
//   State<_ControlsOverlay> createState() => _ControlsOverlayState();
// }
//
// class _ControlsOverlayState extends State<_ControlsOverlay> {
//   bool isMuted = false;
//
//   // @override
//   // void dispose() {
//   //   widget.controller.pause();
//   //   super.dispose();
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         AnimatedSwitcher(
//           duration: const Duration(milliseconds: 50),
//           reverseDuration: const Duration(milliseconds: 200),
//           child: widget.controller.value.isPlaying
//               ? const SizedBox.shrink()
//               : Container(
//             color: Colors.black26,
//             child: const Center(
//               child: Icon(
//                 Icons.play_arrow,
//                 color: Colors.white,
//                 size: 100.0,
//                 semanticLabel: 'Play',
//               ),
//             ),
//           ),
//         ),
//         GestureDetector(
//           onTap: () {
//             widget.controller.value.isPlaying
//                 ? widget.controller.pause()
//                 : widget.controller.play();
//             setState(() {});
//           },
//         ),
//         Align(
//           alignment: Alignment.topLeft,
//           child: PopupMenuButton<Duration>(
//             initialValue: widget.controller.value.captionOffset,
//             tooltip: 'Caption Offset',
//             onSelected: (Duration delay) {
//               widget.controller.setCaptionOffset(delay);
//             },
//             itemBuilder: (BuildContext context) {
//               return <PopupMenuItem<Duration>>[
//                 for (final Duration offsetDuration
//                 in _ControlsOverlay._exampleCaptionOffsets)
//                   PopupMenuItem<Duration>(
//                     value: offsetDuration,
//                     child: Text(
//                       '${offsetDuration.inMilliseconds}ms',
//                       style: const TextStyle(
//                         color: Colors.transparent,
//                       ),
//                     ),
//                   )
//               ];
//             },
//             child: Padding(
//               padding: const EdgeInsets.symmetric(
//                 // Using less vertical padding as the text is also longer
//                 // horizontally, so it feels like it would need more spacing
//                 // horizontally (matching the aspect ratio of the video).
//                 vertical: 12,
//                 horizontal: 16,
//               ),
//               child: Text(
//                 '${widget.controller.value.captionOffset.inMilliseconds}ms',
//                 style: const TextStyle(
//                   color: Colors.transparent,
//                 ),
//               ),
//             ),
//           ),
//         ),
//         Align(
//           alignment: Alignment.topRight,
//           child: Visibility(
//             visible: false,
//             child: PopupMenuButton<double>(
//               initialValue: widget.controller.value.playbackSpeed,
//               tooltip: 'Playback speed',
//               onSelected: (double speed) {
//                 widget.controller.setPlaybackSpeed(speed);
//               },
//               itemBuilder: (BuildContext context) {
//                 return <PopupMenuItem<double>>[
//                   for (final double speed
//                   in _ControlsOverlay._examplePlaybackRates)
//                     PopupMenuItem<double>(
//                       value: speed,
//                       child: Text('${speed}x'),
//                     )
//                 ];
//               },
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(
//                   // Using less vertical padding as the text is also longer
//                   // horizontally, so it feels like it would need more spacing
//                   // horizontally (matching the aspect ratio of the video).
//                   vertical: 12,
//                   horizontal: 16,
//                 ),
//                 child: Text('${widget.controller.value.playbackSpeed}x'),
//               ),
//             ),
//           ),
//         ),
//         Align(
//           alignment: Alignment.bottomRight,
//           child: Padding(
//             padding: const EdgeInsets.fromLTRB(0, 10, 10, 15),
//             child: CircleAvatar(
//               backgroundColor: MyColor.black.withOpacity(0.2),
//               child: IconButton(
//                   onPressed: () {
//                     debugPrint(isMuted.toString());
//                     if (isMuted) {
//                       widget.controller.setVolume(1);
//                     } else {
//                       widget.controller.setVolume(0);
//                     }
//                     isMuted = !isMuted;
//                     setState(() {});
//                   },
//                   icon: Visibility(
//                     visible: isMuted,
//                     replacement: const Icon(
//                       Icons.volume_up,
//                       color: Colors.white,
//                     ),
//                     child: const Icon(
//                       Icons.volume_off,
//                       color: Colors.white,
//                     ),
//                   )),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }


import 'dart:io';
import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/my_fonts_style.dart';
import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/model/dynamic_models/my_story_model.dart';
import 'package:cooking_champs/services/api_path.dart';
import 'package:cooking_champs/services/api_services.dart';
import 'package:cooking_champs/utils/all_dialogs.dart';
import 'package:cooking_champs/utils/navigators.dart';
import 'package:cooking_champs/utils/ui_utils.dart';
import 'package:cooking_champs/views/dashboard.dart';
import 'package:cooking_champs/views/story/share_story_view.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'add_your_stories_view.dart';

class StoriesDetailsView extends StatefulWidget {
  StoryModel model;
  String type;
  StoriesDetailsView({super.key, required this.model, required this.type});

  @override
  State<StoriesDetailsView> createState() => _StoriesDetailsViewState();
}

class _StoriesDetailsViewState extends State<StoriesDetailsView> {
  List<StoryImages> storyImagesList = [];
  StoryImages storyImageModel = StoryImages();
  StoryModel storyModel = StoryModel();
  int currentIndex = 0;

  @override
  void initState() {
    setStoryImage();
    Future.delayed(Duration.zero, getStoriesDetail);
    super.initState();
  }

  @override
  void dispose() {
    storyModel.videolink != "" ? _controller!.pause() : null;
    super.dispose();
  }

  bool _mounted = false;
  bool isVideoError = false;

  void _initializeController(String link) async {
    // Dispose previous controller if it exists
    if (_controller != null) {
      await _controller!.dispose();
      _controller = null; // Ensure it's fully reset
    }

    // Set loading state
    setState(() {
      isVideoError = true; // Reset error flag
    });

    try {
      // Create new video player controller
      _controller = VideoPlayerController.networkUrl(
        Uri.parse(link),
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      );

      // Try to initialize the controller
      await _controller!.initialize();

      // Start playing after initialization
      _controller!.pause();

      if (_mounted) {
        setState(() {
          isVideoError = false; // No error, video loaded successfully
        });
      }

      _controller!.addListener(() {
        if (_mounted) {
          setState(() {});
        }
      });
    } catch (e) {
      print("Error initializing video controller: $e");

      if (_mounted) {
        setState(() {
          isVideoError = true; // Flag to show error UI
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final bool isIpad = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Visibility(
                    visible: storyImagesList.isNotEmpty,
                    child: SizedBox(
                      width: size.width,
                      height: isIpad ? size.height * 0.45 : size.height * 0.35,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          PageView.builder(
                              itemCount: storyImagesList.length,
                              onPageChanged: (v) {
                                if (mounted) {
                                  setState(() {
                                    currentIndex = v;
                                  });
                                }
                              },
                              itemBuilder: (context, int index) {
                                return Container(
                                  width: size.width,
                                  height: isIpad
                                      ? size.height * 0.45
                                      : size.height * 0.35,
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(
                                          isIpad ? 30 : 20),
                                      bottomLeft: Radius.circular(
                                          isIpad ? 30 : 20),
                                    ),
                                  ),
                                  child: UiUtils.networkImages(
                                    double.infinity,
                                    isIpad ? size.height * 0.45 : size.height * 0.35,
                                    storyImagesList[index].images != null
                                        ? ApiPath.imageBaseUrl +
                                        storyImagesList[index].images
                                            .toString()
                                        : "",
                                  ),
                                );
                              }),
                          Container(
                            padding: EdgeInsets.only(
                                bottom: isIpad ? 30 : 20),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                    storyImagesList.length, (index) {
                                  return Container(
                                    margin: EdgeInsets.only(
                                        right: isIpad ? 10 : 5),
                                    height: isIpad ? 10 : 8,
                                    width: currentIndex == index
                                        ? (isIpad ? 25 : 18)
                                        : (isIpad ? 10 : 8),
                                    decoration: BoxDecoration(
                                      color: currentIndex == index
                                          ? MyColor.blue1
                                          : MyColor.liteGray,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: isIpad ? 30 : 20,
                            left: isIpad ? 25 : 15),
                        child: InkWell(
                          radius: 80,
                          borderRadius: BorderRadius.circular(30),
                          onTap: () {
                            if (widget.type == "Notification") {
                              setState(() {
                                tabCheck = "";
                                pageIndex = 0;
                                isTabExplore = false;
                              });
                              CustomNavigators.pushRemoveUntil(
                                  DashBoardView(pageIndex: 0), context);
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: isIpad ? 28 : 20,
                            child: Padding(
                              padding: EdgeInsets.only(left: isIpad ? 10 : 8),
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.black,
                                size: isIpad ? 28 : 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: isIpad ? 30 : 20,
                            right: isIpad ? 25 : 15),
                        child: InkWell(
                          radius: 80,
                          borderRadius: BorderRadius.circular(30),
                          onTap: () {
                            CustomNavigators.pushNavigate(
                              AddYourStoriesView(
                                onCallback: () {
                                  getStoriesDetail();
                                },
                                onCallScreen: true,
                                storyid: storyModel.id.toString(),
                                storyvideolink: storyModel.videolink,
                              ),
                              context,
                            );
                          },
                          child: CircleAvatar(
                            backgroundColor: MyColor.purple,
                            radius: isIpad ? 28 : 20,
                            child: Padding(
                              padding: EdgeInsets.only(left: 1),
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: isIpad ? 28 : 20,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
              hsized15,
              Padding(
                padding: EdgeInsets.only(
                    left: isIpad ? 30 : 15.0,
                    right: isIpad ? 30 : 15.0,
                    top: isIpad ? 20 : 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.model.title ?? "",
                      style: mediumTextStyle(
                        fontSize: isIpad ? 32.0 : 20.0,
                        color: MyColor.black,
                      ),
                    ),
                    SizedBox(height: isIpad ? 25 : 15),
                    Text(
                      widget.model.description ?? "",
                      style: regularNormalTextStyle(
                        fontSize: isIpad ? 22.0 : 15.0,
                        color: MyColor.black,
                      ),
                    ),
                  ],
                ),
              ),
              hsized20,
              storyModel.videolink != "" && isVideoError == true
                  ? Container(
                margin: EdgeInsets.only(
                    left: isIpad ? 30 : 10,
                    right: isIpad ? 30 : 10,
                    bottom: 20),
                padding: EdgeInsets.only(
                    right: 13, left: 13, top: 5, bottom: 8),
                width: size.width * 0.95,
                height: isIpad ? size.height * 0.40 : size.height * 0.30,
                child: _buildVideoPlayer(0),
              )
                  : Container(),
              hsized30,
            ],
          ),
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          setState(() {
            tabCheck = "";
          });
          AllDialogs.globalBottomSheet(
            context,
            ShareStoryView(storyId: widget.model.id ?? ""),
                () {},
          );
        },
        child: Container(
          height: Platform.isAndroid
              ? (isIpad ? 90 : 70)
              : (isIpad ? 100 : 80),
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: MyColor.appTheme),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.share_outlined,
                color: Colors.white,
                size: isIpad ? 32 : 24,
              ),
              SizedBox(width: isIpad ? 18 : 12),
              Text(
                "Share",
                style: mediumTextStyle(
                  fontSize: isIpad ? 26.0 : 18.0,
                  color: MyColor.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getStoriesDetail() async {
    try {
      await ApiServices.getStoryDetail(
          context, true, widget.model.id.toString())
          .then((onValue) {
        if (mounted && onValue.status == true) {
          setState(() {
            if (onValue.data != null) {
              storyModel = StoryModel.fromJson(onValue.data);
              widget.model = storyModel;
              storyModel.videolink != ""
                  ? _initializeController(storyModel.videolink.toString())
                  : null;
              setStoryImage();
            }
          });
        }
      });
    } catch (e) {
      debugPrint('Error fetching stories: $e');
    }
  }

  void setStoryImage() {
    if (mounted) {
      setState(() {
        storyImagesList.clear();
        if (widget.model.image != null) {
          storyImageModel = StoryImages(
              id: "0",
              storyId: widget.model.id,
              images: widget.model.image,
              createdAt: widget.model.createdAt,
              updatedAt: widget.model.updatedAt);
          storyImagesList.add(storyImageModel);
        }
        if (widget.model.storyImages != null) {
          storyImagesList.addAll(widget.model.storyImages!);
        }
      });
    }
  }

  VideoPlayerController? _controller;

  Widget _buildVideoPlayer(int index) {
    final data = MediaQuery.of(context);
    final bool isIpad = data.size.width > 600;
    final double width = data.size.width;
    final double height = data.size.height;

    return InkWell(
      onTap: () {
        print("object");
        print("_controller>>>>>>>>>>>${_controller!.value.isPlaying}");
      },
      child: Container(
        child: AspectRatio(
          aspectRatio: _controller!.value.aspectRatio,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              VideoPlayer(_controller!),
              ClosedCaption(text: _controller!.value.caption.text),
              _ControlsOverlay(controller: _controller!),
              VideoProgressIndicator(
                _controller!,
                colors: VideoProgressColors(
                  playedColor: MyColor.color1C1C1C,
                  bufferedColor: Colors.white,
                  backgroundColor: Colors.white,
                ),
                allowScrubbing: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ControlsOverlay extends StatefulWidget {
  const _ControlsOverlay({required this.controller});

  static const List<Duration> _exampleCaptionOffsets = <Duration>[
    Duration(seconds: -10),
    Duration(seconds: -3),
    Duration(seconds: -1, milliseconds: -500),
    Duration(milliseconds: -250),
    Duration.zero,
    Duration(milliseconds: 250),
    Duration(seconds: 1, milliseconds: 500),
    Duration(seconds: 3),
    Duration(seconds: 10),
  ];
  static const List<double> _examplePlaybackRates = <double>[
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
    3.0,
    5.0,
    10.0,
  ];

  final VideoPlayerController controller;

  @override
  State<_ControlsOverlay> createState() => _ControlsOverlayState();
}

class _ControlsOverlayState extends State<_ControlsOverlay> {
  bool isMuted = false;

  @override
  Widget build(BuildContext context) {
    final bool isIpad = MediaQuery.of(context).size.width > 600;

    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: widget.controller.value.isPlaying
              ? const SizedBox.shrink()
              : Container(
            color: Colors.black26,
            child: Center(
              child: Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: isIpad ? 140.0 : 100.0,
                semanticLabel: 'Play',
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            widget.controller.value.isPlaying
                ? widget.controller.pause()
                : widget.controller.play();
            setState(() {});
          },
        ),
        Align(
          alignment: Alignment.topLeft,
          child: PopupMenuButton<Duration>(
            initialValue: widget.controller.value.captionOffset,
            tooltip: 'Caption Offset',
            onSelected: (Duration delay) {
              widget.controller.setCaptionOffset(delay);
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<Duration>>[
                for (final Duration offsetDuration
                in _ControlsOverlay._exampleCaptionOffsets)
                  PopupMenuItem<Duration>(
                    value: offsetDuration,
                    child: Text(
                      '${offsetDuration.inMilliseconds}ms',
                      style: const TextStyle(
                        color: Colors.transparent,
                      ),
                    ),
                  )
              ];
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: isIpad ? 16 : 12,
                horizontal: isIpad ? 20 : 16,
              ),
              child: Text(
                '${widget.controller.value.captionOffset.inMilliseconds}ms',
                style: const TextStyle(
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Visibility(
            visible: false,
            child: PopupMenuButton<double>(
              initialValue: widget.controller.value.playbackSpeed,
              tooltip: 'Playback speed',
              onSelected: (double speed) {
                widget.controller.setPlaybackSpeed(speed);
              },
              itemBuilder: (BuildContext context) {
                return <PopupMenuItem<double>>[
                  for (final double speed
                  in _ControlsOverlay._examplePlaybackRates)
                    PopupMenuItem<double>(
                      value: speed,
                      child: Text('${speed}x'),
                    )
                ];
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: isIpad ? 16 : 12,
                  horizontal: isIpad ? 20 : 16,
                ),
                child: Text('${widget.controller.value.playbackSpeed}x'),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 10, isIpad ? 15 : 10, isIpad ? 20 : 15),
            child: CircleAvatar(
              backgroundColor: MyColor.black.withOpacity(0.2),
              radius: isIpad ? 28 : 22,
              child: IconButton(
                iconSize: isIpad ? 28 : 22,
                onPressed: () {
                  debugPrint(isMuted.toString());
                  if (isMuted) {
                    widget.controller.setVolume(1);
                  } else {
                    widget.controller.setVolume(0);
                  }
                  isMuted = !isMuted;
                  setState(() {});
                },
                icon: Visibility(
                  visible: isMuted,
                  replacement: Icon(
                    Icons.volume_up,
                    color: Colors.white,
                    size: isIpad ? 28 : 22,
                  ),
                  child: Icon(
                    Icons.volume_off,
                    color: Colors.white,
                    size: isIpad ? 28 : 22,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
