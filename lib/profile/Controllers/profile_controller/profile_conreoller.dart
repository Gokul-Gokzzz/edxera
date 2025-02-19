import 'package:edxera/profile/Models/profile_model.dart';
import 'package:edxera/profile/service/edit_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfileController extends GetxController {
  final UserProfileService _service = UserProfileService();
  var userProfile = Rxn<UserProfile>();
  var profile = Rxn<UserData>();
  var isLoading = false.obs;

  // TextEditingControllers for each field
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController addressNameController = TextEditingController();
  TextEditingController dobNameController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();

  Future<void> loadUserProfile(String userId) async {
    isLoading.value = true;

    var profile = await _service.fetchUserProfile(userId);
    if (profile != null && profile.data != null) {
      userProfile.value = profile;

      // Populate controllers with existing data
      firstNameController.text = profile.data?.firstName ?? "";
      lastNameController.text = profile.data?.lastName ?? "";
      qualificationController.text = profile.data?.qualification ?? "";
      emailController.text = profile.data?.email ?? "";
      addressController.text = profile.data?.address ?? "";
      phoneController.text = profile.data?.gender ?? "";
      addressController.text = profile.data?.address ?? "";
      dobNameController.text = profile.data?.dateOfBirth.toString() ?? "";
    }

    isLoading.value = false;
  }
}
