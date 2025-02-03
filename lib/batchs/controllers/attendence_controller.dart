import 'package:dio/dio.dart';
import 'package:edxera/batchs/Models/attendence_data_model.dart';
import 'package:edxera/batchs/Models/get_attendence_data_model.dart';
import 'package:edxera/repositories/post_repository.dart';
import 'package:edxera/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttendencePresentController extends GetxController {
  RxBool isloader = false.obs;
  PostRepository postRepository = PostRepository();
  final Rx<AttendencePresentDataModel> _attendencePresentDataModel = AttendencePresentDataModel().obs;
  final Rx<GetAttendenceDataModel> _getAttendenceDataModel = GetAttendenceDataModel().obs;
  Future<void> attendencePresentAPi(String examid) async {
    isloader(true);

    var data = {
      //'user_id': 1.toString(),
      'user_id': await PrefData.getUserId(),
      'batch_id': examid,
    };
    print(data);

    try {
      AttendencePresentDataModel? classesData = await postRepository.attendencePresentAPi(data);
      if ((classesData?.status ?? false)) {
        _attendencePresentDataModel.value = classesData!;

        // Get.showSnackbar(
        //   GetSnackBar(
        //     backgroundColor: Colors.green,
        //     message: classesData.message,
        //     duration: const Duration(seconds: 1),
        //   ),
        // );
      } else {
        _attendencePresentDataModel.value = classesData!;
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

  Future<void> getAttendencePresentAPi(String examid) async {
    isloader(true);

    var data = {
      //'user_id': 1.toString(),
      'user_id': await PrefData.getUserId(),
      'batch_id': examid,
    };
    print(data);

    try {
      GetAttendenceDataModel? classesData = await postRepository.getAttendencePresentAPi(data);
      if ((classesData?.success ?? false)) {
        if (classesData?.data != null) {
          _getAttendenceDataModel.value = classesData!;
        }

        // Get.showSnackbar(
        //   GetSnackBar(
        //     backgroundColor: Colors.green,
        //     message: classesData.message,
        //     duration: const Duration(seconds: 1),
        //   ),
        // );
      } else {
        _getAttendenceDataModel.value = classesData!;
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

  AttendencePresentDataModel get attendencePresentDataModel => _attendencePresentDataModel.value;

  GetAttendenceDataModel get getAttendenceDataModel => _getAttendenceDataModel.value;
}
