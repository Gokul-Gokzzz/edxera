class ExamResultCheckDataModel {
  bool? success;
  String? message;
  Data? data;

  ExamResultCheckDataModel({this.success, this.message, this.data});

  ExamResultCheckDataModel.fromJson(Map<String, dynamic> json) {
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
  int? totalQuestions;
  int? totalQuestionsAnswered;
  int? totalCorrectAnswers;
  String? totalMarksOfExam;
  String? passMarks;
  int? totalMarksGiven;
  int? totalPercentage;
  String? examResult;
  String? examStatus;

  Data(
      {this.totalQuestions,
      this.totalQuestionsAnswered,
      this.totalCorrectAnswers,
      this.totalMarksOfExam,
      this.passMarks,
      this.totalMarksGiven,
      this.totalPercentage,
      this.examResult,
      this.examStatus});

  Data.fromJson(Map<String, dynamic> json) {
    totalQuestions = json['total_questions'];
    totalQuestionsAnswered = json['total_questions_answered'];
    totalCorrectAnswers = json['total_correct_answers'];
    totalMarksOfExam = json['total_marks_of_exam'];
    passMarks = json['pass_marks'];
    totalMarksGiven = json['total_marks_given'];
    totalPercentage = json['total_percentage'];
    examResult = json['exam_result'];
    examStatus = json['exam_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_questions'] = this.totalQuestions;
    data['total_questions_answered'] = this.totalQuestionsAnswered;
    data['total_correct_answers'] = this.totalCorrectAnswers;
    data['total_marks_of_exam'] = this.totalMarksOfExam;
    data['pass_marks'] = this.passMarks;
    data['total_marks_given'] = this.totalMarksGiven;
    data['total_percentage'] = this.totalPercentage;
    data['exam_result'] = this.examResult;
    data['exam_status'] = this.examStatus;
    return data;
  }
}
