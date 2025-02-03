// ignore_for_file: must_be_immutable

import 'package:edxera/batchs/BatchDetailsScreen/SubModules/pdf_viewers.dart';
import 'package:edxera/home/Models/study_matrial_video_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../repositories/api/api_constants.dart';

class FreeMatrialPdfListScreen extends StatefulWidget {
  String subjectVideoName;
  List<SubChapterFiles>? subChapterFiles;

  FreeMatrialPdfListScreen({super.key, required this.subjectVideoName, this.subChapterFiles});

  @override
  State<FreeMatrialPdfListScreen> createState() => _FreeMatrialPdfListScreenState();
}

class _FreeMatrialPdfListScreenState extends State<FreeMatrialPdfListScreen> {
  late PageController pController;

  @override
  void initState() {
    pController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        titleSpacing: 0,
        leading: const BackButton(
          color: Colors.black, // <-- SEE HERE
        ),
        centerTitle: false,
        title: Text(
          "${widget.subjectVideoName}",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.sp, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            search_text_field(),
            SizedBox(height: 20.h),
            if (widget.subChapterFiles?.length != 0)
              ListView.builder(
                itemCount: widget.subChapterFiles?.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PdfViwersScreen(
                                  name: widget.subChapterFiles?[index].subChaptersNotes ?? '',
                                  path: '${ApiConstants.publicBaseUrl}/${widget.subChapterFiles?[index].subChaptersStudyMaterials ?? ''}')));
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
                              (widget.subChapterFiles?[index].subChaptersNotes ?? '').toUpperCase(),
                              style: TextStyle(color: Color(0XFF503494), fontSize: 15.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
          ],
        ),
      ),
    );
  }

  Widget search_text_field() {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w),
      child: Container(
        height: 50,
        child: TextFormField(
            decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0XFF503494), width: 1.w), borderRadius: BorderRadius.circular(22)),
          hintText: 'Search',
          hintStyle: TextStyle(color: Color(0XFF9B9B9B), fontSize: 15.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.w400),
          prefixIcon: const Image(
            image: AssetImage('assets/search.png'),
            height: 24,
            width: 24,
          ),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(22.h), borderSide: BorderSide(color: Color(0XFFDEDEDE), width: 1.h)),
        )),
      ),
    );
  }
}
