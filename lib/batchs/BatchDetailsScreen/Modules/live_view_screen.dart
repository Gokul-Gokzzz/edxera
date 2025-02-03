import 'dart:io';

import 'package:edxera/batchs/controllers/live_class_controller.dart';
import 'package:edxera/utils/screen_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class LiveViewScreen extends StatefulWidget {
  final String batchid;

  const LiveViewScreen({super.key, required this.batchid});

  @override
  State<LiveViewScreen> createState() => _LiveViewScreenState();
}

class _LiveViewScreenState extends State<LiveViewScreen> {
  LiveClassController _liveClassController = Get.put(LiveClassController());

  @override
  void initState() {
    _liveClassController.liveClassApiCall(widget.batchid);
    super.initState();
  }

  String _formatDateTime(String? dateTimeString, String? classDate) {
    if (dateTimeString == null) return '';
    try {
      final dateTime = DateFormat('HH:mm:ss').parse(dateTimeString);
      DateTime classTime = classDate == null ? DateTime.now() : DateTime.parse(classDate);
      return DateFormat('dd MMM, yyyy, hh:mm a')
          .format(DateTime(classTime.year, classTime.month, classTime.day, dateTime.hour, dateTime.minute, dateTime.second));
    } catch (e) {
      // Log the error or handle it as needed
      print('Error parsing date: $e');
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 20.h),
                // search_text_field(),
                Expanded(
                  child: (_liveClassController.liveClassListDataModel.data?.liveClass?.length ?? 0) > 0
                      ? ListView.builder(
                          itemCount: _liveClassController.liveClassListDataModel.data?.liveClass?.length,
                          // physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () async {
                                // if (await canLaunchUrl(Uri.parse(url))) {
                                await launchUrl(Uri.parse(_liveClassController.liveClassListDataModel.data?.liveClass?[index].meetingLink ?? ''),
                                    mode: LaunchMode.externalApplication);
                                // if ((_liveClassController
                                //             .liveClassListDataModel
                                //             .data
                                //             ?.assignmentListForUser?[index]
                                //             .progressStatus ??
                                //         '') !=
                                //     'COMPLETED') {
                                //   Get.to(
                                //     StudyPlanAssigmentScreen(
                                //       title: _liveClassController
                                //               .liveClassListDataModel
                                //               .data
                                //               ?.assignmentListForUser?[index]
                                //               .title ??
                                //           '',
                                //       assigmentid: (_liveClassController
                                //                   .liveClassListDataModel
                                //                   .data
                                //                   ?.assignmentListForUser?[
                                //                       index]
                                //                   .assigmentId ??
                                //               0)
                                //           .toString(),
                                //       studyPlanId: (_liveClassController
                                //                   .liveClassListDataModel
                                //                   .data
                                //                   ?.assignmentListForUser?[
                                //                       index]
                                //                   .fkIntStudyPlanItemsId ??
                                //               0)
                                //           .toString(),
                                //     ),
                                //   );
                                // }
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 5.h, top: 10.h),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 10.h,
                                    ),
                                    Icon(
                                      Icons.error,
                                      color: const Color(0XFF503494),
                                    ),
                                    SizedBox(
                                      width: 20.h,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Text(
                                            (_liveClassController.liveClassListDataModel.data?.liveClass?[index].startAt != null &&
                                                    _liveClassController.liveClassListDataModel.data?.liveClass?[index].startAt!
                                                            .compareTo("00:00:00") !=
                                                        0)
                                                ? 'Start on ${_formatDateTime(_liveClassController.liveClassListDataModel.data?.liveClass?[index].startAt, _liveClassController.liveClassListDataModel.data?.liveClass?[index].classDate)}'
                                                : '',
                                            style: TextStyle(
                                              color: Color(0XFF503494),
                                              fontSize: 17.sp,
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Text(
                                            _liveClassController.liveClassListDataModel.data?.liveClass?[index].title ?? '',
                                            style: TextStyle(
                                                color: Color(0XFF503494), fontSize: 20.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          // SizedBox(
                                          //   height: 10.h,
                                          // ),
                                          // Text(
                                          //   _liveClassController
                                          //           .liveClassListDataModel
                                          //           .data
                                          //           ?.liveClass?[index]
                                          //           .description ??
                                          //       '',
                                          //   style: TextStyle(
                                          //       color: Color(0XFF503494),
                                          //       fontSize: 15.sp,
                                          //       fontFamily: 'Gilroy',
                                          //       fontWeight: FontWeight.bold),
                                          // ),
                                          // SizedBox(
                                          //   height: 10.h,
                                          // ),
                                          // Text(
                                          //   _liveClassController
                                          //           .liveClassListDataModel
                                          //           .data
                                          //           ?.liveClass?[index]
                                          //           .meetingMethod ??
                                          //       '',
                                          //   style: TextStyle(
                                          //       color: Color(0XFF503494),
                                          //       fontSize: 15.sp,
                                          //       fontFamily: 'Gilroy',
                                          //       fontWeight: FontWeight.bold),
                                          // ),
                                          // SizedBox(
                                          //   height: 10.h,
                                          // ),
                                          // Text(
                                          //   'Meeting id : ${_liveClassController.liveClassListDataModel.data?.liveClass?[index].meetingId ?? ''}',
                                          //   style: TextStyle(
                                          //       color: Color(0XFF503494),
                                          //       fontSize: 15.sp,
                                          //       fontFamily: 'Gilroy',
                                          //       fontWeight: FontWeight.bold),
                                          // ),
                                          // SizedBox(
                                          //   height: 10.h,
                                          // ),
                                          Text(
                                            (_liveClassController.liveClassListDataModel.data?.liveClass?[index].endAt != null &&
                                                    _liveClassController.liveClassListDataModel.data?.liveClass?[index].endAt!
                                                            .compareTo("00:00:00") !=
                                                        0)
                                                ? 'End on ${_formatDateTime(_liveClassController.liveClassListDataModel.data?.liveClass?[index].endAt, _liveClassController.liveClassListDataModel.data?.liveClass?[index].classDate)}'
                                                : '',
                                            style: TextStyle(
                                                color: Color(0XFF503494), fontSize: 17.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                        ],
                                      ),
                                    ),
                                    // if ((_liveClassController
                                    //             .liveClassListDataModel
                                    //             .data
                                    //             ?.assignmentListForUser?[index]
                                    //             .progressStatus ??
                                    //         '') ==
                                    //     'COMPLETED')
                                    //   GestureDetector(
                                    //     onTap: () {
                                    //       // Navigator.push(
                                    //       //   context,
                                    //       //   MaterialPageRoute(
                                    //       //     builder: (context) =>
                                    //       //         LessonDetailsScreens(
                                    //       //       batchId:
                                    //       //           homecontroller.batchid.value,
                                    //       //     ),
                                    //       //   ),
                                    //       // );pk_int_study_plan_items_id

                                    //       _liveClassController
                                    //           .resultAssigmentCheckApi(
                                    //         (_liveClassController
                                    //                     .liveClassListDataModel
                                    //                     .data
                                    //                     ?.assignmentListForUser?[
                                    //                         index]
                                    //                     .assigmentId ??
                                    //                 0)
                                    //             .toString(),
                                    //         (_liveClassController
                                    //                     .liveClassListDataModel
                                    //                     .data
                                    //                     ?.assignmentListForUser?[
                                    //                         index]
                                    //                     .pkIntStudyPlanItemsId ??
                                    //                 0)
                                    //             .toString(),
                                    //       );
                                    //     },
                                    //     child: Container(
                                    //       alignment: Alignment.center,
                                    //       decoration: BoxDecoration(
                                    //         borderRadius:
                                    //             BorderRadius.circular(10.h / 2),
                                    //         color: const Color(0XFF503494),
                                    //       ),
                                    //       margin: EdgeInsets.only(right: 10.w),
                                    //       child: Padding(
                                    //         padding: const EdgeInsets.all(8.0),
                                    //         child: Text(
                                    //           "Result",
                                    //           style: TextStyle(
                                    //               fontWeight: FontWeight.w500,
                                    //               fontSize: 15.sp,
                                    //               color: Colors.white),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              //    Spacer(),
                              Icon(
                                Icons.assignment_add,
                                color: Color(0XFF503494),
                              ),
                              Center(
                                child: Text(
                                  'No Live!',
                                  style: TextStyle(color: Color(0XFF503494), fontSize: 17.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                ),

                //Spacer(),
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     //    Spacer(),
                //     Icon(
                //       Icons.assignment_add,
                //       color: Color(0XFF503494),
                //     ),
                //     Center(
                //       child: Text(
                //         'No assignment created yet!',
                //         style: TextStyle(
                //             color: Color(0XFF503494),
                //             fontSize: 17.sp,
                //             fontFamily: 'Gilroy',
                //             fontWeight: FontWeight.bold),
                //       ),
                //     ),
                //   ],
                // ),
                // Spacer(),
              ],
            ),
            if (_liveClassController.isloader.value)
              SafeArea(
                top: false,
                bottom: false,
                child: ColoredBox(
                  color: Colors.white.withOpacity(0.5),
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.1),
                            spreadRadius: 0.1,
                            offset: const Offset(0.0, 0.0),
                            blurRadius: 5.0,
                          ),
                        ],
                      ),
                      height: 80,
                      width: 80,
                      child: Platform.isIOS
                          ? const CupertinoActivityIndicator(
                              animating: true,
                              color: Color(0XFF503494),
                            )
                          : const Padding(
                              padding: EdgeInsets.all(25),
                              child: CircularProgressIndicator(
                                strokeWidth: 3.0,
                                color: Color(0XFF503494),
                              ),
                            ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

// @override
// Widget build(BuildContext context) {
//   initializeScreenSize(context);
//   return Scaffold(
//     body: Column(
//       children: [
//         Spacer(),
//         Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             //    Spacer(),
//             Icon(
//               Icons.live_tv_rounded,
//               color: Color(0XFF503494),
//             ),
//             Center(
//               child: Text(
//                 'Your tutor is not live right now',
//                 style: TextStyle(
//                     color: Color(0XFF503494),
//                     fontSize: 17.sp,
//                     fontFamily: 'Gilroy',
//                     fontWeight: FontWeight.bold),
//               ),
//             ),
//           ],
//         ),
//         Spacer(),
//       ],
//     ),
//   );
// }

// Widget search_text_field() {
//   return Padding(
//     padding: EdgeInsets.only(left: 20.w, right: 20.w),
//     child: Container(
//       height: 50,
//       child: TextFormField(
//           decoration: InputDecoration(
//         focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: Color(0XFF503494), width: 1.w),
//             borderRadius: BorderRadius.circular(22)),
//         hintText: 'Search',
//         hintStyle: TextStyle(
//             color: Color(0XFF9B9B9B),
//             fontSize: 15.sp,
//             fontFamily: 'Gilroy',
//             fontWeight: FontWeight.w400),
//         prefixIcon: const Image(
//           image: AssetImage('assets/search.png'),
//           height: 24,
//           width: 24,
//         ),
//         enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(22.h),
//             borderSide: BorderSide(color: Color(0XFFDEDEDE), width: 1.h)),
//       )),
//     ),
//   );
// }
}
