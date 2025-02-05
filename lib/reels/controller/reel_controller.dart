import 'package:edxera/reels/model/reel_model.dart';
import 'package:edxera/reels/model/reel_users.dart';
import 'package:edxera/reels/service/reel_service.dart';
import 'package:get/get.dart';

class ReelController extends GetxController {
  RxList<ReelModel> reels = RxList.empty();
  RxBool isLoading = true.obs;
  bool hasError = false;
  getReels() async {
    isLoading.value = true;
    hasError = false;
    reels.value = [];
    try {
      reels.value = await ReelService().getReels();
      hasError = false;
    } catch (ex) {
      reels.value = [];

      hasError = true;
    } finally {
      isLoading.value = false;
    }
  }

  getReelById(int courseId) async {
    try {
      final model = await ReelService().getReelById(courseId: courseId);

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

  Future<List<ReelUser>> getLikes(int courseId) async {
    try {
      return await ReelService().getLikes(courseId: courseId);
    } catch (ex) {
      return [];
    }
  }

  Future<List<ReelUser>> getComments(int courseId) async {
    try {
      return await ReelService().getComments(courseId: courseId);
    } catch (ex) {
      return [];
    }
  }

  Future<bool> likeDislike({required int courseId}) async {
    try {
      bool res = await ReelService().likeDislike(courseId: courseId);
      await getReelById(courseId);
      return res;
    } catch (ex) {
      return false;
    }
  }

  Future<bool> addComment({required int courseId, required String comment}) async {
    try {
      bool res = await ReelService().addComment(courseId: courseId, comment: comment);
      await getReelById(courseId);
      return res;
    } catch (ex) {
      return false;
    }
  }
}
