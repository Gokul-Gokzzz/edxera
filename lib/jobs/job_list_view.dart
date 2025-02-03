import 'package:edxera/jobs/job_add_screen.dart';
import 'package:edxera/jobs/job_details_screen.dart';
import 'package:edxera/jobs/job_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JobListScreen extends StatelessWidget {
  final int userId;
  final JobController jobController = Get.put(JobController());

  JobListScreen({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    jobController.loadJobs(userId);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Job Listings",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white54),
        ),
        backgroundColor: Colors.blueGrey[900],
        centerTitle: true,
        elevation: 0,
      ),
      body: Obx(() {
        if (jobController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (jobController.jobList.isEmpty) {
          return Center(
            child: Text(
              "No jobs found",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.all(12),
          itemCount: jobController.jobList.length,
          itemBuilder: (context, index) {
            final job = jobController.jobList[index];

            return Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                contentPadding: EdgeInsets.all(12),
                title: Text(
                  job.title ?? "No Title",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    job.shortDescription ?? "",
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                ),
                onTap: () {
                  Get.to(() => JobDetailScreen(job: job));
                },
                trailing: job.deletionAllowedStatus == 1
                    ? IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _showDeleteConfirmation(context, job.id ?? 0, index);
                        },
                      )
                    : null,
              ),
            );
          },
        );
      }),

      // Floating Action Button for Adding Job
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddJobScreen(
                userId: userId,
              ));
        },
        backgroundColor: Colors.blueGrey[900],
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, int jobId, int index) {
    Get.defaultDialog(
      title: "Delete Job",
      middleText: "Are you sure you want to delete this job?",
      backgroundColor: Colors.white,
      titleStyle: TextStyle(fontWeight: FontWeight.bold),
      middleTextStyle: TextStyle(fontSize: 16),
      textCancel: "Cancel",
      textConfirm: "Delete",
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: () {
        jobController.deleteJob(jobId, index);
        Get.back(); // Close the dialog
      },
    );
  }
}
