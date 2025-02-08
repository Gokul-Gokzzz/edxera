import 'package:dio/dio.dart';
import 'package:edxera/batchs/Models/assigment_Result_Data_model.dart';
import 'package:edxera/batchs/Models/assigment_list_data_model.dart';
import 'package:edxera/batchs/Models/exam_result_check_data_model.dart';
import 'package:edxera/batchs/Models/test_list_data_model.dart';
import 'package:edxera/repositories/post_repository.dart';
import 'package:edxera/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../languagecontrols/LanguageCheck.dart';

class AssigmentListController extends GetxController {
  RxBool isloader = false.obs;
  PostRepository postRepository = PostRepository();
  final Rx<BatchAssigmentListDataModel> _batchAssigmentListDataModel =
      BatchAssigmentListDataModel().obs;
  final Rx<AssigmentResultDataModel> _assigmentResultDataModel =
      AssigmentResultDataModel().obs;
  TextEditingController searchcontroller = new TextEditingController();

  void batchAssigmentListApi(String examid, text) async {
    isloader(true);

    var data = {
      //'user_id': 1.toString(),
      'user_id': await PrefData.getUserId(),
      'batch_id': examid,
      'search': text
    };
    print(data);

    try {
      BatchAssigmentListDataModel? classesData =
          await postRepository.batchAssigmentListApi(data);
      if ((classesData?.success ?? false)) {
        if (classesData?.data != null) {
          _batchAssigmentListDataModel.value = classesData!;
        }

        // Get.showSnackbar(
        //   GetSnackBar(
        //     backgroundColor: Colors.green,
        //     message: classesData?.message,
        //     duration: const Duration(seconds: 1),
        //   ),
        // );
      } else {
        // _batchAssigmentListDataModel.value = classesData!;
        Get.showSnackbar(
          GetSnackBar(
            backgroundColor: Colors.red,
            message: classesData?.message ?? '',
            duration: const Duration(seconds: 1),
          ),
        );
      }
    } on DioException catch (ex) {
      Get.showSnackbar(
        GetSnackBar(
          backgroundColor: Colors.red,
          message: ex.message,
          duration: const Duration(seconds: 1),
        ),
      );
      isloader(false);
      if (ex.type == DioExceptionType.unknown) {}
    }
    isloader(false);
  }

  void resultAssigmentCheckApi(
    String examid,
    studyPlaniD,
  ) async {
    isloader(true);

    var data = {
      //'user_id': 1.toString(),
      // 'user_id': 498,
      'user_id': await PrefData.getUserId(),
      'assignment_id': examid,
      //1
      'study_plan_items_id': studyPlaniD,
      //1
    };
    print(data);

    try {
      AssigmentResultDataModel? classesData =
          await postRepository.assigmentResultCheckApi(
        data,
      );
      if ((classesData?.success ?? false)) {
        if (classesData?.data != null) {
          _assigmentResultDataModel.value = classesData!;

          String lcode = await PrefData.getLanguage();

          Map<String, dynamic> mplanguage =
              await LanguageCheck.checkLanguage(lcode);
          rateUs_Assigment_dialogue(classesData, mplanguage);
        }

        // Get.showSnackbar(
        //   GetSnackBar(
        //     backgroundColor: Colors.green,
        //     message: classesData?.message,
        //     duration: const Duration(seconds: 1),
        //   ),
        // );
      }
    } on DioException catch (ex) {
      Get.showSnackbar(
        GetSnackBar(
          backgroundColor: Colors.red,
          message: ex.message,
          duration: const Duration(seconds: 1),
        ),
      );
      isloader(false);
      if (ex.type == DioExceptionType.unknown) {}
    }
    isloader(false);
  }

  BatchAssigmentListDataModel get batchAssigmentListDataModel =>
      _batchAssigmentListDataModel.value;
  AssigmentResultDataModel get assigmentResultDataModel =>
      _assigmentResultDataModel.value;

  Future rateUs_Assigment_dialogue(
      AssigmentResultDataModel result, Map<String, dynamic> mplanguage) {
    return Get.defaultDialog(
        barrierDismissible: false,
        title: '',
        content: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                result.data?.assignmentStatus ?? '',
                style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    color: Color(0XFF000000)),
              ),
            ),
            SizedBox(height: 15.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                mplanguage['totalmarkofassignment'].toString() +
                    ' : ${result.data?.totalMarksOfAssignment ?? ''}',
                style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.normal,
                    color: Color(0XFF000000)),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                mplanguage['passmarks'].toString() +
                    ' : ${result.data?.passMarks ?? ''}',
                style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.normal,
                    color: Color(0XFF000000)),
              ),
            ),
            SizedBox(height: 15.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                mplanguage['totalmarks'].toString() +
                    ' : ${result.data?.marksGiven ?? ''}',
                style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.normal,
                    color: Color(0XFF000000)),
              ),
            ),
            SizedBox(height: 15.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                mplanguage['assignmentresult'].toString() +
                    ' : ${result.data?.assignmentResult ?? ''}',
                style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.normal,
                    color: Color(0XFF000000)),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
              child: Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 56.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22.h),
                        color: const Color(0XFF503494),
                      ),
                      child: Center(
                          child: Text(
                        mplanguage['cancel'].toString(),
                        style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w700,
                            color: Color(0XFFFFFFFF),
                            fontStyle: FontStyle.normal,
                            fontSize: 14.sp),
                      )),
                    ),
                  )),
                  SizedBox(width: 10.w),
                ],
              ),
            )
          ],
        ));
  }
}

class TestListController extends GetxController {
  RxBool isloader = false.obs;
  TextEditingController searchcontroller = new TextEditingController();

  PostRepository postRepository = PostRepository();
  final Rx<BatchTestListDataModel> _batchTestListDataModel =
      BatchTestListDataModel().obs;
  final Rx<ExamResultCheckDataModel> _examResultCheckDataModel =
      ExamResultCheckDataModel().obs;

  void batchTestListApi(String examid, search) async {
    isloader(true);

    var data = {
      //'user_id': 1.toString(),
      'user_id': await PrefData.getUserId(),
      'batch_id': examid,
      'search': search
    };
    print(data);

    try {
      BatchTestListDataModel? classesData =
          await postRepository.batchTestListApi(data);
      if ((classesData?.success ?? false)) {
        if (classesData?.data != null) {
          _batchTestListDataModel.value = classesData!;
        }

        // Get.showSnackbar(
        //   GetSnackBar(
        //     backgroundColor: Colors.green,
        //     message: classesData?.message,
        //     duration: const Duration(seconds: 1),
        //   ),
        // );
      } else {
        _batchTestListDataModel.value = classesData!;
        Get.showSnackbar(
          GetSnackBar(
            backgroundColor: Colors.red,
            message: classesData.message,
            duration: const Duration(seconds: 1),
          ),
        );
      }
    } on DioException catch (ex) {
      Get.showSnackbar(
        GetSnackBar(
          backgroundColor: Colors.red,
          message: ex.message,
          duration: const Duration(seconds: 1),
        ),
      );
      isloader(false);
      if (ex.type == DioExceptionType.unknown) {}
    }
    isloader(false);
  }

  void resultCheckApi(String examid, studyPlaniD, type) async {
    isloader(true);

    var data = {
      //'user_id': 1.toString(),
      'user_id': await PrefData.getUserId(),
      'exam_id': examid,
      'study_plan_items_id': studyPlaniD
    };
    print(data);

    try {
      ExamResultCheckDataModel? classesData =
          await postRepository.examResultCheckApi(data, type);
      if ((classesData?.success ?? false)) {
        if (classesData?.data != null) {
          _examResultCheckDataModel.value = classesData!;
          String lcode = await PrefData.getLanguage();

          var b = await LanguageCheck.checkLanguage(lcode);

          rateUs_dialogue(classesData, b);
        }

        // Get.showSnackbar(
        //   GetSnackBar(
        //     backgroundColor: Colors.green,
        //     message: classesData?.message,
        //     duration: const Duration(seconds: 1),
        //   ),
        // );
      } else {
        _examResultCheckDataModel.value = classesData!;
        Get.showSnackbar(
          GetSnackBar(
            backgroundColor: Colors.red,
            message: classesData.message,
            duration: const Duration(seconds: 1),
          ),
        );
      }
    } on DioException catch (ex) {
      Get.showSnackbar(
        GetSnackBar(
          backgroundColor: Colors.red,
          message: ex.message,
          duration: const Duration(seconds: 1),
        ),
      );
      isloader(false);
      if (ex.type == DioExceptionType.unknown) {}
    }
    isloader(false);
  }

  BatchTestListDataModel get batchTestListDataModel =>
      _batchTestListDataModel.value;
  ExamResultCheckDataModel get examResultCheckDataModel =>
      _examResultCheckDataModel.value;

  Future rateUs_dialogue(
      ExamResultCheckDataModel result, Map<String, dynamic> mplanguage) {
    return Get.defaultDialog(
        barrierDismissible: false,
        title: '',
        content: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                result.data?.examStatus ?? '',
                style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    color: Color(0XFF000000)),
              ),
            ),
            SizedBox(height: 15.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                mplanguage['totalquestions'].toString() +
                    ' : ${result.data?.totalQuestions ?? ''}',
                style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.normal,
                    color: Color(0XFF000000)),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                mplanguage['totalquestionsanswered'].toString() +
                    ': ${result.data?.totalQuestionsAnswered ?? ''}',
                style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.normal,
                    color: Color(0XFF000000)),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                mplanguage['totalcorrectanswers'].toString() +
                    ': ${result.data?.totalCorrectAnswers ?? ''}',
                style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.normal,
                    color: Color(0XFF000000)),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                mplanguage['totalmarksofexam'].toString() +
                    ': ${result.data?.totalMarksOfExam ?? ''}',
                style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.normal,
                    color: Color(0XFF000000)),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                mplanguage['passmarks'].toString() +
                    ' : ${result.data?.passMarks ?? ''}',
                style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.normal,
                    color: Color(0XFF000000)),
              ),
            ),
            SizedBox(height: 15.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                mplanguage['totalmarks'].toString() +
                    ' : ${result.data?.totalMarksGiven ?? ''}',
                style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.normal,
                    color: Color(0XFF000000)),
              ),
            ),
            SizedBox(height: 15.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                mplanguage['totalpercent'].toString() +
                    ' : ${result.data?.totalPercentage ?? ''}',
                style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.normal,
                    color: Color(0XFF000000)),
              ),
            ),
            SizedBox(height: 15.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                mplanguage['examresult'].toString() +
                    ' : ${result.data?.examResult ?? ''}',
                style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.normal,
                    color: Color(0XFF000000)),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
              child: Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 56.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22.h),
                        color: const Color(0XFF503494),
                      ),
                      child: Center(
                          child: Text(
                        mplanguage['cancel'].toString(),
                        style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w700,
                            color: Color(0XFFFFFFFF),
                            fontStyle: FontStyle.normal,
                            fontSize: 14.sp),
                      )),
                    ),
                  )),
                  SizedBox(width: 10.w),
                ],
              ),
            )
          ],
        ));
  }
}
