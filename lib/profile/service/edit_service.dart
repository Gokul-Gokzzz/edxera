import 'package:dio/dio.dart';
import 'package:edxera/profile/Models/profile_model.dart';

class UserProfileService {
  final Dio _dio = Dio();
  final String _fetchProfileUrl =
      "https://xianinfotech.in/edxera/api/user/get_user_profile";
  final String _updateProfileUrl =
      "https://xianinfotech.in/edxera/api/user/update_user_profile";

  // Fetch User Profile
  Future<UserProfile?> fetchUserProfile(String userId) async {
    try {
      Response response = await _dio.post(
        _fetchProfileUrl,
        data: {"user_id": userId},
        options: Options(
          headers: {"Content-Type": "application/json"},
        ),
      );

      if (response.statusCode == 200) {
        return UserProfile.fromJson(response.data);
      } else {
        print("Error: ${response.statusMessage}");
        return null;
      }
    } catch (e) {
      print("Exception: $e");
      return null;
    }
  }

  // Update User Profile
  Future<bool> updateUserProfile({
    required String userId,
    required String firstName,
    required String lastName,
    required String email,
    required String address,
    required String qualification,
    required String dateOfBirth,
    required String gender,
    String? profileImagePath, // Optional file
    String? resumePath, // Optional file
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
        if (profileImagePath != null)
          "profile_image": await MultipartFile.fromFile(profileImagePath),
        if (resumePath != null)
          "resume": await MultipartFile.fromFile(resumePath),
      });

      Response response = await _dio.post(
        _updateProfileUrl,
        data: formData,
        options: Options(
          headers: {"Content-Type": "multipart/form-data"},
        ),
      );

      if (response.statusCode == 200) {
        print("Profile updated successfully");
        return true;
      } else {
        print("Error: ${response.statusMessage}");
        return false;
      }
    } catch (e) {
      print("Exception: $e");
      return false;
    }
  }
}
