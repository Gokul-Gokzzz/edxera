import 'package:dio/dio.dart';
import 'package:edxera/jobs/job_list_model.dart';

class JobService {
  final Dio _dio = Dio();
  final String _baseUrl = "https://xianinfotech.in/edxera/api";

  Future<JobListModel?> fetchJobList(int userId) async {
    try {
      Response response = await _dio.post("$_baseUrl/get_job_list", data: {
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
      Response response = await _dio.post("$_baseUrl/delete_job", data: {
        "job_id": jobId,
      });

      return response.statusCode == 200;
    } catch (e) {
      print("Error deleting job: $e");
      return false;
    }
  }

  Future<Map<String, dynamic>> addJob(Map<String, dynamic> jobData) async {
    try {
      final response = await _dio.post("$_baseUrl/add_job", data: jobData);
      return response.data;
    } catch (e) {
      return {"status": false, "message": "Error: ${e.toString()}"};
    }
  }
}
