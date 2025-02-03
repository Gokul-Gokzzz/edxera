import 'package:dio/dio.dart';
import 'package:edxera/profile/Models/change_password_data_model.dart';
import 'package:edxera/profile/Models/payment_details_entity.dart';
import 'package:edxera/repositories/post_repository.dart';
import 'package:edxera/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPaymentDetailsController {
  RxBool isloader = false.obs;

  PostRepository postRepository = PostRepository();

  Rx<PaymentDetailsEntity> paymentdata = PaymentDetailsEntity().obs;

  getAnnouncementData() async {
    try {
      var userid = await PrefData.getUserId();

      Map<String, String> m = {'user_id': userid.toString()};
      var a = await postRepository.getPaymentDetails(m);

      paymentdata.value = a!;
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
  }

  PaymentDetailsEntity get batchAnnouncementDataModel => paymentdata.value;
}
