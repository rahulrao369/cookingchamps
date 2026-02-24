import 'dart:ui';

import 'package:cooking_champs/constant/sized_box.dart';
import 'package:cooking_champs/new_ui/video_profile_screen.dart';
import 'package:cooking_champs/utils/navigators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../constant/my_color.dart';

// class VideoScrollScreen extends StatefulWidget {
//   final List<String> videos;
//   final int initialIndex;
//
//   const VideoScrollScreen({
//     super.key,
//     required this.videos,
//     required this.initialIndex,
//   });
//
//   @override
//   State<VideoScrollScreen> createState() => _VideoScrollScreenState();
// }
//
// class _VideoScrollScreenState extends State<VideoScrollScreen> {
//   // PageController? _pageController;
//   //
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   _pageController = PageController(initialPage: widget.initialIndex);
//   // }
//   //
//   // @override
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //     body: PageView.builder(
//   //       controller: _pageController,
//   //       allowImplicitScrolling: true,
//   //       scrollDirection: Axis.vertical,
//   //       itemCount: widget.videos.length,
//   //       itemBuilder: (context, index) {
//   //         return ReelVideoPlayer(videoUrl: widget.videos[index]);
//   //       },
//   //     ),
//   //   );
//   // }
//
//   late PageController _pageController;
//
//   @override
//   void initState() {
//     super.initState();
//
//     debugPrint("📽 VideoScrollScreen init");
//     debugPrint("➡ Initial index => ${widget.initialIndex}");
//     debugPrint("➡ Total videos => ${widget.videos.length}");
//
//     for (int i = 0; i < widget.videos.length; i++) {
//       debugPrint("🎬 Video[$i] => ${widget.videos[i]}");
//     }
//
//     _pageController = PageController(initialPage: widget.initialIndex);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: PageView.builder(
//         controller: _pageController,
//         scrollDirection: Axis.vertical,
//         itemCount: widget.videos.length,
//         onPageChanged: (index) {
//           debugPrint("📄 Page changed => $index");
//         },
//         itemBuilder: (context, index) {
//           return ReelVideoPlayer(
//             key: ValueKey(widget.videos[index]),
//             videoUrl: widget.videos[index],
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../model/dynamic_models/school_video_model.dart';

class VideoScrollScreen extends StatefulWidget {
  final List<SchoolVideo> videos;
  final int initialIndex;

  const VideoScrollScreen({
    super.key,
    required this.videos,
    required this.initialIndex,
  });

  @override
  State<VideoScrollScreen> createState() => _VideoScrollScreenState();
}

class _VideoScrollScreenState extends State<VideoScrollScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: widget.videos.length,
        itemBuilder: (context, index) {
          final video = widget.videos[index];

          return Stack(
            fit: StackFit.expand,
            children: [
              ReelVideoPlayer(videoUrl: video.url),

              /// Back button
              Positioned(
                top: MediaQuery.of(context).padding.top + 10,
                left: 10,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.grey),
                  onPressed: () => Navigator.pop(context),
                ),
              ),

              /// Title & Description
              Positioned(
                left: 16,
                right: 16,
                bottom: 30,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      video.title,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      video.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}


// class ReelVideoPlayer extends StatefulWidget {
//   final String videoUrl;
//
//   const ReelVideoPlayer({super.key, required this.videoUrl});
//
//   @override
//   State<ReelVideoPlayer> createState() => _ReelVideoPlayerState();
// }
//
// class _ReelVideoPlayerState extends State<ReelVideoPlayer> {
//   late VideoPlayerController _controller;
//   bool _isInitialized = false;
//
//   @override
//   void initState() {
//     super.initState();
//
//     debugPrint("🧩 ReelVideoPlayer init");
//     debugPrint("🎯 Video URL received => ${widget.videoUrl}");
//
//     _initVideo();
//   }
//
//   Future<void> _initVideo() async {
//     debugPrint("🚀 Initializing video...");
//     debugPrint("🌐 Video URL => ${widget.videoUrl}");
//
//     try {
//       _controller = VideoPlayerController.networkUrl(
//         Uri.parse(widget.videoUrl),
//       );
//
//       debugPrint("⏳ Calling initialize()...");
//       await _controller!.initialize();
//
//       debugPrint("✅ Video initialized");
//       debugPrint("📐 Video size => ${_controller!.value.size}");
//       debugPrint("▶️ Auto play video");
//
//       await _controller!.setLooping(true);
//       await _controller!.play();
//
//       if (mounted) {
//         setState(() {
//           _isInitialized = true;
//         });
//       }
//     } catch (e) {
//       debugPrint("❌ VIDEO INIT ERROR => $e");
//     }
//   }
//
//
//   @override
//   void dispose() {
//     debugPrint("🛑 Disposing video: ${widget.videoUrl}");
//     _controller.pause();
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (!_isInitialized) {
//       return const Center(
//         child: CircularProgressIndicator(),
//       );
//     }
//
//     return GestureDetector(
//       onTap: () {
//         if (_controller.value.isPlaying) {
//           debugPrint("⏸ Pause");
//           _controller.pause();
//         } else {
//           debugPrint("▶️ Play");
//           _controller.play();
//         }
//       },
//       child: Stack(
//         fit: StackFit.expand,
//         children: [
//           FittedBox(
//             fit: BoxFit.cover,
//             child: SizedBox(
//               width: _controller.value.size.width,
//               height: _controller.value.size.height,
//               child: VideoPlayer(_controller),
//             ),
//           ),
//
//           // Back button
//           Positioned(
//             top: MediaQuery.of(context).padding.top + 10,
//             left: 10,
//             child: IconButton(
//               icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
//               onPressed: () => Navigator.pop(context),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class ReelVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const ReelVideoPlayer({
    super.key,
    required this.videoUrl,
  });

  @override
  State<ReelVideoPlayer> createState() => _ReelVideoPlayerState();
}

class _ReelVideoPlayerState extends State<ReelVideoPlayer> {
  late VideoPlayerController _controller;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));

    await _controller.initialize();
    await _controller.setLooping(true);
    await _controller.play();

    if (mounted) {
      setState(() {
        _initialized = true;
      });
    }
  }

  @override
  void dispose() {
    _controller.pause();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    return GestureDetector(
      onTap: () {
        _controller.value.isPlaying
            ? _controller.pause()
            : _controller.play();
      },
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: _controller.value.size.width,
          height: _controller.value.size.height,
          child: VideoPlayer(_controller),
        ),
      ),
    );
  }
}


