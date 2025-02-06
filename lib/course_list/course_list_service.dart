import 'package:dio/dio.dart';
import 'course_list_model.dart';

class CourseService {
  final Dio dio = Dio(); // Initialize Dio

  // Accept the requestBody to pass it in the POST request
  Future<CourseListModel> fetchCourseList(
      Map<String, dynamic> requestBody) async {
    try {
      // Replace with your API URL
      final response = await dio.post(
        'https://your-api-url.com/courses',
        data: requestBody, // Use the requestBody in the API call
      );

      if (response.statusCode == 200) {
        return CourseListModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load courses');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
