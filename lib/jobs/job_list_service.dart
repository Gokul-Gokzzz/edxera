import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:edxera/jobs/job_category_model.dart';
import 'package:edxera/jobs/job_list_model.dart';
import 'package:edxera/repositories/api/api.dart';
import 'package:edxera/repositories/api/api_constants.dart';

import '../utils/shared_pref.dart';

class JobService {
  // final _dio = API();
  final _dio = Dio();

  Future<JobListModel?> fetchJobList({String? search}) async {
    try {
      int userId = await PrefData.getUserId();

      Response response = await _dio.post(
        ApiConstants.get_job_list,
        data: {
          "user_id": userId,
          if ((search ?? "").isNotEmpty) "search": search,
        },
      );

      if (response.statusCode == 200) {
        return JobListModel.fromJson(response.data);
      }
    } catch (e) {
      print("Error fetching jobs: $e");
    }
    return null;
  }

  Future<List<JobCategory>> loadJobCategory() async {
    try {
      int userId = await PrefData.getUserId();

      Response response =
          await _dio.post(ApiConstants.get_job_categories, data: {
        "user_id": userId,
      });

      if (response.statusCode == 200) {
        final list = (response.data['data'] as Iterable)
            .map((e) => JobCategory.fromMap(e))
            .toList();
        return list;
      } else {
        return [];
      }
    } catch (e) {
      print("Error fetching jobs: $e");
      return [];
    }
  }

  Future<bool> deleteJobRequest(int jobId) async {
    try {
      Response response = await _dio.post(
        ApiConstants.delete_job,
        data: {"job_id": jobId},
        options: Options(
          headers: {"Content-Type": "application/json"},
        ),
      );
      log('Response Code: ${response.statusCode}');
      log('Response Data: ${response.data}');
      if (response.statusCode == 200) {
        log('Job Deleted Successfully');
        return true;
      } else {
        log('failed to delete job:${response.statusCode} - ${response.data}');
        return false;
      }
    } catch (e) {
      log("Error deleting job: $e");
      return false;
    }
  }

  Future<Map<String, dynamic>> addJob(FormData jobData) async {
    try {
      final response = await _dio.post(ApiConstants.add_job, data: jobData);
      return response.data;
    } catch (e) {
      return {"status": false, "message": "Error: ${e.toString()}"};
    }
  }
}
