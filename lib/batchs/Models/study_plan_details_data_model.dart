class StudyPlanViewDataModel {
  bool? success;
  String? message;
  Data? data;

  StudyPlanViewDataModel({this.success, this.message, this.data});

  StudyPlanViewDataModel.fromJson(Map<String, dynamic> json) {
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
  List<StudyPlans>? studyPlans;

  Data({this.studyPlans});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['study_plans'] != null) {
      studyPlans = <StudyPlans>[];
      json['study_plans'].forEach((v) {
        studyPlans!.add(new StudyPlans.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.studyPlans != null) {
      data['study_plans'] = this.studyPlans!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StudyPlans {
  int? pkIntStudyPlansId;
  int? courseId;
  int? batchId;
  String? studyPlansDate;
  List<Items>? items;

  StudyPlans({this.pkIntStudyPlansId, this.courseId, this.batchId, this.studyPlansDate, this.items});

  StudyPlans.fromJson(Map<String, dynamic> json) {
    pkIntStudyPlansId = json['pk_int_study_plans_id'];
    courseId = json['course_id'];
    batchId = json['batch_id'];
    studyPlansDate = json['study_plans_date'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pk_int_study_plans_id'] = this.pkIntStudyPlansId;
    data['course_id'] = this.courseId;
    data['batch_id'] = this.batchId;
    data['study_plans_date'] = this.studyPlansDate;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int? pkIntStudyPlanItemsId;
  int? fkIntStudyPlansId;
  int? batchId;
  String? title;
  String? type;
  int? chapterId;
  int? assigmentId;
  int? examId;
  String? dvYoutubeLink;
  String? dvVideoFile;
  String? createdAt;
  String? updatedAt;
  int? pkIntStudyPlanUsersId;
  int? fkIntStudyPlanItemsId;
  int? userId;
  String? progressStatus;
  int? percentage;
  int? isVerified;

  Items(
      {this.pkIntStudyPlanItemsId,
      this.fkIntStudyPlansId,
      this.batchId,
      this.title,
      this.type,
      this.chapterId,
      this.assigmentId,
      this.examId,
      this.dvYoutubeLink,
      this.dvVideoFile,
      this.createdAt,
      this.updatedAt,
      this.pkIntStudyPlanUsersId,
      this.fkIntStudyPlanItemsId,
      this.userId,
      this.progressStatus,
      this.percentage,
      this.isVerified});

  Items.fromJson(Map<String, dynamic> json) {
    pkIntStudyPlanItemsId = json['pk_int_study_plan_items_id'];
    fkIntStudyPlansId = json['fk_int_study_plans_id'];
    batchId = json['batch_id'];
    title = json['title'];
    type = json['type'];
    chapterId = json['chapter_id'];
    assigmentId = json['assigment_id'];
    examId = json['exam_id'];
    dvYoutubeLink = json['dv_youtube_link'];
    dvVideoFile = json['dv_video_file'];

    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pkIntStudyPlanUsersId = json['pk_int_study_plan_users_id'];
    fkIntStudyPlanItemsId = json['fk_int_study_plan_items_id'];
    userId = json['user_id'];
    progressStatus = json['progress_status'];
    percentage = json['percentage'];
    isVerified = json['is_verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pk_int_study_plan_items_id'] = this.pkIntStudyPlanItemsId;
    data['fk_int_study_plans_id'] = this.fkIntStudyPlansId;
    data['batch_id'] = this.batchId;
    data['title'] = this.title;
    data['type'] = this.type;
    data['chapter_id'] = this.chapterId;
    data['assigment_id'] = this.assigmentId;
    data['exam_id'] = this.examId;
    data['dv_youtube_link'] = this.dvYoutubeLink;
    data['dv_video_file'] = this.dvVideoFile;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['pk_int_study_plan_users_id'] = this.pkIntStudyPlanUsersId;
    data['fk_int_study_plan_items_id'] = this.fkIntStudyPlanItemsId;
    data['user_id'] = this.userId;
    data['progress_status'] = this.progressStatus;
    data['percentage'] = this.percentage;
    data['is_verified'] = this.isVerified;
    return data;
  }
}
