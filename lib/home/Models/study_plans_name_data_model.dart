class StudyPlanCourseNameDataModel {
  bool? success;
  String? message;
  Data? data;

  StudyPlanCourseNameDataModel({this.success, this.message, this.data});

  StudyPlanCourseNameDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<UserCourses>? userCourses;

  Data({this.userCourses});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['user_courses'] != null) {
      userCourses = <UserCourses>[];
      json['user_courses'].forEach((v) {
        userCourses!.add(new UserCourses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userCourses != null) {
      data['user_courses'] = this.userCourses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserCourses {
  String? courseTitle;
  String? courseThumbnail;
  int? courseId;
  String? batchName;
  String? batchCode;
  int? batchId;

  UserCourses({this.courseTitle, this.courseThumbnail, this.courseId, this.batchName, this.batchCode, this.batchId});

  UserCourses.fromJson(Map<String, dynamic> json) {
    courseTitle = json['course_title'];
    courseThumbnail = json['course_thumbnail'];
    courseId = json['course_id'];
    batchName = json['batch_name'];
    batchCode = json['batch_code'];
    batchId = json['batch_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_title'] = this.courseTitle;
    data['course_thumbnail'] = this.courseThumbnail;
    data['course_id'] = this.courseId;
    data['batch_name'] = this.batchName;
    data['batch_code'] = this.batchCode;
    data['batch_id'] = this.batchId;
    return data;
  }
}
