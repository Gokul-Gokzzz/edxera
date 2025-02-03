import 'package:dio/dio.dart';
import 'package:edxera/login/Models/login_data_model.dart';
import 'package:edxera/login/reset_password.dart';
import 'package:edxera/profile/Models/logout_data_model.dart';
import 'package:edxera/repositories/post_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordOtpController extends GetxController {
  String emailid = Get.arguments;
  RxBool isloader = false.obs;
  RxString otp = ''.obs;

  PostRepository postRepository = PostRepository();

  void verificationCodeApi(String emailid) async {
    isloader(true);
    var data = {
      'otp': otp.value,
      'email': emailid,
    };
    try {
      LogoutDataModel? classesData = await postRepository.verificatoionCodePassword(data);
      if ((classesData?.success ?? false)) {
        Get.to(ResetPassword(), arguments: [emailid, otp.value]);
        Get.showSnackbar(
          GetSnackBar(
            backgroundColor: Colors.green,
            message: classesData?.message,
            duration: const Duration(seconds: 1),
          ),
        );
      } else {
        // Get.showSnackbar(
        //   GetSnackBar(
        //     backgroundColor: Colors.red,
        //     message: classesData?.message,
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
  }
}
