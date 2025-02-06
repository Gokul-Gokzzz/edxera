import 'package:edxera/jobs/job_add_screen.dart';
import 'package:edxera/jobs/job_details_screen.dart';
import 'package:edxera/jobs/job_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JobListScreen extends StatefulWidget {
  JobListScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<JobListScreen> createState() => _JobListScreenState();
}

class _JobListScreenState extends State<JobListScreen> {
  final JobController jobController = Get.put(JobController());
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    jobController.loadJobs();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56), // Set a fixed height for the AppBar
        child: AppBar(
          backgroundColor: Colors.white,
          title: isSearching
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextField(
                    controller: searchController,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: "Search...",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                    style: TextStyle(
                        color: Colors.black), // Set text color to black
                  ),
                )
              : Row(
                  children: [
                    Image.asset(
                      'assets/app_logo.jpeg', // Your logo image
                      height: 30,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Edxera",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple.shade900),
                    ),
                  ],
                ),
          actions: [
            isSearching
                ? IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        isSearching = false;
                        searchController.clear();
                      });
                    },
                  )
                : IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      setState(() {
                        isSearching = true;
                      });
                    },
                  ),
          ],
        ),
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

            return GestureDetector(
                onTap: () {
                  Get.to(() => JobDetailScreen(job: job));
                },
                child: Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Job Name:',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          job.title ?? "No Title",
                          style: TextStyle(fontSize: 14),
                        ),
                        Divider(),
                        Text(
                          'salary :${job.jobSalaryMin} - ${job.jobSalaryMax}',
                          style: TextStyle(color: Colors.black),
                        ),
                        // _buildDetailRow(
                        //     'Salary', job.jobSalaryMin ?? "Not Disclosed"),

                        _buildDetailRow(
                          'Location',
                          job.jobLocation?.isNotEmpty == true
                              ? job.jobLocation!
                              : "Not Provided",
                        ),
                        _buildDetailRow('WhatsApp',
                            job.contactWhatsappNumber ?? "No Number"),
                        // _buildDetailRow(
                        //     'Email', job.contactEmail ?? "No Email"),
                        // if (job.contactLink != null &&
                        //     job.contactLink!.isNotEmpty)
                        //   Padding(
                        //     padding: const EdgeInsets.symmetric(vertical: 4),
                        //     child: Row(
                        //       children: [
                        //         Text(
                        //           'Contact Link:',
                        //           style: TextStyle(
                        //               fontSize: 14,
                        //               fontWeight: FontWeight.bold),
                        //         ),
                        //         SizedBox(width: 4),
                        //         Expanded(
                        //           child: Text(
                        //             job.contactLink!,
                        //             style: TextStyle(
                        //                 fontSize: 14, color: Colors.blue),
                        //             overflow: TextOverflow.ellipsis,
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        SizedBox(height: 12),
                        // Align(
                        //   alignment: Alignment.centerRight,
                        //   child: TextButton(
                        //     onPressed: () {
                        //       Get.to(() => JobDetailScreen(job: job));
                        //     },
                        //     child: Text(
                        //       'View More',
                        //       style: TextStyle(color: Colors.blue),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                )

                // ListTile(
                //   contentPadding: EdgeInsets.all(12),
                //   title: Text(
                //     job.title ?? "No Title",
                //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                //   ),
                //   subtitle: Padding(
                //     padding: const EdgeInsets.only(top: 4),
                //     child: Text(
                //       job.shortDescription ?? "",
                //       style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                //     ),
                //   ),
                //   onTap: () {
                //     Get.to(() => JobDetailScreen(job: job));
                //   },
                //   trailing: job.deletionAllowedStatus == 1
                //       ? IconButton(
                //           icon: Icon(Icons.delete, color: Colors.red),
                //           onPressed: () {
                //             _showDeleteConfirmation(context, job.id ?? 0, index);
                //           },
                //         )
                //       : null,
                // ),

                );
          },
        );
      }),

      // Floating Action Button for Adding Job
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddJobScreen());
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

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            '$label:',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 4),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 14),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
