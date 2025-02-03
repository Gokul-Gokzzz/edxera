import 'package:dio/dio.dart';
import 'package:edxera/My_cources/Models/course_data_model.dart';
import 'package:edxera/batchs/Models/announcements_entity.dart';
import 'package:edxera/batchs/Models/assigment_Result_Data_model.dart';
import 'package:edxera/batchs/Models/assigment_list_data_model.dart';
import 'package:edxera/batchs/Models/attendence_data_model.dart';
import 'package:edxera/batchs/Models/batche_details_data_model.dart';
import 'package:edxera/batchs/Models/batches_list_data_model.dart';
import 'package:edxera/batchs/Models/exam_mcq_data_model.dart';
import 'package:edxera/batchs/Models/exam_result_check_data_model.dart';
import 'package:edxera/batchs/Models/get_attendence_data_model.dart';
import 'package:edxera/batchs/Models/live_class_list_data_model.dart';
import 'package:edxera/batchs/Models/user_logout_or_not_data_model.dart';
import 'package:edxera/chate/models/chat_details_data_model.dart';
import 'package:edxera/chate/models/get_chat_heads_data_model.dart';
import 'package:edxera/batchs/Models/study_plan_assigment_data_model.dart';
import 'package:edxera/batchs/Models/study_plan_details_data_model.dart';
import 'package:edxera/batchs/Models/test_list_data_model.dart';
import 'package:edxera/chate/models/intructort_chat_list_data_model.dart';
import 'package:edxera/cources/Models/cources_details_data_model.dart';
import 'package:edxera/cources/Models/course_chapter_list_data_model.dart';
import 'package:edxera/home/Models/category_wise_product_list_data_model.dart';
import 'package:edxera/home/Models/chapter_inner_data_model.dart';
import 'package:edxera/home/Models/free_study_matrial_data_model.dart';
import 'package:edxera/home/Models/home_dashborad_data_model.dart';
import 'package:edxera/home/Models/notification_count_data_model.dart';
import 'package:edxera/home/Models/notification_list_data_model.dart';
import 'package:edxera/home/Models/study_matrial_video_data_model.dart';
import 'package:edxera/home/Models/study_plans_name_data_model.dart';
import 'package:edxera/home/Models/testimonials_list_data_model.dart';
import 'package:edxera/home/Models/today_study_plan_data_model.dart';
import 'package:edxera/home/Models/trending_courses_data_model.dart';
import 'package:edxera/login/Models/login_data_model.dart';
import 'package:edxera/profile/Models/change_password_data_model.dart';
import 'package:edxera/profile/Models/contact_us_data_model.dart';
import 'package:edxera/profile/Models/faqs_list_data_model.dart';
import 'package:edxera/profile/Models/get_certificat_data_model.dart';
import 'package:edxera/profile/Models/logout_data_model.dart';
import 'package:edxera/profile/Models/payment_details_entity.dart';
import 'package:edxera/profile/Models/privacy_policy_pages_data_model.dart';
import 'package:edxera/profile/Models/user_data_model.dart';
import 'package:edxera/repositories/api/api.dart';
import 'package:edxera/repositories/api/api_constants.dart';
import 'package:edxera/utils/shared_pref.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../My_cources/Models/course_data_entity.dart';
import '../profile/Models/privacypolicy_entity.dart';

class PostRepository {
  API api = API();

  // Future<JWSTokenModel?> fetchtoken() async {
  //   var data = {
  //     ApiConstants.type: 'MOBILEAPP',
  //     ApiConstants.apikey: 'elearn@cmoon.com',
  //     ApiConstants.pwd: 'elearn@2023',
  //   };
  //   try {
  //     Response response = await api.sendRequest.post(
  //         "/students/api_key/generate_token",
  //         data: FormData.fromMap(data));

  //     if (response.statusCode == 200) {
  //       return JWSTokenModel.fromJson(response.data);
  //     }
  //   } catch (ex) {
  //     return null;
  //   }
  //   return null;
  // }

  Future<bool> checkUserExist() async {
    try {
      String userPhone = await PrefData.getUserPhone();
      int userId = await PrefData.getUserId();
      Map<String, String> data = {
        "user_id": userId.toString(),
        "phone": userPhone,
      };
      var response = await api.sendRequest.post(
        ApiConstants.user_exists,
        data: data,
      );
      //final body = jsonDecode(response.data);

      if (response.statusCode == 200) {
        if (response.data['success'] == true) {
          return response.data['success'];
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (ex) {
      return false;
    }
  }

  Future<LoginDataModel?> sendLoginData(Map<String, String> data) async {
    try {
      var response = await api.sendRequest.post(
        ApiConstants.login,
        data: data,
        //  options: Options(contentType: 'multipart/form-data'),
      );
      //final body = jsonDecode(response.data);

      if (response.statusCode == 200) {
        if (response.data['success'] == true) {
          return LoginDataModel.fromJson(response.data);
        } else {
          Fluttertoast.showToast(msg: response.data['message']);

          return LoginDataModel.fromJson(response.data);
        }
      } else {
        return null;
      }
    } catch (ex) {
      rethrow;
    }
  }

  Future<LogoutDataModel?> forgotPasswordLoginData(Map<String, String> data) async {
    try {
      var response = await api.sendRequest.post(
        ApiConstants.get_verification_otp,
        data: data,
        //  options: Options(contentType: 'multipart/form-data'),
      );
      //final body = jsonDecode(response.data);

      if (response.statusCode == 200) {
        if (response.data['success'] == true) {
          return LogoutDataModel.fromJson(response.data);
        } else {
          Fluttertoast.showToast(msg: response.data['message']);

          return LogoutDataModel.fromJson(response.data);
        }
      }
    } catch (ex) {
      rethrow;
    }
    return null;
  }

  Future<LogoutDataModel?> resetPasswordApi(Map<String, String> data) async {
    try {
      var response = await api.sendRequest.post(
        ApiConstants.reset_password,
        data: data,
        //  options: Options(contentType: 'multipart/form-data'),
      );
      //final body = jsonDecode(response.data);

      if (response.statusCode == 200) {
        if (response.data['success'] == true) {
          return LogoutDataModel.fromJson(response.data);
        } else {
          Fluttertoast.showToast(msg: response.data['message']);

          return LogoutDataModel.fromJson(response.data);
        }
      }
    } catch (ex) {
      rethrow;
    }
    return null;
  }

  Future<ChangePasswordDataModel?> changePassword(Map<String, dynamic> data) async {
    // try {
    var response = await api.sendRequest.post(
      ApiConstants.change_password,
      data: data,
      //  options: Options(contentType: 'multipart/form-data'),
    );
    //final body = jsonDecode(response.data);
    if (response.statusCode == 400) {
      return ChangePasswordDataModel.fromJson(response.data);
    }
    if (response.statusCode == 200) {
      if (response.data['success'] == true) {
        return ChangePasswordDataModel.fromJson(response.data);
      } else {
        return ChangePasswordDataModel.fromJson(response.data);
      }
    } else if (response.statusCode == 400) {
      return ChangePasswordDataModel.fromJson(response.data);
    }
    // } catch (ex) {
    //   return null;
    // }
    return null;
  }

  Future<ChangePasswordDataModel?> delteAccountApi(Map<String, dynamic> data) async {
    // try {
    var response = await api.sendRequest.post(
      ApiConstants.delete_account,
      data: data,
      //  options: Options(contentType: 'multipart/form-data'),
    );
    //final body = jsonDecode(response.data);
    if (response.statusCode == 400) {
      return ChangePasswordDataModel.fromJson(response.data);
    }
    if (response.statusCode == 200) {
      if (response.data['success'] == true) {
        return ChangePasswordDataModel.fromJson(response.data);
      } else {
        return ChangePasswordDataModel.fromJson(response.data);
      }
    } else if (response.statusCode == 400) {
      return ChangePasswordDataModel.fromJson(response.data);
    }
    // } catch (ex) {
    //   return null;
    // }
    return null;
  }

  Future<LoginDataModel?> sendRegisterData(Map<String, String> data) async {
    try {
      var response = await api.sendRequest.post(
        ApiConstants.register,
        data: data,
        //  options: Options(contentType: 'multipart/form-data'),
      );
      //final body = jsonDecode(response.data);

      if (response.statusCode == 200) {
        if (response.data['success'] == true) {
          return LoginDataModel.fromJson(response.data);
        } else {
          Fluttertoast.showToast(msg: response.data['message']);

          return LoginDataModel.fromJson(response.data);
        }
      }
    } catch (ex) {
      rethrow;
    }
    return null;
  }

  Future<LoginDataModel?> verificatoionCode(Map<String, String> data) async {
    try {
      var response = await api.sendRequest.post(
        ApiConstants.email_verify,
        data: data,
        //  options: Options(contentType: 'multipart/form-data'),
      );
      //final body = jsonDecode(response.data);

      if (response.statusCode == 200) {
        if (response.data['success'] == true) {
          return LoginDataModel.fromJson(response.data);
        } else {
          Fluttertoast.showToast(msg: response.data['message']);

          return LoginDataModel.fromJson(response.data);
        }
      }
    } catch (ex) {
      rethrow;
    }
    return null;
  }

  Future<LogoutDataModel?> verificatoionCodePassword(Map<String, String> data) async {
    try {
      var response = await api.sendRequest.post(
        ApiConstants.verify_otp,
        data: data,
        //  options: Options(contentType: 'multipart/form-data'),
      );
      //final body = jsonDecode(response.data);

      if (response.statusCode == 200) {
        if (response.data['success'] == true) {
          return LogoutDataModel.fromJson(response.data);
        } else {
          Fluttertoast.showToast(msg: response.data['message']);

          return LogoutDataModel.fromJson(response.data);
        }
      }
    } catch (ex) {
      rethrow;
    }
    return null;
  }

  Future<HomeDashboardDataModel?> homeDashboardDatGet() async {
    try {
      var response = await api.sendRequest.get(
        ApiConstants.homeScreen,

        //  options: Options(contentType: 'multipart/form-data'),
      );
      //final body = jsonDecode(response.data);

      if (response.statusCode == 200) {
        if (response.data['success'] == true) {
          return HomeDashboardDataModel.fromJson(response.data);
        } else {
          Fluttertoast.showToast(msg: response.data['message']);

          return HomeDashboardDataModel.fromJson(response.data);
        }
      }
    } catch (ex) {
      rethrow;
    }
    return null;
  }

  Future homeCategoriesGet() async {
    try {
      final response = await api.sendRequest.get(
        ApiConstants.categoriesApi,
      );

      if (response.statusCode == 200) {
        final message = response.data;
        print(" Categories Response ::$message");
        return response;
      } else {
        Fluttertoast.showToast(msg: response.data['message']);

        return null;
      }
    } catch (ex) {
      rethrow;
    }
  }

  Future categoriesDetailGet({required String id}) async {
    try {
      final response = await api.sendRequest.post(
        ApiConstants.category_courses,
        data: {"category_id": id},
      );

      if (response.statusCode == 200) {
        final message = response.data;
        print(" Categories Detail Response ::$message");
        return response;
      } else {
        Fluttertoast.showToast(msg: response.data['message']);

        return null;
      }
    } catch (ex) {
      rethrow;
    }
  }

  Future<bool> bypassPaymentApi() async {
    try {
      var response = await api.sendRequest.get(
        ApiConstants.bypassApi,

        //  options: Options(contentType: 'multipart/form-data'),
      );
      //final body = jsonDecode(response.data);

      if (response.statusCode == 200) {
        //{
        //     "status": true,
        //     "bypass": true
        // }
        // if (response.data['bypass'] == true) {
        //   return response.data['bypass'];
        // } else {
        //
        //   return response.data['bypass'];
        // }
        return response.data['bypass'];
      } else {
        return false;
      }
    } catch (ex) {
      return false;
    }
  }

  Future<TrendingCoursesDataModel?> homeDashboardTrendingDatGet() async {
    try {
      var response = await api.sendRequest.get(
        ApiConstants.latestCourses,

        //  options: Options(contentType: 'multipart/form-data'),
      );
      //final body = jsonDecode(response.data);

      if (response.statusCode == 200) {
        if (response.data['success'] == true) {
          return TrendingCoursesDataModel.fromJson(response.data);
        } else {
          Fluttertoast.showToast(msg: response.data['message']);

          return TrendingCoursesDataModel.fromJson(response.data);
        }
      }
    } catch (ex) {
      rethrow;
    }
    return null;
  }

  Future<FreeStudyMatrialListDataModel?> freestudyMatrialApi(Map<String, dynamic> data) async {
    try {
      var response = await api.sendRequest.post(ApiConstants.free_study_materials, data: data

          //  options: Options(contentType: 'multipart/form-data'),
          );
      //final body = jsonDecode(response.data);

      if (response.statusCode == 200) {
        if (response.data['success'] == true) {
          return FreeStudyMatrialListDataModel.fromJson(response.data);
        } else {
          Fluttertoast.showToast(msg: response.data['message']);

          return FreeStudyMatrialListDataModel.fromJson(response.data);
        }
      }
    } catch (ex) {
      rethrow;
    }
    return null;
  }

  Future<ChapterInnerDataModel?> chepterInnerApiCall(String id, planId) async {
    var data = {
      'user_id': await PrefData.getUserId(),
      'chapter_id': id,
      'study_plan_items_id': planId,
    };
    try {
      var response = await api.sendRequest.post(ApiConstants.study_plan_chapter_inner, data: data

          //  options: Options(contentType: 'multipart/form-data'),
          );
      //final body = jsonDecode(response.data);

      if (response.statusCode == 200) {
        if (response.data['success'] == true) {
          return ChapterInnerDataModel.fromJson(response.data);
        } else {
          Fluttertoast.showToast(msg: response.data['message']);

          return ChapterInnerDataModel.fromJson(response.data);
        }
      }
    } catch (ex) {
      rethrow;
    }
    return null;
  }

  Future<NotificationListDataModel?> getNotificationDataApi(Map<String, dynamic> data) async {
    try {
      var response = await api.sendRequest.post(ApiConstants.get_user_notifications, data: data

          //  options: Options(contentType: 'multipart/form-data'),
          );
      //final body = jsonDecode(response.data);

      if (response.statusCode == 200) {
        if (response.data['success'] == true) {
          return NotificationListDataModel.fromJson(response.data);
        } else {
          Fluttertoast.showToast(msg: response.data['message']);

          return NotificationListDataModel.fromJson(response.data);
        }
      }
    } catch (ex) {
      rethrow;
    }
    return null;
  }

  Future<SubmitMcqDataModel?> clearNotificationDataApi(Map<String, dynamic> data) async {
    try {
      var response = await api.sendRequest.post(ApiConstants.user_notification_clear, data: data

          //  options: Options(contentType: 'multipart/form-data'),
          );
      //final body = jsonDecode(response.data);

      if (response.statusCode == 200) {
        if (response.data['success'] == true) {
          return SubmitMcqDataModel.fromJson(response.data);
        } else {
          Fluttertoast.showToast(msg: response.data['message']);

          return SubmitMcqDataModel.fromJson(response.data);
        }
      }
    } catch (ex) {
      rethrow;
    }
    return null;
  }

  Future<CategoryWiseCourseListDataModel?> categoryWiseCourseListApi(Map<String, dynamic> data) async {
    try {
      var response = await api.sendRequest.post(ApiConstants.category_courses, data: data

          //  options: Options(contentType: 'multipart/form-data'),
          );
      //final body = jsonDecode(response.data);

      if (response.statusCode == 200) {
        if (response.data['success'] == true) {
          return CategoryWiseCourseListDataModel.fromJson(response.data);
        } else {
          Fluttertoast.showToast(msg: response.data['message']);

          return CategoryWiseCourseListDataModel.fromJson(response.data);
        }
      }
    } catch (ex) {
      rethrow;
    }
    return null;
  }

  Future<TestimonialDataListDataModel?> homeDashboardTestimonailasDatGet() async {
    try {
      var response = await api.sendRequest.get(
        ApiConstants.testimonial,

        //  options: Options(contentType: 'multipart/form-data'),
      );
      //final body = jsonDecode(response.data);

      if (response.statusCode == 200) {
        if (response.data['success'] == true) {
          return TestimonialDataListDataModel.fromJson(response.data);
        } else {
          Fluttertoast.showToast(msg: response.data['message']);

          return TestimonialDataListDataModel.fromJson(response.data);
        }
      }
    } catch (ex) {
      rethrow;
    }
    return null;
  }

  Future<TodaysStudyPlanDataModel?> todayStudyPlanApi(Map<String, dynamic> data) async {
    try {
      var response = await api.sendRequest.post(
        ApiConstants.get_today_study_plans, data: data,
        //   options: Options(contentType: 'multipart/form-data'),
      );
      //final body = jsonDecode(response.data);

      if (response.statusCode == 200) {
        if (response.data['success'] == true) {
          return TodaysStudyPlanDataModel.fromJson(response.data);
        } else {
          //Fluttertoast.showToast(msg: response.data['message']);

          return TodaysStudyPlanDataModel.fromJson(response.data);
        }
      }
    } catch (ex) {
      rethrow;
    }
    return null;
  }

  Future<StudyPlanCourseNameDataModel?> homeDashboardStudyPlansDatGet() async {
    var data = {
      'user_id': await PrefData.getUserId(),
    };
    try {
      var response = await api.sendRequest.post(ApiConstants.study_plan_my_courses, data: data
          //  options: Options(contentType: 'multipart/form-data'),
          );
      //final body = jsonDecode(response.data);

      if (response.statusCode == 200) {
        if (response.data['success'] == true) {
          return StudyPlanCourseNameDataModel.fromJson(response.data);
        } else {
          Fluttertoast.showToast(msg: response.data['message']);

          return StudyPlanCourseNameDataModel.fromJson(response.data);
        }
      }
    } catch (ex) {
      rethrow;
    }
    return null;
  }

  Future<CourseDataEntity?> courseDetailsDataGet(String id) async {
    var data = {
      'user_id': await PrefData.getUserId(),
      'course_id': id,
    };
    print(data);
    // var response = await api.sendRequest
    //     .get(ApiConstants.course + "?user_id=" + data['user_id'].toString() + "&course_id=" + data['course_id'].toString(), data: data
    //         //  options: Options(contentType: 'multipart/form-data'),
    //         );
    //final body = jsonDecode(response.data);
    var response = await api.sendRequest.post(ApiConstants.course, data: data
        //  options: Options(contentType: 'multipart/form-data'),
        );

    if (response.statusCode == 200) {
      if (response.data['success'] == true) {
        return CourseDataEntity.fromJson(response.data);
      } else {
        Fluttertoast.showToast(msg: response.data['message']);

        return CourseDataEntity.fromJson(response.data);
      }
    }
    // } catch (ex) {
    //   return null;
    // }
    return null;
  }

  Future<CourseDetailsDataModel?> coursePurchaseDetails(Map<String, dynamic> data) async {
    var response = await api.sendRequest.post(ApiConstants.send_course_purchace_request, data: data
        //  options: Options(contentType: 'multipart/form-data'),
        );
    //final body = jsonDecode(response.data);

    if (response.statusCode == 200) {
      if (response.data['success'] == true) {
        return CourseDetailsDataModel.fromJson(response.data);
      } else {
        Fluttertoast.showToast(msg: response.data['message']);

        return CourseDetailsDataModel.fromJson(response.data);
      }
    }
    // } catch (ex) {
    //   return null;
    // }
    return null;
  }

  Future<BatchesListDataModel?> batchListDataGet(String text) async {
    var data = {
      'search': text,
      'user_id': await PrefData.getUserId(),
    };
    print(data);
    var response = await api.sendRequest.post(ApiConstants.get_all_batchs, data: data
        //  options: Options(contentType: 'multipart/form-data'),
        );
    //final body = jsonDecode(response.data);

    if (response.statusCode == 200) {
      if (response.data['success'] == true) {
        return BatchesListDataModel.fromJson(response.data);
      } else {
        Fluttertoast.showToast(msg: response.data['message']);

        return BatchesListDataModel.fromJson(response.data);
      }
    }
    // } catch (ex) {
    //   return null;
    // }
    return null;
  }

  Future<BatchesListDataModel?> batchListByCourseDataGet(int id) async {
    var data = {
      'course_id': id,
      'user_id': await PrefData.getUserId(),
    };
    var response = await api.sendRequest.post(ApiConstants.get_all_batchs_by_course, data: data
        //  options: Options(contentType: 'multipart/form-data'),
        );
    //final body = jsonDecode(response.data);

    if (response.statusCode == 200) {
      if (response.data['success'] == true) {
        return BatchesListDataModel.fromJson(response.data);
      } else {
        Fluttertoast.showToast(msg: response.data['message']);

        return BatchesListDataModel.fromJson(response.data);
      }
    }
    // } catch (ex) {
    //   return null;
    // }
    return null;
  }

  Future<BatcheDetailsDataModel?> batchDataGet(Map<String, dynamic> data) async {
    var response = await api.sendRequest.post(ApiConstants.get_batch_details, data: data
        //  options: Options(contentType: 'multipart/form-data'),
        );
    //final body = jsonDecode(response.data);

    if (response.statusCode == 200) {
      if (response.data['success'] == true) {
        return BatcheDetailsDataModel.fromJson(response.data);
      } else {
        Fluttertoast.showToast(msg: response.data['message']);

        return BatcheDetailsDataModel.fromJson(response.data);
      }
    }
    // } catch (ex) {
    //   return null;
    // }
    return null;
  }

  Future<StudyPlanViewDataModel?> studyPlanDetailsApi(Map<String, dynamic> data) async {
    var response = await api.sendRequest.post(ApiConstants.get_study_plans, data: data
        //  options: Options(contentType: 'multipart/form-data'),
        );
    //final body = jsonDecode(response.data);

    if (response.statusCode == 200) {
      if (response.data['success'] == true) {
        return StudyPlanViewDataModel.fromJson(response.data);
      } else {
        Fluttertoast.showToast(msg: response.data['message']);

        return StudyPlanViewDataModel.fromJson(response.data);
      }
    }
    // } catch (ex) {
    //   return null;
    // }
    return null;
  }

  Future<LiveClassListDataModel?> liveClassApiCall(Map<String, dynamic> data) async {
    var response = await api.sendRequest.post(ApiConstants.get_live_classes, data: data
        //  options: Options(contentType: 'multipart/form-data'),
        );
    //final body = jsonDecode(response.data);

    if (response.statusCode == 200) {
      if (response.data['success'] == true) {
        return LiveClassListDataModel.fromJson(response.data);
      } else {
        Fluttertoast.showToast(msg: response.data['message']);

        return LiveClassListDataModel.fromJson(response.data);
      }
    }
    // } catch (ex) {
    //   return null;
    // }
    return null;
  }

  Future<ExamMcqDataModel?> examMcqDataApi(Map<String, dynamic> data) async {
    var response = await api.sendRequest.post(ApiConstants.study_plan_exam_mcq_inner, data: data
        //  options: Options(contentType: 'multipart/form-data'),
        );
    //final body = jsonDecode(response.data);

    if (response.statusCode == 200) {
      if (response.data['success'] == true) {
        return ExamMcqDataModel.fromJson(response.data);
      } else {
        Fluttertoast.showToast(msg: response.data['message']);

        return ExamMcqDataModel.fromJson(response.data);
      }
    }
    // } catch (ex) {
    //   return null;
    // }
    return null;
  }

  Future<StudyPlanAssigmentDataModel?> assigmentDataApi(Map<String, dynamic> data) async {
    var response = await api.sendRequest.post(ApiConstants.study_plan_assignment_inner, data: data
        //  options: Options(contentType: 'multipart/form-data'),
        );
    //final body = jsonDecode(response.data);

    if (response.statusCode == 200) {
      if (response.data['success'] == true) {
        return StudyPlanAssigmentDataModel.fromJson(response.data);
      } else {
        Fluttertoast.showToast(msg: response.data['message']);

        return StudyPlanAssigmentDataModel.fromJson(response.data);
      }
    }
    // } catch (ex) {
    //   return null;
    // }
    return null;
  }

  Future<StudyPlanAssigmentSubmitDataModel?> submitAssigment(FormData formData) async {
    var response = await api.sendRequest.post(ApiConstants.submit_assignment, data: formData
        //  options: Options(contentType: 'multipart/form-data'),
        );
    //final body = jsonDecode(response.data);

    if (response.statusCode == 200) {
      if (response.data['success'] == true) {
        return StudyPlanAssigmentSubmitDataModel.fromJson(response.data);
      } else {
        Fluttertoast.showToast(msg: response.data['message']);

        return StudyPlanAssigmentSubmitDataModel.fromJson(response.data);
      }
    }
    // } catch (ex) {
    //   return null;
    // }
    return null;
  }

  Future<ExamMcqDataModel?> examDescriptionDataApi(Map<String, dynamic> data) async {
    var response = await api.sendRequest.post(ApiConstants.study_plan_exam_description_inner, data: data
        //  options: Options(contentType: 'multipart/form-data'),
        );
    //final body = jsonDecode(response.data);

    if (response.statusCode == 200) {
      if (response.data['success'] == true) {
        return ExamMcqDataModel.fromJson(response.data);
      } else {
        Fluttertoast.showToast(msg: response.data['message']);

        return ExamMcqDataModel.fromJson(response.data);
      }
    }
    // } catch (ex) {
    //   return null;
    // }
    return null;
  }

  Future<BatchAssigmentListDataModel?> batchAssigmentListApi(Map<String, dynamic> data) async {
    var response = await api.sendRequest.post(ApiConstants.get_all_assignment_list_user, data: data
        //  options: Options(contentType: 'multipart/form-data'),
        );
    //final body = jsonDecode(response.data);

    if (response.statusCode == 200) {
      if (response.data['success'] == true) {
        return BatchAssigmentListDataModel.fromJson(response.data);
      } else {
        Fluttertoast.showToast(msg: response.data['message']);

        return BatchAssigmentListDataModel.fromJson(response.data);
      }
    }
    // } catch (ex) {
    //   return null;
    // }
    return null;
  }

  Future<AttendencePresentDataModel?> attendencePresentAPi(Map<String, dynamic> data) async {
    var response = await api.sendRequest.post(ApiConstants.attendence_present, data: data
        //  options: Options(contentType: 'multipart/form-data'),
        );
    //final body = jsonDecode(response.data);

    if (response.statusCode == 200) {
      if (response.data['success'] == true) {
        return AttendencePresentDataModel.fromJson(response.data);
      } else {
        return AttendencePresentDataModel.fromJson(response.data);
      }
    }
    // } catch (ex) {
    //   return null;
    // }
    return null;
  }

  Future<GetChatHeadsDataModel?> getChatHeadsApi(Map<String, dynamic> data) async {
    var response = await api.sendRequest.post(ApiConstants.get_chat_heads, data: data
        //  options: Options(contentType: 'multipart/form-data'),
        );
    //final body = jsonDecode(response.data);

    if (response.statusCode == 200) {
      if (response.data['success'] == true) {
        return GetChatHeadsDataModel.fromJson(response.data);
      } else {
        return GetChatHeadsDataModel.fromJson(response.data);
      }
    }
    // } catch (ex) {
    //   return null;
    // }
    return null;
  }

  Future<IntructorsChatListDataModel?> getChatInstructorHeadsApi(Map<String, dynamic> data) async {
    var response = await api.sendRequest.post(ApiConstants.get_all_chat_intructors, data: data
        //  options: Options(contentType: 'multipart/form-data'),
        );
    //final body = jsonDecode(response.data);

    if (response.statusCode == 200) {
      if (response.data['success'] == true) {
        return IntructorsChatListDataModel.fromJson(response.data);
      } else {
        return IntructorsChatListDataModel.fromJson(response.data);
      }
    }
    // } catch (ex) {
    //   return null;
    // }
    return null;
  }

  Future<GetChatDetailsDataModel?> getChatDetailsAPi(Map<String, dynamic> data) async {
    var response = await api.sendRequest.post(ApiConstants.get_chat_details, data: data
        //  options: Options(contentType: 'multipart/form-data'),
        );
    //final body = jsonDecode(response.data);

    if (response.statusCode == 200) {
      if (response.data['success'] == true) {
        return GetChatDetailsDataModel.fromJson(response.data);
      } else {
        return GetChatDetailsDataModel.fromJson(response.data);
      }
    }
    // } catch (ex) {
    //   return null;
    // }
    return null;
  }

  Future<AttendencePresentDataModel?> sendMessageApi(Map<String, dynamic> data) async {
    var response = await api.sendRequest.post(ApiConstants.sent_message, data: data
        //  options: Options(contentType: 'multipart/form-data'),
        );
    //final body = jsonDecode(response.data);

    if (response.statusCode == 200) {
      if (response.data['success'] == true) {
        return AttendencePresentDataModel.fromJson(response.data);
      } else {
        return AttendencePresentDataModel.fromJson(response.data);
      }
    }
    // } catch (ex) {
    //   return null;
    // }
    return null;
  }

  Future<GetAttendenceDataModel?> getAttendencePresentAPi(Map<String, dynamic> data) async {
    var response = await api.sendRequest.post(ApiConstants.get_batch_attendence, data: data
        //  options: Options(contentType: 'multipart/form-data'),
        );
    //final body = jsonDecode(response.data);

    if (response.statusCode == 200) {
      if (response.data['success'] == true) {
        return GetAttendenceDataModel.fromJson(response.data);
      } else {
        return GetAttendenceDataModel.fromJson(response.data);
      }
    }
    // } catch (ex) {
    //   return null;
    // }
    return null;
  }

  Future<BatchTestListDataModel?> batchTestListApi(Map<String, dynamic> data) async {
    var response = await api.sendRequest.post(ApiConstants.get_all_test_list_user, data: data
        //  options: Options(contentType: 'multipart/form-data'),
        );
    //final body = jsonDecode(response.data);

    if (response.statusCode == 200) {
      if (response.data['success'] == true) {
        return BatchTestListDataModel.fromJson(response.data);
      } else {
        Fluttertoast.showToast(msg: response.data['message']);

        return BatchTestListDataModel.fromJson(response.data);
      }
    }
    // } catch (ex) {
    //   return null;
    // }
    return null;
  }

  Future<ExamResultCheckDataModel?> examResultCheckApi(Map<String, dynamic> data, String type) async {
    var response = await api.sendRequest.post(type == 'EXAM_MCQ' ? ApiConstants.mcq_exam_result : ApiConstants.description_exam_result, data: data
        //  options: Options(contentType: 'multipart/form-data'),
        );
    //final body = jsonDecode(response.data);

    if (response.statusCode == 200) {
      if (response.data['success'] == true) {
        return ExamResultCheckDataModel.fromJson(response.data);
      } else {
        Fluttertoast.showToast(msg: response.data['message']);

        return null;
      }
    }
    // } catch (ex) {
    //   return null;
    // }
    return null;
  }

  Future<AssigmentResultDataModel?> assigmentResultCheckApi(Map<String, dynamic> data) async {
    var response = await api.sendRequest.post(ApiConstants.assignment_result, data: data
        //  options: Options(contentType: 'multipart/form-data'),
        );
    //final body = jsonDecode(response.data);

    if (response.statusCode == 200) {
      if (response.data['success'] == true) {
        return AssigmentResultDataModel.fromJson(response.data);
      } else {
        Fluttertoast.showToast(msg: response.data['message']);

        return null;
      }
    }
    // } catch (ex) {
    //   return null;
    // }
    return null;
  }

  Future<BatchVideoStudyMatrialDataModel?> batchVideoListApi(Map<String, dynamic> data) async {
    var response = await api.sendRequest.post(ApiConstants.get_videos_and_study_materials, data: data
        //  options: Options(contentType: 'multipart/form-data'),
        );
    //final body = jsonDecode(response.data);

    if (response.statusCode == 200) {
      if (response.data['success'] == true) {
        return BatchVideoStudyMatrialDataModel.fromJson(response.data);
      } else {
        // Fluttertoast.showToast(msg: response.data['message']);

        return BatchVideoStudyMatrialDataModel.fromJson(response.data);
      }
    }
    // } catch (ex) {
    //   return null;
    // }
    return null;
  }

  Future<SubmitMcqDataModel?> submitAnswerMCQDataApi(Map<String, dynamic> data) async {
    var response = await api.sendRequest.post(ApiConstants.submit_answer_mcq, data: data
        //  options: Options(contentType: 'multipart/form-data'),
        );
    //final body = jsonDecode(response.data);

    if (response.statusCode == 200) {
      if (response.data['success'] == true) {
        return SubmitMcqDataModel.fromJson(response.data);
      } else {
        Fluttertoast.showToast(msg: response.data['message']);

        return SubmitMcqDataModel.fromJson(response.data);
      }
    }
    // } catch (ex) {
    //   return null;
    // }
    return null;
  }

  Future<SubmitMcqDataModel?> submitAnswerDescriptionDataApi(Map<String, dynamic> data) async {
    var response = await api.sendRequest.post(ApiConstants.submit_answer_description, data: data
        //  options: Options(contentType: 'multipart/form-data'),
        );
    //final body = jsonDecode(response.data);

    if (response.statusCode == 200) {
      if (response.data['success'] == true) {
        return SubmitMcqDataModel.fromJson(response.data);
      } else {
        Fluttertoast.showToast(msg: response.data['message']);

        return SubmitMcqDataModel.fromJson(response.data);
      }
    }
    // } catch (ex) {
    //   return null;
    // }
    return null;
  }

  Future<ExamResultCheckDataModel?> finishAnswerMCQDataApi(Map<String, dynamic> data) async {
    var response = await api.sendRequest.post(ApiConstants.finish_exam_mcq, data: data
        //  options: Options(contentType: 'multipart/form-data'),
        );
    //final body = jsonDecode(response.data);

    if (response.statusCode == 200) {
      if (response.data['success'] == true) {
        return ExamResultCheckDataModel.fromJson(response.data);
      } else {
        Fluttertoast.showToast(msg: response.data['message']);

        return ExamResultCheckDataModel.fromJson(response.data);
      }
    }
    // } catch (ex) {
    //   return null;
    // }
    return null;
  }

  Future<ExamResultCheckDataModel?> finishAnswerDescriptionDataApi(Map<String, dynamic> data) async {
    var response = await api.sendRequest.post(ApiConstants.finish_exam_description, data: data
        //  options: Options(contentType: 'multipart/form-data'),
        );
    //final body = jsonDecode(response.data);

    if (response.statusCode == 200) {
      if (response.data['success'] == true) {
        return ExamResultCheckDataModel.fromJson(response.data);
      } else {
        Fluttertoast.showToast(msg: response.data['message']);

        return ExamResultCheckDataModel.fromJson(response.data);
      }
    }
    // } catch (ex) {
    //   return null;
    // }
    return null;
  }

  Future<SuccesFullDataModel?> joinClassData(Map<String, dynamic> data) async {
    var response = await api.sendRequest.post(ApiConstants.join_batch, data: data
        //  options: Options(contentType: 'multipart/form-data'),
        );
    //final body = jsonDecode(response.data);

    if (response.statusCode == 200) {
      if (response.data['success'] == true) {
        return SuccesFullDataModel.fromJson(response.data);
      } else {
        Fluttertoast.showToast(msg: response.data['message']);

        return SuccesFullDataModel.fromJson(response.data);
      }
    }
    // } catch (ex) {
    //   return null;
    // }
    return null;
  }

  Future<BatchesJoinCodeDataModel?> joinBatchData(Map<String, dynamic> data) async {
    var response = await api.sendRequest.post(ApiConstants.join_request_by_batchcode, data: data
        //  options: Options(contentType: 'multipart/form-data'),
        );
    //final body = jsonDecode(response.data);

    if (response.statusCode == 200) {
      if (response.data['success'] == true) {
        return BatchesJoinCodeDataModel.fromJson(response.data);
      } else {
        Fluttertoast.showToast(msg: response.data['message']);

        return BatchesJoinCodeDataModel.fromJson(response.data);
      }
    }
    // } catch (ex) {
    //   return null;
    // }
    return null;
  }

  Future<CourseChapterListDataModel?> courseChalpterListDetailsDataGet(String id) async {
    var data = {
      'user_id': await PrefData.getUserId(),
      'course_id': id,
      // 'batch_id': await PrefData.getCourseId(),
    };
    print(data);
    try {
      var response = await api.sendRequest.post(ApiConstants.chapters, data: data
          //  options: Options(contentType: 'multipart/form-data'),
          );
      //final body = jsonDecode(response.data);

      if (response.statusCode == 200) {
        if (response.data['success'] == true) {
          return CourseChapterListDataModel.fromJson(response.data);
        } else {
          Fluttertoast.showToast(msg: response.data['message']);

          return CourseChapterListDataModel.fromJson(response.data);
        }
      }
    } catch (ex) {
      rethrow;
    }
    return null;
  }

  Future<CourseDataModel?> courseDataApi(Map<String, dynamic> data) async {
    try {
      var response = await api.sendRequest.post(ApiConstants.user_my_courses, data: data
          //  options: Options(contentType: 'multipart/form-data'),
          );
      //final body = jsonDecode(response.data);

      if (response.statusCode == 200) {
        if (response.data['success'] == true) {
          return CourseDataModel.fromJson(response.data);
        } else {
          Fluttertoast.showToast(msg: response.data['message']);

          return CourseDataModel.fromJson(response.data);
        }
      }
    } catch (ex) {
      rethrow;
    }
    return null;
  }

  Future<UserDataModel?> userDataApi(Map<String, dynamic> data) async {
    try {
      var response = await api.sendRequest.post(ApiConstants.user_profile, data: data
          //  options: Options(contentType: 'multipart/form-data'),
          );
      //final body = jsonDecode(response.data);

      if (response.statusCode == 200) {
        if (response.data['success'] == true) {
          return UserDataModel.fromJson(response.data);
        } else {
          Fluttertoast.showToast(msg: response.data['message']);

          return UserDataModel.fromJson(response.data);
        }
      }
    } catch (ex) {
      rethrow;
    }
    return null;
  }

  Future<NotificationCountDataModel?> notificationCountDataApi(Map<String, dynamic> data) async {
    try {
      var response = await api.sendRequest.post(ApiConstants.get_user_notifications_count, data: data
          //  options: Options(contentType: 'multipart/form-data'),
          );
      //final body = jsonDecode(response.data);

      if (response.statusCode == 200) {
        if (response.data['success'] == true) {
          return NotificationCountDataModel.fromJson(response.data);
        } else {
          Fluttertoast.showToast(msg: response.data['message']);

          return NotificationCountDataModel.fromJson(response.data);
        }
      }
    } catch (ex) {
      rethrow;
    }
    return null;
  }

  Future<StudyPlanAssigmentSubmitDataModel?> feedbackApi(Map<String, dynamic> data) async {
    try {
      var response = await api.sendRequest.post(ApiConstants.add_app_feedback, data: data
          //  options: Options(contentType: 'multipart/form-data'),
          );
      //final body = jsonDecode(response.data);

      if (response.statusCode == 200) {
        if (response.data['success'] == true) {
          return StudyPlanAssigmentSubmitDataModel.fromJson(response.data);
        } else {
          Fluttertoast.showToast(msg: response.data['message']);

          return StudyPlanAssigmentSubmitDataModel.fromJson(response.data);
        }
      }
    } catch (ex) {
      rethrow;
    }
    return null;
  }

  Future<GetCourseCertificateDataModel?> getCretificate(Map<String, dynamic> data) async {
    try {
      var response = await api.sendRequest.post(ApiConstants.get_course_certificate, data: data
          //  options: Options(contentType: 'multipart/form-data'),
          );
      //final body = jsonDecode(response.data);

      if (response.statusCode == 200) {
        if (response.data['success'] == true) {
          return GetCourseCertificateDataModel.fromJson(response.data);
        } else {
          Fluttertoast.showToast(msg: response.data['message']);

          return GetCourseCertificateDataModel.fromJson(response.data);
        }
      }
    } catch (ex) {
      rethrow;
    }
    return null;
  }

  Future<StudyPlanAssigmentSubmitDataModel?> writeCourseReview(Map<String, dynamic> data) async {
    try {
      var response = await api.sendRequest.post(ApiConstants.userwritereview, data: data
          //  options: Options(contentType: 'multipart/form-data'),
          );
      //final body = jsonDecode(response.data);

      if (response.statusCode == 200) {
        if (response.data['success'] == true) {
          return StudyPlanAssigmentSubmitDataModel.fromJson(response.data);
        } else {
          return StudyPlanAssigmentSubmitDataModel.fromJson(response.data);
        }
      }
    } catch (ex) {
      rethrow;
    }
    return null;
  }

  Future<UserLogourOrNotDataModel?> userLogourOrNotApiCall(Map<String, dynamic> data) async {
    try {
      var response = await api.sendRequest.post(ApiConstants.verify_user_device_token, data: data
          //  options: Options(contentType: 'multipart/form-data'),
          );
      //final body = jsonDecode(response.data);

      if (response.statusCode == 200) {
        if (response.data['success'] == true) {
          return UserLogourOrNotDataModel.fromJson(response.data);
        } else {
          return UserLogourOrNotDataModel.fromJson(response.data);
        }
      }
    } catch (ex) {
      rethrow;
    }
    return null;
  }

  Future<StudyPlanAssigmentSubmitDataModel?> ratingAppPoup(Map<String, dynamic> data) async {
    try {
      var response = await api.sendRequest.post(ApiConstants.add_app_rating, data: data
          //  options: Options(contentType: 'multipart/form-data'),
          );
      //final body = jsonDecode(response.data);

      if (response.statusCode == 200) {
        if (response.data['success'] == true) {
          return StudyPlanAssigmentSubmitDataModel.fromJson(response.data);
        } else {
          Fluttertoast.showToast(msg: response.data['message']);

          return StudyPlanAssigmentSubmitDataModel.fromJson(response.data);
        }
      }
    } catch (ex) {
      rethrow;
    }
    return null;
  }

  Future<LogoutDataModel?> logoutApiCall(Map<String, dynamic> data) async {
    try {
      var response = await api.sendRequest.post(ApiConstants.logout_api, data: data
          //  options: Options(contentType: 'multipart/form-data'),
          );
      //final body = jsonDecode(response.data);

      if (response.statusCode == 200) {
        if (response.data['success'] == true) {
          return LogoutDataModel.fromJson(response.data);
        } else {
          Fluttertoast.showToast(msg: response.data['message']);

          return LogoutDataModel.fromJson(response.data);
        }
      }
    } catch (ex) {
      rethrow;
    }
    return null;
  }

  Future<FaaqsListDataModel?> faqsListDataApi() async {
    try {
      var response = await api.sendRequest.get(
        ApiConstants.app_faqs,
        //  options: Options(contentType: 'multipart/form-data'),
      );
      //final body = jsonDecode(response.data);

      if (response.statusCode == 200) {
        if (response.data['success'] == true) {
          return FaaqsListDataModel.fromJson(response.data);
        } else {
          Fluttertoast.showToast(msg: response.data['message']);

          return FaaqsListDataModel.fromJson(response.data);
        }
      }
    } catch (ex) {
      rethrow;
    }
    return null;
  }

  Future<ContactUsDataModel?> contactListApi() async {
    try {
      var response = await api.sendRequest.get(
        ApiConstants.contact_us_details,
        //  options: Options(contentType: 'multipart/form-data'),
      );
      //final body = jsonDecode(response.data);

      if (response.statusCode == 200) {
        if (response.data['success'] == true) {
          return ContactUsDataModel.fromJson(response.data);
        } else {
          Fluttertoast.showToast(msg: response.data['message']);

          return ContactUsDataModel.fromJson(response.data);
        }
      }
    } catch (ex) {
      rethrow;
    }
    return null;
  }

  Future<PrivacypolicyEntity?> privcyPolicyPageApi() async {
    try {
      var response = await api.sendRequest.get(
        ApiConstants.app_pages,
        //  options: Options(contentType: 'multipart/form-data'),
      );
      //final body = jsonDecode(response.data);

      if (response.statusCode == 200) {
        if (response.data['success'] == true) {
          return PrivacypolicyEntity.fromJson(response.data);
        } else {
          Fluttertoast.showToast(msg: response.data['message']);

          return PrivacypolicyEntity.fromJson(response.data);
        }
      }
    } catch (ex) {
      rethrow;
    }
    return null;
  }

  // Future<PetRegistrationDataModel?> sendRegistraionOwnerData(
  //     String userid,
  //     regno,
  //     imageFile,
  //     pettype,
  //     petage,
  //     petname,
  //     ownername,
  //     petdob,
  //     address,
  //     email,
  //     petbehaviour) async {
  //   try {
  //     String fileName = imageFile.split('/').last;
  //     var formData = FormData.fromMap(
  //       {
  //         'user_id': userid,
  //         'reg_no': regno,
  //         'pet_type': pettype,
  //         'pet_age': petage,
  //         'pet_name': petname,
  //         'owner_name': ownername,
  //         'pet_dob': petdob,
  //         'address': address,
  //         'email': email,
  //         'pet_behaviour': petbehaviour,
  //         "pet_image":
  //             await MultipartFile.fromFile(imageFile, filename: fileName),
  //       },
  //     );
  //     var response = await api.sendRequest.post(ApiConstants.registrationOwner,
  //         data: formData, options: Options(contentType: 'multipart/form-data'));
  //     final body = jsonDecode(response.data);

  //     if (response.statusCode == 200) {
  //       if (body['err_code'] == 'valid') {
  //         return PetRegistrationDataModel.fromJson(body);
  //       } else {
  //         Fluttertoast.showToast(msg: body['message']);

  //         return PetRegistrationDataModel.fromJson(body);
  //       }
  //     }
  //   } catch (ex) {
  //     return null;
  //   }

  //   return null;
  // }

  // Future<PetRegistrationDataModel?> sendregistrationSitterORWalkerData(
  //     String userid,
  //     regno,
  //     imageFile,
  //     idcard,
  //     iam,
  //     name,
  //     age,
  //     whyurbest,
  //     whylvpets,
  //     address,
  //     email,
  //     experience) async {
  //   try {
  //     String fileName = imageFile.split('/').last;
  //     String fileidcard = idcard.split('/').last;
  //     var formData = FormData.fromMap(
  //       {
  //         'user_id': userid,
  //         'reg_no': regno,
  //         "profile_pic":
  //             await MultipartFile.fromFile(imageFile, filename: fileName),
  //         "id_card": await MultipartFile.fromFile(idcard, filename: fileidcard),
  //         'i_am': iam,
  //         'name': name,
  //         'age': age,
  //         'why_ur_best': whyurbest,
  //         'why_lv_pets': whylvpets,
  //         'address': address,
  //         'email': email,
  //         'experience': experience
  //       },
  //     );
  //     var response = await api.sendRequest.post(ApiConstants.registrationsitter,
  //         data: formData, options: Options(contentType: 'multipart/form-data'));
  //     final body = jsonDecode(response.data);

  //     if (response.statusCode == 200) {
  //       if (body['err_code'] == 'valid') {
  //         return PetRegistrationDataModel.fromJson(body);
  //       } else {
  //         Fluttertoast.showToast(msg: body['message']);

  //         return PetRegistrationDataModel.fromJson(body);
  //       }
  //     }
  //   } catch (ex) {
  //     return null;
  //   }

  //   return null;
  // }

  // Future<PetRegistrationDataModel?> sendregistrationHospitalData(
  //   bool satclosed,
  //   sunclosed,
  //   String userid,
  //   regno,
  //   imageFile,
  //   idcard,
  //   doctorname,
  //   hospitalname,
  //   description,
  //   address,
  //   startedyear,
  //   email,
  //   emergencyservices,
  //   emergencynumber,
  //   mrngfrom,
  //   mrngto,
  //   afterfrom,
  //   afterto,
  //   satfrom,
  //   satto,
  //   sunfrom,
  //   sunto,
  //   hospitalphonenum,
  // ) async {
  //   try {
  //     String fileName = imageFile.split('/').last;
  //     String fileidcard = idcard.split('/').last;
  //     var formData = FormData.fromMap(
  //       {
  //         'user_id': userid,
  //         'reg_no': regno,
  //         "profile_pic":
  //             await MultipartFile.fromFile(imageFile, filename: fileName),
  //         "document":
  //             await MultipartFile.fromFile(idcard, filename: fileidcard),
  //         'doctor_name': doctorname,
  //         'hospital_name': hospitalname,
  //         'description': description,
  //         'address': address,
  //         'started_year': startedyear,
  //         'email': email,
  //         'emergency_services': emergencyservices,
  //         'emergency_number': emergencynumber,
  //         'mrng_from': mrngfrom,
  //         'mrng_to': mrngto,
  //         'after_from': afterfrom,
  //         'after_to': afterto,
  //         'sat_from': satfrom,
  //         'sat_to': satto,
  //         'sat_closed': satclosed,
  //         'sun_from': sunfrom,
  //         'sun_to': sunto,
  //         'sun_closed': sunclosed,
  //         'hospital_phone_num': hospitalphonenum
  //       },
  //     );
  //     var response = await api.sendRequest.post(
  //         ApiConstants.registrationpethospital,
  //         data: formData,
  //         options: Options(contentType: 'multipart/form-data'));
  //     final body = jsonDecode(response.data);

  //     if (response.statusCode == 200) {
  //       if (body['err_code'] == 'valid') {
  //         return PetRegistrationDataModel.fromJson(body);
  //       } else {
  //         Fluttertoast.showToast(msg: body['message']);

  //         return PetRegistrationDataModel.fromJson(body);
  //       }
  //     }
  //   } catch (ex) {
  //     return null;
  //   }

  //   return null;
  // }

  // Future<PetRegistrationDataModel?> sendregistrationTransportData(
  //   String userid,
  //   regno,
  //   imageFile,
  //   idcard,
  //   name,
  //   website,
  //   address,
  //   transporttypeids,
  //   pickupdropids,
  //   phonenumber,
  //   whatsappnumber,
  //   feedbacklink,
  //   startedyear,
  //   whyurbest,
  // ) async {
  //   try {
  //     String fileName = imageFile.split('/').last;
  //     String fileidcard = idcard.split('/').last;
  //     var formData = FormData.fromMap(
  //       {
  //         'user_id': userid,
  //         'reg_no': regno,
  //         "profile_pic":
  //             await MultipartFile.fromFile(imageFile, filename: fileName),
  //         "document":
  //             await MultipartFile.fromFile(idcard, filename: fileidcard),
  //         'name': name,
  //         'website': website,
  //         'address': address,
  //         'transport_type_ids': transporttypeids,
  //         'pickup_drop_ids': pickupdropids,
  //         'phone_number': phonenumber,
  //         'whatsapp_number': whatsappnumber,
  //         'feedback_link': feedbacklink,
  //         'started_year': startedyear,
  //         'why_ur_best': whyurbest,
  //       },
  //     );
  //     var response = await api.sendRequest.post(
  //         ApiConstants.registrationpettransport,
  //         data: formData,
  //         options: Options(contentType: 'multipart/form-data'));
  //     final body = jsonDecode(response.data);

  //     if (response.statusCode == 200) {
  //       if (body['err_code'] == 'valid') {
  //         return PetRegistrationDataModel.fromJson(body);
  //       } else {
  //         Fluttertoast.showToast(msg: body['message']);

  //         return PetRegistrationDataModel.fromJson(body);
  //       }
  //     }
  //   } catch (ex) {
  //     return null;
  //   }

  //   return null;
  // }

  // Future<PetRegistrationDataModel?> sendregistrationShopData(
  //   String userid,
  //   regno,
  //   imageFile,
  //   idcard,
  //   petstorename,
  //   ownername,
  //   address,
  //   storeopensince,
  //   phonenumber,
  //   officephonenumber,
  //   servicesoffered,
  //   aboutus,
  //   storetimings,
  // ) async {
  //   try {
  //     String fileName = imageFile.split('/').last;
  //     String fileidcard = idcard.split('/').last;
  //     var formData = FormData.fromMap(
  //       {
  //         'user_id': userid,
  //         'reg_no': regno,
  //         "profile_pic":
  //             await MultipartFile.fromFile(imageFile, filename: fileName),
  //         "document":
  //             await MultipartFile.fromFile(idcard, filename: fileidcard),
  //         'pet_store_name': petstorename,
  //         'owner_name': ownername,
  //         'address': address,
  //         'store_open_since': storeopensince,
  //         'phone_number': phonenumber,
  //         'office_phone_number': officephonenumber,
  //         'services_offered': servicesoffered,
  //         'about_us': aboutus,
  //         'store_timings': storetimings,
  //       },
  //     );
  //     var response = await api.sendRequest.post(
  //         ApiConstants.registrationpetshop,
  //         data: formData,
  //         options: Options(contentType: 'multipart/form-data'));
  //     final body = jsonDecode(response.data);

  //     if (response.statusCode == 200) {
  //       if (body['err_code'] == 'valid') {
  //         return PetRegistrationDataModel.fromJson(body);
  //       } else {
  //         Fluttertoast.showToast(msg: body['message']);

  //         return PetRegistrationDataModel.fromJson(body);
  //       }
  //     }
  //   } catch (ex) {
  //     return null;
  //   }

  //   return null;
  // }

  // Future<PetRegistrationDataModel?> sendregistrationBordingData(
  //   String userid,
  //   regno,
  //   idcard,
  //   boardingcentrename,
  //   ownername,
  //   address,
  //   phonenumber,
  //   whatsappnumber,
  //   website,
  //   boardingcapacity,
  //   startedon,
  //   image,
  // ) async {
  //   try {
  //     //  String fileName = imageFile.split('/').last;
  //     String fileidcard = idcard.split('/').last;
  //     var formData = FormData.fromMap(
  //       {
  //         'user_id': userid,
  //         'reg_no': regno,
  //         "document":
  //             await MultipartFile.fromFile(idcard, filename: fileidcard),
  //         'boarding_centre_name': boardingcentrename,
  //         'owner_name': ownername,
  //         'address': address,
  //         'phone_number': phonenumber,
  //         'whatsapp_number': whatsappnumber,
  //         'website': website,
  //         'boarding_capacity': boardingcapacity,
  //         'started_on': startedon,
  //         'image': image,
  //       },
  //     );
  //     var response = await api.sendRequest.post(
  //         ApiConstants.registrationpetboardingcentre,
  //         data: formData,
  //         options: Options(contentType: 'multipart/form-data'));
  //     final body = jsonDecode(response.data);

  //     if (response.statusCode == 200) {
  //       if (body['err_code'] == 'valid') {
  //         return PetRegistrationDataModel.fromJson(body);
  //       } else {
  //         Fluttertoast.showToast(msg: body['message']);

  //         return PetRegistrationDataModel.fromJson(body);
  //       }
  //     }
  //   } catch (ex) {
  //     return null;
  //   }

  //   return null;
  // }

  // Future<PetRegistrationDataModel?> sendregistrationTrainingData(
  //   String userid,
  //   regno,
  //   idcard,
  //   trainingname,
  //   ownername,
  //   address,
  //   phonenumber,
  //   whatsappnumber,
  //   website,
  //   trainingcapacity,
  //   startedon,
  //   aboutus,
  //   image,
  // ) async {
  //   try {
  //     //  String fileName = imageFile.split('/').last;
  //     String fileidcard = idcard.split('/').last;
  //     var formData = FormData.fromMap(
  //       {
  //         'user_id': userid,
  //         'reg_no': regno,
  //         "document":
  //             await MultipartFile.fromFile(idcard, filename: fileidcard),
  //         'training_name': trainingname,
  //         'owner_name': ownername,
  //         'address': address,
  //         'phone_number': phonenumber,
  //         'whatsapp_number': whatsappnumber,
  //         'website': website,
  //         'training_capacity': trainingcapacity,
  //         'started_on': startedon,
  //         'about_us': aboutus,
  //         'image': image,
  //       },
  //     );
  //     var response = await api.sendRequest.post(
  //         ApiConstants.registrationpettrainingre,
  //         data: formData,
  //         options: Options(contentType: 'multipart/form-data'));
  //     final body = jsonDecode(response.data);

  //     if (response.statusCode == 200) {
  //       if (body['err_code'] == 'valid') {
  //         return PetRegistrationDataModel.fromJson(body);
  //       } else {
  //         Fluttertoast.showToast(msg: body['message']);

  //         return PetRegistrationDataModel.fromJson(body);
  //       }
  //     }
  //   } catch (ex) {
  //     return null;
  //   }

  //   return null;
  // }

  // Future<PetRegistrationDataModel?> sendregistrationShelterData(
  //   String userid,
  //   regno,
  //   idcard,
  //   name,
  //   ownername,
  //   address,
  //   startedyear,
  //   capacity,
  //   aboutus,
  //   phonenumber,
  //   image,
  // ) async {
  //   try {
  //     //  String fileName = imageFile.split('/').last;
  //     String fileidcard = idcard.split('/').last;
  //     var formData = FormData.fromMap(
  //       {
  //         'user_id': userid,
  //         'reg_no': regno,
  //         "document":
  //             await MultipartFile.fromFile(idcard, filename: fileidcard),
  //         'name': name,
  //         'owner_name': ownername,
  //         'address': address,
  //         'started_year': startedyear,
  //         'capacity': capacity,
  //         'about_us': aboutus,
  //         'phone_number': phonenumber,
  //         'image': image,
  //       },
  //     );
  //     var response = await api.sendRequest.post(
  //         ApiConstants.registrationpetshelter,
  //         data: formData,
  //         options: Options(contentType: 'multipart/form-data'));
  //     final body = jsonDecode(response.data);

  //     if (response.statusCode == 200) {
  //       if (body['err_code'] == 'valid') {
  //         return PetRegistrationDataModel.fromJson(body);
  //       } else {
  //         Fluttertoast.showToast(msg: body['message']);

  //         return PetRegistrationDataModel.fromJson(body);
  //       }
  //     }
  //   } catch (ex) {
  //     return null;
  //   }

  //   return null;
  // }

  // Future<ImageUploadDataModel?> multipleImageUpload(
  //   String idcard,
  // ) async {
  //   try {
  //     //  String fileName = imageFile.split('/').last;
  //     String fileidcard = idcard.split('/').last;
  //     var formData = FormData.fromMap(
  //       {
  //         "image": await MultipartFile.fromFile(idcard, filename: fileidcard),
  //       },
  //     );
  //     var response = await api.sendRequest.post(
  //         ApiConstants.registrationpetuploadmultipleimages,
  //         data: formData,
  //         options: Options(contentType: 'multipart/form-data'));
  //     final body = jsonDecode(response.data);

  //     if (response.statusCode == 200) {
  //       if (body['err_code'] == 'valid') {
  //         return ImageUploadDataModel.fromJson(body);
  //       } else {
  //         Fluttertoast.showToast(msg: body['message']);

  //         return ImageUploadDataModel.fromJson(body);
  //       }
  //     }
  //   } catch (ex) {
  //     return null;
  //   }

  //   return null;
  // }

  // Future<PetRegistrationDataModel?> deleteImageUpload(
  //   String idcard,
  // ) async {
  //   try {
  //     //  String fileName = imageFile.split('/').last;

  //     var formData = FormData.fromMap(
  //       {
  //         "id": idcard,
  //       },
  //     );
  //     var response = await api.sendRequest.post(
  //         ApiConstants.registrationpetdeleteImages,
  //         data: formData,
  //         options: Options(contentType: 'multipart/form-data'));
  //     final body = jsonDecode(response.data);

  //     if (response.statusCode == 200) {
  //       if (body['status'] == 'valid') {
  //         return PetRegistrationDataModel.fromJson(body);
  //       } else {
  //         Fluttertoast.showToast(msg: body['message']);

  //         return PetRegistrationDataModel.fromJson(body);
  //       }
  //     }
  //   } catch (ex) {
  //     return null;
  //   }

  //   return null;
  // }

  // Future<LoginDataModel?> sendOtpVerifiction(String otp) async {
  //   try {
  //     var formData = FormData.fromMap({
  //       'otp': otp,
  //       'user_id': Preference().getString(Preference.userID),
  //       'reg_no': Preference().getString(Preference.registerNo),
  //     });
  //     var response = await api.sendRequest.post(ApiConstants.otpverification,
  //         data: formData, options: Options(contentType: 'multipart/form-data'));
  //     final body = jsonDecode(response.data);

  //     if (response.statusCode == 200) {
  //       if (body['err_code'] == 'valid') {
  //         return LoginDataModel.fromJson(body);
  //       } else {
  //         Fluttertoast.showToast(msg: body['message']);

  //         return LoginDataModel.fromJson(body);
  //       }
  //     }
  //   } catch (ex) {
  //     return null;
  //   }

  //   return null;
  // }

  // Future<PetSitterWlakerDataModel?> sendPetSitterWlakerData(String type) async {
  //   try {
  //     var formData = FormData.fromMap({
  //       'user_id': Preference().getString(Preference.userID),
  //       'type': type,
  //     });
  //     var response = await api.sendRequest.post(ApiConstants.petsitter,
  //         data: formData, options: Options(contentType: 'multipart/form-data'));
  //     final body = jsonDecode(response.data);

  //     if (response.statusCode == 200) {
  //       if (body['status'] == 'valid') {
  //         return PetSitterWlakerDataModel.fromJson(body);
  //       } else {
  //         Fluttertoast.showToast(msg: body['message']);
  //         return PetSitterWlakerDataModel.fromJson(body);
  //       }
  //     }
  //   } catch (ex) {
  //     return null;
  //   }
  //   return null;
  // }

  // Future<PetFoodGroomingListDataModel?> sendPetsFoodData() async {
  //   try {
  //     var formData = FormData.fromMap({
  //       'user_id': Preference().getString(Preference.userID),
  //     });
  //     var response = await api.sendRequest.post(ApiConstants.petfoodlist,
  //         data: formData, options: Options(contentType: 'multipart/form-data'));
  //     final body = jsonDecode(response.data);

  //     if (response.statusCode == 200) {
  //       if (body['status'] == 'valid') {
  //         return PetFoodGroomingListDataModel.fromJson(body);
  //       } else {
  //         Fluttertoast.showToast(msg: body['message']);
  //         return PetFoodGroomingListDataModel.fromJson(body);
  //       }
  //     }
  //   } catch (ex) {
  //     return null;
  //   }
  //   return null;
  // }

  // Future<PetFoodGroomingListDataModel?> sendPetsGroomingData() async {
  //   try {
  //     var formData = FormData.fromMap({
  //       'user_id': Preference().getString(Preference.userID),
  //     });
  //     var response = await api.sendRequest.post(ApiConstants.petgroominglist,
  //         data: formData, options: Options(contentType: 'multipart/form-data'));
  //     final body = jsonDecode(response.data);

  //     if (response.statusCode == 200) {
  //       if (body['status'] == 'valid') {
  //         return PetFoodGroomingListDataModel.fromJson(body);
  //       } else {
  //         Fluttertoast.showToast(msg: body['message']);
  //         return PetFoodGroomingListDataModel.fromJson(body);
  //       }
  //     }
  //   } catch (ex) {
  //     return null;
  //   }
  //   return null;
  // }

  // Future<PetAtShelterDataModel?> sendPetShelterData() async {
  //   try {
  //     var formData = FormData.fromMap({
  //       'user_id': Preference().getString(Preference.userID),
  //       'reg_no': Preference().getString(Preference.registerNo),
  //     });
  //     var response = await api.sendRequest.post(ApiConstants.petShelter,
  //         data: formData, options: Options(contentType: 'multipart/form-data'));
  //     final body = jsonDecode(response.data);

  //     if (response.statusCode == 200) {
  //       if (body['status'] == 'valid') {
  //         return PetAtShelterDataModel.fromJson(body);
  //       } else {
  //         Fluttertoast.showToast(msg: body['message']);
  //         return PetAtShelterDataModel.fromJson(body);
  //       }
  //     }
  //   } catch (ex) {
  //     return null;
  //   }
  //   return null;
  // }

  // Future<MyAppoinmentDataModel?> sendMyAppoinmentData(String status) async {
  //   try {
  //     var formData = FormData.fromMap({
  //       'user_id': Preference().getString(Preference.userID),
  //       'status': status,
  //     });
  //     var response = await api.sendRequest.post(ApiConstants.myappointments,
  //         data: formData, options: Options(contentType: 'multipart/form-data'));
  //     final body = jsonDecode(response.data);

  //     if (response.statusCode == 200) {
  //       if (body['status'] == 'valid') {
  //         return MyAppoinmentDataModel.fromJson(body);
  //       } else {
  //         Fluttertoast.showToast(msg: body['message']);
  //         return MyAppoinmentDataModel.fromJson(body);
  //       }
  //     }
  //   } catch (ex) {
  //     return null;
  //   }
  //   return null;
  // }

  // Future<PetOwnerDataModel?> getPetOwner() async {
  //   try {
  //     var formData = FormData.fromMap({
  //       'user_id': Preference().getString(Preference.userID),
  //     });
  //     var response = await api.sendRequest.post(
  //         ApiConstants.userdetailspetowner,
  //         data: formData,
  //         options: Options(contentType: 'multipart/form-data'));
  //     final body = jsonDecode(response.data);

  //     if (response.statusCode == 200) {
  //       if (body['status'] == 'valid') {
  //         return PetOwnerDataModel.fromJson(body);
  //       } else {
  //         Fluttertoast.showToast(msg: body['message']);
  //         return PetOwnerDataModel.fromJson(body);
  //       }
  //     }
  //   } catch (ex) {
  //     return null;
  //   }
  //   return null;
  // }

  // Future<PetAtShelterDataModel?> sendPetShelterDeleteData(String id) async {
  //   try {
  //     var formData = FormData.fromMap({
  //       'id': id,
  //     });
  //     var response = await api.sendRequest.post(ApiConstants.petShelterdelete,
  //         data: formData, options: Options(contentType: 'multipart/form-data'));
  //     final body = jsonDecode(response.data);

  //     if (response.statusCode == 200) {
  //       if (body['status'] == 'valid') {
  //         return PetAtShelterDataModel.fromJson(body);
  //       } else {
  //         Fluttertoast.showToast(msg: body['message']);
  //         return PetAtShelterDataModel.fromJson(body);
  //       }
  //     }
  //   } catch (ex) {
  //     return null;
  //   }
  //   return null;
  // }

  // Future<PetBoardingCenterListDataModel?> sendBordingCenterData() async {
  //   try {
  //     var formData = FormData.fromMap({
  //       'user_id': Preference().getString(Preference.userID),
  //     });
  //     var response = await api.sendRequest.post(
  //         ApiConstants.petboardingcenterdetails,
  //         data: formData,
  //         options: Options(contentType: 'multipart/form-data'));
  //     final body = jsonDecode(response.data);

  //     if (response.statusCode == 200) {
  //       if (body['status'] == 'valid') {
  //         return PetBoardingCenterListDataModel.fromJson(body);
  //       } else {
  //         Fluttertoast.showToast(msg: body['message']);
  //         return PetBoardingCenterListDataModel.fromJson(body);
  //       }
  //     }
  //   } catch (ex) {
  //     return null;
  //   }
  //   return null;
  // }

  // Future<PetTransportListDataModel?> sendTrasportData() async {
  //   try {
  //     var formData = FormData.fromMap({
  //       'user_id': Preference().getString(Preference.userID),
  //     });
  //     var response = await api.sendRequest.post(ApiConstants.pettrasportdetails,
  //         data: formData, options: Options(contentType: 'multipart/form-data'));
  //     final body = jsonDecode(response.data);

  //     if (response.statusCode == 200) {
  //       if (body['status'] == 'valid') {
  //         return PetTransportListDataModel.fromJson(body);
  //       } else {
  //         Fluttertoast.showToast(msg: body['message']);
  //         return PetTransportListDataModel.fromJson(body);
  //       }
  //     }
  //   } catch (ex) {
  //     return null;
  //   }
  //   return null;
  // }

  // Future<PetHospitalListDataModel?> sendHospitalData() async {
  //   try {
  //     var formData = FormData.fromMap({
  //       'user_id': Preference().getString(Preference.userID),
  //     });
  //     var response = await api.sendRequest.post(ApiConstants.pethospitals,
  //         data: formData, options: Options(contentType: 'multipart/form-data'));
  //     final body = jsonDecode(response.data);

  //     if (response.statusCode == 200) {
  //       if (body['status'] == 'valid') {
  //         return PetHospitalListDataModel.fromJson(body);
  //       } else {
  //         Fluttertoast.showToast(msg: body['message']);
  //         return PetHospitalListDataModel.fromJson(body);
  //       }
  //     }
  //   } catch (ex) {
  //     return null;
  //   }
  //   return null;
  // }

  // Future<PetSufferingListDataModel?> sendSufferingData() async {
  //   try {
  //     var formData = FormData.fromMap({
  //       'user_id': Preference().getString(Preference.userID),
  //       'reg_no': Preference().getString(Preference.registerNo),
  //     });
  //     var response = await api.sendRequest.post(ApiConstants.petsuffering,
  //         data: formData, options: Options(contentType: 'multipart/form-data'));
  //     final body = jsonDecode(response.data);

  //     if (response.statusCode == 200) {
  //       if (body['status'] == 'valid') {
  //         return PetSufferingListDataModel.fromJson(body);
  //       } else {
  //         Fluttertoast.showToast(msg: body['message']);
  //         return PetSufferingListDataModel.fromJson(body);
  //       }
  //     }
  //   } catch (ex) {
  //     return null;
  //   }
  //   return null;
  // }

  // Future<PetMeetupListDataModel?> sendMeetUpListData() async {
  //   try {
  //     var formData = FormData.fromMap({
  //       'user_id': Preference().getString(Preference.userID),
  //       'reg_no': Preference().getString(Preference.registerNo),
  //     });
  //     var response = await api.sendRequest.post(ApiConstants.petmeetups,
  //         data: formData, options: Options(contentType: 'multipart/form-data'));
  //     final body = jsonDecode(response.data);

  //     if (response.statusCode == 200) {
  //       if (body['status'] == 'valid') {
  //         return PetMeetupListDataModel.fromJson(body);
  //       } else {
  //         Fluttertoast.showToast(msg: body['message']);
  //         return PetMeetupListDataModel.fromJson(body);
  //       }
  //     }
  //   } catch (ex) {
  //     return null;
  //   }
  //   return null;
  // }

  // Future<PetMeetupListDataModel?> sendMeetUpDeleteData(String id) async {
  //   try {
  //     var formData = FormData.fromMap({
  //       'id': id,
  //     });
  //     var response = await api.sendRequest.post(ApiConstants.petmeetupsDelete,
  //         data: formData, options: Options(contentType: 'multipart/form-data'));
  //     final body = jsonDecode(response.data);

  //     if (response.statusCode == 200) {
  //       if (body['status'] == 'valid') {
  //         return PetMeetupListDataModel.fromJson(body);
  //       } else {
  //         Fluttertoast.showToast(msg: body['message']);
  //         return PetMeetupListDataModel.fromJson(body);
  //       }
  //     }
  //   } catch (ex) {
  //     return null;
  //   }
  //   return null;
  // }

  // Future<PetShelterListDataModel?> sendShelterData() async {
  //   try {
  //     var formData = FormData.fromMap({
  //       'user_id': Preference().getString(Preference.userID),
  //     });
  //     var response = await api.sendRequest.post(ApiConstants.petShelterlist,
  //         data: formData, options: Options(contentType: 'multipart/form-data'));
  //     final body = jsonDecode(response.data);

  //     if (response.statusCode == 200) {
  //       if (body['status'] == 'valid') {
  //         return PetShelterListDataModel.fromJson(body);
  //       } else {
  //         Fluttertoast.showToast(msg: body['message']);
  //         return PetShelterListDataModel.fromJson(body);
  //       }
  //     }
  //   } catch (ex) {
  //     return null;
  //   }
  //   return null;
  // }

  // Future<PetFreeFoodToysListDataModel?> sendfreetoysfoodData() async {
  //   try {
  //     var formData = FormData.fromMap({
  //       'user_id': Preference().getString(Preference.userID),
  //       'reg_no': Preference().getString(Preference.registerNo),
  //     });
  //     var response = await api.sendRequest.post(ApiConstants.freetoysfood,
  //         data: formData, options: Options(contentType: 'multipart/form-data'));
  //     final body = jsonDecode(response.data);

  //     if (response.statusCode == 200) {
  //       if (body['status'] == 'valid') {
  //         return PetFreeFoodToysListDataModel.fromJson(body);
  //       } else {
  //         Fluttertoast.showToast(msg: body['message']);
  //         return PetFreeFoodToysListDataModel.fromJson(body);
  //       }
  //     }
  //   } catch (ex) {
  //     return null;
  //   }
  //   return null;
  // }

  // Future<PetFreeFoodToysListDataModel?> addFreeToystData(
  //     String name, phone, shownumber, address, category, imageFile) async {
  //   try {
  //     String fileName = imageFile.split('/').last;
  //     var formData = FormData.fromMap(
  //       {
  //         'user_id': Preference().getString(Preference.userID),
  //         'reg_no': Preference().getString(Preference.registerNo),
  //         'name': name,
  //         'phone': phone,
  //         'show_number': shownumber,
  //         'location': address,
  //         'category': category,
  //         "image": await MultipartFile.fromFile(imageFile, filename: fileName),
  //       },
  //     );
  //     var response = await api.sendRequest.post(ApiConstants.freetoysfoodadd,
  //         data: formData, options: Options(contentType: 'multipart/form-data'));
  //     final body = jsonDecode(response.data);

  //     if (response.statusCode == 200) {
  //       if (body['status'] == 'valid') {
  //         return PetFreeFoodToysListDataModel.fromJson(body);
  //       } else {
  //         Fluttertoast.showToast(msg: body['message']);
  //         return PetFreeFoodToysListDataModel.fromJson(body);
  //       }
  //     }
  //   } catch (ex) {
  //     return null;
  //   }
  //   return null;
  // }

  // Future<PetFreeFoodToysListDataModel?> addMeetupData(
  //     String name, type, description, address, time, imageFile) async {
  //   try {
  //     String fileName = imageFile.split('/').last;
  //     var formData = FormData.fromMap(
  //       {
  //         'user_id': Preference().getString(Preference.userID),
  //         'reg_no': Preference().getString(Preference.registerNo),
  //         'meetup_name': name,
  //         'meetup_type': type,
  //         'description': description,
  //         'address': address,
  //         'date_time': time,
  //         "image": await MultipartFile.fromFile(imageFile, filename: fileName),
  //       },
  //     );
  //     var response = await api.sendRequest.post(ApiConstants.petmeetupsadd,
  //         data: formData, options: Options(contentType: 'multipart/form-data'));
  //     final body = jsonDecode(response.data);

  //     if (response.statusCode == 200) {
  //       if (body['status'] == 'valid') {
  //         return PetFreeFoodToysListDataModel.fromJson(body);
  //       } else {
  //         Fluttertoast.showToast(msg: body['message']);
  //         return PetFreeFoodToysListDataModel.fromJson(body);
  //       }
  //     }
  //   } catch (ex) {
  //     return null;
  //   }
  //   return null;
  // }

  // Future<PetAtShelterDataModel?> addShelterData(
  //     String name, breed, age, imageFile) async {
  //   try {
  //     String fileName = imageFile.split('/').last;
  //     var formData = FormData.fromMap(
  //       {
  //         'user_id': Preference().getString(Preference.userID),
  //         'reg_no': Preference().getString(Preference.registerNo),
  //         'pet_name': name,
  //         'pet_breed': breed,
  //         'pet_age': age,
  //         "pet_image":
  //             await MultipartFile.fromFile(imageFile, filename: fileName),
  //       },
  //     );
  //     var response = await api.sendRequest.post(ApiConstants.petshelteradd,
  //         data: formData, options: Options(contentType: 'multipart/form-data'));
  //     final body = jsonDecode(response.data);

  //     if (response.statusCode == 200) {
  //       if (body['status'] == 'valid') {
  //         return PetAtShelterDataModel.fromJson(body);
  //       } else {
  //         Fluttertoast.showToast(msg: body['message']);
  //         return PetAtShelterDataModel.fromJson(body);
  //       }
  //     }
  //   } catch (ex) {
  //     return null;
  //   }
  //   return null;
  // }

  // Future<PetFreeFoodToysListDataModel?> addSufferingData(
  //     String name, phone, description, address, imageFile) async {
  //   try {
  //     String fileName = imageFile.split('/').last;
  //     var formData = FormData.fromMap(
  //       {
  //         'user_id': Preference().getString(Preference.userID),
  //         'reg_no': Preference().getString(Preference.registerNo),
  //         'name': name,
  //         'phone': phone,
  //         'description': description,
  //         'address': address,
  //         "pet_image":
  //             await MultipartFile.fromFile(imageFile, filename: fileName),
  //       },
  //     );
  //     var response = await api.sendRequest.post(
  //       ApiConstants.petsufferingadd,
  //       data: formData,
  //       options: Options(contentType: 'multipart/form-data'),
  //     );
  //     final body = jsonDecode(response.data);

  //     if (response.statusCode == 200) {
  //       if (body['status'] == 'valid') {
  //         return PetFreeFoodToysListDataModel.fromJson(body);
  //       } else {
  //         Fluttertoast.showToast(msg: body['message']);
  //         return PetFreeFoodToysListDataModel.fromJson(body);
  //       }
  //     }
  //   } catch (ex) {
  //     return null;
  //   }
  //   return null;
  // }

  // Future<PetSitterWlakerViewDataModel?> sendPetSitterWlakerViewData(
  //     String type) async {
  //   try {
  //     var formData = FormData.fromMap({
  //       'id': type,
  //     });
  //     var response = await api.sendRequest.post(ApiConstants.petsitterview,
  //         data: formData, options: Options(contentType: 'multipart/form-data'));
  //     final body = jsonDecode(response.data);

  //     if (response.statusCode == 200) {
  //       if (body['status'] == 'valid') {
  //         return PetSitterWlakerViewDataModel.fromJson(body);
  //       } else {
  //         Fluttertoast.showToast(msg: body['message']);
  //         return PetSitterWlakerViewDataModel.fromJson(body);
  //       }
  //     }
  //   } catch (ex) {
  //     return null;
  //   }
  //   return null;
  // }

  // Future<PetBoardingViewDataModel?> sendBordindViewData(String type) async {
  //   try {
  //     var formData = FormData.fromMap({
  //       'id': type,
  //     });
  //     var response = await api.sendRequest.post(
  //         ApiConstants.petboardingcenterdetailsView,
  //         data: formData,
  //         options: Options(contentType: 'multipart/form-data'));
  //     final body = jsonDecode(response.data);

  //     if (response.statusCode == 200) {
  //       if (body['status'] == 'valid') {
  //         return PetBoardingViewDataModel.fromJson(body);
  //       } else {
  //         Fluttertoast.showToast(msg: body['message']);
  //         return PetBoardingViewDataModel.fromJson(body);
  //       }
  //     }
  //   } catch (ex) {
  //     return null;
  //   }
  //   return null;
  // }

  // Future<PetHospitalViewDataModel?> sendHospitalViewData(String type) async {
  //   try {
  //     var formData = FormData.fromMap({
  //       'id': type,
  //     });
  //     var response = await api.sendRequest.post(ApiConstants.pethospitalsView,
  //         data: formData, options: Options(contentType: 'multipart/form-data'));
  //     final body = jsonDecode(response.data);

  //     if (response.statusCode == 200) {
  //       if (body['status'] == 'valid') {
  //         return PetHospitalViewDataModel.fromJson(body);
  //       } else {
  //         Fluttertoast.showToast(msg: body['message']);
  //         return PetHospitalViewDataModel.fromJson(body);
  //       }
  //     }
  //   } catch (ex) {
  //     return null;
  //   }
  //   return null;
  // }

  // Future<PetTransportViewDataModel?> sendTransportViewData(String type) async {
  //   try {
  //     var formData = FormData.fromMap({
  //       'id': type,
  //     });
  //     var response = await api.sendRequest.post(
  //         ApiConstants.pettrasportdetailsView,
  //         data: formData,
  //         options: Options(contentType: 'multipart/form-data'));
  //     final body = jsonDecode(response.data);

  //     if (response.statusCode == 200) {
  //       if (body['status'] == 'valid') {
  //         return PetTransportViewDataModel.fromJson(body);
  //       } else {
  //         Fluttertoast.showToast(msg: body['message']);
  //         return PetTransportViewDataModel.fromJson(body);
  //       }
  //     }
  //   } catch (ex) {
  //     return null;
  //   }
  //   return null;
  // }

  // Future<PetTransportViewDataModel?> sendTransportAboutData(String type) async {
  //   try {
  //     var formData = FormData.fromMap({
  //       'user_id': type,
  //     });
  //     var response = await api.sendRequest.post(
  //         ApiConstants.pettrasportdetailsabout,
  //         data: formData,
  //         options: Options(contentType: 'multipart/form-data'));
  //     final body = jsonDecode(response.data);

  //     if (response.statusCode == 200) {
  //       if (body['status'] == 'valid') {
  //         return PetTransportViewDataModel.fromJson(body);
  //       } else {
  //         Fluttertoast.showToast(msg: body['message']);
  //         return PetTransportViewDataModel.fromJson(body);
  //       }
  //     }
  //   } catch (ex) {
  //     return null;
  //   }
  //   return null;
  // }

  // Future<LoginDataModel?> sendReOtpVerifiction() async {
  //   try {
  //     var formData = FormData.fromMap({
  //       'user_id': Preference().getString(Preference.userID),
  //       'reg_no': Preference().getString(Preference.registerNo),
  //     });
  //     var response = await api.sendRequest.post(ApiConstants.resendotp,
  //         data: formData, options: Options(contentType: 'multipart/form-data'));
  //     final body = jsonDecode(response.data);

  //     if (response.statusCode == 200) {
  //       if (body['err_code'] == 'valid') {
  //         return LoginDataModel.fromJson(body);
  //       } else {
  //         Fluttertoast.showToast(msg: body['message']);

  //         return LoginDataModel.fromJson(body);
  //       }
  //     }
  //   } catch (ex) {
  //     return null;
  //   }

  //   return null;
  // }

  // Future<LoginDataModel?> updateLocation() async {
  //   try {
  //     var formData = FormData.fromMap({
  //       'user_id': Preference().getString(Preference.userID),
  //       'latitude': Preference().getDouble('lat'),
  //       'longitude': Preference().getDouble('long'),
  //     });
  //     var response = await api.sendRequest.post(ApiConstants.updatelatlong,
  //         data: formData, options: Options(contentType: 'multipart/form-data'));
  //     final body = jsonDecode(response.data);

  //     if (response.statusCode == 200) {
  //       if (body['status'] == 'valid') {
  //         return LoginDataModel.fromJson(body);
  //       } else {
  //         Fluttertoast.showToast(msg: body['message']);

  //         return LoginDataModel.fromJson(body);
  //       }
  //     }
  //   } catch (ex) {
  //     return null;
  //   }

  //   return null;
  // }

  // Future<RegisteredDataModel?> sendForgotPassword(
  //     Map<String, String> data) async {
  //   try {
  //     var response =
  //         await api.sendRequest.post(ApiConstants.forgotpassword, data: data);
  //     if (response.statusCode == 200) {
  //       if (response.data['status'] == 'valid') {
  //         return RegisteredDataModel.fromJson(response.data);
  //       } else {
  //         Utils.showToast(Get.context!, response.data['message']);
  //       }
  //     }
  //   } catch (ex) {
  //     return null;
  //   }

  //   return null;
  // }

  // Future<RegisteredDataModel?> chagePassword(Map<String, String> data) async {
  //   try {
  //     var response = await api.sendRequest.post(ApiConstants.changepassword,
  //         data: data,
  //         options: Options(headers: {
  //           'Authorization':
  //               'Bearer ${Preference.shared.getString(Preference.accessToken)}'
  //         }));
  //     if (response.statusCode == 200) {
  //       if (response.data['status'] == 'valid') {
  //         return RegisteredDataModel.fromJson(response.data);
  //       } else {
  //         Utils.showToast(Get.context!, response.data['message']);
  //       }
  //     }
  //   } catch (ex) {
  //     return null;
  //   }

  //   return null;
  // }

  // Future<RegisteredDataModel?> deletedUploadImage(
  //     Map<String, String> data) async {
  //   try {
  //     var response = await api.sendRequest.post(ApiConstants.imagedelete,
  //         data: data,
  //         options: Options(headers: {
  //           'Authorization':
  //               'Bearer ${Preference.shared.getString(Preference.accessToken)}'
  //         }));
  //     if (response.statusCode == 200) {
  //       if (response.data['status'] == 'valid') {
  //         return RegisteredDataModel.fromJson(response.data);
  //       } else {
  //         Utils.showToast(Get.context!, response.data['message']);
  //       }
  //     }
  //   } catch (ex) {
  //     return null;
  //   }

  //   return null;
  // }

  // Future<RegisteredDataModel?> setNewPasswordApi(
  //     Map<String, String> data) async {
  //   try {
  //     var response =
  //         await api.sendRequest.post(ApiConstants.resetpassword, data: data);
  //     if (response.statusCode == 200) {
  //       if (response.data['status'] == 'valid') {
  //         return RegisteredDataModel.fromJson(response.data);
  //       } else {
  //         Utils.showToast(Get.context!, response.data['message']);
  //       }
  //     }
  //   } catch (ex) {
  //     return null;
  //   }

  //   return null;
  // }

  // Future<OtpVerifyDataModel?> sendVerifyOtp(Map<String, String> data) async {
  //   try {
  //     var response =
  //         await api.sendRequest.post(ApiConstants.verifyOtp, data: data);
  //     if (response.statusCode == 200) {
  //       if (response.data['status'] == 'valid') {
  //         return OtpVerifyDataModel.fromJson(response.data);
  //       } else {
  //         Utils.showToast(Get.context!, response.data['message']);
  //       }
  //     }
  //   } catch (ex) {
  //     return null;
  //   }

  //   return null;
  // }

  // Future<HomeDashboardDataModel?> homeDashBoard(
  //     Map<String, String> data) async {
  //   try {
  //     var response = await api.sendRequest.post(ApiConstants.home,
  //         data: data,
  //         options: Options(headers: {
  //           'Authorization':
  //               'Bearer ${Preference.shared.getString(Preference.accessToken)}'
  //         }));
  //     if (response.statusCode == 200) {
  //       if (response.data['status'] == 'valid') {
  //         return HomeDashboardDataModel.fromJson(response.data);
  //       } else {
  //         Utils.showToast(Get.context!, response.data['message']);
  //       }
  //     }
  //   } catch (ex) {
  //     return null;
  //   }

  //   return null;
  // }

  // Future<ProfileDataModel?> profileDataGet(Map<String, String> data) async {
  //   // try {
  //   var response = await api.sendRequest.post(ApiConstants.getUserDetails,
  //       data: data,
  //       options: Options(headers: {
  //         'Authorization':
  //             'Bearer ${Preference.shared.getString(Preference.accessToken)}'
  //       }));
  //   if (response.statusCode == 200) {
  //     if (response.data['status'] == 'valid') {
  //       return ProfileDataModel.fromJson(response.data);
  //     } else {
  //       Utils.showToast(Get.context!, response.data['message']);
  //     }
  //   }
  //   // } catch (ex) {
  //   //   return null;
  //   // }

  //   // return null;
  // }

  // Future<TermsAndConditionDataModel?> termsandconditiondataFetch(
  //     Map<String, String> data) async {
  //   try {
  //     var response = await api.sendRequest.post(ApiConstants.cmspages,
  //         data: data,
  //         options: Options(headers: {
  //           'Authorization':
  //               'Bearer ${Preference.shared.getString(Preference.accessToken)}'
  //         }));
  //     if (response.statusCode == 200) {
  //       if (response.data['status'] == 'valid') {
  //         return TermsAndConditionDataModel.fromJson(response.data);
  //       } else {
  //         Utils.showToast(Get.context!, response.data['message']);
  //       }
  //     }
  //   } catch (ex) {
  //     return null;
  //   }

  //   return null;
  // }

  // Future<CountryDataModel?> countryDataGet() async {
  //   try {
  //     var response = await api.sendRequest.post(ApiConstants.getcountries,
  //         options: Options(headers: {
  //           'Authorization':
  //               'Bearer ${Preference.shared.getString(Preference.accessToken)}'
  //         }));
  //     if (response.statusCode == 200) {
  //       if (response.data['status'] == 'valid') {
  //         return CountryDataModel.fromJson(response.data);
  //       } else {
  //         Utils.showToast(Get.context!, response.data['message']);
  //       }
  //     }
  //   } catch (ex) {
  //     return null;
  //   }

  //   return null;
  // }

  // Future<CountryDataModel?> stateDataGet(Map<String, String> data) async {
  //   try {
  //     var response = await api.sendRequest.post(ApiConstants.getstates,
  //         data: data,
  //         options: Options(headers: {
  //           'Authorization':
  //               'Bearer ${Preference.shared.getString(Preference.accessToken)}'
  //         }));
  //     if (response.statusCode == 200) {
  //       if (response.data['status'] == 'valid') {
  //         return CountryDataModel.fromJson(response.data);
  //       } else {
  //         Utils.showToast(Get.context!, response.data['message']);
  //       }
  //     }
  //   } catch (ex) {
  //     return null;
  //   }

  //   return null;
  // }

  // Future<CountryDataModel?> cityDataGet(Map<String, String> data) async {
  //   try {
  //     var response = await api.sendRequest.post(ApiConstants.getcities,
  //         data: data,
  //         options: Options(headers: {
  //           'Authorization':
  //               'Bearer ${Preference.shared.getString(Preference.accessToken)}'
  //         }));
  //     if (response.statusCode == 200) {
  //       if (response.data['status'] == 'valid') {
  //         return CountryDataModel.fromJson(response.data);
  //       } else {
  //         Utils.showToast(Get.context!, response.data['message']);
  //       }
  //     }
  //   } catch (ex) {
  //     return null;
  //   }

  //   return null;
  // }

  // Future<RegisteredDataModel?> registerDataSend(
  //     Map<String, String> data, File imageFile) async {
  //   var url = Uri.parse(
  //       'https://colormoon.in/john_vali/edgrow/api/executive/register');

  //   http.MultipartRequest request = http.MultipartRequest("POST", url);

  //   request.fields.addAll(data);
  //   if (imageFile != null) {
  //     request.files.add(http.MultipartFile.fromBytes(
  //         "profile_picture", imageFile.readAsBytesSync(),
  //         filename: 'FIle.jpeg', contentType: MediaType("image", "jpg")));
  //   }

  //   request.headers.addAll(<String, String>{
  //     "content-type": "multipart/form-data",
  //   });

  //   http.StreamedResponse response = await request.send();
  //   final res = await http.Response.fromStream(response);
  //   print(res);
  //   // return response.body;

  //   return RegisteredDataModel.fromJson(jsonDecode(res.body));
  // }

  // Future<ImageUploadDataModel?> imageUploadDataAPI(File imageFile) async {
  //   var url = Uri.parse(
  //       'https://colormoon.in/john_vali/edgrow/api/executive/image-upload');

  //   http.MultipartRequest request = http.MultipartRequest("POST", url);

  //   if (imageFile != null) {
  //     request.files.add(http.MultipartFile.fromBytes(
  //         "image", imageFile.readAsBytesSync(),
  //         filename: 'FIle.jpeg', contentType: MediaType("image", "jpg")));
  //   }

  //   request.headers.addAll(<String, String>{
  //     "content-type": "multipart/form-data",
  //     'Authorization':
  //         'Bearer ${Preference.shared.getString(Preference.accessToken)}'
  //   });

  //   http.StreamedResponse response = await request.send();
  //   final res = await http.Response.fromStream(response);
  //   print(res.body);
  //   // return response.body;

  //   return ImageUploadDataModel.fromJson(jsonDecode(res.body));
  // }

  // Future<RegisteredDataModel?> updateProfile(
  //     Map<String, String> data, File imageFile) async {
  //   var url = Uri.parse(
  //       'https://colormoon.in/john_vali/edgrow/api/executive/profile-update');

  //   http.MultipartRequest request = http.MultipartRequest("POST", url);

  //   request.fields.addAll(data);
  //   if (imageFile.path != '') {
  //     request.files.add(http.MultipartFile.fromBytes(
  //         "profile_picture", imageFile.readAsBytesSync(),
  //         filename: 'FIle.jpeg', contentType: MediaType("image", "jpg")));
  //   }

  //   request.headers.addAll(<String, String>{
  //     "content-type": "multipart/form-data",
  //     'Authorization':
  //         'Bearer ${Preference.shared.getString(Preference.accessToken)}'
  //   });

  //   http.StreamedResponse response = await request.send();
  //   final res = await http.Response.fromStream(response);
  //   print(res);
  //   // return response.body;

  //   return RegisteredDataModel.fromJson(jsonDecode(res.body));
  // }

  // Future<RegisteredDataModel?> ceateInsituteDataSend(Map<String, String> data,
  //     File imageFile, registrationImage, addressProf) async {
  //   var url = Uri.parse(
  //       'https://colormoon.in/john_vali/edgrow/api/executive/create-institute');

  //   http.MultipartRequest request = http.MultipartRequest("POST", url);

  //   request.fields.addAll(data);
  //   if (imageFile.path != '') {
  //     request.files.add(http.MultipartFile.fromBytes(
  //         "institute_logo", imageFile.readAsBytesSync(),
  //         filename: 'FIle.jpeg', contentType: MediaType("image", "jpg")));
  //   }
  //   if (registrationImage.path != '') {
  //     request.files.add(http.MultipartFile.fromBytes(
  //         "institute_registration_file", registrationImage.readAsBytesSync(),
  //         filename: 'FIle.jpeg', contentType: MediaType("image", "jpg")));
  //   }
  //   if (addressProf.path != '') {
  //     request.files.add(http.MultipartFile.fromBytes(
  //         "institute_address_proof", addressProf.readAsBytesSync(),
  //         filename: 'FIle.jpeg', contentType: MediaType("image", "jpg")));
  //   }

  //   request.headers.addAll(<String, String>{
  //     "content-type": "multipart/form-data",
  //     'Authorization':
  //         'Bearer ${Preference.shared.getString(Preference.accessToken)}'
  //   });

  //   http.StreamedResponse response = await request.send();
  //   final res = await http.Response.fromStream(response);
  //   print(res);
  //   // return response.body;

  //   return RegisteredDataModel.fromJson(jsonDecode(res.body));
  // }

  // Future<RegisteredDataModel?> ceateInsituteDataSetp1Send(
  //   Map<String, String> data,
  // ) async {
  //   var url = Uri.parse(
  //       'https://colormoon.in/john_vali/edgrow/api/executive/create-institute-step1');

  //   http.MultipartRequest request = http.MultipartRequest("POST", url);

  //   request.fields.addAll(data);

  //   request.headers.addAll(<String, String>{
  //     'Authorization':
  //         'Bearer ${Preference.shared.getString(Preference.accessToken)}'
  //   });

  //   http.StreamedResponse response = await request.send();
  //   final res = await http.Response.fromStream(response);
  //   print(res);
  //   // return response.body;

  //   return RegisteredDataModel.fromJson(jsonDecode(res.body));
  // }

  // Future<RegisteredInstituiesDataModel?> getRegisteredInstituies(
  //     Map<String, String> data) async {
  //   try {
  //     var response = await api.sendRequest.post(ApiConstants.registerInstitues,
  //         data: data,
  //         options: Options(headers: {
  //           'Authorization':
  //               'Bearer ${Preference.shared.getString(Preference.accessToken)}'
  //         }));
  //     if (response.statusCode == 200) {
  //       if (response.data['status'] == 'valid') {
  //         return RegisteredInstituiesDataModel.fromJson(response.data);
  //       } else {
  //         Utils.showToast(Get.context!, response.data['message']);
  //       }
  //     }
  //   } catch (ex) {
  //     return null;
  //   }

  //   return null;
  // }

  // Future<RegistrationDataModel?> sendRegistrationData(
  //     Map<String, String> data) async {
  //   try {
  //     var response =
  //         await api.sendRequest.post(ApiConstants.register, data: data);
  //     if (response.statusCode == 200) {
  //       final body = jsonDecode(response.data);
  //       if (body['status'] == 1) {
  //         return RegistrationDataModel.fromJson(body);
  //       } else {
  //         Utils.showToast(Get.context!, body['message']);
  //       }
  //     }
  //   } catch (ex) {
  //     return null;
  //   }
  //   return null;
  // }

  Future<AnnouncementsEntity?> getAnnouncements(Map<String, String> data) async {
    try {
      var response = await api.sendRequest.post(ApiConstants.viewAnnouncements, data: data

          //  options: Options(contentType: 'multipart/form-data'),
          );
      //final body = jsonDecode(response.data);

      if (response.statusCode == 200) {
        if (response.data['success'] == true) {
          return AnnouncementsEntity.fromJson(response.data);
        } else {
          Fluttertoast.showToast(msg: response.data['message']);

          return AnnouncementsEntity.fromJson(response.data);
        }
      }
    } catch (ex) {
      rethrow;
    }
    return null;
  }

  Future<PaymentDetailsEntity?> getPaymentDetails(Map<String, String> data) async {
    try {
      var response = await api.sendRequest.post(ApiConstants.studentpaymentdetails, data: data

          //  options: Options(contentType: 'multipart/form-data'),
          );
      //final body = jsonDecode(response.data);

      if (response.statusCode == 200) {
        if (response.data['success'] == true) {
          return PaymentDetailsEntity.fromJson(response.data);
        } else {
          Fluttertoast.showToast(msg: response.data['message']);

          return PaymentDetailsEntity.fromJson(response.data);
        }
      }
    } catch (ex) {
      rethrow;
    }
    return null;
  }
}
