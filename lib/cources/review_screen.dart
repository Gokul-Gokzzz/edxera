import 'dart:collection';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../controller/controller.dart';
import '../languagecontrols/LanguageCheck.dart';
import '../utils/screen_size.dart';
import '../utils/shared_pref.dart';

class Review extends StatefulWidget {
  const Review({Key? key}) : super(key: key);

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  @override
  void initState() {
    // TODO: implement initState
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

  CourceController courceController = Get.put(CourceController());

  Future rateUs_dialogue() {
    return Get.defaultDialog(
        barrierDismissible: false,
        title: '',
        content: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 42.w),
                child: Image(
                  image: const AssetImage('assets/rateUs.png'),
                  height: 174.h,
                ),
              ),
              SizedBox(height: 40.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 42.w),
                child: Text(
                  mplanguage['writereview'].toString(),
                  style: TextStyle(
                      fontSize: 16.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.bold, fontStyle: FontStyle.normal, color: Color(0XFF000000)),
                ),
              ),
              SizedBox(height: 15.h),
              TextFormField(
                controller: courceController.nameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12.h))),
                    focusedBorder:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(12.h), borderSide: BorderSide(color: Color(0XFF503494), width: 1.w)),
                    enabledBorder:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(12.h), borderSide: BorderSide(color: Color(0XFFDFDFDF), width: 1.w)),
                    hintText: mplanguage['writefeedback'].toString(),
                    hintStyle: TextStyle(color: Color(0XFF6E758A), fontSize: 14.sp)),
                maxLines: 5,
              ),
              SizedBox(height: 15.h),
              RatingBar(
                initialRating: courceController.rating.value,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 40,
                glow: false,
                ratingWidget: RatingWidget(
                    full: Image(
                      image: AssetImage("assets/fidbackfillicon.png"),
                    ),
                    half: Image(
                      image: AssetImage("assets/fidbackemptyicon.png"),
                    ),
                    empty: Image(
                      image: AssetImage("assets/fidbackemptyicon.png"),
                    )),
                itemPadding: EdgeInsets.symmetric(horizontal: 10),
                onRatingUpdate: (rating) {
                  courceController.rating.value = rating;
                  print(rating);
                },
              ),
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
                child: Row(
                  children: [
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 56.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22.h),
                          color: const Color(0XFF503494),
                        ),
                        child: Center(
                            child: Text(
                          mplanguage['cancel'].toString(),
                          style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w700,
                              color: Color(0XFFFFFFFF),
                              fontStyle: FontStyle.normal,
                              fontSize: 14.sp),
                        )),
                      ),
                    )),
                    SizedBox(width: 10.w),
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        // Get.off(HomeMainScreen());
                        courceController.feedbackApi((courceController.courseDetailsDataModel.data?.course?.id ?? 0).toString());
                        // controller.onChange(0);
                      },
                      child: Container(
                          height: 56.h,
                          width: double.infinity.w,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0XFF503494),
                              style: BorderStyle.solid,
                              width: 1.0.w,
                            ),
                            borderRadius: BorderRadius.circular(22.h),
                          ),
                          child: Center(
                              child: Text(
                            mplanguage['submit'].toString(),
                            style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.bold,
                                color: const Color(0XFF503494),
                                fontStyle: FontStyle.normal,
                                fontSize: 14.sp),
                          ))),
                    )),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return GetBuilder(
      init: CourceController(),
      builder: (controller) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    mplanguage['ratingreview'].toString(),
                    style: TextStyle(fontSize: 13.sp, fontFamily: 'Gilroy', color: const Color(0XFF000000), fontWeight: FontWeight.w500),
                  ),
                  Text(mplanguage['viewall'].toString(), style: TextStyle(fontSize: 12.sp, fontFamily: 'Gilroy', color: const Color(0XFF000000))),
                ],
              ),
              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "4.5",
                        style: TextStyle(fontFamily: 'Gilroy', fontSize: 36.sp, color: const Color(0XFF000000), fontWeight: FontWeight.w700),
                      ),
                      Text(
                        mplanguage['outof'].toString(),
                        style: TextStyle(fontFamily: 'Gilroy', fontSize: 13.sp, color: Color(0XFF000000), fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          RatingBar.builder(
                            initialRating: 5,
                            glow: false,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 10,
                            itemPadding: EdgeInsets.symmetric(horizontal: 2.17.h),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star_border,
                              color: Color(0XFF503494),
                            ),
                            onRatingUpdate: (rating) {},
                          ),
                          LinearPercentIndicator(
                            width: 204.w,
                            lineHeight: 4.h,
                            percent: 0.5,
                            backgroundColor: Colors.grey,
                            progressColor: Colors.blue,
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          RatingBar.builder(
                            initialRating: 4,
                            glow: false,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 4,
                            itemSize: 10,
                            itemPadding: EdgeInsets.symmetric(horizontal: 2.17.w),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star_border,
                              color: Color(0XFF503494),
                            ),
                            onRatingUpdate: (rating) {},
                          ),
                          LinearPercentIndicator(
                            width: 204.w,
                            lineHeight: 4.h,
                            percent: 0.5,
                            backgroundColor: Colors.grey,
                            progressColor: Colors.blue,
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          RatingBar.builder(
                            initialRating: 3,
                            glow: false,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 3,
                            itemSize: 10,
                            itemPadding: EdgeInsets.symmetric(horizontal: 2.17.w),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star_border,
                              color: Color(0XFF503494),
                            ),
                            onRatingUpdate: (rating) {},
                          ),
                          LinearPercentIndicator(
                            width: 204.w,
                            lineHeight: 4.h,
                            percent: 0.5,
                            backgroundColor: Colors.grey,
                            progressColor: Colors.blue,
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          RatingBar.builder(
                            initialRating: 2,
                            glow: false,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 2,
                            itemSize: 10,
                            itemPadding: EdgeInsets.symmetric(horizontal: 2.17.w),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star_border,
                              color: Color(0XFF503494),
                            ),
                            onRatingUpdate: (rating) {},
                          ),
                          LinearPercentIndicator(
                            width: 204.w,
                            lineHeight: 4.h,
                            percent: 0.5,
                            backgroundColor: Colors.grey,
                            progressColor: Colors.blue,
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          RatingBar.builder(
                            initialRating: 1,
                            glow: false,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 1,
                            itemSize: 10,
                            itemPadding: EdgeInsets.symmetric(horizontal: 2.17.w),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star_border,
                              color: Color(0XFF503494),
                            ),
                            onRatingUpdate: (rating) {},
                          ),
                          LinearPercentIndicator(
                            width: 204.w,
                            lineHeight: 4.h,
                            percent: 0.5,
                            backgroundColor: Colors.grey,
                            progressColor: Colors.blue,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Align(
                  child: Text(
                    "1k " + mplanguage['reviews'].toString(),
                    style: TextStyle(fontFamily: 'Gilroy', fontSize: 12.sp, color: Color(0XFF000000), fontWeight: FontWeight.normal),
                  ),
                  alignment: Alignment.centerRight),
              SizedBox(height: 12.h),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      rateUs_dialogue();
                    },
                    child: Text(
                      mplanguage['writereview'].toString(),
                      style: TextStyle(fontFamily: 'Gilroy', fontSize: 12.sp, color: const Color(0XFF000000), fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(width: 11),
                  RatingBar.builder(
                    glow: true,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemSize: 21.62,
                    itemPadding: EdgeInsets.symmetric(horizontal: 2.17.w),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star_border,
                      //  color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      if (rating == 5.0) {
                        courceController.rating.value = rating;
                        rateUs_dialogue();
                      }
                    },
                  ),
                ],
              ),
              //SizedBox(height: 12.h),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: courceController.courseDetailsDataModel.data?.reviews?.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(left: 15.5.w),
                      child: SizedBox(
                        height: 62.h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(32.h),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.fill,
                                    height: 32.h,
                                    width: 32.w,
                                    imageUrl: courceController.courseDetailsDataModel.data?.reviews?[index].user?.images ?? '',
                                    progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                                      child: Container(
                                        height: 32.h,
                                        width: 32.w,
                                        child: CircularProgressIndicator(value: downloadProgress.progress),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) => ClipRRect(
                                      borderRadius: BorderRadius.circular(32.h),
                                      child: Container(
                                        height: 32.h,
                                        width: 32.w,
                                        color: Colors.grey.withOpacity(0.2),
                                      ),
                                    ),
                                  ),

                                  //  Image(
                                  //   image: NetworkImage(courceController
                                  //           .courseDetailsDataModel
                                  //           .data
                                  //           ?.reviews?[index]
                                  //           .userDataSet
                                  //           ?.profileImage ??
                                  //       ''),
                                  //   fit: BoxFit.fill,
                                  //   height: 32.h,
                                  //   width: 32.w,
                                  // ),
                                ),
                                SizedBox(width: 15.w),
                                Expanded(
                                  child: Text(
                                    courceController.courseDetailsDataModel.data?.reviews?[index].comment ?? '',
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: const Color(0XFF292929),
                                        fontFamily: 'Gilroy',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                  padding: EdgeInsets.only(top: 33.h, bottom: 11.h),
                                  child: Text(
                                    convertToAgo(courceController.courseDetailsDataModel.data?.reviews?[index].createdAt?.toIso8601String() ?? ''),
                                    style: TextStyle(fontSize: 12.sp, color: Color(0XFF503494), fontFamily: 'Gilroy'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  String convertToAgo(String dateTime) {
    DateTime input = DateFormat('yyyy-MM-DDTHH:mm:ss.SSSSSSZ').parse(dateTime, true);
    Duration diff = DateTime.now().difference(input);

    if (diff.inDays >= 1) {
      return '${diff.inDays} day${diff.inDays == 1 ? '' : 's'} ago';
    } else if (diff.inHours >= 1) {
      return '${diff.inHours} hour${diff.inHours == 1 ? '' : 's'} ago';
    } else if (diff.inMinutes >= 1) {
      return '${diff.inMinutes} minute${diff.inMinutes == 1 ? '' : 's'} ago';
    } else if (diff.inSeconds >= 1) {
      return '${diff.inSeconds} second${diff.inSeconds == 1 ? '' : 's'} ago';
    } else {
      return 'just now';
    }
  }
}
