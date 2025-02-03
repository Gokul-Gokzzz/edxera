import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:edxera/My_cources/lesson_play.dart';
import 'package:edxera/batchs/BatchDetailsScreen/Modules/exam_description_screen.dart';
import 'package:edxera/batchs/BatchDetailsScreen/Modules/exam_mcq_screen.dart';
import 'package:edxera/batchs/BatchDetailsScreen/Modules/study_plan_assigment_screen.dart';
import 'package:edxera/batchs/BatchDetailsScreen/Modules/youtube_video_player.dart';
import 'package:edxera/batchs/controllers/lesson_details_controller.dart';
import 'package:edxera/utils/screen_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../languagecontrols/LanguageCheck.dart';
import '../../../repositories/api/api_constants.dart';
import '../../../utils/shared_pref.dart';

class LessonDetailsScreens extends StatefulWidget {
  final String batchId;

  const LessonDetailsScreens({super.key, required this.batchId});

  @override
  State<LessonDetailsScreens> createState() => _LessonDetailsScreensState();
}

class _LessonDetailsScreensState extends State<LessonDetailsScreens> {
  int selectedIndex = 0;
  LessonDetailsController lessonDetailsController = Get.put(LessonDetailsController());

  @override
  void initState() {
    print(widget.batchId);
    lessonDetailsController.studyPlanDetailsApi(widget.batchId);
    super.initState();
    checkLanguage();
  }

  Map<String, dynamic> mplanguage = new HashMap();

  checkLanguage() async {
    String lcode = await PrefData.getLanguage();

    var b = await LanguageCheck.checkLanguage(lcode);
    setState(() {
      mplanguage = b;
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
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
        centerTitle: false,
        title: Text(
          mplanguage['studyplan'].toString(),
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.sp, color: Colors.black),
        ),
        leading: const BackButton(
          color: Colors.black, // <-- SEE HERE
        ),
      ),
      body: Obx(
        () => Stack(
          children: [
            lessonDetailsController.studyPlanViewDataModel.data?.studyPlans != [] &&
                    (lessonDetailsController.studyPlanViewDataModel.data?.studyPlans?.length ?? 0) > 0
                ? SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          color: Colors.grey.withOpacity(0.2),
                          height: 70.h,
                          child: lessonDetailsController.studyPlanViewDataModel.data?.studyPlans != [] &&
                                  (lessonDetailsController.studyPlanViewDataModel.data?.studyPlans?.length ?? 0) > 0
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: lessonDetailsController.studyPlanViewDataModel.data?.studyPlans?.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        selectedIndex = index;
                                        setState(() {});
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(right: 5, top: 2, bottom: 2),
                                        height: 60.h,
                                        width: 70.w,
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 2, color: selectedIndex == index ? const Color(0XFF503494) : Colors.transparent),
                                          color: selectedIndex == index ? Colors.white : Colors.grey[200],
                                          // borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: selectedIndex == index ? Colors.red[400] : Colors.transparent,
                                                // borderRadius: BorderRadius.only(
                                                //   topLeft: Radius.circular(10),
                                                //   topRight: Radius.circular(10),
                                                // ),
                                              ),
                                              height: 20.h,
                                              child: Text(
                                                mplanguage['day'].toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 10.sp,
                                                    color: selectedIndex == index ? Colors.white : Colors.grey),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                width: double.infinity,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(),
                                                child: Text(
                                                  lessonDetailsController.studyPlanViewDataModel.data?.studyPlans?[index].studyPlansDate
                                                          ?.split('-')
                                                          .last ??
                                                      '',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 20.sp,
                                                      color: selectedIndex == index ? Colors.black : Colors.grey),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : Container(),
                        ),
                        if ((lessonDetailsController.studyPlanViewDataModel.data?.studyPlans?.length ?? 0) > 0)
                          lessonDetailsController.studyPlanViewDataModel.data?.studyPlans?[selectedIndex] != null
                              ? ListView.builder(
                                  padding: const EdgeInsets.all(10),
                                  itemCount: lessonDetailsController.studyPlanViewDataModel.data?.studyPlans?[selectedIndex].items?.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, indexs) {
                                    return GestureDetector(
                                      onTap: () {
                                        if ((lessonDetailsController.studyPlanViewDataModel.data?.studyPlans?[selectedIndex].items?[indexs].type ??
                                                '') ==
                                            'EXAM_MCQ') {
                                          Get.to(ExamMcqScreen(
                                            examPogress: lessonDetailsController
                                                    .studyPlanViewDataModel.data?.studyPlans?[selectedIndex].items?[indexs].progressStatus ??
                                                '',
                                            title: lessonDetailsController
                                                    .studyPlanViewDataModel.data?.studyPlans?[selectedIndex].items?[indexs].title ??
                                                '',
                                            examid: (lessonDetailsController
                                                        .studyPlanViewDataModel.data?.studyPlans?[selectedIndex].items?[indexs].examId ??
                                                    0)
                                                .toString(),
                                            studyPlanId: (lessonDetailsController.studyPlanViewDataModel.data?.studyPlans?[selectedIndex]
                                                        .items?[indexs].fkIntStudyPlanItemsId ??
                                                    0)
                                                .toString(),
                                          ));
                                        } else if ((lessonDetailsController
                                                    .studyPlanViewDataModel.data?.studyPlans?[selectedIndex].items?[indexs].type ??
                                                '') ==
                                            'EXAM_DESCRIPTION') {
                                          Get.to(ExamDescriptionScreen(
                                            examPogress: lessonDetailsController
                                                    .studyPlanViewDataModel.data?.studyPlans?[selectedIndex].items?[indexs].progressStatus ??
                                                '',
                                            title: lessonDetailsController
                                                    .studyPlanViewDataModel.data?.studyPlans?[selectedIndex].items?[indexs].title ??
                                                '',
                                            examid: (lessonDetailsController
                                                        .studyPlanViewDataModel.data?.studyPlans?[selectedIndex].items?[indexs].examId ??
                                                    0)
                                                .toString(),
                                            studyPlanId: (lessonDetailsController.studyPlanViewDataModel.data?.studyPlans?[selectedIndex]
                                                        .items?[indexs].fkIntStudyPlanItemsId ??
                                                    0)
                                                .toString(),
                                          ));
                                        } else if ((lessonDetailsController
                                                    .studyPlanViewDataModel.data?.studyPlans?[selectedIndex].items?[indexs].type ??
                                                '') ==
                                            'ASSIGMENT') {
                                          Get.to(StudyPlanAssigmentScreen(
                                            title: lessonDetailsController
                                                    .studyPlanViewDataModel.data?.studyPlans?[selectedIndex].items?[indexs].title ??
                                                '',
                                            assigmentid: (lessonDetailsController
                                                        .studyPlanViewDataModel.data?.studyPlans?[selectedIndex].items?[indexs].assigmentId ??
                                                    0)
                                                .toString(),
                                            studyPlanId: (lessonDetailsController.studyPlanViewDataModel.data?.studyPlans?[selectedIndex]
                                                        .items?[indexs].fkIntStudyPlanItemsId ??
                                                    0)
                                                .toString(),
                                          ));
                                        } else if ((lessonDetailsController
                                                    .studyPlanViewDataModel.data?.studyPlans?[selectedIndex].items?[indexs].type ??
                                                '') ==
                                            'DIRECT_VIDEO') {
                                          if ((lessonDetailsController
                                                      .studyPlanViewDataModel.data?.studyPlans?[selectedIndex].items?[indexs].dvVideoFile ??
                                                  '') !=
                                              '') {
                                            var dataVIdeo = jsonDecode(lessonDetailsController
                                                    .studyPlanViewDataModel.data?.studyPlans?[selectedIndex].items?[indexs].dvVideoFile ??
                                                '');
                                            print(dataVIdeo["video"]);

                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => VidioPlay(lessonplay: '${ApiConstants.publicBaseUrl}/${dataVIdeo["video"]}'),
                                              ),
                                            );
                                          } else {
                                            Get.to(() => YoutubeVideoPlayerScreen(
                                                url: lessonDetailsController
                                                        .studyPlanViewDataModel.data?.studyPlans?[selectedIndex].items?[indexs].dvYoutubeLink ??
                                                    ''));
                                          }
                                        } else if ((lessonDetailsController
                                                    .studyPlanViewDataModel.data?.studyPlans?[selectedIndex].items?[indexs].type ??
                                                '') ==
                                            'CHAPTER') {
                                          lessonDetailsController.chepterInnerApiCall(
                                              (lessonDetailsController
                                                          .studyPlanViewDataModel.data?.studyPlans?[selectedIndex].items?[indexs].chapterId ??
                                                      0)
                                                  .toString(),
                                              (lessonDetailsController.studyPlanViewDataModel.data?.studyPlans?[selectedIndex].items?[indexs]
                                                          .pkIntStudyPlanItemsId ??
                                                      '')
                                                  .toString());
                                        }
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(bottom: 20),
                                        child: ListTile(
                                          leading: Container(
                                              height: 60.h,
                                              width: 60.w,
                                              decoration: BoxDecoration(
                                                color: Colors.blue.withOpacity(0.2),
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Icon(
                                                Icons.play_circle,
                                                color: Colors.blue,
                                                size: 40,
                                              )),
                                          title: Text(
                                            lessonDetailsController.studyPlanViewDataModel.data?.studyPlans?[selectedIndex].items?[indexs].title ??
                                                '',
                                            maxLines: 4,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700, fontSize: 15.sp, color: Colors.black, overflow: TextOverflow.ellipsis),
                                          ),
                                          subtitle: Text(
                                            'Pogress:${lessonDetailsController.studyPlanViewDataModel.data?.studyPlans?[selectedIndex].items?[indexs].progressStatus ?? ''}',
                                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, color: Colors.grey),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : Container(
                                  child: Center(
                                    child: Text(
                                      mplanguage['nodata'].toString(),
                                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                )
                        // Padding(
                        //   padding: const EdgeInsets.all(10),
                        //   child: Column(
                        //     children: [
                        //       SizedBox(
                        //         height: 20.h,
                        //       ),
                        //       Row(
                        //         children: [
                        //           Container(
                        //               height: 60.h,
                        //               width: 60.w,
                        //               decoration: BoxDecoration(
                        //                 color: Colors.blue.withOpacity(0.2),
                        //                 borderRadius: BorderRadius.circular(10),
                        //               ),
                        //               child: Icon(
                        //                 Icons.play_circle,
                        //                 color: Colors.blue,
                        //                 size: 40,
                        //               )),
                        //           SizedBox(
                        //             width: 10.w,
                        //           ),
                        //           Column(
                        //             crossAxisAlignment: CrossAxisAlignment.start,
                        //             children: [
                        //               Text(
                        //                 "Theory of Computation-01",
                        //                 style: TextStyle(
                        //                     fontWeight: FontWeight.w700,
                        //                     fontSize: 15.sp,
                        //                     color: Colors.black),
                        //               ),
                        //               Text(
                        //                 "30:40 min",
                        //                 style: TextStyle(
                        //                     fontWeight: FontWeight.w500,
                        //                     fontSize: 14.sp,
                        //                     color: Colors.grey),
                        //               ),
                        //             ],
                        //           ),
                        //         ],
                        //       ),
                        //       SizedBox(
                        //         height: 20.h,
                        //       ),
                        //       Row(
                        //         children: [
                        //           Container(
                        //               height: 60.h,
                        //               width: 60.w,
                        //               decoration: BoxDecoration(
                        //                 color: Colors.blue.withOpacity(0.2),
                        //                 borderRadius: BorderRadius.circular(10),
                        //               ),
                        //               child: Icon(
                        //                 Icons.play_circle,
                        //                 color: Colors.blue,
                        //                 size: 40,
                        //               )),
                        //           SizedBox(
                        //             width: 10.w,
                        //           ),
                        //           Column(
                        //             crossAxisAlignment: CrossAxisAlignment.start,
                        //             children: [
                        //               Text(
                        //                 "Theory of Computation-02",
                        //                 style: TextStyle(
                        //                     fontWeight: FontWeight.w700,
                        //                     fontSize: 15.sp,
                        //                     color: Colors.black),
                        //               ),
                        //               Text(
                        //                 "20:40 min",
                        //                 style: TextStyle(
                        //                     fontWeight: FontWeight.w700,
                        //                     fontSize: 14.sp,
                        //                     color: Colors.grey),
                        //               ),
                        //             ],
                        //           ),
                        //         ],
                        //       ),
                        //       SizedBox(
                        //         height: 20.h,
                        //       ),
                        //       Row(
                        //         children: [
                        //           Container(
                        //               height: 60.h,
                        //               width: 60.w,
                        //               decoration: BoxDecoration(
                        //                 color: Colors.orange.withOpacity(0.2),
                        //                 borderRadius: BorderRadius.circular(10),
                        //               ),
                        //               child: Icon(
                        //                 Icons.assignment,
                        //                 color: Colors.orange,
                        //                 size: 40,
                        //               )),
                        //           SizedBox(
                        //             width: 20.w,
                        //           ),
                        //           Expanded(
                        //             child: Column(
                        //               crossAxisAlignment: CrossAxisAlignment.start,
                        //               children: [
                        //                 Text(
                        //                   "Theory of Computation-01,02-2023-12-03",
                        //                   style: TextStyle(
                        //                       fontWeight: FontWeight.w700,
                        //                       fontSize: 15.sp,
                        //                       color: Colors.black),
                        //                 ),
                        //                 Text(
                        //                   "20:40 min",
                        //                   style: TextStyle(
                        //                       fontWeight: FontWeight.w700,
                        //                       fontSize: 14.sp,
                        //                       color: Colors.grey),
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //       SizedBox(
                        //         height: 20.h,
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  )
                : Container(
                    child: Center(
                      child: Text(
                        'No Study Plan',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 18),
                      ),
                    ),
                  ),
            if (lessonDetailsController.isloader.value)
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
    );
  }
}
