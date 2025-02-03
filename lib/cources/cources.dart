import 'dart:collection';
import 'dart:io';

import 'package:edxera/batchs/batches_show_by_course.dart';
import 'package:edxera/repositories/api/api_constants.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:edxera/controller/controller.dart';
import 'package:edxera/cources/lessons_screen.dart';
import 'package:edxera/cources/overview_page.dart';
import 'package:edxera/cources/review_screen.dart';
import 'package:flutter/material.dart';

import '../batchs/controllers/batch_main_controller.dart';
import '../languagecontrols/LanguageCheck.dart';
import '../utils/screen_size.dart';
import '../utils/shared_pref.dart';
import '../widget/button.dart';
import 'choose_plane_screen.dart';

class MyCources extends StatefulWidget {
  const MyCources({
    Key? key,
  }) : super(key: key);

  @override
  State<MyCources> createState() => _MyCourcesState();
}

class _MyCourcesState extends State<MyCources> {
  CourceController courceController = Get.put(CourceController());

  PageController pageController = PageController();
  int initialvalue = 0;

  bool currentbuttonpos = false;
  String courseid = "0";

  @override
  void initState() {
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
        title: Text(
          mplanguage['courses'].toString(),
          maxLines: 2,
          style: TextStyle(fontFamily: 'Gilroy', fontWeight: FontWeight.w700, fontSize: 24.sp, overflow: TextOverflow.ellipsis),
        ),
      ),
      body: Obx(
        () => Stack(
          children: [
            GetBuilder<CourceController>(
              init: CourceController(),
              builder: (CourceController) => SafeArea(
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Obx(
                            () {
                              if (CourceController.isVideoLoading.value) {
                                return Container();
                              } else {
                                if (CourceController.isVideoLoaded.value) {
                                  return (CourceController.flickManager != null)
                                      ? Padding(
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
                                              height: 195.h,
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(22.h)),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(22),
                                                child: FlickVideoPlayer(
                                                  flickManager: courceController.flickManager!,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container();
                                } else {
                                  return CourceController.isloader.value
                                      ? Container()
                                      : Padding(
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
                                              height: 195.h,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(22.h),
                                              ),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(22),
                                                child: CourceController.imageGroup == null
                                                    ? Center(child: Text("Video is temporarily unavailable"))
                                                    : Image.network(
                                                        "${ApiConstants.publicBaseUrl}/${CourceController.courseDetailsDataModel.data?.course?.image?.originalImage}",
                                                        errorBuilder: (context, error, stackTrace) =>
                                                            Center(child: Text("Video is temporarily unavailable")),
                                                      ),
                                              ),
                                            ),
                                          ),
                                        );
                                }
                              }
                            },
                          ),
                          SizedBox(height: 12.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: Container(
                              height: 54.h,
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
                                labelStyle:
                                    TextStyle(color: const Color(0XFF503494), fontWeight: FontWeight.bold, fontSize: 12.sp, fontFamily: 'Gilroy'),
                                labelColor: const Color(0XFF503494),
                                unselectedLabelStyle:
                                    TextStyle(color: const Color(0XFF503494), fontWeight: FontWeight.w700, fontSize: 12.sp, fontFamily: 'Gilroy'),
                                indicator: ShapeDecoration(
                                    color: const Color(0XFFE5ECFF), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.h))),
                                controller: courceController.tabController,
                                tabs: [
                                  Tab(
                                    text: mplanguage['overview'].toString(),
                                  ),
                                  Tab(
                                    text: mplanguage['chapter'].toString(),
                                  ),
                                  Tab(
                                    text: mplanguage['reviews'].toString(),
                                  ),
                                ],
                                onTap: (value) {
                                  courceController.pController.animateToPage(value, duration: const Duration(milliseconds: 300), curve: Curves.ease);
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 12.h),
                          courceController.courseDetailsDataModel.data != null
                              ? Expanded(
                                  child: PageView.builder(
                                    controller: courceController.pController,
                                    onPageChanged: (value) {
                                      courceController.tabController
                                          .animateTo(value, duration: const Duration(milliseconds: 300), curve: Curves.ease);
                                    },
                                    itemCount: 3,
                                    itemBuilder: (context, index) {
                                      return index == 0
                                          ? Overview(
                                              courseDetails: courceController.courseDetailsDataModel,
                                            )
                                          : index == 1
                                              ? Lesson()
                                              : Review();
                                    },
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                      flex: 4,
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Align(
                            alignment: FractionalOffset.center,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 30.h),
                              child: CustomButton(
                                onTap: () async {
                                  bool isBypassTrue = await courceController.checkByPassApi();
                                  if (isBypassTrue) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BatchesShowByCourseScreen(
                                            id: courceController.courseDetailsDataModel.data?.course?.id ?? 0,
                                            count: courceController.batchmodel.data!.batches!.length ?? 0),
                                      ),
                                    );
                                  } else {
                                    if ((courceController.courseDetailsDataModel.data?.coursePurchasedStatus ?? 0) == 1) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BatchesShowByCourseScreen(
                                              id: courceController.courseDetailsDataModel.data?.course?.id ?? 0,
                                              count: courceController.batchmodel.data?.batches?.length ?? 0),
                                        ),
                                      );
                                    } else {
                                      courceController.couserPurchaseRequest();
                                      Get.to(
                                        ChoosePlane(data: courceController.courseDetailsDataModel),
                                      );
                                    }
                                  }
                                },
                                buttonText: ((courceController.courseDetailsDataModel.data?.coursePurchasedStatus ?? 0) == 1)
                                    ? ((courceController.batchmodel.data != null)
                                        ? ((courceController.batchmodel.data!.batches!.length > 1)
                                            ? mplanguage['viewbatches'].toString()
                                            : mplanguage['viewbatche'].toString())
                                        : mplanguage['viewbatches'].toString())
                                    : mplanguage['enrollnow'].toString(),
                              ),
                            ),
                          )
                        ],
                      ),
                      flex: 1,
                    )
                  ],
                ),
              ),
            ),
            if (courceController.isloader.value)
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
