class BatchTestListDataModel {
  bool? success;
  String? message;
  Data? data;

  BatchTestListDataModel({this.success, this.message, this.data});

  BatchTestListDataModel.fromJson(Map<String, dynamic> json) {
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
  int? testCount;
  List<TestListForUser>? testListForUser;

  Data({this.testCount, this.testListForUser});

  Data.fromJson(Map<String, dynamic> json) {
    testCount = json['test_count'];
    if (json['test_list_for_user'] != null) {
      testListForUser = <TestListForUser>[];
      json['test_list_for_user'].forEach((v) {
        testListForUser!.add(new TestListForUser.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['test_count'] = this.testCount;
    if (this.testListForUser != null) {
      data['test_list_for_user'] = this.testListForUser!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TestListForUser {
  int? pkIntStudyPlanItemsId;
  int? fkIntStudyPlansId;
  int? batchId;
  String? title;
  String? type;
  int? chapterId;
  int? assigmentId;
  int? examId;
  int? pkIntStudyPlanUsersId;
  int? fkIntStudyPlanItemsId;
  int? userId;
  String? progressStatus;
  int? percentage;
  int? isVerified;

  TestListForUser(
      {this.pkIntStudyPlanItemsId,
      this.fkIntStudyPlansId,
      this.batchId,
      this.title,
      this.type,
      this.chapterId,
      this.assigmentId,
      this.examId,
      this.pkIntStudyPlanUsersId,
      this.fkIntStudyPlanItemsId,
      this.userId,
      this.progressStatus,
      this.percentage,
      this.isVerified});

  TestListForUser.fromJson(Map<String, dynamic> json) {
    pkIntStudyPlanItemsId = json['pk_int_study_plan_items_id'];
    fkIntStudyPlansId = json['fk_int_study_plans_id'];
    batchId = json['batch_id'];
    title = json['title'];
    type = json['type'];
    chapterId = json['chapter_id'];
    assigmentId = json['assigment_id'];
    examId = json['exam_id'];
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
    data['pk_int_study_plan_users_id'] = this.pkIntStudyPlanUsersId;
    data['fk_int_study_plan_items_id'] = this.fkIntStudyPlanItemsId;
    data['user_id'] = this.userId;
    data['progress_status'] = this.progressStatus;
    data['percentage'] = this.percentage;
    data['is_verified'] = this.isVerified;
    return data;
  }
}
