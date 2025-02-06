// import 'package:dio/dio.dart';
// import 'course_list_model.dart'; // import the model

// class PostService {
//   final Dio _dio = Dio();

//   // Define the API URL
//   final String _apiUrl = "https://xianinfotech.in/edxera/api/get_all_courses_list"; // Replace with actual API endpoint

//   // Method to send a POST request and get the response
//   Future<CourseListModel> postCourseListData(CourseListModel courseListModel) async {
//     try {
//       // Send a POST request with the data as JSON
//       Response response = await _dio.post(
//         _apiUrl,
//         data: courseListModel.toJson(),
//       );

//       // If the request is successful, return the parsed response as a model
//       if (response.statusCode == 200) {
//         return CourseListModel.fromJson(response.data);
//       } else {
//         throw Exception('Failed to load data');
//       }
//     } catch (e) {
//       // Handle any errors here
//       print('Error during post request: $e');
//       rethrow; // You can rethrow the error or return a default model, depending on your needs
//     }
//   }
// }
