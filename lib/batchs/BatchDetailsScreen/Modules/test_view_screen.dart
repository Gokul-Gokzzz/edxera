import 'dart:collection';
import 'dart:io';

import 'package:edxera/batchs/BatchDetailsScreen/Modules/exam_description_screen.dart';
import 'package:edxera/batchs/BatchDetailsScreen/Modules/exam_mcq_screen.dart';
import 'package:edxera/batchs/controllers/assigment_list_controller.dart';
import 'package:edxera/utils/screen_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../languagecontrols/LanguageCheck.dart';
import '../../../utils/shared_pref.dart';

class TestViewScreen extends StatefulWidget {
  final String batchid;
  const TestViewScreen({super.key, required this.batchid});

  @override
  State<TestViewScreen> createState() => _TestViewScreenState();
}

class _TestViewScreenState extends State<TestViewScreen> {
  TestListController _testListController = Get.put(TestListController());

  @override
  void initState() {
    _testListController.batchTestListApi(widget.batchid, '');

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
    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 20.h),
                search_text_field(),
                Expanded(
                  child: _testListController.batchTestListDataModel.data?.testCount != 0
                      ? ListView.builder(
                          itemCount: _testListController.batchTestListDataModel.data?.testListForUser?.length,
                          // physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                if ((_testListController.batchTestListDataModel.data?.testListForUser?[index].progressStatus ?? '') != 'COMPLETED' &&
                                    (_testListController.batchTestListDataModel.data?.testListForUser?[index].progressStatus ?? '') != 'SUBMITED') {
                                  if ((_testListController.batchTestListDataModel.data?.testListForUser?[index].type ?? '') == 'EXAM_MCQ') {
                                    Get.to(ExamMcqScreen(
                                      examPogress: _testListController.batchTestListDataModel.data?.testListForUser?[index].progressStatus ?? '',
                                      title: _testListController.batchTestListDataModel.data?.testListForUser?[index].title ?? '',
                                      examid: (_testListController.batchTestListDataModel.data?.testListForUser?[index].examId ?? 0).toString(),
                                      studyPlanId:
                                          (_testListController.batchTestListDataModel.data?.testListForUser?[index].fkIntStudyPlanItemsId ?? 0)
                                              .toString(),
                                    ))?.then((value) {
                                      _testListController.batchTestListApi(widget.batchid, '');
                                    });
                                  } else if ((_testListController.batchTestListDataModel.data?.testListForUser?[index].type ?? '') ==
                                      'EXAM_DESCRIPTION') {
                                    Get.to(ExamDescriptionScreen(
                                      examPogress: _testListController.batchTestListDataModel.data?.testListForUser?[index].progressStatus ?? '',
                                      title: _testListController.batchTestListDataModel.data?.testListForUser?[index].title ?? '',
                                      examid: (_testListController.batchTestListDataModel.data?.testListForUser?[index].examId ?? 0).toString(),
                                      studyPlanId:
                                          (_testListController.batchTestListDataModel.data?.testListForUser?[index].fkIntStudyPlanItemsId ?? 0)
                                              .toString(),
                                    ))?.then((value) {
                                      _testListController.batchTestListApi(widget.batchid, '');
                                    });
                                  }
                                }
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
                                          // SizedBox(
                                          //   height: 10.h,
                                          // ),
                                          // Text(
                                          //   'Due at ${_testListController.batchTestListDataModel.data?.testListForUser?[index].assignmentDeadline ?? ''}',
                                          //   style: TextStyle(
                                          //       color: Color(0XFF503494),
                                          //       fontSize: 17.sp,
                                          //       fontFamily: 'Gilroy',
                                          //       fontWeight: FontWeight.bold),
                                          // ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Text(
                                            _testListController.batchTestListDataModel.data?.testListForUser?[index].title ?? '',
                                            style: TextStyle(
                                                color: Color(0XFF503494), fontSize: 20.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Text(
                                            _testListController.batchTestListDataModel.data?.testListForUser?[index].progressStatus ?? '',
                                            style: TextStyle(
                                                color: Color(0XFF503494), fontSize: 15.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                        ],
                                      ),
                                    ),
                                    if ((_testListController.batchTestListDataModel.data?.testListForUser?[index].progressStatus ?? '') ==
                                        'COMPLETED')
                                      GestureDetector(
                                        onTap: () {
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //     builder: (context) =>
                                          //         LessonDetailsScreens(
                                          //       batchId:
                                          //           homecontroller.batchid.value,
                                          //     ),
                                          //   ),
                                          // );pk_int_study_plan_items_id

                                          _testListController.resultCheckApi(
                                              (_testListController.batchTestListDataModel.data?.testListForUser?[index].examId ?? 0).toString(),
                                              (_testListController.batchTestListDataModel.data?.testListForUser?[index].pkIntStudyPlanItemsId ?? 0)
                                                  .toString(),
                                              _testListController.batchTestListDataModel.data?.testListForUser?[index].type ?? '');
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10.h / 2),
                                            color: const Color(0XFF503494),
                                          ),
                                          margin: EdgeInsets.only(right: 10.w),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Result",
                                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15.sp, color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
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
                                  'Tests assigned to you will appear here',
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
            if (_testListController.isloader.value)
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

  Widget search_text_field() {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w),
      child: Container(
        height: 50,
        child: TextFormField(
            controller: _testListController.searchcontroller,
            onChanged: (value) {
              _testListController.batchTestListApi(widget.batchid, value);
            },
            decoration: InputDecoration(
              focusedBorder:
                  OutlineInputBorder(borderSide: BorderSide(color: Color(0XFF503494), width: 1.w), borderRadius: BorderRadius.circular(22)),
              hintText: mplanguage['search'].toString(),
              hintStyle: TextStyle(color: Color(0XFF9B9B9B), fontSize: 15.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.w400),
              prefixIcon: const Image(
                image: AssetImage('assets/search.png'),
                height: 24,
                width: 24,
              ),
              enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(22.h), borderSide: BorderSide(color: Color(0XFFDEDEDE), width: 1.h)),
            )),
      ),
    );
  }
}
