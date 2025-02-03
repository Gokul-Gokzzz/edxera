import 'dart:collection';

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:edxera/controller/controller.dart';

import '../languagecontrols/LanguageCheck.dart';
import '../utils/screen_size.dart';
import '../utils/shared_pref.dart';

class Lesson extends StatefulWidget {
  const Lesson({Key? key}) : super(key: key);

  @override
  State<Lesson> createState() => _LessonState();
}

class _LessonState extends State<Lesson> {
  CourceController courceController = Get.put(CourceController());
  //List<LessonList> lessonLists = Utils.getLesson();

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

  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return GetBuilder(
      init: CourceController(),
      builder: (controller) => SingleChildScrollView(
        child: Column(
          children: [
            (courceController.courseChapterListDataModel.data?.chapter ?? []).isNotEmpty
                ? ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: courceController.courseChapterListDataModel.data?.chapter?.length,
                    itemBuilder: (BuildContext, index) {
                      return Padding(
                        padding: EdgeInsets.only(top: index == 0 ? 0.h : 8.h, bottom: 8.h, left: 15.w, right: 15.w),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.h),
                            boxShadow: [
                              BoxShadow(color: const Color(0XFF503494).withOpacity(0.14), offset: const Offset(-4, 5), blurRadius: 16),
                            ],
                          ),
                          child: ExpansionTileCard(
                            trailing: Padding(
                              padding: EdgeInsets.only(right: 20.w),
                              child: Image.asset("assets/down.png", height: 24.h, width: 24.w),
                            ),
                            animateTrailing: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 5.h),
                            borderRadius: BorderRadius.circular(22.h),
                            leading: Image.asset(
                              'assets/lesson1.png',
                              height: 66.h,
                              width: 66.w,
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  courceController.courseChapterListDataModel.data?.chapter?[index].title ?? '',
                                  style: TextStyle(fontSize: 14.sp, color: Color(0XFF000000), fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 4.h),
                                Container(
                                  height: 20.h,
                                  width: 70.w,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.h), color: const Color(0XFFE5ECFF)),
                                  child: Center(
                                      child: Text(
                                    mplanguage['chapter'].toString() + ' ${index + 1}',
                                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: const Color(0XFF503494)),
                                  )),
                                ),
                              ],
                            ),
                            children: <Widget>[
                              Divider(
                                thickness: 1.0,
                                height: 1.0.h,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.h),
                                  child: (courceController.courseChapterListDataModel.data?.chapter?[index].subchapter ?? []).isNotEmpty
                                      ? lesson_detail(index)
                                      : Container(),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    })
                : Center(
                    child: Container(
                      height: 100,
                      // color: Colors.amber,
                      alignment: Alignment.center,
                      child: Text(
                        mplanguage['nodata'].toString(),
                        style: TextStyle(fontSize: 14.sp, color: Color(0XFF000000), fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget lesson_detail(int index) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: courceController.courseChapterListDataModel.data?.chapter?[index].subchapter?.length,
        itemBuilder: (context, index1) {
          return Column(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Image.asset('assets/1stlessondetail.png', height: 20.h, width: 20.w),
                      SizedBox(width: 10.w),
                      Flexible(
                          child: Text(
                        courceController.courseChapterListDataModel.data?.chapter?[index].subchapter?[index1].title ?? '',
                        style: TextStyle(fontSize: 14.sp, color: Color(0XFF000000)),
                      )),
                      // SizedBox(width: 10.w),
                      // Text(
                      //   "${lessonLists[index].detail1stscore}",
                      //   style: TextStyle(fontSize: 14.sp, color: Color(0XFF503494)),
                      // )
                    ],
                  ),
                  SizedBox(height: 5.h),
                ],
              )
            ],
          );
        });
  }
}
