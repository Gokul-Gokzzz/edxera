import 'package:edxera/My_cources/lesson_play.dart';
import 'package:edxera/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class TestimonialsWidget extends StatefulWidget {
  const TestimonialsWidget({super.key});

  @override
  State<TestimonialsWidget> createState() => _TestimonialsWidgetState();
}

class _TestimonialsWidgetState extends State<TestimonialsWidget> {
  HomeController homecontroller = Get.put(HomeController());
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // flickManager.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (homecontroller.testimonialDataListDataModel.data?.testimonial?.length ?? 0) > 0
          ? ListView.builder(
              padding: EdgeInsets.only(left: 15.h),
              itemCount: homecontroller.testimonialDataListDataModel.data?.testimonial?.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VidioPlay(
                          lessonplay: homecontroller.testimonialDataListDataModel.data?.testimonial?[index].video ?? '',
                        ),
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.h),
                        ),
                        margin: EdgeInsets.only(right: 10.h),
                        height: 160.h,
                        width: 250.h,
                        // width: 100.0,
                        // height: 56.0,
                        child: (homecontroller.testimonialDataListDataModel.data?.testimonial?[index].video ?? '') == ''
                            ? Container()
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: VideoPlayer(VideoPlayerController.networkUrl(
                                    Uri.parse(homecontroller.testimonialDataListDataModel.data?.testimonial?[index].video ?? ''))
                                  ..initialize()),
                              ),
                      ),
                      Positioned(
                        bottom: 8,
                        left: 8,
                        child: Row(
                          children: [
                            Icon(
                              Icons.play_circle,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              (homecontroller.testimonialDataListDataModel.data?.testimonial?[index].video ?? '').split('/').last,
                              style: TextStyle(fontSize: 18.sp, color: Colors.white, fontWeight: FontWeight.w700, fontFamily: 'Gilroy'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          : Container(),
    );
  }
}
