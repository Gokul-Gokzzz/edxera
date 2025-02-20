import 'dart:developer';
import 'dart:io';

import 'package:edxera/profile/Models/profile_model.dart';
import 'package:edxera/profile/service/edit_service.dart';
import 'package:edxera/utils/shared_pref.dart'; // For user ID
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfileController extends GetxController {
  final UserProfileService _service = UserProfileService();
  var userProfile = Rxn<UserProfile>();
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController dobNameController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final userIdInt = await PrefData.getUserId();
      if (userIdInt != null) {
        final userId = userIdInt.toString();
        final profile = await _service.fetchUserProfile(userId);
        if (profile != null && profile.data != null) {
          userProfile.value = profile;

          firstNameController.text =
              profile.data?.firstName ?? ""; // Set text here
          lastNameController.text = profile.data?.lastName ?? "";
          emailController.text = profile.data?.email ?? "";
          addressController.text = profile.data?.address ?? "";
          qualificationController.text = profile.data?.qualification ?? "";
          if (profile.data?.dateOfBirth != null) {
            dobNameController.text =
                "${profile.data!.dateOfBirth!.year}-${profile.data!.dateOfBirth!.month.toString().padLeft(2, '0')}-${profile.data!.dateOfBirth!.day.toString().padLeft(2, '0')}";
          } else {
            dobNameController.text = "";
          }
        } else {
          errorMessage.value = "Failed to load profile data.";
        }
      } else {
        errorMessage.value = "User ID not found.";
      }
    } catch (e) {
      errorMessage.value = e.toString();
      log('edit controller Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProfile({
    String? firstName,
    String? lastName,
    String? email,
    String? address,
    String? qualification,
    String? dateOfBirth,
    String? gender,
    File? profileImageFile,
    File? resumeFile,
  }) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final userIdInt = await PrefData.getUserId(); // Get userId as int?

      if (userIdInt != null) {
        final userId = userIdInt.toString(); // Convert to String here!

        final updated = await _service.updateUserProfile(
          userId: userId, // Use the String userId
          firstName: firstName ?? "",
          lastName: lastName ?? "",
          email: email ?? "",
          address: address ?? "",
          qualification: qualification ?? "",
          dateOfBirth: dateOfBirth ?? "",
          gender: gender ?? "",
          profileImagePath: profileImageFile?.path,
          resumePath: resumeFile?.path,
        );

        if (updated) {
          Get.snackbar("Success", "Profile updated successfully");
          await loadUserProfile();
        } else {
          errorMessage.value = "Failed to update profile.";
        }
      } else {
        errorMessage.value = "User ID not found.";
      }
    } catch (e) {
      errorMessage.value = e.toString();
      log('Error updating profile: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
