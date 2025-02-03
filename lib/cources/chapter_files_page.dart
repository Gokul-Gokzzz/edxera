// ignore_for_file: must_be_immutable

import 'package:edxera/batchs/BatchDetailsScreen/SubModules/pdf_viewers.dart';
import 'package:edxera/home/Models/chapter_inner_data_model.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:edxera/controller/controller.dart';

import '../models/overview_page_grid_model.dart';
import '../repositories/api/api_constants.dart';
import '../utils/screen_size.dart';

class ChapterFiles extends StatefulWidget {
  late ChapterInnerDataModel courseDetails;
  ChapterFiles({Key? key, required this.courseDetails}) : super(key: key);

  @override
  State<ChapterFiles> createState() => _ChapterFilesState();
}

class _ChapterFilesState extends State<ChapterFiles> {
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
              (widget.courseDetails.data?.chapter?.pdf ?? '') != ''
                  ? InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PdfViwersScreen(
                                    name: widget.courseDetails.data?.chapter?.title ?? '',
                                    path: '${ApiConstants.publicBaseUrl}/${widget.courseDetails.data?.chapter?.pdf ?? ''}')));
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 7.5.w, top: 7.5.w),
                        width: double.infinity.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.h),
                            boxShadow: [
                              BoxShadow(color: const Color(0XFF503494).withOpacity(0.14), offset: const Offset(-4, 5), blurRadius: 16.h),
                            ],
                            color: Colors.white),
                        child: Container(
                          margin: EdgeInsets.all(10.w),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 30.h,
                                width: 30.w,
                                decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/pdf.png'), fit: BoxFit.fill)),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                widget.courseDetails.data?.chapter?.title ?? ''.toUpperCase(),
                                style: TextStyle(color: Color(0XFF503494), fontSize: 15.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(
                      child: Text(
                        'No Files',
                        style: TextStyle(color: Color(0XFF503494), fontSize: 15.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
