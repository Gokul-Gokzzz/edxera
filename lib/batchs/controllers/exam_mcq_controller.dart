import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:edxera/batchs/Models/exam_mcq_data_model.dart';
import 'package:edxera/batchs/Models/exam_result_check_data_model.dart';
import 'package:edxera/repositories/post_repository.dart';
import 'package:edxera/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../languagecontrols/LanguageCheck.dart';

class ExamMcqController extends GetxController {
  RxBool isloader = false.obs;
  PostRepository postRepository = PostRepository();
  final Rx<ExamMcqDataModel> _examMcqDataModel = ExamMcqDataModel().obs;
  RxInt examQiestion = 1.obs;
  RxString selectedAnswer = ''.obs;

  void examMcqDataApi(String examid, studyplanid) async {
    isloader(true);

    var data = {
      //'user_id': 1.toString(),
      'user_id': await PrefData.getUserId(),
      'exam_id': examid,
      'question_page_no': examQiestion.value,
      'study_plan_items_id': studyplanid
    };
    print(data);

    try {
      ExamMcqDataModel? classesData = await postRepository.examMcqDataApi(data);
      if ((classesData?.success ?? false)) {
        if (classesData?.data != null) {
          _examMcqDataModel.value = classesData!;
          if (classesData.data?.userSubmitedOption != null) {
            selectedAnswer.value = classesData.data?.userSubmitedOption?.answerOption ?? '';
          }
        }

        // Get.showSnackbar(
        //   GetSnackBar(
        //     backgroundColor: Colors.green,
        //     message: classesData?.message,
        //     duration: const Duration(seconds: 1),
        //   ),
        // );
      } else {
        _examMcqDataModel.value = classesData!;
        isloader(false);
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

  Future<void> submitAnswer(String examid, studyplanid, questionId, bool isFinisg) async {
    if (selectedAnswer == '') {
      Get.showSnackbar(
        GetSnackBar(
          backgroundColor: Colors.red,
          message: 'Please Select The Answer',
          duration: const Duration(seconds: 1),
        ),
      );
      return;
    }

    isloader(true);

    var data = {
      //'user_id': 1.toString(),
      'user_id': await PrefData.getUserId(),
      'exam_id': examid,
      'study_plan_items_id': studyplanid,
      'questions_id': questionId,
      'answer_option': selectedAnswer.value
    };
    print(data);

    try {
      SubmitMcqDataModel? classesData = await postRepository.submitAnswerMCQDataApi(data);
      if ((classesData?.success ?? false)) {
        if (isFinisg) {
          finishExam(examid, studyplanid).then((value) {});
        } else {
          selectedAnswer.value = '';
          examMcqDataApi(examid, studyplanid);
        }

        Get.showSnackbar(
          GetSnackBar(
            backgroundColor: Colors.green,
            message: classesData?.message,
            duration: const Duration(seconds: 1),
          ),
        );
      } else {
        Get.showSnackbar(
          GetSnackBar(
            backgroundColor: Colors.red,
            message: classesData?.message,
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

  Future<void> finishExam(
    String examid,
    studyplanid,
  ) async {
    isloader(true);

    var data = {
      //'user_id': 1.toString(),
      'user_id': await PrefData.getUserId(),
      'exam_id': examid,
      'study_plan_items_id': studyplanid,
    };
    print(data);

    try {
      ExamResultCheckDataModel? classesData = await postRepository.finishAnswerMCQDataApi(data);
      if ((classesData?.success ?? false)) {
        Get.showSnackbar(
          GetSnackBar(
            backgroundColor: Colors.green,
            message: classesData?.message,
            duration: const Duration(seconds: 1),
          ),
        );

        String lcode = await PrefData.getLanguage();

        Map<String, dynamic> mplanguage = await LanguageCheck.checkLanguage(lcode);

        rateUs_dialogue(classesData ?? ExamResultCheckDataModel(), mplanguage).then((value) {
          Get.back();
        });
      } else {
        Get.showSnackbar(
          GetSnackBar(
            backgroundColor: Colors.red,
            message: classesData?.message,
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

  Future rateUs_dialogue(ExamResultCheckDataModel result, Map<String, dynamic> mplanguage) {
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
                    fontSize: 14.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.bold, fontStyle: FontStyle.normal, color: Color(0XFF000000)),
              ),
            ),
            SizedBox(height: 15.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                mplanguage['totalquestions'].toString() + ' : ${result.data?.totalQuestions ?? ''}',
                style: TextStyle(
                    fontSize: 14.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, color: Color(0XFF000000)),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                mplanguage['totalquestionsanswered'].toString() + ': ${result.data?.totalQuestionsAnswered ?? ''}',
                style: TextStyle(
                    fontSize: 14.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, color: Color(0XFF000000)),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                mplanguage['totalcorrectanswers'].toString() + ': ${result.data?.totalCorrectAnswers ?? ''}',
                style: TextStyle(
                    fontSize: 14.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, color: Color(0XFF000000)),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                mplanguage['totalmarksofexam'].toString() + ' : ${result.data?.totalMarksOfExam ?? ''}',
                style: TextStyle(
                    fontSize: 14.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, color: Color(0XFF000000)),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                mplanguage['passmarks'].toString() + ' : ${result.data?.passMarks ?? ''}',
                style: TextStyle(
                    fontSize: 14.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, color: Color(0XFF000000)),
              ),
            ),
            SizedBox(height: 15.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                mplanguage['totalmarks'].toString() + ' : ${result.data?.totalMarksGiven ?? ''}',
                style: TextStyle(
                    fontSize: 14.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, color: Color(0XFF000000)),
              ),
            ),
            SizedBox(height: 15.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                mplanguage['totalpercent'].toString() + ' : ${result.data?.totalPercentage ?? ''}',
                style: TextStyle(
                    fontSize: 14.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, color: Color(0XFF000000)),
              ),
            ),
            SizedBox(height: 15.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                mplanguage['examresult'].toString() + ' : ${result.data?.examResult ?? ''}',
                style: TextStyle(
                    fontSize: 14.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, color: Color(0XFF000000)),
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

  ExamMcqDataModel get examMcqDataModel => _examMcqDataModel.value;
}

class ExamDescriptionsController extends GetxController {
  RxBool isloader = false.obs;
  PostRepository postRepository = PostRepository();
  final Rx<ExamMcqDataModel> _examMcqDataModel = ExamMcqDataModel().obs;
  RxInt examQiestion = 1.obs;
  TextEditingController answerController = TextEditingController();

  void examMcqDataApi(String examid, studyplanid) async {
    isloader(true);

    var data = {
      //'user_id': 1.toString(),
      'user_id': await PrefData.getUserId(),
      'exam_id': examid,
      'question_page_no': examQiestion.value,
      'study_plan_items_id': studyplanid
    };

    try {
      ExamMcqDataModel? classesData = await postRepository.examDescriptionDataApi(data);
      if ((classesData?.success ?? false)) {
        if (classesData?.data != null) {
          _examMcqDataModel.value = classesData!;
          if (classesData.data?.userSubmitedAnswer != null) {
            answerController.text = classesData.data?.userSubmitedAnswer?.answerDescription ?? '';
          }
        }

        // Get.showSnackbar(
        //   GetSnackBar(
        //     backgroundColor: Colors.green,
        //     message: classesData?.message,
        //     duration: const Duration(seconds: 1),
        //   ),
        // );
      } else {
        _examMcqDataModel.value = classesData!;
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
    } finally {
      isloader(false);
    }
  }

  Future<void> submitAnswer(String examid, studyplanid, questionId, bool isFinisg) async {
    Map<String, dynamic> mplanguage = new HashMap();

    String lcode = await PrefData.getLanguage();

    var b = await LanguageCheck.checkLanguage(lcode);
    mplanguage = b;

    if (answerController.text == '') {
      Get.showSnackbar(
        GetSnackBar(
          backgroundColor: Colors.red,
          message: mplanguage['pleasenteranswer'].toString(),
          duration: const Duration(seconds: 1),
        ),
      );
      return;
    }

    isloader(true);

    var data = {
      //'user_id': 1.toString(),
      'user_id': await PrefData.getUserId(),
      'exam_id': examid,
      'study_plan_items_id': studyplanid,
      'questions_id': questionId,
      'answer_description': answerController.text
    };
    print(data);

    try {
      SubmitMcqDataModel? classesData = await postRepository.submitAnswerDescriptionDataApi(data);
      if ((classesData?.success ?? false)) {
        if (isFinisg) {
          finishExam(examid, studyplanid).then((value) {});
        } else {
          answerController.text = '';
          examMcqDataApi(examid, studyplanid);
        }

        Get.showSnackbar(
          GetSnackBar(
            backgroundColor: Colors.green,
            message: classesData?.message,
            duration: const Duration(seconds: 1),
          ),
        );
      } else {
        Get.showSnackbar(
          GetSnackBar(
            backgroundColor: Colors.red,
            message: classesData?.message,
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

  Future<void> finishExam(
    String examid,
    studyplanid,
  ) async {
    isloader(true);

    var data = {
      //'user_id': 1.toString(),
      'user_id': await PrefData.getUserId(),
      'exam_id': examid,
      'study_plan_items_id': studyplanid,
    };
    print(data);

    try {
      ExamResultCheckDataModel? classesData = await postRepository.finishAnswerDescriptionDataApi(data);
      if ((classesData?.success ?? false)) {
        Get.showSnackbar(
          GetSnackBar(
            backgroundColor: Colors.green,
            message: classesData?.message,
            duration: const Duration(seconds: 1),
          ),
        );

        String lcode = await PrefData.getLanguage();

        var b = await LanguageCheck.checkLanguage(lcode);
        rateUs_dialogue(classesData ?? ExamResultCheckDataModel(), b).then((value) {
          Get.back();
        });
      } else {
        Get.showSnackbar(
          GetSnackBar(
            backgroundColor: Colors.red,
            message: classesData?.message,
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

  Future rateUs_dialogue(ExamResultCheckDataModel result, Map<String, dynamic> mplanguage) {
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
                    fontSize: 14.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.bold, fontStyle: FontStyle.normal, color: Color(0XFF000000)),
              ),
            ),
            SizedBox(height: 15.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                mplanguage['totalquestions'].toString() + ' : ${result.data?.totalQuestions ?? ''}',
                style: TextStyle(
                    fontSize: 14.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, color: Color(0XFF000000)),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                mplanguage['totalquestionsanswered'].toString() + ': ${result.data?.totalQuestionsAnswered ?? ''}',
                style: TextStyle(
                    fontSize: 14.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, color: Color(0XFF000000)),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                mplanguage['totalcorrectanswers'].toString() + ': ${result.data?.totalCorrectAnswers ?? ''}',
                style: TextStyle(
                    fontSize: 14.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, color: Color(0XFF000000)),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                mplanguage['totalmarksofexam'].toString() + ': ${result.data?.totalMarksOfExam ?? ''}',
                style: TextStyle(
                    fontSize: 14.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, color: Color(0XFF000000)),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                mplanguage['passmarks'].toString() + ' : ${result.data?.passMarks ?? ''}',
                style: TextStyle(
                    fontSize: 14.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, color: Color(0XFF000000)),
              ),
            ),
            SizedBox(height: 15.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                mplanguage['totalmarks'].toString() + ': ${result.data?.totalMarksGiven ?? ''}',
                style: TextStyle(
                    fontSize: 14.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, color: Color(0XFF000000)),
              ),
            ),
            SizedBox(height: 15.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                mplanguage['totalpercent'].toString() + ' : ${result.data?.totalPercentage ?? ''}',
                style: TextStyle(
                    fontSize: 14.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, color: Color(0XFF000000)),
              ),
            ),
            SizedBox(height: 15.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                mplanguage['examresult'].toString() + ' : ${result.data?.examResult ?? ''}',
                style: TextStyle(
                    fontSize: 14.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, color: Color(0XFF000000)),
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

  ExamMcqDataModel get examMcqDataModel => _examMcqDataModel.value;
}
