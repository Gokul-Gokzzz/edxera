// // import 'package:edxera/course_list/course_list_controller.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';

// // class CourseListPage extends StatelessWidget {
// //   // Instantiate the CourseController
// //   final CourseController courseController = Get.put(CourseController());

// //   @override
// //   Widget build(BuildContext context) {
// //     courseController.fetchCourseList();
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Course List'),
// //       ),
// //       body: Obx(() {
// //         // Display loading indicator while data is being fetched
// //         if (courseController.isLoading.value) {
// //           return Center(child: CircularProgressIndicator());
// //         }

// //         // Display error message if there's an error
// //         if (courseController.hasError.value) {
// //           return Center(child: Text('Failed to load course list'));
// //         }

// //         // Display the course list
// //         return ListView.builder(
// //           itemCount: courseController.courseList.length,
// //           itemBuilder: (context, index) {
// //             final course = courseController.courseList[index];
// //             return ListTile(
// //               title: Text('No name available'), // Adjust based on your model
// //             );
// //           },
// //         );
// //       }),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:edxera/course_list/course_list_controller.dart';

// class CourseListPage extends StatelessWidget {
//   final CourseController courseController = Get.put(CourseController());

//   @override
//   Widget build(BuildContext context) {
//     courseController.fetchCourseList();
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Courses', style: TextStyle(color: Colors.amber)),
//         backgroundColor: Colors.black,
//         elevation: 0,
//         iconTheme: IconThemeData(color: Colors.amber),
//       ),
//       backgroundColor: Colors.black,
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: TextField(
//               // onChanged: (query) => courseController.searchCourse(query),
//               style: TextStyle(color: Colors.white),
//               decoration: InputDecoration(
//                 hintText: 'Search courses...',
//                 hintStyle: TextStyle(color: Colors.grey),
//                 prefixIcon: Icon(Icons.search, color: Colors.amber),
//                 filled: true,
//                 fillColor: Colors.grey[900],
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: Obx(() {
//               if (courseController.isLoading.value) {
//                 return Center(
//                     child: CircularProgressIndicator(color: Colors.amber));
//               }
//               if (courseController.hasError.value) {
//                 return Center(
//                     child: Text('Failed to load courses',
//                         style: TextStyle(color: Colors.red)));
//               }
//               if (courseController.courseList.isEmpty) {
//                 return Center(
//                     child: Text('No courses found',
//                         style: TextStyle(color: Colors.white)));
//               }
//               return ListView.builder(
//                 itemCount: courseController.courseList.length,
//                 itemBuilder: (context, index) {
//                   final course = courseController.courseList[index];
//                   return Card(
//                     color: Colors.grey[900],
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12)),
//                     margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                     child: ListTile(
//                       title: Text(course.title ?? 'No Name',
//                           style: TextStyle(color: Colors.amber)),
//                       subtitle: Text(
//                           course.shortDescription ?? 'No description available',
//                           style: TextStyle(color: Colors.grey)),
//                       leading: Icon(Icons.book, color: Colors.amber),
//                       onTap: () {
//                         // Navigate to course details if needed
//                       },
//                     ),
//                   );
//                 },
//               );
//             }),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:edxera/course_list/course_list_controller.dart';

class CourseListPage extends StatelessWidget {
  final CourseController courseController = Get.put(CourseController());

  @override
  Widget build(BuildContext context) {
    courseController.fetchCourseList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Courses', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Search courses...',
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(Icons.search, color: Colors.blue),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (courseController.isLoading.value) {
                return Center(
                    child: CircularProgressIndicator(color: Colors.blue));
              }
              if (courseController.hasError.value) {
                return Center(
                    child: Text('Failed to load courses',
                        style: TextStyle(color: Colors.red)));
              }
              if (courseController.courseList.isEmpty) {
                return Center(
                    child: Text('No courses found',
                        style: TextStyle(color: Colors.black)));
              }
              return ListView.builder(
                itemCount: courseController.courseList.length,
                itemBuilder: (context, index) {
                  final course = courseController.courseList[index];
                  return Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: ListTile(
                      title: Text(course.title ?? 'No Name',
                          style: TextStyle(color: Colors.blue)),
                      subtitle: Text(
                          course.shortDescription ?? 'No description available',
                          style: TextStyle(color: Colors.grey[700])),
                      leading: Icon(Icons.book, color: Colors.blue),
                      onTap: () {
                        // Navigate to course details if needed
                      },
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
