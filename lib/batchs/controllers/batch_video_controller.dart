import 'package:dio/dio.dart';
import 'package:edxera/home/Models/study_matrial_video_data_model.dart';
import 'package:edxera/repositories/post_repository.dart';
import 'package:edxera/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BatchVideoController extends GetxController {
  RxBool isloader = false.obs;
  PostRepository postRepository = PostRepository();
  final Rx<BatchVideoStudyMatrialDataModel> _batchVideoStudyMatrialDataModel = BatchVideoStudyMatrialDataModel().obs;
  TextEditingController searchcontroller = new TextEditingController();

  batchVideoListApi(String examid, search) async {
    isloader(true);

    var data = {
      //'user_id': 1.toString(),
      'user_id': await PrefData.getUserId(),
      'batch_id': examid,
    };
    print(data);

    try {
      BatchVideoStudyMatrialDataModel? classesData = await postRepository.batchVideoListApi(data);
      if ((classesData?.success ?? false)) {
        if (classesData?.data != null) {
          _batchVideoStudyMatrialDataModel.value = classesData!;
        }
        isloader(false);
        // Get.showSnackbar(
        //   GetSnackBar(
        //     backgroundColor: Colors.green,
        //     message: classesData?.message,
        //     duration: const Duration(seconds: 1),
        //   ),
        // );
      } else {
        _batchVideoStudyMatrialDataModel.value = classesData!;
        isloader(false);
        // Get.showSnackbar(
        //   GetSnackBar(
        //     backgroundColor: Colors.red,
        //     message: classesData.message,
        //     duration: const Duration(seconds: 1),
        //   ),
        // );
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
    update();
  }

  BatchVideoStudyMatrialDataModel get batchVideoStudyMatrialDataModel => _batchVideoStudyMatrialDataModel.value;
}

class BatchStudyController extends GetxController {
  RxBool isloader = false.obs;
  PostRepository postRepository = PostRepository();
  final Rx<BatchVideoStudyMatrialDataModel> _batchVideoStudyMatrialDataModel = BatchVideoStudyMatrialDataModel().obs;
  TextEditingController searchcontroller = new TextEditingController();

  void batchVideoListApi(String examid, search) async {
    isloader(true);

    var data = {
      //'user_id': 1.toString(),
      'user_id': await PrefData.getUserId(),
      'batch_id': examid,
    };
    print(data);

    try {
      BatchVideoStudyMatrialDataModel? classesData = await postRepository.batchVideoListApi(data);
      if ((classesData?.success ?? false)) {
        if (classesData?.data != null) {
          _batchVideoStudyMatrialDataModel.value = classesData!;
        }

        // Get.showSnackbar(
        //   GetSnackBar(
        //     backgroundColor: Colors.green,
        //     message: classesData?.message,
        //     duration: const Duration(seconds: 1),
        //   ),
        // );
      } else {
        _batchVideoStudyMatrialDataModel.value = classesData!;
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

  BatchVideoStudyMatrialDataModel get batchVideoStudyMatrialDataModel => _batchVideoStudyMatrialDataModel.value;
}
