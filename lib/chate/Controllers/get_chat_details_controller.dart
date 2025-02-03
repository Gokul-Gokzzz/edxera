import 'package:dio/dio.dart';
import 'package:edxera/batchs/Models/attendence_data_model.dart';
import 'package:edxera/chate/models/chat_details_data_model.dart';
import 'package:edxera/repositories/post_repository.dart';
import 'package:edxera/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailChateScreenController extends GetxController {
  RxBool isloader = false.obs;
  PostRepository postRepository = PostRepository();
  final Rx<GetChatDetailsDataModel> _getChatDetailsDataModel = GetChatDetailsDataModel().obs;
//AttendencePresentDataModel
  Future<void> getChatDetailsAPi(String id) async {
    isloader(true);

    var data = {
      //'user_id': 1.toString(),
      'user_id': await PrefData.getUserId(),
      'instructor_id': id,
    };
    print(data);

    try {
      GetChatDetailsDataModel? classesData = await postRepository.getChatDetailsAPi(data);
      if ((classesData?.success ?? false)) {
        if (classesData?.data != null) {
          _getChatDetailsDataModel.value = classesData!;
        }
        // Get.showSnackbar(
        //   GetSnackBar(
        //     backgroundColor: Colors.green,
        //     message: classesData.message,
        //     duration: const Duration(seconds: 1),
        //   ),
        // );
      } else {
        _getChatDetailsDataModel.value = classesData!;
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

  Future<void> sendMessage(String id, message) async {
    isloader(true);

    var data = {
      //'user_id': 1.toString(),
      'user_id': await PrefData.getUserId(),
      'instructor_id': id,
      'message': message,
    };
    print(data);

    try {
      AttendencePresentDataModel? classesData = await postRepository.sendMessageApi(data);
      if ((classesData?.success ?? false)) {
        getChatDetailsAPi(id);
        // Get.showSnackbar(
        //   GetSnackBar(
        //     backgroundColor: Colors.green,
        //     message: classesData.message,
        //     duration: const Duration(seconds: 1),
        //   ),
        // );
      } else {
        Get.showSnackbar(
          GetSnackBar(
            backgroundColor: Colors.red,
            message: classesData!.message,
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

  GetChatDetailsDataModel get getChatDetailsDataModel => _getChatDetailsDataModel.value;
}
