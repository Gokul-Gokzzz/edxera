import 'dart:collection';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:edxera/cources/cources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:edxera/controller/controller.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../languagecontrols/LanguageCheck.dart';
import '../repositories/api/api_constants.dart';
import '../utils/screen_size.dart';
import '../utils/shared_pref.dart';

class OngoingScreen extends StatefulWidget {
  const OngoingScreen({Key? key}) : super(key: key);

  @override
  State<OngoingScreen> createState() => _OngoingScreenState();
}

class _OngoingScreenState extends State<OngoingScreen> {
  OngoingController ongoingController = Get.put(OngoingController());

  Map<String, dynamic> mplanguage = new HashMap();

  @override
  void initState() {
    ongoingController.courseDataApi();
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
          (ongoingController.courseDataModel.data?.userCourses ?? []).isNotEmpty
              ? ListView.builder(
                  itemCount: ongoingController.courseDataModel.data?.userCourses?.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(top: 8.h, bottom: 8.h, right: 15.w, left: 15.w),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(MyCources(), arguments: ongoingController.courseDataModel.data?.userCourses?[index].id ?? 0);

                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => CourceDetail(
                          //             corcedetail: ongoingCource[index])));
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              boxShadow: [
                                BoxShadow(color: const Color(0XFF503494).withOpacity(0.14), offset: const Offset(-4, 5), blurRadius: 16),
                              ],
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    height: 100,
                                    width: 100,
                                    imageUrl:
                                        '${ApiConstants.publicBaseUrl}/${ongoingController.courseDataModel.data?.userCourses?[index].courseThumbnail ?? ''}',
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
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 20),
                                      Text(
                                        ongoingController.courseDataModel.data?.userCourses?[index].title ?? '',
                                        maxLines: 5,
                                        style: const TextStyle(fontSize: 18, fontFamily: 'Gilroy', fontStyle: FontStyle.normal),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        "${ongoingController.courseDataModel.data?.userCourses?[index].chapterCount ?? 0} Lesson to go",
                                        style: TextStyle(color: Color(0XFF292929)),
                                      ),
                                      const SizedBox(height: 15),
                                      LinearPercentIndicator(
                                        padding: EdgeInsets.zero,
                                        width: 180.0,
                                        lineHeight: 6.0,
                                        percent: (ongoingController.courseDataModel.data?.userCourses?[index].courseProgressPercentage ?? 0 / 100)
                                            .toDouble(),
                                        trailing: Padding(
                                          padding: EdgeInsets.only(left: 4.w),
                                          child: Text(
                                            '${ongoingController.courseDataModel.data?.userCourses?[index].courseProgressPercentage ?? 0}%',
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
                  },
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                        child: Text(
                      mplanguage['nodata'].toString(),
                      style: TextStyle(color: Colors.black),
                    )),
                  ],
                ),
          if (ongoingController.isloader.value)
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
