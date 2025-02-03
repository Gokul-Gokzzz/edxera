import 'package:dio/dio.dart';
import 'package:edxera/profile/Models/change_password_data_model.dart';
import 'package:edxera/repositories/post_repository.dart';
import 'package:edxera/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  RxBool isloader = false.obs;
  PostRepository postRepository = PostRepository();

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController newController = TextEditingController();

  void changePasswordApi() async {
    isloader(true);
    var data = {
      'old_password': passwordController.text,
      'password': newController.text,
      'password_confirmation': confirmController.text,
      'user_id': await PrefData.getUserId()
    };
    try {
      ChangePasswordDataModel? classesData = await postRepository.changePassword(data);
      if ((classesData?.success ?? false)) {
        Get.back();
        Get.showSnackbar(
          GetSnackBar(
            backgroundColor: Colors.green,
            message: classesData?.message,
            duration: const Duration(seconds: 1),
          ),
        );
      } else {
        Get.showSnackbar(
          GetSnackBar(
            backgroundColor: Colors.red,
            message: classesData?.message,
            duration: const Duration(seconds: 1),
          ),
        );
      }
    } on DioException catch (ex) {
      ChangePasswordDataModel? classesData = ChangePasswordDataModel.fromJson(ex.response!.data ?? null);
      Get.showSnackbar(
        GetSnackBar(
          backgroundColor: Colors.red,
          message: ex.message ?? classesData.message,
          duration: const Duration(seconds: 1),
        ),
      );
      isloader(false);
      if (ex.type == DioExceptionType.unknown) {}
    }
    isloader(false);
  }

  void delteAccountApi() async {
    isloader(true);
    var data = {'user_id': await PrefData.getUserId()};
    try {
      ChangePasswordDataModel? classesData = await postRepository.delteAccountApi(data);
      if ((classesData?.success ?? false)) {
        Get.back();
        Get.showSnackbar(
          GetSnackBar(
            backgroundColor: Colors.green,
            message: classesData?.message,
            duration: const Duration(seconds: 1),
          ),
        );
      } else {
        Get.showSnackbar(
          GetSnackBar(
            backgroundColor: Colors.red,
            message: classesData?.message,
            duration: const Duration(seconds: 1),
          ),
        );
      }
    } on DioException catch (ex) {
      ChangePasswordDataModel? classesData = ChangePasswordDataModel.fromJson(ex.response!.data ?? null);
      Get.showSnackbar(
        GetSnackBar(
          backgroundColor: Colors.red,
          message: ex.message ?? classesData.message,
          duration: const Duration(seconds: 1),
        ),
      );
      isloader(false);
      if (ex.type == DioExceptionType.unknown) {}
    }
    isloader(false);
  }
}
