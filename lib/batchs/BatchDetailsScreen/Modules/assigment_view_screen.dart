import 'dart:collection';
import 'dart:io';

import 'package:edxera/batchs/BatchDetailsScreen/Modules/study_plan_assigment_screen.dart';
import 'package:edxera/batchs/controllers/assigment_list_controller.dart';
import 'package:edxera/utils/screen_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../languagecontrols/LanguageCheck.dart';
import '../../../utils/shared_pref.dart';

class AssigmentViewScreen extends StatefulWidget {
  final String batchid;

  const AssigmentViewScreen({super.key, required this.batchid});

  @override
  State<AssigmentViewScreen> createState() => _AssigmentViewScreenState();
}

class _AssigmentViewScreenState extends State<AssigmentViewScreen> {
  AssigmentListController _assigmentListController = Get.put(AssigmentListController());

  @override
  void initState() {
    _assigmentListController.batchAssigmentListApi(widget.batchid, '');
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
                  child: _assigmentListController.batchAssigmentListDataModel.data?.assignmentCount != 0
                      ? ListView.builder(
                          itemCount: _assigmentListController.batchAssigmentListDataModel.data?.assignmentListForUser?.length,
                          // physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            print(
                                "LINk:- ${_assigmentListController.batchAssigmentListDataModel.data?.assignmentListForUser?[index].assignmentDescription}");
                            return InkWell(
                              onTap: () {
                                if ((_assigmentListController.batchAssigmentListDataModel.data?.assignmentListForUser?[index].progressStatus ?? '') !=
                                    'COMPLETED') {
                                  Get.to(
                                    StudyPlanAssigmentScreen(
                                      title: _assigmentListController.batchAssigmentListDataModel.data?.assignmentListForUser?[index].title ?? '',
                                      assigmentid:
                                          (_assigmentListController.batchAssigmentListDataModel.data?.assignmentListForUser?[index].assigmentId ?? 0)
                                              .toString(),
                                      studyPlanId: (_assigmentListController
                                                  .batchAssigmentListDataModel.data?.assignmentListForUser?[index].fkIntStudyPlanItemsId ??
                                              0)
                                          .toString(),
                                    ),
                                  );
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
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Text(
                                            mplanguage['duedate'].toString() +
                                                ' ${_assigmentListController.batchAssigmentListDataModel.data?.assignmentListForUser?[index].assignmentDeadline ?? ''}',
                                            style: TextStyle(
                                                color: Color(0XFF503494), fontSize: 17.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Text(
                                            _assigmentListController.batchAssigmentListDataModel.data?.assignmentListForUser?[index].title ?? '',
                                            style: TextStyle(
                                                color: Color(0XFF503494), fontSize: 20.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          HtmlWidget(
                                            _assigmentListController
                                                    .batchAssigmentListDataModel.data?.assignmentListForUser?[index].assignmentDescription ??
                                                '',

                                            // this callback will be triggered when user taps a link
                                            onTapUrl: (url) async {
                                              if (url.isNotEmpty) {
                                                final Uri uri = Uri.parse(url);
                                                if (await canLaunchUrl(uri)) {
                                                  await launchUrl(uri);
                                                }
                                              }
                                              return true;
                                            },

                                            renderMode: RenderMode.column,

                                            textStyle: TextStyle(fontSize: 14),
                                          ),
                                          // Text(
                                          //   parse(
                                          //         _assigmentListController
                                          //                 .batchAssigmentListDataModel.data?.assignmentListForUser?[index].assignmentDescription ??
                                          //             '',
                                          //       ).body?.text ??
                                          //       "",
                                          //   style: TextStyle(
                                          //       color: Color(0XFF503494), fontSize: 15.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                                          // ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Text(
                                            _assigmentListController.batchAssigmentListDataModel.data?.assignmentListForUser?[index].progressStatus ??
                                                '',
                                            style: TextStyle(
                                                color: Color(0XFF503494), fontSize: 15.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                        ],
                                      ),
                                    ),
                                    if ((_assigmentListController.batchAssigmentListDataModel.data?.assignmentListForUser?[index].progressStatus ??
                                            '') ==
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

                                          _assigmentListController.resultAssigmentCheckApi(
                                            (_assigmentListController.batchAssigmentListDataModel.data?.assignmentListForUser?[index].assigmentId ??
                                                    0)
                                                .toString(),
                                            (_assigmentListController
                                                        .batchAssigmentListDataModel.data?.assignmentListForUser?[index].pkIntStudyPlanItemsId ??
                                                    0)
                                                .toString(),
                                          );
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
                                  'No assignment created yet!',
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
            if (_assigmentListController.isloader.value)
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
            controller: _assigmentListController.searchcontroller,
            onChanged: (value) {
              _assigmentListController.batchAssigmentListApi(widget.batchid, value);
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
