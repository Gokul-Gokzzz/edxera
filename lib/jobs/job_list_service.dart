import 'package:dio/dio.dart';
import 'package:edxera/jobs/job_list_model.dart';
import 'package:edxera/repositories/api/api.dart';
import 'package:edxera/repositories/api/api_constants.dart';

import '../utils/shared_pref.dart';

class JobService {
  final _dio = API();

  Future<JobListModel?> fetchJobList() async {
    try {
      int userId = await PrefData.getUserId();

      Response response = await _dio.sendRequest.post(ApiConstants.get_job_list, data: {
        "user_id": userId,
      });

      if (response.statusCode == 200) {
        return JobListModel.fromJson(response.data);
      }
    } catch (e) {
      print("Error fetching jobs: $e");
    }
    return null;
  }

  Future<bool> deleteJob(int jobId) async {
    try {
      Response response = await _dio.sendRequest.post(ApiConstants.delete_job, data: {
        "job_id": jobId,
      });

      return response.statusCode == 200;
    } catch (e) {
      print("Error deleting job: $e");
      return false;
    }
  }

  Future<Map<String, dynamic>> addJob(FormData jobData) async {
    try {
      final response = await _dio.sendRequest.post(ApiConstants.add_job, data: jobData);
      return response.data;
    } catch (e) {
      return {"status": false, "message": "Error: ${e.toString()}"};
    }
  }
}
