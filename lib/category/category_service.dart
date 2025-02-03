import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:edxera/category/categor_model.dart';

class CategoryService {
  final Dio _dio = Dio();

  // Fetch categories for a given userId
  Future<CategoryModel?> fetchCategories(String userId) async {
    const String url = "https://xianinfotech.in/edxera/api/get_all_categories";
    try {
      final Response response = await _dio.post(url, data: {"user_id": userId});
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

  // Submit selected categories for a given userId
  Future<Response?> submitCategories(String userId, String categoryIds) async {
    const String url =
        "https://xianinfotech.in/edxera/api/add_categories_for_user";
    try {
      final Response response = await _dio.post(url, data: {
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
