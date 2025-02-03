import 'package:dio/dio.dart';
import 'package:edxera/batchs/Models/batche_details_data_model.dart';
import 'package:edxera/batchs/Models/batches_list_data_model.dart';
import 'package:edxera/repositories/post_repository.dart';
import 'package:edxera/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BatchMainControleller extends GetxController with GetTickerProviderStateMixin {
  RxBool isloader = false.obs;
  PostRepository postRepository = PostRepository();
  final Rx<BatchesListDataModel> _batchesListDataModel = BatchesListDataModel().obs;

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
  }

  TextEditingController searchcontroller = new TextEditingController();

  onSearchTextChanged(String text) async {
    batchListDataGets(text);
  }

  void batchListDataGets(String text) async {
    isloader(true);

    try {
      BatchesListDataModel? classesData = await postRepository.batchListDataGet(text);
      if ((classesData?.success ?? false)) {
        if (classesData != null) _batchesListDataModel.value = classesData;

        // Get.showSnackbar(
        //   GetSnackBar(
        //     backgroundColor: Colors.green,
        //     message: classesData?.message,
        //     duration: const Duration(seconds: 1),
        //   ),
        // );
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
          message: ex.message,
          duration: const Duration(seconds: 1),
        ),
      );
      isloader(false);
      if (ex.type == DioExceptionType.unknown) {}
    }
    isloader(false);
  }

  void batchListbycourseDataGets(int id) async {
    isloader(true);

    try {
      BatchesListDataModel? classesData = await postRepository.batchListByCourseDataGet(id);
      if ((classesData?.success ?? false)) {
        if (classesData != null) _batchesListDataModel.value = classesData;

        // Get.showSnackbar(
        //   GetSnackBar(
        //     backgroundColor: Colors.green,
        //     message: classesData?.message,
        //     duration: const Duration(seconds: 1),
        //   ),
        // );
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
          message: ex.message,
          duration: const Duration(seconds: 1),
        ),
      );
      isloader(false);
      if (ex.type == DioExceptionType.unknown) {}
    }
    isloader(false);
  }

  BatchesListDataModel get batchesListDataModel => _batchesListDataModel.value;
}

class BatchDeatilsControleller extends GetxController with GetTickerProviderStateMixin {
  RxBool isloader = false.obs;
  PostRepository postRepository = PostRepository();
  final Rx<BatcheDetailsDataModel> _batcheDetailsDataModel = BatcheDetailsDataModel().obs;

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
  }

  void batchDataGets(String batchId) async {
    isloader(true);

    var data = {
      //'user_id': 1.toString(),
      'user_id': await PrefData.getUserId(),
      'batch_id': batchId,
    };
    print(data);

    try {
      BatcheDetailsDataModel? classesData = await postRepository.batchDataGet(data);
      if ((classesData?.success ?? false)) {
        if (classesData?.data != null) {
          _batcheDetailsDataModel.value = classesData!;
        } else {
          _batcheDetailsDataModel.value = classesData!;
        }

        // Get.showSnackbar(
        //   GetSnackBar(
        //     backgroundColor: Colors.green,
        //     message: classesData?.message,
        //     duration: const Duration(seconds: 1),
        //   ),
        // );
      } else {
        _batcheDetailsDataModel.value = classesData!;
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

  void joinClass(String batchId) async {
    isloader(true);

    var data = {
      //'user_id': 1.toString(),
      'user_id': await PrefData.getUserId(),
      'batch_id': batchId,
    };
    print(data);

    try {
      SuccesFullDataModel? classesData = await postRepository.joinClassData(data);
      if ((classesData?.success ?? false)) {
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
          message: ex.message,
          duration: const Duration(seconds: 1),
        ),
      );
      isloader(false);
      if (ex.type == DioExceptionType.unknown) {}
    }
    isloader(false);
  }

  void joinBatchClass(String batchId) async {
    isloader(true);

    var data = {
      //'user_id': 1.toString(),
      'user_id': await PrefData.getUserId(),
      'batch_code': batchId,
    };
    print(data);

    try {
      BatchesJoinCodeDataModel? classesData = await postRepository.joinBatchData(data);
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

  BatcheDetailsDataModel get batcheDetailsDataModel => _batcheDetailsDataModel.value;
}
