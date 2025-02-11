import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:edxera/My_cources/Models/course_data_model.dart';
import 'package:edxera/My_cources/lesson_play.dart';
import 'package:edxera/batchs/BatchDetailsScreen/Modules/exam_description_screen.dart';
import 'package:edxera/batchs/BatchDetailsScreen/Modules/exam_mcq_screen.dart';
import 'package:edxera/batchs/BatchDetailsScreen/Modules/study_plan_assigment_screen.dart';
import 'package:edxera/batchs/BatchDetailsScreen/Modules/youtube_video_player.dart';
import 'package:edxera/batchs/BatchDetailsScreen/SubModules/pdf_viewers.dart';
import 'package:edxera/batchs/Models/assigment_Result_Data_model.dart';
import 'package:edxera/batchs/Models/exam_mcq_data_model.dart';
import 'package:edxera/batchs/Models/exam_result_check_data_model.dart';
import 'package:edxera/batchs/Models/study_plan_assigment_data_model.dart';
import 'package:edxera/batchs/Models/study_plan_details_data_model.dart';
import 'package:edxera/batchs/Models/user_logout_or_not_data_model.dart';
import 'package:edxera/category/categor_model.dart';
import 'package:edxera/category/category_service.dart';
import 'package:edxera/category/user_category_model.dart';
import 'package:edxera/chate/detail_chate.dart';
import 'package:edxera/cources/Models/cources_details_data_model.dart';
import 'package:edxera/cources/Models/course_chapter_list_data_model.dart';
import 'package:edxera/cources/cources.dart';
import 'package:edxera/course_list/course_list_model.dart';
import 'package:edxera/home/Models/all_course_model.dart';
import 'package:edxera/home/Models/categories_detail_model.dart';
import 'package:edxera/home/Models/category_wise_product_list_data_model.dart';
import 'package:edxera/home/Models/chapter_inner_data_model.dart';
import 'package:edxera/home/Models/free_study_matrial_data_model.dart';
import 'package:edxera/home/Models/home_categories_model.dart';
import 'package:edxera/home/Models/home_dashborad_data_model.dart';
import 'package:edxera/home/Models/notification_count_data_model.dart';
import 'package:edxera/home/Models/notification_list_data_model.dart';
import 'package:edxera/home/Models/study_plans_name_data_model.dart';
import 'package:edxera/home/Models/testimonials_list_data_model.dart';
import 'package:edxera/home/Models/today_study_plan_data_model.dart';
import 'package:edxera/home/Models/trending_courses_data_model.dart';
import 'package:edxera/home/chpter_inner_screen.dart';
import 'package:edxera/login/login_empty_state.dart';
import 'package:edxera/profile/Models/contact_us_data_model.dart';
import 'package:edxera/profile/Models/faqs_list_data_model.dart';
import 'package:edxera/profile/Models/get_certificat_data_model.dart';
import 'package:edxera/profile/Models/logout_data_model.dart';
import 'package:edxera/profile/Models/privacy_policy_pages_data_model.dart';
import 'package:edxera/profile/Models/privacypolicy_entity.dart';
import 'package:edxera/profile/Models/user_data_model.dart';
import 'package:edxera/repositories/post_repository.dart';
import 'package:edxera/utils/shared_pref.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../My_cources/Models/course_data_entity.dart';
import '../batchs/Models/batches_list_data_model.dart';
import '../languagecontrols/LanguageCheck.dart';
import '../models/choose_plane.dart';

import '../repositories/api/api_constants.dart';
import '../utils/slider_page_data_model.dart';

class HomeController extends GetxController {
  RxInt currentpage = 1.obs;
  RxBool buttonpos = false.obs;
  RxBool isloader = false.obs;
  RxBool isStudyPlan = true.obs;
  RxString batchid = ''.obs;
  List<String> countries = [];

  RxString dropdownvalue = ''.obs;
  PostRepository postRepository = PostRepository();
  Rx<CategoriesModel> categoriesData = CategoriesModel().obs;
  Rx<CategoriesDetailModel> categoriesDetailsData = CategoriesDetailModel().obs;

  final Rx<HomeDashboardDataModel> _homeDashboardDataModel = HomeDashboardDataModel().obs;
  final Rx<TestimonialDataListDataModel> _testimonialDataListDataModel = TestimonialDataListDataModel().obs;
  final Rx<AllCourseModel> _trendingCoursesDataModel = AllCourseModel().obs;
  final Rx<CategoryWiseCourseListDataModel> _freeCourseDataModel = CategoryWiseCourseListDataModel().obs;
  final Rx<TodaysStudyPlanDataModel> _todaysStudyPlanDataModel = TodaysStudyPlanDataModel().obs;
  final Rx<ChapterInnerDataModel> _chapterInnerDataModel = ChapterInnerDataModel().obs;
  final Rx<StudyPlanCourseNameDataModel> _studyPlanCourseNameDataModel = StudyPlanCourseNameDataModel().obs;
  var categotry = CourseListModel();

  onChange(RxInt index) {
    currentpage.value = index.value;
    update();
  }

  onposchange(RxBool currentbuttonpos) {
    buttonpos.value = currentbuttonpos.value;
    update();
  }

  final Rx<UserDataModel> _userDataModel = UserDataModel().obs;

  Future<void> userDataApi() async {
    isloader(true);
    var data = {
      'user_id': await PrefData.getUserId(),
    };
    try {
      UserDataModel? classesData = await postRepository.userDataApi(data);
      if ((classesData?.success ?? false)) {
        if (classesData != null) _userDataModel.value = classesData;
      } else {
        // Get.showSnackbar(
        //   GetSnackBar(
        //     backgroundColor: Colors.red,
        //      message: classesData?.message,
        //     duration: const Duration(seconds: 1),
        //   ),
        // );
      }
    } on DioException catch (ex) {
      Get.showSnackbar(
        GetSnackBar(
          backgroundColor: Colors.red,
          message: ex.message.toString(),
          duration: const Duration(seconds: 1),
        ),
      );
      isloader(false);
      if (ex.type == DioExceptionType.unknown) {}
    }

    isloader(false);
  }

  UserDataModel get userDataModel => _userDataModel.value;
  final Rx<NotificationCountDataModel> _notificationCountDataModel = NotificationCountDataModel().obs;

  Future<void> notificationCountDataApi() async {
    isloader(true);
    var data = {
      'user_id': await PrefData.getUserId(),
    };
    try {
      NotificationCountDataModel? classesData = await postRepository.notificationCountDataApi(data);
      if ((classesData?.success ?? false)) {
        if (classesData != null) _notificationCountDataModel.value = classesData;
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
          message: ex.message.toString(),
          duration: const Duration(seconds: 1),
        ),
      );
      isloader(false);
      if (ex.type == DioExceptionType.unknown) {}
    }

    isloader(false);
  }

  NotificationCountDataModel get notificationCountDataModel => _notificationCountDataModel.value;

  Future<void> homeDashboardDatGetApi() async {
    isloader(true);

    try {
      HomeDashboardDataModel? classesData = await postRepository.homeDashboardDatGet();
      if ((classesData?.success ?? false)) {
        if (classesData != null) _homeDashboardDataModel.value = classesData;
      } else {
        // Get.showSnackbar(
        //   GetSnackBar(
        //     backgroundColor: Colors.red,
        //     message: classesData?.message ??" " ,
        //     duration: const Duration(seconds: 1),
        //   ),
        // );
      }
    } on DioException catch (ex) {
      Get.showSnackbar(
        GetSnackBar(
          backgroundColor: Colors.red,
          message: ex.message ?? 'Trying to access array offset on null',
          duration: const Duration(seconds: 1),
        ),
      );
      isloader(false);
      if (ex.type == DioExceptionType.unknown) {}
    }
    isloader(false);
  }

  Future<void> homeCategoryDataGetApi() async {
    isloader(true);

    try {
      final resp = await postRepository.homeCategoriesGet();
      if (resp != null) {
        categoriesData.value = CategoriesModel.fromMap(resp.data);
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
    } finally {
      isloader(false);
    }
  }

  Future<void> categoryDetailGetApi({required String id}) async {
    isloader(true);

    try {
      final resp = await postRepository.categoriesDetailGet(id: id);
      if (resp != null) {
        categoriesDetailsData.value = CategoriesDetailModel.fromMap(resp.data);
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
    } finally {
      isloader(false);
    }
  }

  final CategoryService categoryService = CategoryService();

  Rx<UserCategory> userCategory = UserCategory(data: []).obs;
  RxBool ishUserCategories = false.obs;

  Future<UserCategory> fetchUserCategories() async {
    try {
      ishUserCategories.value = true;

      userCategory.value = await categoryService.fetchUserCategories() ?? UserCategory(data: []);
      return userCategory.value;
    } catch (e) {
      userCategory.value = UserCategory(data: []);
      log('Error fetching course list: $e');
      return userCategory.value;
    } finally {
      update();
      ishUserCategories.value = false;
    }
  }

  Future<void> homeDashboardTrendingDatGetApi({String? search}) async {
    try {
      AllCourseModel? classesData = await postRepository.homeDashboardTrendingDatGet(search: search);
      if ((classesData?.success ?? false)) {
        if (classesData != null) _trendingCoursesDataModel.value = classesData;
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
          message: ex.message.toString(),
          duration: const Duration(seconds: 1),
        ),
      );
      isloader(false);
      if (ex.type == DioExceptionType.unknown) {}
    }
    isloader(false);
  }

  Future<void> chepterInnerApiCall(String id, planId) async {
    isloader(true);
    try {
      ChapterInnerDataModel? classesData = await postRepository.chepterInnerApiCall(id, planId);
      if ((classesData?.success ?? false)) {
        if (classesData != null) _chapterInnerDataModel.value = classesData;
        Get.to(() => ChapteInnerScreen(
              chapterInnerDataModel: classesData ?? ChapterInnerDataModel(),
            ));
        // if ((classesData?.data?.chapter?.video ?? '') != '') {
        //   // var dataVIdeo = jsonDecode(homecontroller.todaysStudyPlanDataModel
        //   //         .data?.studyPlans?[0].items?[indexs].dvVideoFile ??
        //   //     '');
        //   // print(dataVIdeo["video"]);

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
            message: classesData?.message ?? "Error",
            duration: const Duration(seconds: 1),
          ),
        );
      }
    } on DioException catch (ex) {
      Get.showSnackbar(
        GetSnackBar(
          backgroundColor: Colors.red,
          message: ex.message.toString(),
          duration: const Duration(seconds: 1),
        ),
      );
      isloader(false);
      if (ex.type == DioExceptionType.unknown) {}
    }
    isloader(false);
  }

  Future<void> homeDashboardTestimonailasDatGetApi() async {
    isloader(true);

    try {
      TestimonialDataListDataModel? classesData = await postRepository.homeDashboardTestimonailasDatGet();
      if ((classesData?.success ?? false)) {
        if (classesData != null) _testimonialDataListDataModel.value = classesData;
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
          message: ex.message.toString(),
          duration: const Duration(seconds: 1),
        ),
      );
      isloader(false);
      if (ex.type == DioExceptionType.unknown) {}
    }
    isloader(false);
  }

  Future<void> getTodayStudyPlan(String id) async {
    isloader(true);
    var data = {'user_id': await PrefData.getUserId(), 'batch_id': id};
    try {
      TodaysStudyPlanDataModel? classesData = await postRepository.todayStudyPlanApi(data);
      if ((classesData?.success ?? false)) {
        if (classesData != null) _todaysStudyPlanDataModel.value = classesData;
      } else {
        // Get.showSnackbar(
        //   GetSnackBar(
        //     backgroundColor: Colors.red,
        //     message: classesData?.message ??" " ,
        //     duration: const Duration(seconds: 1),
        //   ),
        // );
      }
    } on DioException catch (ex) {
      // Get.showSnackbar(
      //   GetSnackBar(
      //     backgroundColor: Colors.red,
      //     message: ex.message.toString(),
      //     duration: const Duration(seconds: 1),
      //   ),
      // );
      isloader(false);
      if (ex.type == DioExceptionType.unknown) {}
    }
    isloader(false);
  }

  @override
  void onInit() async {
    getTodayStudyPlan(await PrefData.getCourseId());
    // print(await PrefData.getCourseId().toString());
    super.onInit();
  }

  final Rx<StudyPlanViewDataModel> _studyPlanViewDataModel = StudyPlanViewDataModel().obs;

  StudyPlanViewDataModel get studyPlanViewDataModel => _studyPlanViewDataModel.value;

  Future<void> homeDashboardStudyPlansDatGetApi() async {
    isloader(true);
    countries.clear();
    try {
      StudyPlanCourseNameDataModel? classesData = await postRepository.homeDashboardStudyPlansDatGet();
      if ((classesData?.success ?? false)) {
        if (classesData != null) _studyPlanCourseNameDataModel.value = classesData;
        if ((classesData?.data?.userCourses?.length ?? 0) > 0) {
          for (var element in classesData?.data?.userCourses ?? []) {
            countries.add(element.courseTitle);
          }

          if (await PrefData.getCourseId() != '' && await PrefData.getCourseName() != '') {
            print(await PrefData.getCourseId());
            dropdownvalue.value = await PrefData.getCourseName();
            batchid.value = await PrefData.getCourseId();
            studyPlanDetailsApi(batchid.value);
          } else {
            PrefData.setCourseID((classesData?.data?.userCourses?[0].batchId ?? '').toString());
            PrefData.setCourseName(dropdownvalue.value = classesData?.data?.userCourses?[0].courseTitle ?? '');
            dropdownvalue.value = classesData?.data?.userCourses?[0].courseTitle ?? '';
            batchid.value = (classesData?.data?.userCourses?[0].batchId ?? '').toString();
            studyPlanDetailsApi(batchid.value);
          }
          getTodayStudyPlan(batchid.value);
        }
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
          message: ex.message.toString(),
          duration: const Duration(seconds: 1),
        ),
      );
      isloader(false);
      if (ex.type == DioExceptionType.unknown) {}
    }
    isloader(false);
  }

  void studyPlanDetailsApi(String batchId) async {
    isStudyPlan(true);

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
      }
    } on DioException catch (ex) {
      Get.showSnackbar(
        GetSnackBar(
          backgroundColor: Colors.red,
          message: ex.message,
          duration: const Duration(seconds: 1),
        ),
      );
      isStudyPlan(false);
      if (ex.type == DioExceptionType.unknown) {}
    }
    isStudyPlan(false);
  }

  HomeDashboardDataModel get homeDashboardDataModel => _homeDashboardDataModel.value;

  StudyPlanCourseNameDataModel get studyPlanCourseNameDataModel => _studyPlanCourseNameDataModel.value;

  TestimonialDataListDataModel get testimonialDataListDataModel => _testimonialDataListDataModel.value;

  AllCourseModel get trendingCoursesDataModel => _trendingCoursesDataModel.value;

  CategoryWiseCourseListDataModel get freeCourseDataModel => _freeCourseDataModel.value;

  TodaysStudyPlanDataModel get todaysStudyPlanDataModel => _todaysStudyPlanDataModel.value;

  void getFreeCourses() async {
    isloader(true);
    var data = {'category_id': 146};
    try {
      CategoryWiseCourseListDataModel? classesData = await postRepository.categoryWiseCourseListApi(data);
      if ((classesData?.success ?? false)) {
        if (classesData != null) _freeCourseDataModel.value = classesData;
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
          message: ex.message.toString(),
          duration: const Duration(seconds: 1),
        ),
      );
      isloader(false);
      if (ex.type == DioExceptionType.unknown) {}
    }
    isloader(false);
  }
}

class TrendingController extends GetxController {
  RxBool isloader = false.obs;

  RxString dropdownvalue = ''.obs;
  PostRepository postRepository = PostRepository();

  final Rx<AllCourseModel> _trendingCoursesDataModel = AllCourseModel().obs;

  void homeDashboardTrendingDatGetApi() async {
    isloader(true);
    try {
      AllCourseModel? classesData = await postRepository.homeDashboardTrendingDatGet();
      if ((classesData?.success ?? false)) {
        if (classesData != null) _trendingCoursesDataModel.value = classesData;
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
          message: ex.message.toString(),
          duration: const Duration(seconds: 1),
        ),
      );
      isloader(false);
      if (ex.type == DioExceptionType.unknown) {}
    }
    isloader(false);
  }

  AllCourseModel get trendingCoursesDataModel => _trendingCoursesDataModel.value;
}

class FreeStudyMatrialController extends GetxController {
  RxBool isloader = false.obs;

  RxString dropdownvalue = ''.obs;
  PostRepository postRepository = PostRepository();

  final Rx<FreeStudyMatrialListDataModel> _trendingCoursesDataModel = FreeStudyMatrialListDataModel().obs;

  TextEditingController searchcontroller = new TextEditingController();

  onSearchTextChanged(String text) async {
    homeDashboardTrendingDatGetApi(text);
  }

  void homeDashboardTrendingDatGetApi(String search) async {
    var data = {
      'search': search,
      'course_id': await PrefData.getCourseId(),
    };
    isloader(true);

    try {
      FreeStudyMatrialListDataModel? classesData = await postRepository.freestudyMatrialApi(data);
      if ((classesData?.success ?? false)) {
        if (classesData != null) _trendingCoursesDataModel.value = classesData;
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
          message: ex.message.toString(),
          duration: const Duration(seconds: 1),
        ),
      );
      isloader(false);
      if (ex.type == DioExceptionType.unknown) {}
    }
    isloader(false);
  }

  FreeStudyMatrialListDataModel get freeStudyMatrialListDataModel => _trendingCoursesDataModel.value;
}

class NotificationController extends GetxController {
  RxBool isloader = false.obs;

  RxString dropdownvalue = ''.obs;
  PostRepository postRepository = PostRepository();
  final Rx<ExamResultCheckDataModel> _examResultCheckDataModel = ExamResultCheckDataModel().obs;
  final Rx<NotificationListDataModel> _trendingCoursesDataModel = NotificationListDataModel().obs;
  final Rx<AssigmentResultDataModel> _assigmentResultDataModel = AssigmentResultDataModel().obs;

  // onSearchTextChanged(String text) async {
  //   homeDashboardTrendingDatGetApi(text);
  // }

  void notificationListDataGetApi() async {
    var data = {'user_id': await PrefData.getUserId()};
    isloader(true);

    try {
      NotificationListDataModel? classesData = await postRepository.getNotificationDataApi(data);
      if ((classesData?.success ?? false)) {
        if (classesData != null) _trendingCoursesDataModel.value = classesData;
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
          message: ex.message.toString(),
          duration: const Duration(seconds: 1),
        ),
      );
      isloader(false);
      if (ex.type == DioExceptionType.unknown) {}
    }
    isloader(false);
  }

  Future<void> clearnotificationDataGetApi(String id, int index) async {
    var data = {
      'user_id': await PrefData.getUserId(),
      'notification_id': id,
    };
    isloader(true);

    try {
      SubmitMcqDataModel? classesData = await postRepository.clearNotificationDataApi(data);
      if ((classesData?.success ?? false)) {
        if (_trendingCoursesDataModel.value.data?.userNotification?[index].notificationType == 'ASSIGNMENT_TODAY') {
          Get.to(StudyPlanAssigmentScreen(
            title: _trendingCoursesDataModel.value.data?.userNotification?[index].notificationType ?? '',
            assigmentid: (_trendingCoursesDataModel.value.data?.userNotification?[index].assignmentId ?? '').toString(),
            studyPlanId: (_trendingCoursesDataModel.value.data?.userNotification?[index].studyPlanItemsId ?? 0).toString(),
          ));
        } else if (_trendingCoursesDataModel.value.data?.userNotification?[index].notificationType == 'EXAM_TODAY') {
          if (_trendingCoursesDataModel.value.data?.userNotification?[index].examType == 'DESCRIPTION') {
            Get.to(ExamDescriptionScreen(
              examPogress: '',
              title: _trendingCoursesDataModel.value.data?.userNotification?[index].notificationType ?? '',
              examid: (_trendingCoursesDataModel.value.data?.userNotification?[index].examId ?? 0).toString(),
              studyPlanId: (_trendingCoursesDataModel.value.data?.userNotification?[index].studyPlanItemsId ?? 0).toString(),
            ));
          } else {
            Get.to(ExamMcqScreen(
              examPogress: '',
              title: _trendingCoursesDataModel.value.data?.userNotification?[index].notificationType ?? '',
              examid: (_trendingCoursesDataModel.value.data?.userNotification?[index].examId ?? 0).toString(),
              studyPlanId: (_trendingCoursesDataModel.value.data?.userNotification?[index].studyPlanItemsId ?? 0).toString(),
            ));
          }
        } else if (_trendingCoursesDataModel.value.data?.userNotification?[index].notificationType == 'EXAM_RESULT') {
          if (_trendingCoursesDataModel.value.data?.userNotification?[index].examType == 'DESCRIPTION') {
            resultCheckApi((_trendingCoursesDataModel.value.data?.userNotification?[index].examId ?? 0).toString(),
                (_trendingCoursesDataModel.value.data?.userNotification?[index].studyPlanItemsId ?? 0).toString(), 'DESCRIPTION');
          } else {
            resultCheckApi((_trendingCoursesDataModel.value.data?.userNotification?[index].examId ?? 0).toString(),
                (_trendingCoursesDataModel.value.data?.userNotification?[index].studyPlanItemsId ?? 0).toString(), 'EXAM_MCQ');
          }
        } else if (_trendingCoursesDataModel.value.data?.userNotification?[index].notificationType == 'ASSIGNMENT_RESULT') {
          resultAssigmentCheckApi(
            (_trendingCoursesDataModel.value.data?.userNotification?[index].assignmentId ?? 0).toString(),
            (_trendingCoursesDataModel.value.data?.userNotification?[index].studyPlanItemsId ?? 0).toString(),
          );
        } else if (_trendingCoursesDataModel.value.data?.userNotification?[index].notificationType == 'CHAT') {
          Get.to(DetailChate(
            name: _trendingCoursesDataModel.value.data?.userNotification?[index].childIdType ?? '',
            detail: (_trendingCoursesDataModel.value.data?.userNotification?[index].assignmentId ?? 0).toString(),
            imege: '',
          ));
        } else if (_trendingCoursesDataModel.value.data?.userNotification?[index].notificationType == 'COURSE_JOIN_ACCEPTED') {
          Get.to(MyCources(), arguments: _trendingCoursesDataModel.value.data?.userNotification?[index].courseId ?? 0);
        }
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
          message: ex.message.toString(),
          duration: const Duration(seconds: 1),
        ),
      );
      isloader(false);
      if (ex.type == DioExceptionType.unknown) {}
    }
    isloader(false);
  }

  void resultCheckApi(String examid, studyPlaniD, type) async {
    isloader(true);

    var data = {
      //'user_id': 1.toString(),
      'user_id': await PrefData.getUserId(),
      'exam_id': examid,
      'study_plan_items_id': studyPlaniD
    };
    print(data);

    try {
      ExamResultCheckDataModel? classesData = await postRepository.examResultCheckApi(data, type);
      if ((classesData?.success ?? false)) {
        if (classesData?.data != null) {
          _examResultCheckDataModel.value = classesData!;

          String lcode = await PrefData.getLanguage();

          var b = await LanguageCheck.checkLanguage(lcode);

          rateUs_dialogue(classesData, b);
        }

        // Get.showSnackbar(
        //   GetSnackBar(
        //     backgroundColor: Colors.green,
        //     message: classesData?.message ??" " ,
        //     duration: const Duration(seconds: 1),
        //   ),
        // );
      }
    } on DioException catch (ex) {
      Get.showSnackbar(
        GetSnackBar(
          backgroundColor: Colors.red,
          message: ex.message.toString(),
          duration: const Duration(seconds: 1),
        ),
      );
      isloader(false);
      if (ex.type == DioExceptionType.unknown) {}
    }
    isloader(false);
  }

  void resultAssigmentCheckApi(
    String examid,
    studyPlaniD,
  ) async {
    isloader(true);

    var data = {
      //'user_id': 1.toString(),
      'user_id': await PrefData.getUserId(),
      'assignment_id': examid,
      'study_plan_items_id': studyPlaniD
    };
    print(data);

    try {
      AssigmentResultDataModel? classesData = await postRepository.assigmentResultCheckApi(
        data,
      );
      if ((classesData?.success ?? false)) {
        if (classesData?.data != null) {
          _assigmentResultDataModel.value = classesData!;
          String lcode = await PrefData.getLanguage();

          var b = await LanguageCheck.checkLanguage(lcode);

          rateUs_Assigment_dialogue(classesData, b);
        }

        // Get.showSnackbar(
        //   GetSnackBar(
        //     backgroundColor: Colors.green,
        //     message: classesData?.message ??" " ,
        //     duration: const Duration(seconds: 1),
        //   ),
        // );
      } else {
        _assigmentResultDataModel.value = classesData!;
        Get.showSnackbar(
          GetSnackBar(
            backgroundColor: Colors.red,
            message: classesData.message.toString(),
            duration: const Duration(seconds: 1),
          ),
        );
      }
    } on DioException catch (ex) {
      Get.showSnackbar(
        GetSnackBar(
          backgroundColor: Colors.red,
          message: ex.message.toString(),
          duration: const Duration(seconds: 1),
        ),
      );
      isloader(false);
      if (ex.type == DioExceptionType.unknown) {}
    }
    isloader(false);
  }

  Future rateUs_dialogue(ExamResultCheckDataModel result, Map<String, dynamic> mplanguage) {
    return Get.defaultDialog(
        barrierDismissible: false,
        title: '',
        content: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                result.data?.examStatus ?? '',
                style: TextStyle(
                    fontSize: 14.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.bold, fontStyle: FontStyle.normal, color: Color(0XFF000000)),
              ),
            ),
            SizedBox(height: 15.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                mplanguage['totalquestions'].toString() + ' : ${result.data?.totalQuestions ?? ''}',
                style: TextStyle(
                    fontSize: 14.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, color: Color(0XFF000000)),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                mplanguage['totalquestionsanswered'].toString() + ': ${result.data?.totalQuestionsAnswered ?? ''}',
                style: TextStyle(
                    fontSize: 14.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, color: Color(0XFF000000)),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                mplanguage['totalcorrectanswers'].toString() + ': ${result.data?.totalCorrectAnswers ?? ''}',
                style: TextStyle(
                    fontSize: 14.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, color: Color(0XFF000000)),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                mplanguage['totalmarksofexam'].toString() + ' : ${result.data?.totalMarksOfExam ?? ''}',
                style: TextStyle(
                    fontSize: 14.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, color: Color(0XFF000000)),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                mplanguage['passmarks'].toString() + ' : ${result.data?.passMarks ?? ''}',
                style: TextStyle(
                    fontSize: 14.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, color: Color(0XFF000000)),
              ),
            ),
            SizedBox(height: 15.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                mplanguage['totalmarks'].toString() + ' : ${result.data?.totalMarksGiven ?? ''}',
                style: TextStyle(
                    fontSize: 14.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, color: Color(0XFF000000)),
              ),
            ),
            SizedBox(height: 15.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                mplanguage['totalpercent'].toString() + ' : ${result.data?.totalPercentage ?? ''}',
                style: TextStyle(
                    fontSize: 14.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, color: Color(0XFF000000)),
              ),
            ),
            SizedBox(height: 15.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                mplanguage['examresult'].toString() + ' : ${result.data?.examResult ?? ''}',
                style: TextStyle(
                    fontSize: 14.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, color: Color(0XFF000000)),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
              child: Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 56.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22.h),
                        color: const Color(0XFF503494),
                      ),
                      child: Center(
                          child: Text(
                        mplanguage['cancel'].toString(),
                        style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w700,
                            color: Color(0XFFFFFFFF),
                            fontStyle: FontStyle.normal,
                            fontSize: 14.sp),
                      )),
                    ),
                  )),
                  SizedBox(width: 10.w),
                ],
              ),
            )
          ],
        ));
  }

  NotificationListDataModel get notificationListDataModel => _trendingCoursesDataModel.value;

  AssigmentResultDataModel get assigmentResultDataModel => _assigmentResultDataModel.value;

  Future rateUs_Assigment_dialogue(AssigmentResultDataModel result, Map<String, dynamic> mplanguage) {
    return Get.defaultDialog(
        barrierDismissible: false,
        title: '',
        content: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                result.data?.assignmentStatus ?? '',
                style: TextStyle(
                    fontSize: 14.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.bold, fontStyle: FontStyle.normal, color: Color(0XFF000000)),
              ),
            ),
            SizedBox(height: 15.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                mplanguage['totalmarkofassignment'].toString() + ' : ${result.data?.totalMarksOfAssignment ?? ''}',
                style: TextStyle(
                    fontSize: 14.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, color: Color(0XFF000000)),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                mplanguage['passmarks'].toString() + ' : ${result.data?.passMarks ?? ''}',
                style: TextStyle(
                    fontSize: 14.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, color: Color(0XFF000000)),
              ),
            ),
            SizedBox(height: 15.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                mplanguage['totalmarks'].toString() + ' : ${result.data?.marksGiven ?? ''}',
                style: TextStyle(
                    fontSize: 14.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, color: Color(0XFF000000)),
              ),
            ),
            SizedBox(height: 15.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                mplanguage['assignmentresult'].toString() + ' : ${result.data?.assignmentResult ?? ''}',
                style: TextStyle(
                    fontSize: 14.sp, fontFamily: 'Gilroy', fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, color: Color(0XFF000000)),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
              child: Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 56.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22.h),
                        color: const Color(0XFF503494),
                      ),
                      child: Center(
                          child: Text(
                        mplanguage['cancel'].toString(),
                        style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w700,
                            color: Color(0XFFFFFFFF),
                            fontStyle: FontStyle.normal,
                            fontSize: 14.sp),
                      )),
                    ),
                  )),
                  SizedBox(width: 10.w),
                ],
              ),
            )
          ],
        ));
  }
}

class CategoryWiseSubjectController extends GetxController {
  RxBool isloader = false.obs;

  RxString dropdownvalue = ''.obs;
  PostRepository postRepository = PostRepository();

  final Rx<CategoryWiseCourseListDataModel> _trendingCoursesDataModel = CategoryWiseCourseListDataModel().obs;

  void homeDashboardTrendingDatGetApi(String id) async {
    isloader(true);
    var data = {'category_id': id};
    try {
      CategoryWiseCourseListDataModel? classesData = await postRepository.categoryWiseCourseListApi(data);
      if ((classesData?.success ?? false)) {
        if (classesData != null) _trendingCoursesDataModel.value = classesData;
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
          message: ex.message.toString(),
          duration: const Duration(seconds: 1),
        ),
      );
      isloader(false);
      if (ex.type == DioExceptionType.unknown) {}
    }
    isloader(false);
  }

  CategoryWiseCourseListDataModel get categoryWiseCourseListDataModel => _trendingCoursesDataModel.value;
}

class HomeMainController extends GetxController {
  RxBool isloader = false.obs;
  RxInt position = 0.obs;
  PostRepository postRepository = PostRepository();
  final Rx<UserLogourOrNotDataModel> _userValidOrNotDeviceToken = UserLogourOrNotDataModel().obs;

  void feedbackApi() async {
    isloader(true);
    var data = {
      'user_id': await PrefData.getUserId(),
      'device_token': await PrefData.getdeviceToken(),
    };
    print('Token Device ${PrefData.getdeviceToken()}');
    try {
      UserLogourOrNotDataModel? classesData = await postRepository.userLogourOrNotApiCall(data);
      if ((classesData?.success ?? false)) {
        if (classesData?.data?.status ?? false) {
          isloader(false);
        } else {
          PrefData.setLogin(false);
          Get.offAll(EmptyState());
        }
      } else {
        Get.back();
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
          message: ex.message.toString(),
          duration: const Duration(seconds: 1),
        ),
      );
      isloader(false);
      if (ex.type == DioExceptionType.unknown) {}
    }

    isloader(false);
  }

  onChange(int value) {
    position.value = value;
    update();
  }
}

class CourceController extends GetxController with GetTickerProviderStateMixin {
  late TabController tabController;
  late PageController pController;
  RxBool isloader = false.obs;
  FlickManager? flickManager = null;
  Rx<CourseImage>? imageGroup = null;
  RxBool isVideoLoaded = false.obs;
  RxBool isVideoLoading = false.obs;
  RxDouble rating = 3.0.obs;
  TextEditingController nameController = TextEditingController();
  PostRepository postRepository = PostRepository();
  final Rx<CourseDataEntity> _courseDetailsDataModel = CourseDataEntity().obs;
  final Rx<CourseChapterListDataModel> _courseChapterListDataModel = CourseChapterListDataModel().obs;
  int courseId = Get.arguments != null ? Get.arguments : 0;

  final Rx<BatchesListDataModel> _batchesListDataModel = BatchesListDataModel().obs;

  @override
  void onClose() {
    tabController.dispose();
    if (flickManager != null) {
      flickManager!.dispose();
    }
    super.onClose();
  }

  @override
  void onInit() {
    tabController = TabController(length: 3, vsync: this);

    batchListbycourseDataGets();
    tabController = TabController(length: 3, vsync: this);
    pController = PageController();

    super.onInit();
  }

  @override
  Future<void> onReady() async {
    await courseDetailsDataGets();
    super.onReady();
  }

  void batchListbycourseDataGets() async {
    isloader(true);

    try {
      BatchesListDataModel? classesData = await postRepository.batchListByCourseDataGet(courseId);
      if ((classesData?.success ?? false)) {
        if (classesData != null) _batchesListDataModel.value = classesData;
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
          message: ex.message.toString(),
          duration: const Duration(seconds: 1),
        ),
      );
      isloader(false);
      if (ex.type == DioExceptionType.unknown) {}
    }
    isloader(false);
  }

  void feedbackApi(String id) async {
    isloader(true);
    var data = {
      'user_id': await PrefData.getUserId(),
      'rating': rating.value,
      'comment': nameController.text,
      'type': 'course',
      'id': id,
    };
    try {
      StudyPlanAssigmentSubmitDataModel? classesData = await postRepository.writeCourseReview(data);
      if ((classesData?.success ?? false)) {
        if (classesData != null) Get.back();
        Get.showSnackbar(
          GetSnackBar(
            backgroundColor: Colors.green,
            message: classesData?.message,
            duration: const Duration(seconds: 1),
          ),
        );
      } else {
        Get.back();
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
          message: ex.message.toString(),
          duration: const Duration(seconds: 1),
        ),
      );
      isloader(false);
      if (ex.type == DioExceptionType.unknown) {}
    }

    isloader(false);
  }

  Future<bool> checkByPassApi() async {
    try {
      final resp = await postRepository.bypassPaymentApi();
      return resp;
    } catch (e, s) {
      return false;
    }
  }

  Future<void> courseDetailsDataGets() async {
    isloader(true);
    isVideoLoading(true);
    var data = {
      'user_id': PrefData.getUserId().toString(),
      'course_id': courseId.toString(),
    };
    //print(data);
    try {
      CourseDataEntity? classesData = await postRepository.courseDetailsDataGet(courseId.toString());
      if ((classesData?.success ?? false)) {
        if (classesData != null) {
          _courseDetailsDataModel.value = classesData;
          imageGroup = classesData.data?.course?.image?.obs;
          if (_courseDetailsDataModel.value.data?.course?.video == null) {
            isVideoLoaded.value = false;
          } else {
            if (_courseDetailsDataModel.value.data?.course?.video is String) {
              flickManager = FlickManager(
                videoPlayerController: VideoPlayerController.networkUrl(Uri.parse(
                  (_courseDetailsDataModel.value.data?.course?.video as String).isURL
                      ? _courseDetailsDataModel.value.data?.course?.video
                      : '${ApiConstants.publicBaseUrl}/${_courseDetailsDataModel.value.data?.course?.video ?? ''}',
                )),
                autoPlay: false,
              );
              isVideoLoaded.value = true;
              print('${ApiConstants.publicBaseUrl}/${_courseDetailsDataModel.value.data?.course?.video ?? ''}');
            } else {
              Map<String, dynamic> videoData = _courseDetailsDataModel.value.data?.course?.video;
              if (videoData.containsKey('image')) {
                flickManager = FlickManager(
                  videoPlayerController: VideoPlayerController.networkUrl(Uri.parse(
                    '${ApiConstants.publicBaseUrl}/${_courseDetailsDataModel.value.data?.course?.video['image'] ?? ''}',
                  )),
                  autoPlay: false,
                );
                isVideoLoaded.value = true;
                print('${ApiConstants.publicBaseUrl}/${_courseDetailsDataModel.value.data?.course?.video['image'] ?? ''}');
              } else {
                isVideoLoaded.value = false;
              }
            }
          }
          update();
          await courseChapterListDetailsDataGets(_courseDetailsDataModel.value.data?.course?.id ?? 0);
          Get.showSnackbar(
            GetSnackBar(
              backgroundColor: Colors.green,
              message: classesData?.message,
              duration: const Duration(seconds: 1),
            ),
          );
        } else {
          isVideoLoaded.value = false;
          imageGroup = null;
        }
      } else {}
    } on DioException catch (ex) {
      isVideoLoaded.value = false;
      Get.showSnackbar(
        GetSnackBar(
          backgroundColor: Colors.red,
          message: ex.message.toString(),
          duration: const Duration(seconds: 1),
        ),
      );
      isloader(false);
      if (ex.type == DioExceptionType.unknown) {}
    } finally {
      isVideoLoading(false);
    }
    isloader(false);
  }

  void couserPurchaseRequest() async {
    isloader(true);
    var data = {
      'user_id': await PrefData.getUserId(),
      'course_id': courseId.toString(),
    };
    print(data);
    CourseDetailsDataModel? classesData = await postRepository.coursePurchaseDetails(data);

    isloader(false);
  }

  Future<void> courseChapterListDetailsDataGets(int courseid) async {
    isloader(true);

    try {
      CourseChapterListDataModel? classesData = await postRepository.courseChalpterListDetailsDataGet(courseid.toString());
      if ((classesData?.success ?? false)) {
        if (classesData != null) _courseChapterListDataModel.value = classesData;

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
        //     message: classesData?.message ??" " ,
        //     duration: const Duration(seconds: 1),
        //   ),
        // );
      }
    } on DioException catch (ex) {
      Get.showSnackbar(
        GetSnackBar(
          backgroundColor: Colors.red,
          message: ex.message.toString(),
          duration: const Duration(seconds: 1),
        ),
      );
      isloader(false);
      if (ex.type == DioExceptionType.unknown) {}
    }
    isloader(false);
  }

  CourseDataEntity get courseDetailsDataModel => _courseDetailsDataModel.value;

  CourseChapterListDataModel get courseChapterListDataModel => _courseChapterListDataModel.value;

  BatchesListDataModel get batchmodel => _batchesListDataModel.value;
}

class ChooseController extends GetxController {
  List<ChoicePlane> plane = Utils.getChoosePlane();
}

class ProfilePageController extends GetxController {
  //String? selectedGender;
  //var dataModel = Get.arguments();
  final List<String> choice = ['0', '1'];

  String? select;

  void onClickRadioButton(value) {
    print(value);
    select = value;
    update();
  }
}

class PaymentSelectionController extends GetxController {
  final List<String> choice = ['0', '1', '2', '3'];

  String? select;

  void onClickPaymentRadioButton(value) {
    print(value);
    select = value;
    update();
  }
}

class OngoingCompletedController extends GetxController with GetTickerProviderStateMixin {
  late PageController pController;

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}

class OngoingController extends GetxController {
  RxBool isloader = false.obs;
  PostRepository postRepository = PostRepository();
  final Rx<CourseDataModel> _courseDataModel = CourseDataModel().obs;

  @override
  void onInit() {
    courseDataApi();
    super.onInit();
  }

  void courseDataApi() async {
    isloader(true);
    var data = {
      'user_id': await PrefData.getUserId(),
      'status': 'ONGOING',
    };
    print(data);
    try {
      CourseDataModel? classesData = await postRepository.courseDataApi(data);
      if ((classesData?.success ?? false)) {
        if (classesData != null) _courseDataModel.value = classesData;

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
          message: ex.message.toString(),
          duration: const Duration(seconds: 1),
        ),
      );
      isloader(false);
      if (ex.type == DioExceptionType.unknown) {}
    }
    isloader(false);
  }

  void courseDataApi2() async {
    isloader(true);
    var data = {
      'user_id': await PrefData.getUserId(),
    };
    print(data);
    try {
      CourseDataModel? classesData = await postRepository.courseDataApi(data);
      if ((classesData?.success ?? false)) {
        if (classesData != null) _courseDataModel.value = classesData;

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
          message: ex.message.toString(),
          duration: const Duration(seconds: 1),
        ),
      );
      isloader(false);
      if (ex.type == DioExceptionType.unknown) {}
    }
    isloader(false);
  }

  CourseDataModel get courseDataModel => _courseDataModel.value;
}

class CompletedController extends GetxController {
  RxBool isloader = false.obs;
  PostRepository postRepository = PostRepository();
  final Rx<CourseDataModel> _courseDataModel = CourseDataModel().obs;

  void courseDataApi() async {
    isloader(true);
    var data = {
      'user_id': await PrefData.getUserId(),
      'status': 'COMPLETED',
    };
    print(data);
    try {
      CourseDataModel? classesData = await postRepository.courseDataApi(data);
      if ((classesData?.success ?? false)) {
        if (classesData != null) _courseDataModel.value = classesData;

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
          message: ex.message.toString(),
          duration: const Duration(seconds: 1),
        ),
      );
      isloader(false);
      if (ex.type == DioExceptionType.unknown) {}
    }
    isloader(false);
  }

  CourseDataModel get courseDataModel => _courseDataModel.value;
}

class CourceDetailController extends GetxController {}

class MyProfileController extends GetxController {
  RxBool isloader = false.obs;
  PostRepository postRepository = PostRepository();
  final Rx<UserDataModel> _userDataModel = UserDataModel().obs;
  RxDouble rating = 3.0.obs;

  void userDataApi() async {
    isloader(true);
    var data = {
      'user_id': await PrefData.getUserId(),
    };
    try {
      UserDataModel? classesData = await postRepository.userDataApi(data);
      if ((classesData?.success ?? false)) {
        if (classesData != null) _userDataModel.value = classesData;

        // Get.showSnackbar(
        //   GetSnackBar(
        //     backgroundColor: Colors.green,
        //     message: classesData?.message ??" " ,
        //     duration: const Duration(seconds: 1),
        //   ),
        // );
      } else {
        // Get.showSnackbar(
        //   GetSnackBar(
        //     backgroundColor: Colors.red,
        //      message: classesData?.message,
        //     duration: const Duration(seconds: 1),
        //   ),
        // );
      }
    } on DioException catch (ex) {
      Get.showSnackbar(
        GetSnackBar(
          backgroundColor: Colors.red,
          message: ex.message.toString(),
          duration: const Duration(seconds: 1),
        ),
      );
      isloader(false);
      if (ex.type == DioExceptionType.unknown) {}
    }
    update(['UserData']);
    isloader(false);
  }

  void ratingApi() async {
    isloader(true);
    var data = {
      'user_id': await PrefData.getUserId(),
      'rating': rating.value,
    };
    try {
      StudyPlanAssigmentSubmitDataModel? classesData = await postRepository.ratingAppPoup(data);
      if ((classesData?.success ?? false)) {
        if (classesData != null) ;
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
          message: ex.message.toString(),
          duration: const Duration(seconds: 1),
        ),
      );
      isloader(false);
      if (ex.type == DioExceptionType.unknown) {}
    }

    isloader(false);
  }

  void logout() async {
    isloader(true);
    var data = {
      'user_id': await PrefData.getUserId(),
    };
    try {
      LogoutDataModel? classesData = await postRepository.logoutApiCall(data);
      if ((classesData?.success ?? false)) {
        PrefData.setLogin(false);
        Get.offAll(EmptyState());
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
          message: ex.message.toString(),
          duration: const Duration(seconds: 1),
        ),
      );
      isloader(false);
      if (ex.type == DioExceptionType.unknown) {}
    }

    isloader(false);
  }

  UserDataModel get userDataModel => _userDataModel.value;
}

class EditScreenController extends GetxController {
  RxBool isloader = false.obs;
  PostRepository postRepository = PostRepository();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final Rx<UserDataModel> _userDataModel = UserDataModel().obs;

  void userDataApi() async {
    isloader(true);
    var data = {
      'user_id': await PrefData.getUserId(),
    };
    try {
      UserDataModel? classesData = await postRepository.userDataApi(data);
      if ((classesData?.success ?? false)) {
        if (classesData != null) _userDataModel.value = classesData;

        nameController.text = classesData?.data?.name ?? '';
        emailController.text = classesData?.data?.email ?? '';
        passwordController.text = classesData?.data?.phone ?? '';
      } else {
        // Get.showSnackbar(
        //   GetSnackBar(
        //     backgroundColor: Colors.red,
        //      message: classesData?.message,
        //     duration: const Duration(seconds: 1),
        //   ),
        // );
      }
    } on DioException catch (ex) {
      Get.showSnackbar(
        GetSnackBar(
          backgroundColor: Colors.red,
          message: ex.message.toString(),
          duration: const Duration(seconds: 1),
        ),
      );
      isloader(false);
      if (ex.type == DioExceptionType.unknown) {}
    }

    isloader(false);
  }

  UserDataModel get userDataModel => _userDataModel.value;
}

class FeedBackController extends GetxController {
  RxBool isloader = false.obs;
  PostRepository postRepository = PostRepository();
  RxDouble ratings = 3.0.obs;

  TextEditingController nameController = TextEditingController();

  final Rx<StudyPlanAssigmentSubmitDataModel> _userDataModel = StudyPlanAssigmentSubmitDataModel().obs;

  void feedbackApi() async {
    isloader(true);
    var data = {'user_id': await PrefData.getUserId(), 'rating': ratings.value, 'comment': nameController.text};
    try {
      StudyPlanAssigmentSubmitDataModel? classesData = await postRepository.feedbackApi(data);
      if ((classesData?.success ?? false)) {
        if (classesData != null) _userDataModel.value = classesData;
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
          message: ex.message.toString(),
          duration: const Duration(seconds: 1),
        ),
      );
      isloader(false);
      if (ex.type == DioExceptionType.unknown) {}
    }

    isloader(false);
  }

  StudyPlanAssigmentSubmitDataModel get studyPlanAssigmentSubmitDataModel => _userDataModel.value;
}

class MyCertificationScreenConyroller extends GetxController {
  RxBool isloader = false.obs;
  PostRepository postRepository = PostRepository();
  final Rx<GetCourseCertificateDataModel> _getCourseCertificateDataModel = GetCourseCertificateDataModel().obs;

  void getCretificate() async {
    isloader(true);
    var data = {
      'user_id': await PrefData.getUserId(),
    };
    try {
      GetCourseCertificateDataModel? classesData = await postRepository.getCretificate(data);
      if ((classesData?.success ?? false)) {
        if (classesData != null) _getCourseCertificateDataModel.value = classesData;
        // Get.back();
        // Get.showSnackbar(
        //   GetSnackBar(
        //     backgroundColor: Colors.green,
        //     message: classesData?.message ??" " ,
        //     duration: const Duration(seconds: 1),
        //   ),
        // );
      } else {
        // Get.showSnackbar(
        //   GetSnackBar(
        //     backgroundColor: Colors.red,
        //     message: classesData?.message ??" " ,
        //     duration: const Duration(seconds: 1),
        //   ),
        // );
      }
    } on DioException catch (ex) {
      Get.showSnackbar(
        GetSnackBar(
          backgroundColor: Colors.red,
          message: ex.message.toString(),
          duration: const Duration(seconds: 1),
        ),
      );
      isloader(false);
      if (ex.type == DioExceptionType.unknown) {}
    }

    isloader(false);
  }

  GetCourseCertificateDataModel get getCourseCertificateDataModel => _getCourseCertificateDataModel.value;
}

class CertificatePaymentController extends GetxController {}

class RateUsScreenCpontroller extends GetxController {}

class HelpCenterController extends GetxController with GetTickerProviderStateMixin {
  late TabController tabController;
  late PageController pController;
  RxBool isloader = false.obs;
  PostRepository postRepository = PostRepository();
  final Rx<FaaqsListDataModel> _userDataModel = FaaqsListDataModel().obs;
  final Rx<ContactUsDataModel> _contactUsDataModel = ContactUsDataModel().obs;

  void faqsListDataApi() async {
    isloader(true);
    try {
      FaaqsListDataModel? classesData = await postRepository.faqsListDataApi();
      if ((classesData?.success ?? false)) {
        if (classesData != null) _userDataModel.value = classesData;
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
          message: ex.message.toString(),
          duration: const Duration(seconds: 1),
        ),
      );
      isloader(false);
      if (ex.type == DioExceptionType.unknown) {}
    }

    isloader(false);
  }

  void contactListDataApi() async {
    try {
      ContactUsDataModel? classesData = await postRepository.contactListApi();
      if ((classesData?.success ?? false)) {
        if (classesData != null) _contactUsDataModel.value = classesData;
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
          message: ex.message.toString(),
          duration: const Duration(seconds: 1),
        ),
      );
      isloader(false);
      if (ex.type == DioExceptionType.unknown) {}
    }

    isloader(false);
  }

  FaaqsListDataModel get faaqsListDataModel => _userDataModel.value;

  ContactUsDataModel get contactUsDataModel => _contactUsDataModel.value;

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    tabController = TabController(length: 2, vsync: this);
    pController = PageController();
    super.onInit();
  }
}

class ContactusController extends GetxController with GetTickerProviderStateMixin {
  RxBool isloader = false.obs;
  PostRepository postRepository = PostRepository();
  final Rx<ContactUsDataModel> _contactUsDataModel = ContactUsDataModel().obs;

  void contactListDataApi() async {
    isloader(true);
    try {
      ContactUsDataModel? classesData = await postRepository.contactListApi();
      if ((classesData?.success ?? false)) {
        if (classesData != null) _contactUsDataModel.value = classesData;
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
          message: ex.message.toString(),
          duration: const Duration(seconds: 1),
        ),
      );
      isloader(false);
      if (ex.type == DioExceptionType.unknown) {}
    }

    isloader(false);
  }

  ContactUsDataModel get contactUsDataModel => _contactUsDataModel.value;
}

class PrivacyPolicyController extends GetxController with GetTickerProviderStateMixin {
  RxBool isloader = false.obs;
  PostRepository postRepository = PostRepository();
  final Rx<PrivacypolicyEntity> _contactUsDataModel = PrivacypolicyEntity().obs;

  Future<PrivacypolicyEntity?> contactListDataApi() async {
    isloader(true);
    PrivacypolicyEntity? classesData = null;
    try {
      classesData = await postRepository.privcyPolicyPageApi();
      if ((classesData?.success ?? false)) {
        if (classesData != null) _contactUsDataModel.value = classesData;
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
          message: ex.message.toString(),
          duration: const Duration(seconds: 1),
        ),
      );
      isloader(false);
      if (ex.type == DioExceptionType.unknown) {}
    }

    isloader(false);

    return classesData;
  }

  PrivacypolicyEntity get privacyPolicyPagesDataModel => _contactUsDataModel.value;
}

class SearchScreenController extends GetxController {}

// class ChateScreenController extends GetxController {}

//class DetailChateScreenController extends GetxController {}
