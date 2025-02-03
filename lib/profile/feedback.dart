import 'dart:collection';

import 'package:edxera/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../languagecontrols/LanguageCheck.dart';
import '../utils/screen_size.dart';
import '../utils/shared_pref.dart';

class FeedBack extends StatefulWidget {
  const FeedBack({Key? key}) : super(key: key);

  @override
  State<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
//FeedBackController
  FeedBackController feedBackController = Get.put(FeedBackController());
  //StudyPlanAssigmentSubmitDataModel

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

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(right: 20.w, left: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 70.h),
            InkWell(
                onTap: () {
                  Get.back();
                },
                child: Image(
                  image: AssetImage("assets/back_arrow.png"),
                  height: 24.h,
                  width: 24.h,
                )),
            SizedBox(height: 20.h),
            Text(
              mplanguage['givefeedback'].toString(),
              style: TextStyle(fontWeight: FontWeight.w700, fontFamily: 'Gilroy', fontSize: 28.sp),
            ),
            SizedBox(height: 12.h),
            Text(mplanguage['givefeedbackaboutapp'].toString(), style: TextStyle(fontSize: 15.sp, color: Color(0XFF000000), fontFamily: 'Gilroy')),
            SizedBox(height: 40.h),
            Text(mplanguage['areyousatisfiedwithapp'].toString(),
                style: TextStyle(fontSize: 18.sp, color: Color(0XFF000000), fontFamily: 'Gilroy', fontWeight: FontWeight.w500)),
            SizedBox(height: 16.h),
            ratingbar(),
            SizedBox(height: 40.h),
            Text(mplanguage['telluswhatimproved'].toString(), style: TextStyle(fontSize: 15.sp, color: Color(0XFF000000), fontFamily: 'Gilroy')),
            SizedBox(height: 20.h),
            TextFormField(
              controller: feedBackController.nameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12.h))),
                  focusedBorder:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(12.h), borderSide: BorderSide(color: Color(0XFF503494), width: 1.w)),
                  enabledBorder:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(12.h), borderSide: BorderSide(color: Color(0XFFDFDFDF), width: 1.w)),
                  hintText: mplanguage['writefeedback'].toString(),
                  hintStyle: TextStyle(color: Color(0XFF6E758A), fontSize: 16.sp)),
              maxLines: 5,
            ),
            SizedBox(height: 150.h),
            submit_button(),
          ],
        ),
      ),
    );
  }

  ratingbar() {
    return RatingBar(
      initialRating: feedBackController.ratings.value,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: 42,
      glow: false,
      ratingWidget: RatingWidget(
          full: Image(
            image: AssetImage("assets/fidbackfillicon.png"),
            height: 21.h,
            width: 21.w,
          ),
          half: Image(
            image: AssetImage("assets/fidbackemptyicon.png"),
            height: 21.h,
            width: 21.w,
          ),
          empty: Image(
            image: AssetImage("assets/fidbackemptyicon.png"),
            height: 21.h,
            width: 21.w,
          )),
      itemPadding: EdgeInsets.symmetric(horizontal: 10),
      onRatingUpdate: (rating) {
        feedBackController.ratings.value = rating;

        print(rating);
      },
    );
  }

  Widget submit_button() {
    return GestureDetector(
      onTap: () {
        feedBackController.feedbackApi();
      },
      child: Container(
        height: 60.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.h),
          color: const Color(0XFF503494),
        ),
        child: Center(
          child: Text(mplanguage['submitfeedback'].toString(),
              style: TextStyle(color: Color(0XFFFFFFFF), fontSize: 14.sp, fontWeight: FontWeight.w700, fontFamily: 'Gilroy')),
        ),
      ),
    );
  }
}
