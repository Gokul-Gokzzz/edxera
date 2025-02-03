class AssigmentResultDataModel {
  bool? success;
  String? message;
  Data? data;

  AssigmentResultDataModel({this.success, this.message, this.data});

  AssigmentResultDataModel.fromJson(Map<String, dynamic> json) {
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
  int? totalMarksOfAssignment;
  int? passMarks;
  String? marksGiven;
  String? assignmentResult;
  String? assignmentStatus;

  Data({this.totalMarksOfAssignment, this.passMarks, this.marksGiven, this.assignmentResult, this.assignmentStatus});

  Data.fromJson(Map<String, dynamic> json) {
    totalMarksOfAssignment = json['total_marks_of_assignment'];
    passMarks = json['pass_marks'];
    marksGiven = json['marks_given'];
    assignmentResult = json['assignment_result'];
    assignmentStatus = json['assignment_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_marks_of_assignment'] = this.totalMarksOfAssignment;
    data['pass_marks'] = this.passMarks;
    data['marks_given'] = this.marksGiven;
    data['assignment_result'] = this.assignmentResult;
    data['assignment_status'] = this.assignmentStatus;
    return data;
  }
}
