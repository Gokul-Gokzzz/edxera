// ignore_for_file: must_be_immutable

import 'package:edxera/home/Models/chapter_inner_data_model.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:edxera/controller/controller.dart';

import '../models/overview_page_grid_model.dart';
import '../utils/screen_size.dart';

class ChapterNotes extends StatefulWidget {
  late ChapterInnerDataModel courseDetails;
  ChapterNotes({Key? key, required this.courseDetails}) : super(key: key);

  @override
  State<ChapterNotes> createState() => _ChapterNotesState();
}

class _ChapterNotesState extends State<ChapterNotes> {
  HomeController homecontroller = Get.put(HomeController());
  List<OverViewGrid> grid = [];

  bool activevalue = false;

  List<String> selectedCategory = [];

  @override
  void initState() {
    setState(() {});
    super.initState();
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
              (widget.courseDetails.data?.chapter?.notes ?? '') != ''
                  ? ExpandableText(
                      widget.courseDetails.data?.chapter?.notes ?? '',
                      expandText: 'Learn more.',
                      style: TextStyle(fontSize: 14.sp, color: const Color(0XFF6E758A), fontFamily: 'Gilroy', fontWeight: FontWeight.w400),
                      collapseText: 'Learn less.',
                      maxLines: 3,
                      linkStyle: TextStyle(color: const Color(0XFF503494), fontSize: 14.sp, fontWeight: FontWeight.w700, fontFamily: 'Gilroy'),
                    )
                  : Container(
                      child: Text(
                        'No Notes',
                        style: TextStyle(color: Color(0XFF503494), fontSize: 15.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
