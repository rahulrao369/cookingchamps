import 'package:cooking_champs/new_ui/video_scroll_screen.dart';
import 'package:cooking_champs/utils/navigators.dart';
import 'package:flutter/material.dart';

import '../constant/app_state.dart';
import '../constant/my_color.dart';
import '../constant/sized_box.dart';
import '../model/dynamic_models/school_video_model.dart';

class VideoProfileScreen extends StatefulWidget {
  const VideoProfileScreen({super.key});

  @override
  State<VideoProfileScreen> createState() => _VideoProfileScreenState();
}

class _VideoProfileScreenState extends State<VideoProfileScreen> { List<String> demoVideoList = [
  "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
  "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",

  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4",

  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/SubaruOutbackOnStreetAndDirt.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/VolkswagenGTIReview.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WhatCarCanYouGetForAGrand.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4",
];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 50,
        automaticallyImplyLeading: false,
        backgroundColor: MyColor.yellowF6F1E1,
        surfaceTintColor: MyColor.yellowF6F1E1,
        leading: InkWell(
          borderRadius: BorderRadius.circular(30),
          radius: 80,
          onTap: () {
            Navigator.pop(context);
            //  widget.onCallBack();
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: const Icon(
              Icons.arrow_back_ios,
              size: 28,
              color: Colors.black,
            ),
          ),
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(15, 10, 15, 15),        child: Column(
          children: [
            Container(
              height: 127,
              width: 129,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: Image.asset(
                "assets/images/demoschoolImg.png",
                fit: BoxFit.fill,
              ),
            ),
            hsized8,
            Text(
              "Catherine Cooking School",
              style: TextStyle(
                  color: MyColor.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w700),
            ),
            hsized8,
            Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: MyColor.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
            hsized25,
            Expanded(
              child: GridView.builder(
              physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: demoVideoList.length,padding: EdgeInsets.zero,
                gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,mainAxisSpacing: 5,crossAxisSpacing: 5,  childAspectRatio: 1),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(onTap: () {
                    final List<SchoolVideo> videos = demoVideoList.map((url) {
                      return SchoolVideo(
                        url: url,
                        title: "Demo Video",
                        description: "Demo video description",
                      );
                    }).toList();

                    CustomNavigators.pushNavigate(
                      VideoScrollScreen(
                        videos: videos,
                        initialIndex: index,
                      ),
                      context,
                    );
                  },
                    child: Container(
                    //  clipBehavior: Clip.antiAlias,
                    //   width: (AppState.devicetype == "ipad") ? 400 : 112,
                      //height: 160,

                      child: Stack(  fit: StackFit.expand,
                          children: [
                        Image.asset(
                          "assets/images/demoschoolImg.png",
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          left: 5,
                          bottom: 5,
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: MyColor.appTheme,
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                                height: 15,
                                width: 18,
                                "assets/images/videoPlayIcon.png"),
                          ),
                        ),
                      ]),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
