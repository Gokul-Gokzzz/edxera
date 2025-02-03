class StudyPlanAssigmentDataModel {
  bool? success;
  String? message;
  Data? data;

  StudyPlanAssigmentDataModel({this.success, this.message, this.data});

  StudyPlanAssigmentDataModel.fromJson(Map<String, dynamic> json) {
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
  Assignment? assignment;
  UserSubmitedAssignment? userSubmitedAssignment;

  Data({this.assignment, this.userSubmitedAssignment});

  Data.fromJson(Map<String, dynamic> json) {
    assignment = json['Assignment'] != null ? new Assignment.fromJson(json['Assignment']) : null;
    if (json['user_submited_assignment'] != 'Not answered') {
      userSubmitedAssignment =
          json['user_submited_assignment'] != null ? new UserSubmitedAssignment.fromJson(json['user_submited_assignment']) : null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.assignment != null) {
      data['Assignment'] = this.assignment!.toJson();
    }
    if (this.userSubmitedAssignment != null) {
      data['user_submited_assignment'] = this.userSubmitedAssignment!.toJson();
    }
    return data;
  }
}

class Assignment {
  int? id;
  int? batchId;
  String? title;
  String? description;
  String? file;
  String? deadline;
  int? totalMarks;
  int? passMarks;
  int? status;
  String? createdAt;
  String? updatedAt;

  Assignment(
      {this.id,
      this.batchId,
      this.title,
      this.description,
      this.file,
      this.deadline,
      this.totalMarks,
      this.passMarks,
      this.status,
      this.createdAt,
      this.updatedAt});

  Assignment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    batchId = json['batch_id'];
    title = json['title'];
    description = json['description'];
    file = json['file'];
    deadline = json['deadline'];
    totalMarks = json['total_marks'];
    passMarks = json['pass_marks'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['batch_id'] = this.batchId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['file'] = this.file;
    data['deadline'] = this.deadline;
    data['total_marks'] = this.totalMarks;
    data['pass_marks'] = this.passMarks;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class UserSubmitedAssignment {
  String? heading;
  String? description;
  String? file;

  UserSubmitedAssignment({this.heading, this.description, this.file});

  UserSubmitedAssignment.fromJson(Map<String, dynamic> json) {
    heading = json['heading'];
    description = json['description'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['heading'] = this.heading;
    data['description'] = this.description;
    data['file'] = this.file;
    return data;
  }
}

class StudyPlanAssigmentSubmitDataModel {
  bool? success;
  String? message;

  StudyPlanAssigmentSubmitDataModel({
    this.success,
    this.message,
  });

  StudyPlanAssigmentSubmitDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;

    return data;
  }
}
