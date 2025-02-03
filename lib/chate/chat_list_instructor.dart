import 'dart:collection';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:edxera/chate/Controllers/chat_list_controller.dart';
import 'package:edxera/chate/instructor_chat_head_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../languagecontrols/LanguageCheck.dart';
import '../repositories/api/api_constants.dart';
import '../utils/shared_pref.dart';

class ChatInstructorListScreen extends StatefulWidget {
  const ChatInstructorListScreen({super.key});

  @override
  State<ChatInstructorListScreen> createState() => _ChatInstructorListScreenState();
}

class _ChatInstructorListScreenState extends State<ChatInstructorListScreen> {
  ChatListController chateScreenController = Get.put(ChatListController());

  @override
  void initState() {
    chateScreenController.homeDashboardStudyPlansDatGetApi();
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        titleSpacing: 0,
        centerTitle: false,
        leading: const BackButton(
          color: Colors.black, // <-- SEE HERE
        ),
        title: Text(
          mplanguage['courselist'].toString(),
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.sp, color: Colors.black),
        ),
      ),
      body: Obx(
        () => Stack(
          children: [
            chateScreenController.studyPlanCourseNameDataModel.data != null
                ? ListView.builder(
                    itemCount: chateScreenController.studyPlanCourseNameDataModel.data?.userCourses?.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 10.h, top: index == 0 ? 0.h : 10.h, left: 20.w, right: 20.w),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChatInstruterListByCourseScreen(
                                        courseId:
                                            (chateScreenController.studyPlanCourseNameDataModel.data?.userCourses?[index].courseId ?? 0).toString(),
                                      )),
                            );
                          },
                          child: Container(
                            width: double.infinity.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.h),
                                boxShadow: [
                                  BoxShadow(color: const Color(0XFF503494).withOpacity(0.14), offset: const Offset(-4, 5), blurRadius: 16.h),
                                ],
                                color: Colors.white),
                            child: Container(
                              margin: EdgeInsets.all(15.w),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.fill,
                                      height: 50.h,
                                      width: 50.w,
                                      imageUrl:
                                          '${ApiConstants.publicBaseUrl}/${chateScreenController.studyPlanCourseNameDataModel.data?.userCourses?[index].courseThumbnail ?? ''}',
                                      progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                                        child: Container(
                                          height: 30.h,
                                          width: 30.w,
                                          child: CircularProgressIndicator(value: downloadProgress.progress),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) => Container(
                                        height: 50.h,
                                        width: 50.h,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    // Image(
                                    //   image: NetworkImage(),
                                    //   fit: BoxFit.fill,
                                    // ),
                                  ),
                                  SizedBox(width: 5.w),
                                  Expanded(
                                    child: Text(
                                      chateScreenController.studyPlanCourseNameDataModel.data?.userCourses?[index].courseTitle ?? '',
                                      style: TextStyle(fontSize: 15.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: [
                                          Image(
                                            image: const AssetImage("assets/right_arrow.png"),
                                            height: 24.h,
                                            width: 24.w,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
