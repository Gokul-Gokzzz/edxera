// import 'package:edxera/course_list/course_list_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class CourseListPage extends StatelessWidget {
//   // Instantiate the CourseController
//   final CourseController courseController = Get.put(CourseController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Course List'),
//       ),
//       body: Obx(() {
//         // Display loading indicator while data is being fetched
//         if (courseController.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         }

//         // Display error message if there's an error
//         if (courseController.hasError.value) {
//           return Center(child: Text('Failed to load course list'));
//         }

//         // Display the course list
//         return ListView.builder(
//           itemCount: courseController.courseList.length,
//           itemBuilder: (context, index) {
//             final course = courseController.courseList[index];
//             return ListTile(
//               title: Text(course.data. ?? 'No name available'), // Adjust based on your model
//             );
//           },
//         );
//       }),
//     );
//   }
// }
