import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../utils/screen_size.dart';

class VidioPlay extends StatefulWidget {
  const VidioPlay({Key? key, required this.lessonplay}) : super(key: key);
  final String lessonplay;

  @override
  State<VidioPlay> createState() => _VidioPlayState();
}

class _VidioPlayState extends State<VidioPlay> {
  late FlickManager flickManager;

  @override
  void initState() {
    super.initState();
    print(widget.lessonplay);
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.networkUrl(Uri.parse("${widget.lessonplay}")),
      autoPlay: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 26.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Image(
                    image: AssetImage("assets/back_arrow.png"),
                    height: 24,
                    width: 24,
                  )),
            ),
            SizedBox(height: 95.h),
            Center(
                child: Container(
                    height: 345.h,
                    child: FlickVideoPlayer(
                      flickManager: flickManager,
                    )))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }
}
