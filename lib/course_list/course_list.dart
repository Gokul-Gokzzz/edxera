import 'package:edxera/course_list/course_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectedCourseListScreen extends StatelessWidget {
  final CourseController controller = Get.put(CourseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Courses")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              final requestBody = {
                "key": "value", // Replace with actual API parameters
              };
              controller.getCourses(requestBody);
            },
            child: Text("Load Courses"),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }

              if (controller.courseList.value.data == null ||
                  controller.courseList.value.data!.isEmpty) {
                return Center(child: Text("No courses available"));
              }

              return ListView.builder(
                itemCount: controller.courseList.value.data?.length ?? 0,
                itemBuilder: (context, index) {
                  final course = controller.courseList.value.data![index];
                  return ListTile(
                    title: Text(course.title ?? "No Title"),
                    subtitle: Text(course.shortDescription ?? "No Description"),
                    leading: course.courseThumbnail != null
                        ? Image.network(course.courseThumbnail!,
                            width: 50, height: 50, fit: BoxFit.cover)
                        : Icon(Icons.image),
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
