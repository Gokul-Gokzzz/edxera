import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:edxera/profile/Models/profile_model.dart';

class UserProfileService {
  final Dio _dio = Dio();
  final String _fetchProfileUrl =
      "https://www.edxera.com/api/user/get_user_profile";

  Future<UserProfile?> fetchUserProfile(String userId) async {
    try {
      final response = await _dio.post(
        _fetchProfileUrl,
        data: {"user_id": userId},
      );

      if (response.statusCode == 200) {
        return UserProfile.fromJson(response.data);
      } else {
        log("Error: ${response.statusCode} - ${response.data}");
        return null;
      }
    } on DioException catch (e) {
      log("Dio Error: ${e.message}");
      return null;
    } catch (e) {
      log("Other Error: $e");
      return null;
    }
  }

  final String _updateProfileUrl =
      "https://www.edxera.com/api/user/update_user_profile";

  Future<bool> updateUserProfile({
    required String userId,
    required String firstName,
    required String lastName,
    required String email,
    required String address,
    required String qualification,
    required String dateOfBirth,
    required String gender,
    String? profileImagePath,
    String? resumePath,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        "user_id": userId,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "address": address,
        "qualification": qualification,
        "date_of_birth": dateOfBirth,
        "gender": gender,
      });

      if (profileImagePath != null) {
        formData.files.add(MapEntry(
            "profile_image", await MultipartFile.fromFile(profileImagePath)));
      }
      if (resumePath != null) {
        formData.files
            .add(MapEntry("resume", await MultipartFile.fromFile(resumePath)));
      }

      final response = await _dio.post(
        _updateProfileUrl,
        data: formData,
      );

      if (response.statusCode == 200) {
        log("Profile updated successfully");
        return true;
      } else {
        log("Error updating profile: ${response.statusCode} - ${response.data}"); // Log details
        return false;
      }
    } on DioException catch (e) {
      log("Dio Error: ${e.message}");
      return false;
    } catch (e) {
      log("Other Error: $e");
      return false;
    }
  }
}
