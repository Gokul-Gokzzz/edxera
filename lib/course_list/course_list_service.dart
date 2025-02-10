import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:edxera/utils/shared_pref.dart';
import 'course_list_model.dart'; // Import the model

class PostService {
  final Dio _dio = Dio();

  // Define the API URL
  final String _apiUrl =
      "https://xianinfotech.in/edxera/api/get_all_courses_list";

  // Method to send a POST request and get the response
  Future<List<CourseListModel>> postCourseListData() async {
    int userId = await PrefData.getUserId();

    try {
      // Send a POST request with the user_id
      Response response = await _dio.post(
        _apiUrl,
        data: {
          "user_id": userId,
        },
      );

      log("Course list response: ${response.data}");

      // Check if the response is successful
      if (response.statusCode == 200 && response.data['success'] == true) {
        // Extract the list of courses from the "data" field
        List<dynamic> coursesJson = response.data['data'];

        // Map the JSON list to a list of CourseListModel objects
        List<CourseListModel> courses = coursesJson
            .map((course) => CourseListModel.fromJson(course))
            .toList();

        return courses;
      } else {
        throw Exception('Failed to load course list');
      }
    } catch (e) {
      log('Error fetching course list: $e');
      rethrow; // Rethrow the error to be handled in the controller
    }
  }
}
