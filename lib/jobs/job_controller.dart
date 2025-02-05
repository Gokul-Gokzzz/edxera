import 'dart:developer';
import 'dart:io';
import 'package:edxera/jobs/job_list_model.dart';
import 'package:edxera/jobs/job_list_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:image_picker/image_picker.dart';

import '../utils/shared_pref.dart';

class JobController extends GetxController {
  final JobService _jobService = JobService();

  var jobList = <Datum>[].obs;
  var isLoading = false.obs;

  // Text Controllers for form fields
  final TextEditingController titleController = TextEditingController();
  final TextEditingController smallDescController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactLinkController = TextEditingController();
  final TextEditingController whatsappController = TextEditingController();
  final TextEditingController jobLocationController = TextEditingController();
  final TextEditingController jobSalaryController = TextEditingController();
  final TextEditingController maxSalaryController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController responsibilitiesController =
      TextEditingController();
  final TextEditingController requirementsController = TextEditingController();
  final TextEditingController skillsController = TextEditingController();
  final TextEditingController preferredQualificationController =
      TextEditingController();
  final TextEditingController jobBenefitsController = TextEditingController();
  final TextEditingController companyWebsiteController =
      TextEditingController();
  final TextEditingController companyLogoController = TextEditingController();
  XFile? selectedLogo;
  final TextEditingController deadlineController = TextEditingController();

  // Dropdown options
  final List<String> workTypes = ["On-site", "Remote", "Hybrid"];
  final List<String> jobTypes = [
    "Full-time",
    "Part-time",
    "Contract",
    "Internship"
  ];
  final List<String> experienceLevels = [
    "0-1 years",
    "1-3 years",
    "3-5 years",
    "5+ years"
  ];

  // Selected dropdown values
  final RxString selectedWorkType = "On-site".obs;
  final RxString selectedJobType = "Full-time".obs;
  final RxString selectedExperience = "0-1 years".obs;

  final RxInt applyStatus = 1.obs; // 1 for allowed, 0 for not allowed

  void loadJobs() async {
    isLoading(true);
    JobListModel? result = await _jobService.fetchJobList();
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

  void setCompanyLogo(File image) {
    companyLogoController.text = image.path;
  }

  Future<void> submitJob() async {
    try {
      isLoading.value = true;
      int userId = await PrefData.getUserId();

      if (selectedLogo == null) {
        Get.snackbar("Error", "Select company logo",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);

        return;
      }

      final jobData = dio.FormData.fromMap({
        "user_id": userId,
        "title": titleController.text,
        "shot_description": smallDescController.text,
        "description": descriptionController.text,
        "contact_email": emailController.text,
        "contact_whatsapp_number": whatsappController.text,
        "contact_link": contactLinkController.text,
        "apply_allowed_status": applyStatus.value,
        "job_salary": jobSalaryController.text,
        "max_salary": maxSalaryController.text,
        "job_location": jobLocationController.text,
        "work_type": selectedWorkType.value,
        "job_type": selectedJobType.value,
        "experience_level": selectedExperience.value,
        "responsibilities": responsibilitiesController.text,
        "requirements": requirementsController.text,
        "skills": skillsController.text,
        "preferred_qualification": preferredQualificationController.text,
        "job_benefits": jobBenefitsController.text,
        "company_website": companyWebsiteController.text,
        "company_logo": [
          await dio.MultipartFile.fromFile(
            selectedLogo!.path,
          )
        ],
        "deadline": deadlineController.text,
      });

      final response = await _jobService.addJob(jobData);
      isLoading.value = false;

      if (response["success"] == true) {
        Get.back();
        Get.snackbar("Success", response["message"],
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);

        // Clear controllers after success
        _clearControllers();

        Future.delayed(Duration(seconds: 1), () {
          // Close the AddJobScreen after success
        });
      } else {
        Get.snackbar("Error", response["message"],
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        log(response['message']);
      }
    } catch (e) {
      isLoading.value = false;
    } finally {
      isLoading.value = false;
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
    jobLocationController.clear();
    jobSalaryController.clear();
    maxSalaryController.clear();
    responsibilitiesController.clear();
    requirementsController.clear();
    skillsController.clear();
    preferredQualificationController.clear();
    jobBenefitsController.clear();
    companyWebsiteController.clear();
    companyLogoController.clear();
    deadlineController.clear();
  }

  @override
  void onClose() {
    titleController.dispose();
    smallDescController.dispose();
    descriptionController.dispose();
    emailController.dispose();
    contactLinkController.dispose();
    whatsappController.dispose();
    jobLocationController.dispose();
    jobSalaryController.dispose();
    maxSalaryController.dispose();
    responsibilitiesController.dispose();
    requirementsController.dispose();
    skillsController.dispose();
    preferredQualificationController.dispose();
    jobBenefitsController.dispose();
    companyWebsiteController.dispose();
    companyLogoController.dispose();
    deadlineController.dispose();
    super.onClose();
  }
}
