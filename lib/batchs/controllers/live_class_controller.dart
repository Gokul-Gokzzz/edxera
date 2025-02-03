import 'package:dio/dio.dart';
import 'package:edxera/batchs/Models/live_class_list_data_model.dart';
import 'package:edxera/repositories/post_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/shared_pref.dart';

class LiveClassController extends GetxController {
  RxBool isloader = false.obs;

  PostRepository postRepository = PostRepository();
  final Rx<LiveClassListDataModel> _liveClassListDataModel = LiveClassListDataModel().obs;

  void liveClassApiCall(String batchId) async {
    isloader(true);

    var data = {
      //'user_id': 1.toString(),
      'user_id': await PrefData.getUserId(),
      'batch_id': batchId,
    };
    print(data);

    try {
      LiveClassListDataModel? classesData = await postRepository.liveClassApiCall(data);
      if ((classesData?.success ?? false)) {
        if (classesData?.data != null) {
          _liveClassListDataModel.value = classesData!;
        } else {
          _liveClassListDataModel.value = classesData!;
        }

        // Get.showSnackbar(
        //   GetSnackBar(
        //     backgroundColor: Colors.green,
        //     message: classesData?.message,
        //     duration: const Duration(seconds: 1),
        //   ),
        // );
      } else {
        _liveClassListDataModel.value = classesData!;
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

  LiveClassListDataModel get liveClassListDataModel => _liveClassListDataModel.value;
}

class RecorderVideoClassController extends GetxController {
  RxBool isloader = false.obs;

  PostRepository postRepository = PostRepository();
  final Rx<LiveClassListDataModel> _liveClassListDataModel = LiveClassListDataModel().obs;

  void liveClassApiCall(String batchId) async {
    isloader(true);

    var data = {
      //'user_id': 1.toString(),
      'user_id': await PrefData.getUserId(),
      'batch_id': batchId,
    };
    print(data);

    try {
      LiveClassListDataModel? classesData = await postRepository.liveClassApiCall(data);
      if ((classesData?.success ?? false)) {
        if (classesData?.data != null) {
          _liveClassListDataModel.value = classesData!;
        } else {
          _liveClassListDataModel.value = classesData!;
        }

        // Get.showSnackbar(
        //   GetSnackBar(
        //     backgroundColor: Colors.green,
        //     message: classesData?.message,
        //     duration: const Duration(seconds: 1),
        //   ),
        // );
      } else {
        _liveClassListDataModel.value = classesData!;
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

  LiveClassListDataModel get liveClassListDataModel => _liveClassListDataModel.value;
}
