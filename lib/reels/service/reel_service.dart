import 'package:edxera/reels/model/reel_model.dart';
import 'package:edxera/repositories/api/api.dart';
import 'package:edxera/repositories/api/api_constants.dart';

import '../../utils/shared_pref.dart';
import '../model/reel_users.dart';

class ReelService {
  final _dio = API();

  Future<List<ReelModel>> getReels() async {
    try {
      int userId = await PrefData.getUserId();
      final response = await _dio.sendRequest.post(ApiConstants.get_course_reels, data: {"user_id": userId});

      final data = ReelResponse.fromMap(response.data);
      return data.data ?? [];
    } catch (ex) {
      return [];
    }
  }

  Future<ReelModel?> getReelById({required int courseId}) async {
    try {
      int userId = await PrefData.getUserId();
      final response = await _dio.sendRequest.post(ApiConstants.get_course_reels_details, data: {
        "user_id": userId,
        "course_id": courseId,
      });

      final data = ReelModel.fromMap(response.data['data']);
      return data;
    } catch (ex) {
      return null;
    }
  }

  Future<List<ReelUser>> getLikes({required int courseId}) async {
    try {
      int userId = await PrefData.getUserId();
      final response = await _dio.sendRequest.post(ApiConstants.view_course_likes, data: {
        "user_id": userId,
        "course_id": courseId,
      });

      final List<ReelUser> data = (response.data['data'] as Iterable).map((e) => ReelUser.fromMap(e)).toList();
      return data;
    } catch (ex) {
      return [];
    }
  }

  Future<List<ReelUser>> getComments({required int courseId}) async {
    try {
      int userId = await PrefData.getUserId();
      final response = await _dio.sendRequest.post(ApiConstants.view_course_comments, data: {
        "user_id": userId,
        "course_id": courseId,
      });

      final List<ReelUser> data = (response.data['data'] as Iterable).map((e) => ReelUser.fromMap(e)).toList();
      return data;
    } catch (ex) {
      return [];
    }
  }

  Future<bool> likeDislike({required int courseId}) async {
    try {
      int userId = await PrefData.getUserId();
      final response = await _dio.sendRequest.post(ApiConstants.like_or_unlike_course, data: {
        "user_id": userId,
        "course_id": courseId,
      });
      if (response.statusCode == 200) {
        if (response.data['success']) {
          return true;
        }
      }
      return false;
    } catch (ex) {
      return false;
    }
  }

  Future<bool> addComment({required int courseId, required String comment}) async {
    try {
      int userId = await PrefData.getUserId();
      final response = await _dio.sendRequest.post(ApiConstants.comment_course, data: {
        "user_id": userId,
        "course_id": courseId,
        "comment": comment,
      });
      if (response.statusCode == 200) {
        if (response.data['success']) {
          return true;
        }
      }
      return false;
    } catch (ex) {
      return false;
    }
  }
}
