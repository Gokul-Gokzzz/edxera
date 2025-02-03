class BatchAssigmentListDataModel {
  bool? success;
  String? message;
  BatchAssigmentListData? data;

  BatchAssigmentListDataModel({this.success, this.message, this.data});

  BatchAssigmentListDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new BatchAssigmentListData.fromJson(json['data']) : null;
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

class BatchAssigmentListData {
  int? assignmentCount;
  List<AssignmentListForUser>? assignmentListForUser;

  BatchAssigmentListData({this.assignmentCount, this.assignmentListForUser});

  BatchAssigmentListData.fromJson(Map<String, dynamic> json) {
    assignmentCount = json['assignment_count'];
    if (json['assignment_list_for_user'] != null) {
      assignmentListForUser = <AssignmentListForUser>[];
      json['assignment_list_for_user'].forEach((v) {
        assignmentListForUser!.add(new AssignmentListForUser.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['assignment_count'] = this.assignmentCount;
    if (this.assignmentListForUser != null) {
      data['assignment_list_for_user'] = this.assignmentListForUser!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AssignmentListForUser {
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
  String? assignmentDeadline;
  String? assignmentDescription;

  AssignmentListForUser(
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
      this.isVerified,
      this.assignmentDeadline,
      this.assignmentDescription});

  AssignmentListForUser.fromJson(Map<String, dynamic> json) {
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
    assignmentDeadline = json['assignment_deadline'];
    assignmentDescription = json['assignment_description'];
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
    data['assignment_deadline'] = this.assignmentDeadline;
    data['assignment_description'] = this.assignmentDescription;
    return data;
  }
}
