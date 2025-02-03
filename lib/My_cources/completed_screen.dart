import 'dart:collection';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:edxera/cources/cources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../controller/controller.dart';
import '../languagecontrols/LanguageCheck.dart';
import '../repositories/api/api_constants.dart';
import '../utils/screen_size.dart';
import '../utils/shared_pref.dart';

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({Key? key}) : super(key: key);
  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  CompletedController completedController = Get.put(CompletedController());
  Map<String, dynamic> mplanguage = new HashMap();
  @override
  void initState() {
    completedController.courseDataApi();
    super.initState();
    checkLanguage();
  }

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
    return Obx(
      () => Stack(
        children: [
          GetBuilder(
            init: CompletedController(),
            builder: (completedController) => SingleChildScrollView(
              child: Column(
                children: [
                  (completedController.courseDataModel.data?.userCourses ?? []).isNotEmpty
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: ListView.builder(
                              itemCount: completedController.courseDataModel.data?.userCourses?.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(MyCources(), arguments: completedController.courseDataModel.data?.userCourses?[index].id ?? 0);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 20.w, right: 20.w, top: index == 0 ? 0.h : 8.h, bottom: 8.h),
                                    child: Container(
                                      height: 124.h,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(22.h),
                                          boxShadow: [
                                            BoxShadow(
                                                color: const Color(0XFF503494).withOpacity(0.14), offset: const Offset(-4, 5), blurRadius: 16.h),
                                          ],
                                          color: Colors.white),
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10.w, right: 10.w),
                                        child: Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                height: 100,
                                                width: 100,
                                                imageUrl:
                                                    '${ApiConstants.publicBaseUrl}/${completedController.courseDataModel.data?.userCourses?[index].courseThumbnail ?? ''}',
                                                progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                                                  child: Container(
                                                    height: 30.h,
                                                    width: 30.w,
                                                    child: CircularProgressIndicator(value: downloadProgress.progress),
                                                  ),
                                                ),
                                                errorWidget: (context, url, error) => ClipRRect(
                                                  borderRadius: BorderRadius.circular(10.h),
                                                  child: Container(
                                                    height: 100,
                                                    width: 100,
                                                    color: Colors.grey.withOpacity(0.2),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10.w),
                                            Expanded(
                                              child: Column(
                                                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(height: 20.h),
                                                  Text(
                                                    completedController.courseDataModel.data?.userCourses?[index].title ?? '',
                                                    maxLines: 1,
                                                    style: const TextStyle(fontSize: 18, fontFamily: 'Gilroy', fontStyle: FontStyle.normal),
                                                  ),
                                                  SizedBox(height: 10.h),
                                                  Text(
                                                    "${completedController.courseDataModel.data?.userCourses?[index].chapterCount ?? 0} Lesson ",
                                                    style: TextStyle(
                                                        color: Color(0XFF292929), fontSize: 14.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.w400),
                                                  ),
                                                  SizedBox(height: 15.h),
                                                  LinearPercentIndicator(
                                                    padding: EdgeInsets.zero,
                                                    width: 180.0,
                                                    lineHeight: 6.0,
                                                    percent:
                                                        (completedController.courseDataModel.data?.userCourses?[index].courseProgressPercentage ??
                                                                0 / 100)
                                                            .toDouble(),
                                                    trailing: Padding(
                                                      padding: EdgeInsets.only(left: 4.w),
                                                      child: Text(
                                                        '${completedController.courseDataModel.data?.userCourses?[index].courseProgressPercentage ?? 0}%',
                                                        style: TextStyle(fontFamily: 'Gilroy', fontSize: 14, fontWeight: FontWeight.w400),
                                                      ),
                                                    ),
                                                    backgroundColor: const Color(0XFFDEDEDE),
                                                    progressColor: const Color(0XFF503494),
                                                    barRadius: const Radius.circular(22),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }))
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 3,
                            ),
                            Center(
                                child: Text(
                              mplanguage['nodata'].toString(),
                              style: TextStyle(color: Colors.black),
                            )),
                          ],
                        ),
                ],
              ),
            ),
          ),
          if (completedController.isloader.value)
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
    );
  }
}
