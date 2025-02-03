import 'package:dio/dio.dart';
import 'package:edxera/login/Models/login_data_model.dart';
import 'package:edxera/login/OtpVerification/otp_verification_screen.dart';
import 'package:edxera/login/PasswordOtpVerification/password_otp_verification_screen.dart';
import 'package:edxera/login/login_empty_state.dart';
import 'package:edxera/profile/Models/logout_data_model.dart';
import 'package:edxera/repositories/post_repository.dart';
import 'package:edxera/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordControllers extends GetxController {
  String emaildId = Get.arguments[0];
  String otp = Get.arguments[1];
  RxBool isloader = false.obs;
  PostRepository postRepository = PostRepository();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  void forgotPassword() async {
    isloader(true);
    var data = {
      'email': emaildId,
      'password': passwordController.text,
      'password_confirmation': confirmController.text,
      'otp': otp,
    };
    try {
      LogoutDataModel? classesData = await postRepository.resetPasswordApi(data);
      if ((classesData?.success ?? false)) {
        Get.offAll(EmptyState());
        Get.showSnackbar(
          GetSnackBar(
            backgroundColor: Colors.green,
            message: classesData?.message,
            duration: const Duration(seconds: 1),
          ),
        );
        //   showDialog(
        //     barrierDismissible: false,
        //     context: context,
        //     builder: (BuildContext context) => AlertDialog(
        //       backgroundColor: const Color(0XFFFFFFFF),
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(20),
        //       ),
        //       actions: [
        //         Center(
        //           child: Padding(
        //             padding: EdgeInsets.only(left: 15.w, right: 15.w),
        //             child: Column(
        //               children: [
        //                 SizedBox(height: 20.h),
        //                 Image(
        //                   image: const AssetImage("assets/Privacy2.png"),
        //                   height: 88.13.h,
        //                   width: 76.33.w,
        //                 ),
        //                 SizedBox(height: 20.h),
        //                 Text(
        //                   "Changed !",
        //                   style: TextStyle(
        //                       fontSize: 22.sp,
        //                       fontFamily: 'Gilroy',
        //                       fontWeight: FontWeight.w700),
        //                 ),
        //                 SizedBox(height: 20.h),
        //                 Align(
        //                   //alignment: Alignment.centerRight,
        //                   child: Text(
        //                     "Your password has been changed sucessfully ! ",
        //                     style: TextStyle(
        //                         fontSize: 15.sp,
        //                         fontFamily: 'Gilroy',
        //                         fontWeight: FontWeight.bold),
        //                     textAlign: TextAlign.center,
        //                   ),
        //                 ),
        //                 SizedBox(height: 20.h),
        //                 ok_button(),
        //               ],
        //             ),
        //           ),
        //         )
        //       ],
        //     ),
        //   ); // Navi
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
