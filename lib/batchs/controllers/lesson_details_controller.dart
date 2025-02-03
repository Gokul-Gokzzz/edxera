import 'package:dio/dio.dart';
import 'package:edxera/My_cources/lesson_play.dart';
import 'package:edxera/batchs/BatchDetailsScreen/Modules/youtube_video_player.dart';
import 'package:edxera/batchs/BatchDetailsScreen/SubModules/pdf_viewers.dart';
import 'package:edxera/batchs/Models/study_plan_details_data_model.dart';
import 'package:edxera/home/Models/chapter_inner_data_model.dart';
import 'package:edxera/home/chpter_inner_screen.dart';
import 'package:edxera/repositories/post_repository.dart';
import 'package:edxera/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LessonDetailsController extends GetxController {
  RxBool isloader = false.obs;
  PostRepository postRepository = PostRepository();
  final Rx<StudyPlanViewDataModel> _studyPlanViewDataModel = StudyPlanViewDataModel().obs;
  final Rx<ChapterInnerDataModel> _chapterInnerDataModel = ChapterInnerDataModel().obs;

  void chepterInnerApiCall(String id, planId) async {
    isloader(true);
    try {
      ChapterInnerDataModel? classesData = await postRepository.chepterInnerApiCall(id, planId);
      if ((classesData?.success ?? false)) {
        if (classesData != null) _chapterInnerDataModel.value = classesData;
        // if ((classesData?.data?.chapter?.video ?? '') != '') {
        // var dataVIdeo = jsonDecode(homecontroller.todaysStudyPlanDataModel
        //         .data?.studyPlans?[0].items?[indexs].dvVideoFile ??
        //     '');
        // print(dataVIdeo["video"]);
        Get.to(() => ChapteInnerScreen(
              chapterInnerDataModel: classesData ?? ChapterInnerDataModel(),
            ));
        //   Get.to(
        //     () => VidioPlay(
        //         lessonplay:
        //             '${ApiConstants.publicBaseUrl}/${classesData?.data?.chapter?.video ?? ''}'),
        //   );
        // } else if ((classesData?.data?.chapter?.youTubeLink ?? '') != '') {
        //   Get.to(() => YoutubeVideoPlayerScreen(
        //       url: classesData?.data?.chapter?.youTubeLink ?? ''));
        // } else if ((classesData?.data?.chapter?.pdf ?? '') != '') {
        //   Get.to(() => PdfViwersScreen(
        //       name: classesData?.data?.chapter?.title ?? '',
        //       path:
        //           '${ApiConstants.publicBaseUrl}/${classesData?.data?.chapter?.pdf ?? ''}'));
        // }
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

  void studyPlanDetailsApi(String batchId) async {
    isloader(true);

    var data = {
      //'user_id': 1.toString(),
      'user_id': await PrefData.getUserId(),
      'batch_id': batchId,
    };
    print(data);

    try {
      StudyPlanViewDataModel? classesData = await postRepository.studyPlanDetailsApi(data);
      if ((classesData?.success ?? false)) {
        if (classesData?.data != null) {
          _studyPlanViewDataModel.value = classesData!;
        } else {
          _studyPlanViewDataModel.value = classesData!;
        }

        // Get.showSnackbar(
        //   GetSnackBar(
        //     backgroundColor: Colors.green,
        //     message: classesData?.message,
        //     duration: const Duration(seconds: 1),
        //   ),
        // );
      } else {
        _studyPlanViewDataModel.value = classesData!;
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

  StudyPlanViewDataModel get studyPlanViewDataModel => _studyPlanViewDataModel.value;
}
