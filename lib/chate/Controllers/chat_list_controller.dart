import 'package:dio/dio.dart';
import 'package:edxera/home/Models/study_plans_name_data_model.dart';
import 'package:edxera/repositories/post_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatListController extends GetxController {
  PostRepository postRepository = PostRepository();
  RxBool isloader = false.obs;
  List<String> countries = [];
  RxString dropdownvalue = ''.obs;
  RxString batchid = ''.obs;

  final Rx<StudyPlanCourseNameDataModel> _studyPlanCourseNameDataModel = StudyPlanCourseNameDataModel().obs;
  void homeDashboardStudyPlansDatGetApi() async {
    isloader(true);
    countries.clear();
    try {
      StudyPlanCourseNameDataModel? classesData = await postRepository.homeDashboardStudyPlansDatGet();
      if ((classesData?.success ?? false)) {
        if (classesData != null) _studyPlanCourseNameDataModel.value = classesData;
        if ((classesData?.data?.userCourses?.length ?? 0) > 0) {
          for (var element in classesData?.data?.userCourses ?? []) {
            countries.add(element.courseTitle);
          }
          dropdownvalue.value = classesData?.data?.userCourses?[0].courseTitle ?? '';
        }
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

  StudyPlanCourseNameDataModel get studyPlanCourseNameDataModel => _studyPlanCourseNameDataModel.value;
}
