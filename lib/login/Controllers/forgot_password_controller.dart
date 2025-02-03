import 'package:dio/dio.dart';
import 'package:edxera/login/Models/login_data_model.dart';
import 'package:edxera/login/OtpVerification/otp_verification_screen.dart';
import 'package:edxera/login/PasswordOtpVerification/password_otp_verification_screen.dart';
import 'package:edxera/profile/Models/logout_data_model.dart';
import 'package:edxera/repositories/post_repository.dart';
import 'package:edxera/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordControllers extends GetxController {
  RxBool isloader = false.obs;
  PostRepository postRepository = PostRepository();
  TextEditingController emailController = TextEditingController();

  void forgotPassword() async {
    var deviceids = DateTime.now();

    isloader(true);
    var data = {
      'email': emailController.text,
    };
    try {
      LogoutDataModel? classesData = await postRepository.forgotPasswordLoginData(data);
      if ((classesData?.success ?? false)) {
        Get.to(const PasswordOtpVerification(), arguments: emailController.text);
        Get.showSnackbar(
          GetSnackBar(
            backgroundColor: Colors.green,
            message: 'We sent Otp In Your Email Id Please check Your Email',
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
