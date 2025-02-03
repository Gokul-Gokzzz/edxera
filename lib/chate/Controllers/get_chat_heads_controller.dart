import 'package:dio/dio.dart';
import 'package:edxera/chate/models/get_chat_heads_data_model.dart';
import 'package:edxera/repositories/post_repository.dart';
import 'package:edxera/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChateScreenController extends GetxController {
  RxBool isloader = false.obs;
  PostRepository postRepository = PostRepository();
  final Rx<GetChatHeadsDataModel> _getChatHeadsDataModel = GetChatHeadsDataModel().obs;
  List<ChatHeads> searchResult = [];
  TextEditingController searchcontroller = new TextEditingController();

  onSearchTextChanged(String text) async {
    searchResult.clear();
    if (text.isEmpty) {
      update(['Filter']);
      return;
    }

    getChatHeadsDataModel.data?.chatHeads?.forEach((userDetail) {
      if ((userDetail.sentBy ?? '').contains(text.toUpperCase())) {
        searchResult.add(userDetail);
      }
    });
    update(['Filter']);
  }

  Future<void> getChatHeadsApi() async {
    isloader(true);

    var data = {
      //'user_id': 1.toString(),
      'user_id': await PrefData.getUserId(),
    };
    print(data);

    try {
      GetChatHeadsDataModel? classesData = await postRepository.getChatHeadsApi(data);
      if ((classesData?.success ?? false)) {
        if (classesData?.data != null) {
          _getChatHeadsDataModel.value = classesData!;
        }
        // Get.showSnackbar(
        //   GetSnackBar(
        //     backgroundColor: Colors.green,
        //     message: classesData.message,
        //     duration: const Duration(seconds: 1),
        //   ),
        // );
      } else {
        _getChatHeadsDataModel.value = classesData!;
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

  GetChatHeadsDataModel get getChatHeadsDataModel => _getChatHeadsDataModel.value;
}
