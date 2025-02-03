import 'dart:io';

import 'package:edxera/controller/controller.dart';
import 'package:edxera/utils/screen_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  //NotificationController

  NotificationController notificationController = Get.put(NotificationController());
  @override
  void initState() {
    notificationController.notificationListDataGetApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
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
          "Notifications",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.sp, color: Colors.black),
        ),
      ),
      body: Obx(
        () => Stack(
          children: [
            ListView.builder(
              itemCount: notificationController.notificationListDataModel.data?.userNotification?.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    // if ((_assigmentListController
                    //             .batchAssigmentListDataModel
                    //             .data
                    //             ?.assignmentListForUser?[index]
                    //             .progressStatus ??
                    //         '') !=
                    //     'COMPLETED') {
                    //   Get.to(
                    //     StudyPlanAssigmentScreen(
                    //       title: _assigmentListController
                    //               .batchAssigmentListDataModel
                    //               .data
                    //               ?.assignmentListForUser?[index]
                    //               .title ??
                    //           '',
                    //       assigmentid: (_assigmentListController
                    //                   .batchAssigmentListDataModel
                    //                   .data
                    //                   ?.assignmentListForUser?[
                    //                       index]
                    //                   .assigmentId ??
                    //               0)
                    //           .toString(),
                    //       studyPlanId: (_assigmentListController
                    //                   .batchAssigmentListDataModel
                    //                   .data
                    //                   ?.assignmentListForUser?[
                    //                       index]
                    //                   .fkIntStudyPlanItemsId ??
                    //               0)
                    //           .toString(),
                    //     ),
                    //   );
                    //  }
                    notificationController
                        .clearnotificationDataGetApi(
                            (notificationController.notificationListDataModel.data?.userNotification?[index].id ?? 0).toString(), index)
                        .then((value) {
                      notificationController.notificationListDataGetApi();
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 5.h, top: 10.h),
                    decoration: BoxDecoration(
                      color: notificationController.notificationListDataModel.data?.userNotification?[index].isSeen == 1
                          ? Colors.grey.withOpacity(0.2)
                          : Colors.white,
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
                                notificationController.notificationListDataModel.data?.userNotification?[index].message ?? '',
                                style: TextStyle(color: Color(0XFF503494), fontSize: 20.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                notificationController.notificationListDataModel.data?.userNotification?[index].notificationType ?? '',
                                style: TextStyle(color: Color(0XFF503494), fontSize: 15.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            if (notificationController.isloader.value)
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
}
