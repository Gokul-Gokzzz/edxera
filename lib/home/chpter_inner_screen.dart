import 'package:edxera/cources/chapter_files_page.dart';
import 'package:edxera/cources/chapter_notes_page.dart';
import 'package:edxera/cources/chapter_overview_page.dart';
import 'package:edxera/home/Models/chapter_inner_data_model.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../repositories/api/api_constants.dart';
import '../utils/screen_size.dart';

class ChapteInnerScreen extends StatefulWidget {
  final ChapterInnerDataModel chapterInnerDataModel;

  const ChapteInnerScreen({Key? key, required this.chapterInnerDataModel}) : super(key: key);

  @override
  State<ChapteInnerScreen> createState() => _ChapteInnerScreenState();
}

class _ChapteInnerScreenState extends State<ChapteInnerScreen> with TickerProviderStateMixin {
  // CourceController courceController = Get.put(CourceController());
  PageController pageController = PageController();
  int initialvalue = 0;
  late PageController pController;

  bool currentbuttonpos = false;
  YoutubePlayerController? _youtubePlayerController;
  String? videoId;

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _youtubePlayerController!.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _youtubePlayerController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.chapterInnerDataModel.data?.chapter?.video == '') {
      flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.networkUrl(Uri.parse(
          '${ApiConstants.publicBaseUrl}/${widget.chapterInnerDataModel.data?.chapter?.video ?? ''}',
        )),
        autoPlay: false,
      );
    } else {
      videoId = YoutubePlayer.convertUrlToId(widget.chapterInnerDataModel.data?.chapter?.youTubeLink ?? "");
      _youtubePlayerController = YoutubePlayerController(
        initialVideoId: videoId ?? '',
        flags: YoutubePlayerFlags(autoPlay: false, mute: false, showLiveFullscreenButton: true),
      );
    }
    tabController = TabController(length: 3, vsync: this);
    pController = PageController();
    setState(() {});
    super.initState();
  }

  late TabController tabController;

  late FlickManager flickManager;

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          widget.chapterInnerDataModel.data?.chapter?.title ?? '',
          maxLines: 5,
          style: TextStyle(fontFamily: 'Gilroy', fontWeight: FontWeight.w700, fontSize: 20.sp, overflow: TextOverflow.ellipsis),
        ),
      ),
      body: OrientationBuilder(builder: (context, orientation) {
        return SingleChildScrollView(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              widget.chapterInnerDataModel.data != null
                  ? OrientationBuilder(builder: (context, _orientation) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Container(
                          padding: EdgeInsets.all(12.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0XFF503494).withOpacity(0.1),
                                blurRadius: 16,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(22.h),
                          ),
                          child: Container(
                            height: orientation == Orientation.portrait
                                ? MediaQuery.of(context).size.height * 0.3
                                : MediaQuery.of(context).size.height * 0.7,
                            width: MediaQuery.sizeOf(context).width * 0.9,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(22.h)),
                            child: Center(
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(22),
                                  child: widget.chapterInnerDataModel.data?.chapter?.video == ''
                                      ? FlickVideoPlayer(flickManager: flickManager)
                                      : YoutubePlayerBuilder(
                                          player: YoutubePlayer(
                                            controller: _youtubePlayerController!,
                                            showVideoProgressIndicator: true,
                                            progressIndicatorColor: Colors.amber,
                                            progressColors: ProgressBarColors(playedColor: Colors.amber, handleColor: Colors.amberAccent),
                                          ),
                                          builder: (p0, p1) {
                                            return Scaffold(
                                              appBar: AppBar(
                                                shadowColor: Colors.transparent,
                                                backgroundColor: Colors.white,
                                                leading: const BackButton(
                                                  color: Colors.black, // <-- SEE HERE
                                                ),
                                              ),
                                              body: p1,
                                            );
                                          })),
                            ),
                          ),
                        ),
                      );
                    })
                  : Container(),
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: const Color(0XFF503494).withOpacity(0.20),
                      blurRadius: 16,
                    ),
                  ], color: const Color(0XFFFFFFFF), borderRadius: BorderRadius.circular(22)),
                  child: TabBar(
                    unselectedLabelColor: Color(0XFF6E758A),
                    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                    labelStyle: TextStyle(color: const Color(0XFF503494), fontWeight: FontWeight.bold, fontSize: 15.sp, fontFamily: 'Gilroy'),
                    labelColor: const Color(0XFF503494),
                    unselectedLabelStyle:
                        TextStyle(color: const Color(0XFF503494), fontWeight: FontWeight.w700, fontSize: 15.sp, fontFamily: 'Gilroy'),
                    indicator:
                        ShapeDecoration(color: const Color(0XFFE5ECFF), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.h))),
                    controller: tabController,
                    tabs: const [
                      Tab(
                        text: "Overview ",
                      ),
                      Tab(
                        text: "Notes",
                      ),
                      Tab(
                        text: "Files",
                      ),
                    ],
                    onTap: (value) {
                      pController.animateToPage(value, duration: const Duration(milliseconds: 300), curve: Curves.ease);
                    },
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              widget.chapterInnerDataModel.data != null
                  ? SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.4,
                      child: PageView.builder(
                        controller: pController,
                        onPageChanged: (value) {
                          tabController.animateTo(value, duration: const Duration(milliseconds: 300), curve: Curves.ease);
                        },
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return index == 0
                              ? ChapterOverview(courseDetails: widget.chapterInnerDataModel)
                              : index == 1
                                  ? ChapterNotes(courseDetails: widget.chapterInnerDataModel)
                                  : ChapterFiles(courseDetails: widget.chapterInnerDataModel);
                        },
                      ),
                    )
                  : Container(),
            ],
          ),
        );
      }),
    );
  }
}
