import 'package:dio/dio.dart';
import 'package:edxera/category/category_view.dart';
import 'package:edxera/home/home_main.dart';
import 'package:edxera/login/Models/login_data_model.dart';
import 'package:edxera/login/OtpVerification/otp_verification_screen.dart';
import 'package:edxera/repositories/post_repository.dart';
import 'package:edxera/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginControllers extends GetxController {
  RxBool isloader = false.obs;
  PostRepository postRepository = PostRepository();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void loginApi() async {
    var deviceids = DateTime.now();

    isloader(true);
    var data = {'email': emailController.text, 'password': passwordController.text, 'device_token': deviceids.toString()};
    try {
      LoginDataModel? classesData = await postRepository.sendLoginData(data);
      if ((classesData?.success ?? false)) {
        //Get.offAll(const HomeMainScreen());
        // Get.to(Verification(emailid: emailController.value.text));
        PrefData.setdeviceToken(deviceids.toString());
        //TODO:- OtpVerification removed
        // Get.offAll(const OtpVerification());
        PrefData.setLogin(true);
        PrefData.setUserId(classesData?.data?.id ?? 0);
        PrefData.setUserPhone(classesData?.data?.phone ?? "0");
        // Get.offAll(const HomeMainScreen());
        Get.offAll(const CategoryGridView());

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
      Get.showSnackbar(
        GetSnackBar(
          backgroundColor: Colors.red,
          message: ex.message ??
              (ex.response?.data != null
                  ? (ex.response?.data as Map<String, dynamic>).containsKey('message')
                      ? ex.response?.data['message']
                      : ex.response?.statusMessage ?? "Login failed"
                  : "Login failed"),
          duration: const Duration(seconds: 2),
        ),
      );
      isloader(false);
      if (ex.type == DioExceptionType.unknown) {}
    }
    isloader(false);
  }
}
