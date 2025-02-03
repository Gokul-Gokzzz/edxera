// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:edxera/My_cources/lesson_play.dart';
import 'package:edxera/batchs/BatchDetailsScreen/Modules/youtube_video_player.dart';
import 'package:edxera/home/Models/study_matrial_video_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

import '../../../repositories/api/api_constants.dart';

class VideoListScreen extends StatefulWidget {
  String subjectVideoName;
  List<SubChapterFiles>? subChapterFiles;
  List<OtherFiles>? otherFiles;

  VideoListScreen({super.key, required this.subjectVideoName, this.otherFiles, this.subChapterFiles});

  @override
  State<VideoListScreen> createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        // leading: GestureDetector(
        //   onTap: () {
        //     Get.back();
        //   },
        //   child: Image(
        //     image: AssetImage("assets/back_arrow.png"),
        //     height: 22.h,
        //     width: 22.w,
        //   ),
        // ),
        titleSpacing: 0,
        leading: const BackButton(
          color: Colors.black, // <-- SEE HERE
        ),
        centerTitle: false,
        title: Text(
          "${widget.subjectVideoName}",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.sp, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            search_text_field(),
            SizedBox(height: 20.h),
            widget.otherFiles?.length != 0
                ? ListView.builder(
                    itemCount: widget.otherFiles?.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  VidioPlay(lessonplay: '${ApiConstants.publicBaseUrl}/${widget.otherFiles?[index].otherFilesVideos ?? ''}'),
                            ),
                          );
                          print('${ApiConstants.publicBaseUrl}/${widget.otherFiles?[index].otherFilesVideos ?? ''}');
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 7.5.w, top: 7.5.w),
                          width: double.infinity.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.h),
                              boxShadow: [
                                BoxShadow(color: const Color(0XFF503494).withOpacity(0.14), offset: const Offset(-4, 5), blurRadius: 16.h),
                              ],
                              color: Colors.white),
                          child: Container(
                            margin: EdgeInsets.all(10.w),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.h), color: Colors.grey.withOpacity(0.2)),

                                  height: 80.h,
                                  width: 100.h,
                                  // width: 100.0,
                                  // height: 56.0,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: VideoPlayer(VideoPlayerController.networkUrl(
                                        Uri.parse('${ApiConstants.publicBaseUrl}/${widget.otherFiles?[index].otherFilesVideos ?? ''}'))
                                      ..initialize().then((_) {
                                        // setState(() {}); //when your thumbnail will show.
                                      })),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  '${index + 1}. ${widget.otherFiles?[index].otherFilesNotes ?? ''}',
                                  style: TextStyle(color: Color(0XFF503494), fontSize: 15.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : Container(),
            widget.subChapterFiles?.length != 0
                ? ListView.builder(
                    itemCount: widget.subChapterFiles?.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      print('---->${ApiConstants.publicBaseUrl}/${widget.subChapterFiles?[index].subChaptersImage ?? ''}');
                      if (widget.subChapterFiles?[index].subChapterYoutubeLink != null &&
                          widget.subChapterFiles![index].subChapterYoutubeLink!.isNotEmpty) {
                        return InkWell(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => VidioPlay(
                            //       lessonplay: '${ApiConstants.publicBaseUrl}/${widget.subChapterFiles?[index].subChaptersVideos ?? ''}',
                            //     ),
                            //   ),
                            // );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => YoutubeVideoPlayerScreen(
                                  url: '${widget.subChapterFiles?[index].subChapterYoutubeLink ?? ''}',
                                ),
                              ),
                            );
                            print('++++++++');
                            print('${ApiConstants.publicBaseUrl}/${widget.subChapterFiles?[index].subChapterYoutubeLink ?? ''}');
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 7.5.w, top: 7.5.w),
                            width: double.infinity.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.h),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0XFF503494).withOpacity(0.14),
                                    offset: const Offset(-4, 5),
                                    blurRadius: 16.h,
                                  ),
                                ],
                                color: Colors.white),
                            child: Container(
                              margin: EdgeInsets.all(10.w),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.h),
                                      color: Colors.grey.withOpacity(0.2),
                                    ),

                                    height: 80.h,
                                    width: 100.h,
                                    // width: 100.0,
                                    // height: 56.0,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: CachedNetworkImage(
                                        imageUrl: '${ApiConstants.publicBaseUrl}/${widget.subChapterFiles?[index].subChaptersImage ?? ''}',
                                        errorWidget: (context, url, error) => SizedBox(),
                                      ),

                                      // child: VideoPlayer(VideoPlayerController.networkUrl(
                                      //     Uri.parse('${ApiConstants.publicBaseUrl}/${widget.subChapterFiles?[index].subChaptersVideos ?? ''}'))
                                      //   ..initialize().then((_) {
                                      //     //when your thumbnail will show.
                                      //   })),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Text(
                                    '${index + 1}. ${widget.subChapterFiles?[index].subChaptersNotes ?? ''}',
                                    style: TextStyle(color: Color(0XFF503494), fontSize: 15.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  Widget search_text_field() {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w),
      child: Container(
        height: 50,
        child: TextFormField(
            decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0XFF503494), width: 1.w), borderRadius: BorderRadius.circular(22)),
          hintText: 'Search',
          hintStyle: TextStyle(color: Color(0XFF9B9B9B), fontSize: 15.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.w400),
          prefixIcon: const Image(
            image: AssetImage('assets/search.png'),
            height: 24,
            width: 24,
          ),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(22.h), borderSide: BorderSide(color: Color(0XFFDEDEDE), width: 1.h)),
        )),
      ),
    );
  }
}
