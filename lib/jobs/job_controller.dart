import 'dart:developer';
import 'package:edxera/jobs/job_list_model.dart';
import 'package:edxera/jobs/job_list_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JobController extends GetxController {
  final JobService _jobService = JobService();

  var jobList = <Datum>[].obs;
  var isLoading = false.obs;

  // Move controllers here
  final TextEditingController titleController = TextEditingController();
  final TextEditingController smallDescController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactLinkController = TextEditingController();
  final TextEditingController whatsappController = TextEditingController();

  final RxInt applyStatus = 1.obs; // 1 for allowed, 0 for not allowed

  void loadJobs(int userId) async {
    isLoading(true);
    JobListModel? result = await _jobService.fetchJobList(userId);
    if (result != null && result.data != null) {
      jobList.assignAll(result.data!);
    }
    isLoading(false);
  }

  void deleteJob(int jobId, int index) async {
    bool success = await _jobService.deleteJob(jobId);
    if (success) {
      jobList.removeAt(index);
      Get.snackbar("Success", "Job deleted successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    } else {
      Get.snackbar("Error", "Failed to delete job",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  Future<void> submitJob(int userId) async {
    isLoading.value = true;
    final jobData = {
      "user_id": userId,
      "title": titleController.text,
      "shot_description": smallDescController.text,
      "description": descriptionController.text,
      "contact_email": emailController.text,
      "contact_whatsapp_number": whatsappController.text,
      "contact_link": contactLinkController.text,
      "apply_allowed_status": applyStatus.value,
    };

    final response = await _jobService.addJob(jobData);
    isLoading.value = false;

    if (response["status"] == true) {
      Get.snackbar("Success", response["message"],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);

      // Clear controllers after success
      _clearControllers();

      Future.delayed(Duration(seconds: 1), () {
        Get.back(); // Close the AddJobScreen after success
      });
    } else {
      Get.snackbar("Error", response["message"],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      log(response['message']);
    }
  }

  // Function to clear text controllers
  void _clearControllers() {
    titleController.clear();
    smallDescController.clear();
    descriptionController.clear();
    emailController.clear();
    contactLinkController.clear();
    whatsappController.clear();
  }

  @override
  void onClose() {
    titleController.dispose();
    smallDescController.dispose();
    descriptionController.dispose();
    emailController.dispose();
    contactLinkController.dispose();
    whatsappController.dispose();
    super.onClose();
  }
}
