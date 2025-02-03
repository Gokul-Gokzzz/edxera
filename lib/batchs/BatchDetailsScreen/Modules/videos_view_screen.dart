import 'dart:io';

import 'package:edxera/batchs/BatchDetailsScreen/Modules/sub_chapter_view_screen.dart';
import 'package:edxera/batchs/BatchDetailsScreen/Modules/youtube_video_player.dart';
import 'package:edxera/batchs/controllers/batch_video_controller.dart';
import 'package:edxera/utils/screen_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VideosViewScreen extends StatelessWidget {
  final String batchid;

  VideosViewScreen({super.key, required this.batchid});

  // late PageController pController;

  final _batchVideoController = Get.find<BatchVideoController>();

  // @override
  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return GetBuilder<BatchVideoController>(
        initState: (state) {
          _batchVideoController.batchVideoListApi(batchid, '');
        },
        init: _batchVideoController,
        builder: (controller) {
          return Scaffold(
            body: RefreshIndicator(
              onRefresh: () async {
                await _batchVideoController.batchVideoListApi(batchid, '');
              },
              child: SafeArea(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 20.h),
                        search_text_field(),
                        SizedBox(height: 20.h),
                        (_batchVideoController.batchVideoStudyMatrialDataModel.data?.chapterListForUser ?? []) != []
                            // ? PageView.builder(
                            //   controller: pController,
                            //   physics: NeverScrollableScrollPhysics(),
                            //   itemCount: 1,
                            //   itemBuilder: (context, i) {
                            //     return ;
                            //   },
                            // )
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: _batchVideoController.batchVideoStudyMatrialDataModel.data?.chapterListForUser?.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) => VideoListScreen(
                                        //       subjectVideoName: _batchVideoController
                                        //               .batchVideoStudyMatrialDataModel
                                        //               .data
                                        //               ?.chapterListForUser?[index]
                                        //               .chaptersTitle ??
                                        //           '',
                                        //     ),
                                        //   ),
                                        // );
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => SubChapterViewScreen(
                                                isVideoScreen: true,
                                                data: _batchVideoController.batchVideoStudyMatrialDataModel.data?.chapterListForUser?[index],
                                                subjectVideoName: _batchVideoController
                                                        .batchVideoStudyMatrialDataModel.data?.chapterListForUser?[index].chaptersTitle ??
                                                    ''),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 7.5.w, top: 7.5.w),
                                        width: double.infinity.w,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10.h),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: const Color(0XFF503494).withOpacity(0.14), offset: const Offset(-4, 5), blurRadius: 16.h),
                                            ],
                                            color: Colors.white),
                                        child: ListTile(
                                          contentPadding: EdgeInsets.zero,
                                          horizontalTitleGap: 10,
                                          minLeadingWidth: 5,
                                          isThreeLine: false,
                                          minVerticalPadding: 0,
                                          minTileHeight: 50,
                                          leading: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.folder,
                                              color: Color(0XFF503494),
                                            ),
                                          ),
                                          title: Text(
                                            '${index + 1}. ${_batchVideoController.batchVideoStudyMatrialDataModel.data?.chapterListForUser?[index].chaptersTitle ?? ''}',
                                            maxLines: 3,
                                            style: TextStyle(
                                              color: Color(0XFF503494),
                                              fontSize: 15.sp,
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.bold,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Container(
                                height: MediaQuery.sizeOf(context).height * 0.6,
                                child: SingleChildScrollView(
                                  physics: AlwaysScrollableScrollPhysics(),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      //    Spacer(),
                                      Icon(
                                        Icons.assignment_add,
                                        color: Color(0XFF503494),
                                      ),
                                      Center(
                                        child: Text(
                                          'No Video!',
                                          style:
                                              TextStyle(color: Color(0XFF503494), fontSize: 17.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      ],
                    ),
                    if (_batchVideoController.isloader.value)
                      SafeArea(
                        top: false,
                        bottom: false,
                        child: ColoredBox(
                          color: Colors.white.withOpacity(0.5),
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(.1),
                                    spreadRadius: 0.1,
                                    offset: const Offset(0.0, 0.0),
                                    blurRadius: 5.0,
                                  ),
                                ],
                              ),
                              height: 80,
                              width: 80,
                              child: Platform.isIOS
                                  ? const CupertinoActivityIndicator(
                                      animating: true,
                                      color: Color(0XFF503494),
                                    )
                                  : const Padding(
                                      padding: EdgeInsets.all(25),
                                      child: CircularProgressIndicator(
                                        strokeWidth: 3.0,
                                        color: Color(0XFF503494),
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget search_text_field() {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w),
      child: Container(
        height: 50,
        child: TextFormField(
            controller: _batchVideoController.searchcontroller,
            onChanged: (value) {
              _batchVideoController.batchVideoListApi(batchid, value);
            },
            decoration: InputDecoration(
              focusedBorder:
                  OutlineInputBorder(borderSide: BorderSide(color: Color(0XFF503494), width: 1.w), borderRadius: BorderRadius.circular(22)),
              hintText: 'Search',
              hintStyle: TextStyle(color: Color(0XFF9B9B9B), fontSize: 15.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.w400),
              prefixIcon: const Image(
                image: AssetImage('assets/search.png'),
                height: 24,
                width: 24,
              ),
              enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(22.h), borderSide: BorderSide(color: Color(0XFFDEDEDE), width: 1.h)),
            )),
      ),
    );
  }
}
