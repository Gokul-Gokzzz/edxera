import 'package:dio/dio.dart';
import 'package:edxera/batchs/Models/study_plan_assigment_data_model.dart';
import 'package:edxera/repositories/post_repository.dart';
import 'package:edxera/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class StudyPlanAssigmentController extends GetxController {
  RxBool isloader = false.obs;
  PostRepository postRepository = PostRepository();
  final Rx<StudyPlanAssigmentDataModel> _studyPlanAssigmentDataModel = StudyPlanAssigmentDataModel().obs;
  TextEditingController answerController = TextEditingController();

  void assigmentDataApi(String assignmentid, studyplanid) async {
    isloader(true);

    var data = {
      //'user_id': 1.toString(),
      'user_id': await PrefData.getUserId(),
      'assignment_id': assignmentid,
      'study_plan_items_id': studyplanid
    };
    print(data);

    try {
      StudyPlanAssigmentDataModel? classesData = await postRepository.assigmentDataApi(data);
      if ((classesData?.success ?? false)) {
        if (classesData?.data != null) {
          _studyPlanAssigmentDataModel.value = classesData!;
          // if (classesData.data?.userSubmitedOption != null) {
          //   selectedAnswer.value =
          //       classesData.data?.userSubmitedOption?.answerOption ?? '';
          // }
        }

        // Get.showSnackbar(
        //   GetSnackBar(
        //     backgroundColor: Colors.green,
        //     message: classesData?.message,
        //     duration: const Duration(seconds: 1),
        //   ),
        // );
      } else {
        _studyPlanAssigmentDataModel.value = classesData!;
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

  void submitAssigment(String assignmentid, studyplanid, file, heading, description) async {
    isloader(true);
    dio.FormData formData;

    if (file == '') {
      formData = dio.FormData.fromMap({
        //'user_id': 1.toString(),
        'user_id': await PrefData.getUserId(),
        'assignment_id': assignmentid,
        'study_plan_items_id': studyplanid,
        // 'assignment_file': file == ''
        //     ? ''
        //     : await dio.MultipartFile.fromFile(file, filename: fileName),
        'assignment_type': 'DESC',
        'heading': heading,
        'description': description
      });
      print(formData);
    } else {
      String fileName = file == '' ? '' : file.split('/').last;
      formData = dio.FormData.fromMap({
        //'user_id': 1.toString(),
        'user_id': await PrefData.getUserId(),
        'assignment_id': assignmentid,
        'study_plan_items_id': studyplanid,
        'assignment_file': await dio.MultipartFile.fromFile(file, filename: fileName),
        'assignment_type': 'FILE',
        'heading': heading,
        'description': description
      });
      print(formData);
    }

    try {
      StudyPlanAssigmentSubmitDataModel? classesData = await postRepository.submitAssigment(formData);
      if ((classesData?.success ?? false)) {
        Get.back();
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

  StudyPlanAssigmentDataModel get studyPlanAssigmentDataModel => _studyPlanAssigmentDataModel.value;
}
