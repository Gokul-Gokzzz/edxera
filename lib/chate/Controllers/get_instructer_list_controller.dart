import 'package:dio/dio.dart';
import 'package:edxera/chate/models/intructort_chat_list_data_model.dart';
import 'package:edxera/repositories/post_repository.dart';
import 'package:edxera/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetInstructorListController extends GetxController {
  RxBool isloader = false.obs;
  PostRepository postRepository = PostRepository();
  final Rx<IntructorsChatListDataModel> _getChatHeadsDataModel = IntructorsChatListDataModel().obs;

  Future<void> getChatInstructorHeadsApi(String courseid) async {
    isloader(true);

    var data = {
      'course_id': courseid,
      'user_id': await PrefData.getUserId(),
    };
    print(data);

    try {
      IntructorsChatListDataModel? classesData = await postRepository.getChatInstructorHeadsApi(data);
      if ((classesData?.success ?? false)) {
        if (classesData?.data != null) {
          _getChatHeadsDataModel.value = classesData!;
        }
        // Get.showSnackbar(
        //   GetSnackBar(
        //     backgroundColor: Colors.green,
        //     message: classesData.message,
        //     duration: const Duration(seconds: 1),
        //   ),
        // );
      } else {
        _getChatHeadsDataModel.value = classesData!;
        Get.showSnackbar(
          GetSnackBar(
            backgroundColor: Colors.red,
            message: classesData.message,
            duration: const Duration(seconds: 1),
          ),
        );
      }
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
    isloader(false);
  }

  IntructorsChatListDataModel get getChatHeadsDataModel => _getChatHeadsDataModel.value;
}
