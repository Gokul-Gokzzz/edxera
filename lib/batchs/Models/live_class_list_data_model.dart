class LiveClassListDataModel {
  bool? success;
  String? message;
  LiveClassListData? data;

  LiveClassListDataModel({this.success, this.message, this.data});

  LiveClassListDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new LiveClassListData.fromJson(json['data']) : null;
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

class LiveClassListData {
  List<LiveClass>? liveClass;

  LiveClassListData({this.liveClass});

  LiveClassListData.fromJson(Map<String, dynamic> json) {
    if (json['live_class'] != null) {
      liveClass = <LiveClass>[];
      json['live_class'].forEach((v) {
        liveClass!.add(new LiveClass.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.liveClass != null) {
      data['live_class'] = this.liveClass!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LiveClass {
  int? id;
  int? userId;
  int? courseId;
  int? batchId;
  String? title;
  String? slug;
  String? classDate;
  String? meetingMethod;
  String? description;
  String? endAt;
  String? startAt;
  String? recordedvideolink;
  int? isFree;
  String? meetingLink;
  String? meetingId;
  String? meetingPassword;
  int? status;
  String? createdAt;
  String? updatedAt;

  LiveClass(
      {this.id,
      this.userId,
      this.courseId,
      this.batchId,
      this.title,
      this.slug,
      this.classDate,
      this.meetingMethod,
      this.description,
      this.endAt,
      this.recordedvideolink,
      this.startAt,
      this.isFree,
      this.meetingLink,
      this.meetingId,
      this.meetingPassword,
      this.status,
      this.createdAt,
      this.updatedAt});

  LiveClass.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    courseId = json['course_id'];
    batchId = json['batch_id'];
    title = json['title'];
    slug = json['slug'];
    classDate = json['class_date'];
    meetingMethod = json['meeting_method'];
    description = json['description'];
    endAt = json['end_at'];
    startAt = json['start_at'];
    recordedvideolink = json['recorded_video_link'];
    isFree = json['is_free'];
    meetingLink = json['meeting_link'];
    meetingId = json['meeting_id'];
    meetingPassword = json['meeting_password'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['course_id'] = this.courseId;
    data['batch_id'] = this.batchId;
    data['title'] = this.title;
    data['recorded_video_link'] = this.recordedvideolink;
    data['slug'] = this.slug;
    data['class_date'] = this.classDate;
    data['meeting_method'] = this.meetingMethod;
    data['description'] = this.description;
    data['end_at'] = this.endAt;
    data['start_at'] = this.startAt;
    data['is_free'] = this.isFree;
    data['meeting_link'] = this.meetingLink;
    data['meeting_id'] = this.meetingId;
    data['meeting_password'] = this.meetingPassword;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
