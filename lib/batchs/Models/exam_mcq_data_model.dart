class ExamMcqDataModel {
  bool? success;
  String? message;
  Data? data;

  ExamMcqDataModel({this.success, this.message, this.data});

  ExamMcqDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];

    data = json['data'] == []
        ? null
        : json['data'] != null
            ? new Data.fromJson(json['data'])
            : null;
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
  String? examHeading;
  String? examDate;
  Question? question;
  UserSubmitedOption? userSubmitedOption;
  UserSubmitedAnswer? userSubmitedAnswer;

  int? totalQuestionCount;

  Data(
      {this.examHeading,
      this.examDate,
      this.question,
      this.userSubmitedAnswer,
      this.userSubmitedOption,
      this.totalQuestionCount});

  Data.fromJson(Map<String, dynamic> json) {
    examHeading = json['Exam_heading'];
    examDate = json['Exam_date'];
    question = json['Question'] != null
        ? new Question.fromJson(json['Question'])
        : null;
    if (json['user_submited_option'] != 'Not answered') {
      userSubmitedOption = json['user_submited_option'] != null
          ? new UserSubmitedOption.fromJson(json['user_submited_option'])
          : null;
    }
    if (json['user_submited_answer'] != 'Not answered') {
      userSubmitedAnswer = json['user_submited_answer'] != null
          ? new UserSubmitedAnswer.fromJson(json['user_submited_answer'])
          : null;
    }

    totalQuestionCount = json['total_question_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Exam_heading'] = this.examHeading;
    data['Exam_date'] = this.examDate;
    if (this.question != null) {
      data['Question'] = this.question!.toJson();
    }
    if (this.userSubmitedOption != null) {
      data['user_submited_option'] = this.userSubmitedOption!.toJson();
    }
    if (this.userSubmitedAnswer != null) {
      data['user_submited_answer'] = this.userSubmitedAnswer!.toJson();
    }
    data['total_question_count'] = this.totalQuestionCount;
    return data;
  }
}

class UserSubmitedAnswer {
  String? answerDescription;

  UserSubmitedAnswer({this.answerDescription});

  UserSubmitedAnswer.fromJson(Map<String, dynamic> json) {
    answerDescription = json['answer_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['answer_description'] = this.answerDescription;
    return data;
  }
}

class Question {
  int? id;
  String? textQuestion;
  String? optionA;
  String? optionB;
  String? optionC;
  String? optionD;

  Question(
      {this.id,
      this.textQuestion,
      this.optionA,
      this.optionB,
      this.optionC,
      this.optionD});

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    textQuestion = json['text_question'];
    optionA = json['option_a'];
    optionB = json['option_b'];
    optionC = json['option_c'];
    optionD = json['option_d'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text_question'] = this.textQuestion;
    data['option_a'] = this.optionA;
    data['option_b'] = this.optionB;
    data['option_c'] = this.optionC;
    data['option_d'] = this.optionD;
    return data;
  }
}

class UserSubmitedOption {
  String? answerOption;

  UserSubmitedOption({this.answerOption});

  UserSubmitedOption.fromJson(Map<String, dynamic> json) {
    answerOption = json['answer_option'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['answer_option'] = this.answerOption;
    return data;
  }
}

class SubmitMcqDataModel {
  bool? success;
  String? message;

  SubmitMcqDataModel({
    this.success,
    this.message,
  });

  SubmitMcqDataModel.fromJson(Map<String, dynamic> json) {
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
