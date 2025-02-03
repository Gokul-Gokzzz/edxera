import 'package:dio/dio.dart';
import 'package:edxera/batchs/Models/announcements_entity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../repositories/post_repository.dart';
import '../Models/announcements_entity.dart';

class AnouncementController extends GetxController {
  RxBool isloader = false.obs;

  PostRepository postRepository = PostRepository();

  Rx<AnnouncementsEntity> _announcements = AnnouncementsEntity().obs;

  getAnnouncementData(String batchid) async {
    Map<String, String> m = {'batch_id': batchid};

    try {
      var a = await postRepository.getAnnouncements(m);

      _announcements.value = a!;
    } on DioException catch (ex) {
      Get.showSnackbar(
        GetSnackBar(
          backgroundColor: Colors.red,
          message: ex.message,
          duration: const Duration(seconds: 1),
        ),
      );
      isloader(false);
      if (ex.type == DioExceptionType.unknown) {}
    }
  }

  AnnouncementsEntity get batchAnnouncementDataModel => _announcements.value;
}
