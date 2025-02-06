// import 'package:edxera/course_list/course_list_service.dart';
// import 'package:get/get.dart';
// import 'course_list_model.dart';

// class CourseController extends GetxController {
//   // Instantiate the PostService
//   final PostService postService = PostService();

//   // Rx variable to store the course list
//   var courseList = <CourseListModel>[].obs;

//   // Loading state variable
//   var isLoading = false.obs;

//   // Error state variable
//   var hasError = false.obs;

//   // Method to fetch the course list data
//   Future<void> fetchCourseList() async {
//     try {
//       isLoading.value = true; // Set loading state to true
//       hasError.value = false; // Reset error state

//       // Call the postCourseListData method from the PostService
//       CourseListModel courseListResponse = await postService.postCourseListData(CourseListModel());

//       // Assign the fetched data to the course list
//       courseList.value = [courseListResponse]; // Adjust as necessary depending on your response structure
//     } catch (e) {
//       print('Error fetching course list: $e');
//       hasError.value = true; // Set error state to true
//     } finally {
//       isLoading.value = false; // Set loading state to false after the request is completed
//     }
//   }
// }
