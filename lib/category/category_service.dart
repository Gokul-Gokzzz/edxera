import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:edxera/category/categor_model.dart';
import 'package:edxera/category/user_category_model.dart';
import 'package:edxera/repositories/api/api.dart';
import 'package:edxera/repositories/api/api_constants.dart';

import '../utils/shared_pref.dart';

class CategoryService {
  final api = API();
  Future<CategoryModel?> fetchCategories({String search = ""}) async {
    int userId = await PrefData.getUserId();

    try {
      final Map<String, dynamic> requestData = {"user_id": userId};

      if (search.isNotEmpty) {
        requestData["search"] = search;
      }

      final Response response = await api.sendRequest.post(
        ApiConstants.get_all_categories,
        data: requestData, // Pass dynamic data
      );

      if (response.statusCode == 200) {
        log('API response: ${response.data}');
        return CategoryModel.fromJson(response.data);
      } else {
        log("Failed to fetch categories: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      log("Error fetching categories: $e");
      return null;
    }
  }

  Future<UserCategory?> fetchUserCategories() async {
    int userId = await PrefData.getUserId();

    try {
      final Response response = await api.sendRequest
          .post(ApiConstants.get_user_categories, data: {"user_id": userId});
      if (response.statusCode == 200) {
        log('API response: ${response.data}');
        return UserCategory.fromJson(response.data);
      } else {
        log("Failed to fetch categories: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      log("Error fetching categories: $e");
      return null;
    }
  }

  // Submit selected categories for a given userId
  Future<Response?> submitCategories(String categoryIds) async {
    int userId = await PrefData.getUserId();

    try {
      final Response response = await api.sendRequest
          .post(ApiConstants.add_categories_for_user, data: {
        "user_id": userId,
        "category_ids": categoryIds,
      });
      return response;
    } catch (e) {
      log("Error submitting categories: $e");
      return null;
    }
  }
}
