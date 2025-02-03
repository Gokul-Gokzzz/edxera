// ignore_for_file: non_constant_identifier_names

import 'dart:collection';

import 'package:edxera/batchs/BatchDetailsScreen/Modules/announcementsview.dart';
import 'package:edxera/batchs/BatchDetailsScreen/Modules/assigment_view_screen.dart';
import 'package:edxera/batchs/BatchDetailsScreen/Modules/attendence_view_screen.dart';
import 'package:edxera/batchs/BatchDetailsScreen/Modules/live_view_screen.dart';
import 'package:edxera/batchs/BatchDetailsScreen/Modules/over_view_screen.dart';
import 'package:edxera/batchs/BatchDetailsScreen/Modules/recorderd_video_view_screen.dart';
import 'package:edxera/batchs/BatchDetailsScreen/Modules/study_matrial_view_screen.dart';
import 'package:edxera/batchs/BatchDetailsScreen/Modules/test_view_screen.dart';
import 'package:edxera/batchs/BatchDetailsScreen/Modules/videos_view_screen.dart';
import 'package:edxera/batchs/controllers/batch_video_controller.dart';
import 'package:edxera/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:edxera/controller/controller.dart';

import '../../languagecontrols/LanguageCheck.dart';
import '../../utils/shared_pref.dart';

class BatchesDetailScreen extends StatefulWidget {
  BatchesDetailScreen({Key? key, required this.corcedetail, required this.id, this.requested}) : super(key: key);
  final String corcedetail, id;
  String? requested;

  @override
  State<BatchesDetailScreen> createState() => _BatchesDetailScreenState();
}

class _BatchesDetailScreenState extends State<BatchesDetailScreen> {
  // List cource_detail = Utils.getCourceDetail();
  // CourceDetailController courceDetailController =
  //     Get.put(CourceDetailController());
  BatchVideoController _batchVideoController = Get.put(BatchVideoController());

  @override
  void initState() {
    // cource_detail = Utils.getCourceDetail();
    // cource_detail = cource_detail
    //     .where((element) => element.courceID == widget.corcedetail.id)
    //     .toList();
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
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // floatingActionButton: InkWell(
        //   child: Container(
        //     alignment: Alignment.center,
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(50.h / 2),
        //       color: const Color(0XFF503494),
        //     ),
        //     height: 50.h,
        //     margin: EdgeInsets.only(left: 30.w, right: 30.w),
        //     child: Text(
        //       "View Study Plan",
        //       style: TextStyle(
        //           fontWeight: FontWeight.w500,
        //           fontSize: 20.sp,
        //           color: Colors.white),
        //     ),

        //   ),
        //    onTap: () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => StudyPlanScreen(),
        //         ),
        //       );
        //     },
        // ),
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
          leading: const BackButton(
            color: Colors.black, // <-- SEE HERE
          ),
          centerTitle: false,
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Color(0XFF503494),
            dividerColor: Colors.green,
            unselectedLabelStyle:
                TextStyle(fontSize: 15.sp, fontFamily: 'Gilroy', color: Color(0XFF503494).withOpacity(0.5), fontWeight: FontWeight.w700),
            unselectedLabelColor: Color(0XFF503494).withOpacity(0.5),
            labelColor: Color(0XFF503494),
            onTap: (index) {
              // Tab index when user select it, it start from zero
              if (index == 5) {
                _batchVideoController.batchVideoListApi(widget.id, '');
              }
            },
            labelStyle: TextStyle(fontSize: 15.sp, fontFamily: 'Gilroy', color: Color(0XFF503494), fontWeight: FontWeight.w700),
            tabs: [
              Tab(
                text: mplanguage['overview'].toString(),
              ),
              Tab(
                text: mplanguage['videos'].toString(),
              ),
              Tab(
                text: mplanguage['live'].toString(),
              ),
              Tab(
                text: mplanguage['attendance'].toString(),
              ),
              Tab(
                text: mplanguage['assignments'].toString(),
              ),
              Tab(
                text: mplanguage['announcements'].toString(),
              ),
              Tab(
                text: mplanguage['tests'].toString(),
              ),
              Tab(
                text: mplanguage['rlc'].toString(),
              ),
              Tab(
                text: mplanguage['studymaterial'].toString(),
              ),
            ],
          ),
          title: Text(
            "${widget.corcedetail}",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.sp, color: Colors.black),
          ),
        ),
        body: GetBuilder(
          init: CourceDetailController(),
          builder: (courceDetailController) => TabBarView(
            children: [
              OverViewScreen(id: widget.id),
              widget.requested == '1'
                  ? VideosViewScreen(batchid: widget.id)
                  : Container(
                      child: Center(
                          child: Text(
                        mplanguage['plsjoin'].toString(),
                        style: TextStyle(fontWeight: FontWeight.w700),
                      )),
                    ),
              widget.requested == '1'
                  ? LiveViewScreen(batchid: widget.id)
                  : Container(
                      child: Center(
                          child: Text(
                        mplanguage['plsjoin'].toString(),
                        style: TextStyle(fontWeight: FontWeight.w700),
                      )),
                    ),
              widget.requested == '1'
                  ? AttendenceViewScreen(id: widget.id)
                  : Container(
                      child: Center(
                          child: Text(
                        mplanguage['plsjoin'].toString(),
                        style: TextStyle(fontWeight: FontWeight.w700),
                      )),
                    ),
              widget.requested == '1'
                  ? AssigmentViewScreen(batchid: widget.id)
                  : Container(
                      child: Center(
                          child: Text(
                        mplanguage['plsjoin'].toString(),
                        style: TextStyle(fontWeight: FontWeight.w700),
                      )),
                    ),
              widget.requested == '1'
                  ? AnnouncementsView(widget.id)
                  : Container(
                      child: Center(
                          child: Text(
                        mplanguage['plsjoin'].toString(),
                        style: TextStyle(fontWeight: FontWeight.w700),
                      )),
                    ),
              widget.requested == '1'
                  ? TestViewScreen(batchid: widget.id)
                  : Container(
                      child: Center(
                          child: Text(
                        mplanguage['plsjoin'].toString(),
                        style: TextStyle(fontWeight: FontWeight.w700),
                      )),
                    ),
              widget.requested == '1'
                  ? RecordedVideoViewScreen(batchid: widget.id)
                  : Container(
                      child: Center(
                          child: Text(
                        mplanguage['plsjoin'].toString(),
                        style: TextStyle(fontWeight: FontWeight.w700),
                      )),
                    ),
              widget.requested == '1'
                  ? StudyMatrialViewScreen(batchid: widget.id)
                  : Container(
                      child: Center(
                          child: Text(
                        mplanguage['plsjoin'].toString(),
                        style: TextStyle(fontWeight: FontWeight.w700),
                      )),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
