// ignore_for_file: must_be_immutable

import 'package:edxera/cources/Models/cources_details_data_model.dart';
import 'package:edxera/home/Models/chapter_inner_data_model.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:edxera/controller/controller.dart';
import 'package:html/parser.dart';

import '../models/overview_page_grid_model.dart';
import '../utils/screen_size.dart';

class ChapterOverview extends StatefulWidget {
  late ChapterInnerDataModel courseDetails;

  ChapterOverview({Key? key, required this.courseDetails}) : super(key: key);

  @override
  State<ChapterOverview> createState() => _ChapterOverviewState();
}

class _ChapterOverviewState extends State<ChapterOverview> {
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
              (widget.courseDetails.data?.chapter?.description ?? '') != ''
                  ? ExpandableText(
                      parse(widget.courseDetails.data?.chapter?.description ?? '').body?.text ?? "",
                      expandText: 'Learn more.',
                      style: TextStyle(fontSize: 14.sp, color: const Color(0XFF6E758A), fontFamily: 'Gilroy', fontWeight: FontWeight.w400),
                      collapseText: 'Learn less.',
                      maxLines: 3,
                      linkStyle: TextStyle(color: const Color(0XFF503494), fontSize: 14.sp, fontWeight: FontWeight.w700, fontFamily: 'Gilroy'),
                    )
                  : Container(
                      child: Text(
                        'No Overview',
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
