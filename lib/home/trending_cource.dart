import 'dart:collection';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:edxera/controller/controller.dart';
import 'package:edxera/cources/cources.dart';
import 'package:edxera/repositories/api/api_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:edxera/utils/slider_page_data_model.dart';

import '../languagecontrols/LanguageCheck.dart';
import '../utils/screen_size.dart';
import '../utils/shared_pref.dart';

class TrendingCource extends StatefulWidget {
  const TrendingCource({Key? key}) : super(key: key);

  @override
  State<TrendingCource> createState() => _TrendingCourceState();
}

class _TrendingCourceState extends State<TrendingCource> {
  TrendingController homecontroller = Get.put(TrendingController());

  List cource = Utils.getTrending();
  toggle(int index) {
    setState(() {
      if (cource[index].buttonStatus == true) {
        cource[index].buttonStatus = false;
      } else {
        cource[index].buttonStatus = true;
      }
    });
  }

  @override
  void initState() {
    homecontroller.homeDashboardTrendingDatGetApi();
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
        body: SafeArea(
      child: Obx(
        () => Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 22.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Image(
                            image: const AssetImage("assets/back_arrow.png"),
                            height: 24.h,
                            width: 24.w,
                          )),
                      SizedBox(width: 16.w),
                      Text(
                        mplanguage['trendingc'].toString(),
                        style: TextStyle(fontSize: 24.sp, color: const Color(0XFF000000), fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                homecontroller.trendingCoursesDataModel.data != null ? trending_cource_list() : Container(),
              ],
            ),
            if (homecontroller.isloader.value)
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
    ));
  }

  Widget trending_cource_list() {
    return Expanded(
      flex: 1,
      child: GridView.count(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        crossAxisCount: 2,
        crossAxisSpacing: 18.73,
        mainAxisSpacing: 20,
        childAspectRatio: 0.650,
        children: (homecontroller.trendingCoursesDataModel.data?.courses ?? [])
            .map((index) => GestureDetector(
                  onTap: () {
                    Get.to(MyCources(), arguments: index.id ?? 0);
                  },
                  child: Container(
                    //height: 302,
                    width: 177.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(color: const Color(0XFF503494).withOpacity(0.14), offset: const Offset(-4, 5), blurRadius: 16),
                        ],
                        color: const Color(0XFFFFFFFF)),
                    child: Column(
                      children: [
                        Container(
                          height: 170.h,
                          width: 190.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(color: const Color(0XFF503494).withOpacity(0.14), offset: const Offset(-4, 5), blurRadius: 16),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CachedNetworkImage(
                              fit: BoxFit.fill,
                              // height: 50.h,
                              // width: 50.w,
                              imageUrl: '${ApiConstants.publicBaseUrl}/${index.courseThumbnail ?? ''}',
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
                                  // height: 50.h,
                                  // width: 50.w,
                                  color: Colors.grey.withOpacity(0.2),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 6.w, right: 6.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 6.h),
                              Text(
                                index.title!,
                                maxLines: 2,
                                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700, fontFamily: 'Gilroy', color: const Color(0XFF000000)),
                              ),
                              // Text(
                              //   index.title!,
                              //   style: TextStyle(
                              //       fontSize: 14.sp,
                              //       fontWeight: FontWeight.w700,
                              //       fontFamily: 'Gilroy',
                              //       color: const Color(0XFF000000)),
                              // ),
                              Padding(
                                padding: EdgeInsets.only(top: 12.h),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 27.h,
                                      width: 50.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: const Color(0XFFFAF4E1),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Image(
                                            image: const AssetImage("assets/staricon.png"),
                                            height: 15.h,
                                            width: 15.w,
                                          ),
                                          Text(
                                            "${index.totalRating ?? ""}",
                                            style: TextStyle(color: Color(0XFFFFC403), fontFamily: 'Gilroy', fontSize: 14.sp),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 6.w),
                                      child: SizedBox(
                                        height: 21.h,
                                        width: 76.w,
                                        child: Row(
                                          children: [
                                            // Image(
                                            //   image: const AssetImage(
                                            //       "assets/clock.png"),
                                            //   height: 17.h,
                                            //   width: 17.w,
                                            // ),
                                            // SizedBox(width: 4.w),
                                            // Text(
                                            //   '2.40Hrs',
                                            //   style: TextStyle(
                                            //       fontSize: 13.sp,
                                            //       color:
                                            //           const Color(0XFF000000),
                                            //       fontWeight: FontWeight.w400,
                                            //       fontFamily: 'Gilroy'),
                                            // )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 10.h),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
