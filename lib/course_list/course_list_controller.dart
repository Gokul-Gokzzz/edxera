import 'dart:developer';

import 'package:edxera/course_list/course_list_service.dart';
import 'package:get/get.dart';
import 'course_list_model.dart';

class CourseController extends GetxController {
  // Instantiate the PostService
  final PostService postService = PostService();

  // Rx variable to store the course list
  var courseList = <CourseListModel>[].obs;
  // RxList<CourseListModel> courseList = RxList.empty();

  // Loading state variable
  var isLoading = false.obs;

  // Error state variable
  var hasError = false.obs;
  Future<void> fetchCourseList() async {
    try {
      isLoading.value = true;
      hasError.value = false;

      List<CourseListModel> courses = await postService.postCourseListData();
      courseList.assignAll(courses); // Proper way to update RxList
    } catch (e) {
      log('Error fetching course list: $e');
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }
}
