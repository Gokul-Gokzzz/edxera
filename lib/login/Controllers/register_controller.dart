import 'package:dio/dio.dart';
import 'package:edxera/home/home_main.dart';
import 'package:edxera/login/Models/login_data_model.dart';
import 'package:edxera/login/sign_up/verification_screen.dart';
import 'package:edxera/repositories/post_repository.dart';
import 'package:edxera/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RegisterControllers extends GetxController {
  RxBool isloader = false.obs;
  PostRepository postRepository = PostRepository();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  // TextEditingController passwordController = TextEditingController();
  // TextEditingController confirmpassController = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  RxString otp = ''.obs;

  void loginApi() async {
    var deviceids = DateTime.now();
    isloader(true);
    var data = {
      'first_name': nameController.text,
      'last_name': '',
      'email': emailController.text,
      // 'password': passwordController.text,
      'password': phoneNumber.text,
      'phone': phoneNumber.text,
      'password_confirmation': phoneNumber.text,
      // 'password_confirmation': passwordController.text,
      'device_token': deviceids.toString()
    };
    try {
      LoginDataModel? classesData = await postRepository.sendRegisterData(data);
      if ((classesData?.success ?? false)) {
        // PrefData.setLogin(true);
        // PrefData.setUserId(classesData?.data?.id ?? 0);
        // Get.offAll(const HomeMainScreen());
        PrefData.setdeviceToken(deviceids.toString());
        //TODO:- OtpVerification removed
        // Get.to(Verification(emailid: emailController.value.text));
        PrefData.setLogin(true);
        PrefData.setUserId(classesData?.data?.id ?? 0);
        Get.offAll(const HomeMainScreen());
        Get.showSnackbar(
          GetSnackBar(
            backgroundColor: Colors.green,
            message: classesData?.message,
            duration: const Duration(seconds: 1),
          ),
        );
      }
    } on DioException catch (ex) {
      String message = "Registration failed";
      if (ex.response?.data is Map<String, dynamic>) {
        Map<String, dynamic> data = ex.response?.data['data'];
        if (data.containsKey('message')) {
          message = data['message'] is List<dynamic> ? (data['message'] as List<dynamic>).first.toString() : data['message'];
        }
        if (data.containsKey('phone')) {
          message = data['phone'] is List<dynamic> ? (data['phone'] as List<dynamic>).first.toString() : data['phone'];
        }
        if (data.containsKey('email')) {
          message = data['email'] is List<dynamic> ? (data['email'] as List<dynamic>).first.toString() : data['email'];
        }
        if (data.containsKey('name')) {
          message = data['name'] is List<dynamic> ? (data['name'] as List<dynamic>).first.toString() : data['name'];
        }
        if (data.containsKey('password')) {
          message = data['password'] is List<dynamic> ? (data['password'] as List<dynamic>).first.toString() : data['password'];
        }
      }

      Get.showSnackbar(
        GetSnackBar(
          backgroundColor: Colors.red,
          message: ex.message ?? message,
          duration: const Duration(seconds: 1),
        ),
      );
      isloader(false);
      if (ex.type == DioExceptionType.unknown) {}
    }
    isloader(false);
  }

  void verificationCodeApi(String emailid) async {
    isloader(true);
    var data = {
      'otp': otp.value,
      'email': emailController.text,
    };
    try {
      LoginDataModel? classesData = await postRepository.verificatoionCode(data);
      if ((classesData?.success ?? false)) {
        PrefData.setLogin(true);
        PrefData.setUserId(classesData?.data?.id ?? 0);
        Get.defaultDialog(
          barrierDismissible: false,
          title: '',
          //middleText: '',
          content: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                Image(
                  image: AssetImage("assets/User_Approved.png"),
                  height: 90.h,
                  width: 78.w,
                ),
                SizedBox(height: 30.h),
                Text(
                  "Sucessful !",
                  style: TextStyle(fontSize: 22.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.h),
                Text(
                  "Your Email Are Verifired !!",
                  style: TextStyle(fontSize: 15.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32.h),
                ok_button(),
              ],
            ),
          ),
        );

        Get.showSnackbar(
          GetSnackBar(
            backgroundColor: Colors.green,
            message: classesData?.message,
            duration: const Duration(seconds: 1),
          ),
        );
      }
    } on DioException catch (ex) {
      Get.showSnackbar(
        GetSnackBar(
          backgroundColor: Colors.red,
          message: ex.message ?? ex.response?.data['message'],
          duration: const Duration(seconds: 1),
        ),
      );
      isloader(false);
      if (ex.type == DioExceptionType.unknown) {}
    }
    isloader(false);
  }

  Widget ok_button() {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Center(
        child: GestureDetector(
          onTap: () {
            Get.to(const HomeMainScreen());
          },
          child: Container(
            height: 56.h,
            width: 334.w,
            //color: Color(0XFF503494),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0XFF503494),
            ),
            child: Center(
              child: Text("Ok", style: TextStyle(color: Color(0XFFFFFFFF), fontSize: 18.sp, fontWeight: FontWeight.bold, fontFamily: 'Gilroy')),
            ),
          ),
        ),
      ),
    );
  }
}
