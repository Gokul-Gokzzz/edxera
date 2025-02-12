// ignore_for_file: must_be_immutable

import 'dart:collection';

import 'package:edxera/cources/Models/cources_details_data_model.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:edxera/controller/controller.dart';

import '../My_cources/Models/course_data_entity.dart';
import '../languagecontrols/LanguageCheck.dart';

import '../models/overview_page_grid_model.dart';
import '../utils/screen_size.dart';
import '../utils/shared_pref.dart';

class Overview extends StatefulWidget {
  late CourseDataEntity courseDetails;

  Overview({Key? key, required this.courseDetails}) : super(key: key);

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  HomeController homecontroller = Get.put(HomeController());
  List<OverViewGrid> grid = [];

  bool activevalue = false;

  List<String> selectedCategory = [];

  @override
  void initState() {
    // instuctor = Utils.getInstruter();
    setState(() {});
    super.initState();

    checkLanguage();
  }

  Map<String, dynamic> mplanguage = new HashMap();

  checkLanguage() async {
    String lcode = await PrefData.getLanguage();

    var b = await LanguageCheck.checkLanguage(lcode);
    setState(() {
      mplanguage = b;

      grid = [
        OverViewGrid(
            image: 'assets/gridview1.png',
            title: mplanguage['syllabus'].toString()),
        OverViewGrid(
            image: 'assets/gridview2.png',
            title: widget.courseDetails.data?.course?.level?.title ?? ''),
        OverViewGrid(
            image: 'assets/gridview3.png',
            title: widget.courseDetails.data?.course?.duration ?? ''),
        OverViewGrid(
            image: 'assets/gridview4.png',
            title: widget.courseDetails.data?.course?.language?.name ?? ''),
        OverViewGrid(
            image: 'assets/gridview5.png',
            title: mplanguage['certificate'].toString()),
        OverViewGrid(
            image: 'assets/gridview6.png',
            title: mplanguage['fullysecure'].toString()),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return GetBuilder(
      init: HomeController(),
      builder: (controller) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              Text(
                widget.courseDetails.data?.course?.title ?? '',
                maxLines: 5,
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0XFF000000),
                    fontFamily: 'Gilroy'),
              ),
              ExpandableText(
                widget.courseDetails.data?.course?.shortDescription ?? '',
                expandText: 'Learn more.',
                style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0XFF6E758A),
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w400),
                collapseText: 'Learn less.',
                maxLines: 3,
                linkStyle: TextStyle(
                    color: const Color(0XFF503494),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Gilroy'),
              ),
              SizedBox(
                child: GridView.count(
                  primary: false,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 8.0,

                  //reverse: true,
                  children: grid
                      .map((e) => Padding(
                            padding: EdgeInsets.all(6.0.h),
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(22.h),
                                    color: const Color(0XFFF3F6FF)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image(
                                      image: AssetImage(e.image!),
                                      height: 30.h,
                                      width: 30.w,
                                      fit: BoxFit.cover,
                                    ),
                                    SizedBox(height: 10.h),
                                    Text(
                                      e.title!,
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          color: const Color(0XFf000000),
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Gilroy'),
                                    )
                                  ],
                                )),
                          ))
                      .toList(),
                ),
              ),
              SizedBox(height: 21.sp),
              Text(
                "Instructor",
                style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 18.sp,
                    color: const Color(0XFF000000),
                    fontWeight: FontWeight.w700),
              ),
              (widget.courseDetails.data?.instructors != null)
                  ? ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.courseDetails.data?.instructors?.length,
                      itemBuilder: (BuildContext, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              top: index == 0 ? 0.h : 8.h,
                              bottom: index == 1 ? 0.w : 8.w),
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(22.h),
                                  color: const Color(0XFFFFFFFF),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0XFF503494)
                                          .withOpacity(0.14),
                                      blurRadius: 20.0.h,
                                    ),
                                  ]),
                              height: 95.h,
                              width: 374.w,
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: 10.w, right: 10.w),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.person,
                                      size: 50,
                                    ),
                                    // height: 71.h, width: 71.w),
                                    // Image(image: AssetImage('assets/1stinstructor.png'), height: 71.h, width: 71.w),
                                    SizedBox(width: 10.w),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          (widget
                                                      .courseDetails
                                                      .data
                                                      ?.instructors?[index]
                                                      .user
                                                      ?.firstName ??
                                                  '') +
                                              ' ' +
                                              (widget
                                                      .courseDetails
                                                      .data
                                                      ?.instructors?[index]
                                                      .user
                                                      ?.lastName ??
                                                  ''),
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              color: const Color(0XFF000000),
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Gilroy'),
                                        ), //SizedBox(height: 5),
                                        Text(
                                          widget
                                                  .courseDetails
                                                  .data
                                                  ?.instructors?[index]
                                                  .designation ??
                                              '',
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              color: const Color(0XFF000000),
                                              fontFamily: 'Gilroy'),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )),
                        );
                      })
                  : Container(),
              SizedBox(height: 20.h),
              Text(
                "Skill",
                style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 18.sp,
                    color: Color(0XFF000000),
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 12.h),
              Wrap(
                alignment: WrapAlignment.start,
                children: [
                  for (final i in List.generate(
                      (widget.courseDetails.data?.skills?.length ?? 0),
                      (index) => index))
                    Padding(
                      padding:
                          EdgeInsets.only(top: 8.h, bottom: 8.h, right: 8.w),
                      child: Wrap(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (!selectedCategory.contains(widget
                                        .courseDetails.data?.skills?[i].title ??
                                    '')) {
                                  selectedCategory.add(widget.courseDetails.data
                                          ?.skills?[i].title ??
                                      '');
                                } else {
                                  selectedCategory.remove(widget.courseDetails
                                          .data?.skills?[i].title ??
                                      '');
                                }
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 6.h, horizontal: 13.w),
                              decoration: BoxDecoration(
                                color: selectedCategory.contains(widget
                                            .courseDetails
                                            .data
                                            ?.skills?[i]
                                            .title ??
                                        '')
                                    ? Color(0XFFE5ECFF)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(26.h),
                                border: Border.all(
                                    color: selectedCategory.contains(widget
                                                .courseDetails
                                                .data
                                                ?.skills?[i]
                                                .title ??
                                            '')
                                        ? Color(0XFF503494)
                                        : Color(0XFF6E758A),
                                    width: 1.w),
                              ),
                              child: Text(
                                widget.courseDetails.data?.skills?[i].title ??
                                    '',
                                style: selectedCategory.contains(widget
                                            .courseDetails
                                            .data
                                            ?.skills?[i]
                                            .title ??
                                        '')
                                    ? const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0XFF503494),
                                        fontFamily: 'Gilroy')
                                    : const TextStyle(
                                        color: Color(0XFF6E758A),
                                        fontFamily: 'Gilroy'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
