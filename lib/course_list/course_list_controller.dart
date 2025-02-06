import 'package:edxera/course_list/course_list_model.dart';
import 'package:edxera/course_list/course_list_service.dart';
import 'package:get/get.dart';

class CourseController extends GetxController {
  final CourseService _courseService = CourseService();
  var courseList = CourseListModel().obs;
  var isLoading = false.obs;

  // Modified the getCourses function to accept requestBody parameter
  void getCourses(Map<String, dynamic> requestBody) async {
    try {
      isLoading.value = true;
      // Pass the requestBody to the service method
      var courses = await _courseService.fetchCourseList(requestBody);
      if (courses != null) {
        courseList.value = courses;
      }
    } finally {
      isLoading.value = false;
    }
  }
}
