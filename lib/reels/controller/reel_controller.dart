import 'package:edxera/reels/model/reel_model.dart';
import 'package:edxera/reels/model/reel_users.dart';
import 'package:edxera/reels/service/reel_service.dart';
import 'package:get/get.dart';

class ReelController extends GetxController {
  RxList<ReelModel> reels = RxList.empty();
  RxBool isLoading = true.obs;
  bool hasError = false;

  getReels({String? search}) async {
    isLoading.value = true;
    hasError = false;
    reels.value = [];
    try {
      reels.value = await ReelService().getReels(search: search);
      hasError = false;
    } catch (ex) {
      reels.value = [];

      hasError = true;
    } finally {
      isLoading.value = false;
    }
  }

  getReelById(int courseId, int course_reels_id) async {
    try {
      final model = await ReelService()
          .getReelById(courseId: courseId, course_reels_id: course_reels_id);

      if (model != null) {
        int i = reels.indexWhere(
          (element) => element.id == model.id,
        );
        reels[i] = model;
      }
    } catch (ex) {
      isLoading.value = false;
    }
  }

  Future<List<ReelUser>> getLikes(int courseId, int course_reels_id) async {
    try {
      return await ReelService()
          .getLikes(courseId: courseId, course_reels_id: course_reels_id);
    } catch (ex) {
      return [];
    }
  }

  Future<List<ReelUser>> getComments(int courseId, int course_reels_id) async {
    try {
      return await ReelService()
          .getComments(courseId: courseId, course_reels_id: course_reels_id);
    } catch (ex) {
      return [];
    }
  }

  Future<bool> likeDislike(
      {required int courseId, required int course_reels_id}) async {
    try {
      bool res = await ReelService()
          .likeDislike(courseId: courseId, course_reels_id: course_reels_id);
      await getReelById(courseId, course_reels_id);
      return res;
    } catch (ex) {
      return false;
    }
  }

  Future<bool> addComment(
      {required int courseId,
      required String comment,
      required int course_reels_id}) async {
    try {
      bool res = await ReelService().addComment(
          courseId: courseId,
          comment: comment,
          course_reels_id: course_reels_id);
      await getReelById(courseId, course_reels_id);
      return res;
    } catch (ex) {
      return false;
    }
  }
}
