class NotificationListDataModel {
  bool? success;
  String? message;
  Data? data;

  NotificationListDataModel({this.success, this.message, this.data});

  NotificationListDataModel.fromJson(Map<String, dynamic> json) {
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
  List<UserNotification>? userNotification;

  Data({this.userNotification});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['user_notification'] != null) {
      userNotification = <UserNotification>[];
      json['user_notification'].forEach((v) {
        userNotification!.add(new UserNotification.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userNotification != null) {
      data['user_notification'] = this.userNotification!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserNotification {
  int? id;
  int? userId;
  String? notificationType;
  String? childIdType;
  int? intructorId;
  int? courseId;
  int? studyPlanItemsId;
  int? examId;
  String? examType;
  int? assignmentId;
  String? message;
  int? isSeen;

  UserNotification(
      {this.id,
      this.userId,
      this.notificationType,
      this.childIdType,
      this.intructorId,
      this.courseId,
      this.studyPlanItemsId,
      this.examId,
      this.examType,
      this.assignmentId,
      this.message,
      this.isSeen});

  UserNotification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    notificationType = json['notification_type'];
    childIdType = json['child_id_type'];
    intructorId = json['intructor_id'];
    courseId = json['course_id'];
    studyPlanItemsId = json['study_plan_items_id'];
    examId = json['exam_id'];
    examType = json['exam_type'];
    assignmentId = json['assignment_id'];
    message = json['message'];
    isSeen = json['is_seen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['notification_type'] = this.notificationType;
    data['child_id_type'] = this.childIdType;
    data['intructor_id'] = this.intructorId;
    data['course_id'] = this.courseId;
    data['study_plan_items_id'] = this.studyPlanItemsId;
    data['exam_id'] = this.examId;
    data['exam_type'] = this.examType;
    data['assignment_id'] = this.assignmentId;
    data['message'] = this.message;
    data['is_seen'] = this.isSeen;
    return data;
  }
}
