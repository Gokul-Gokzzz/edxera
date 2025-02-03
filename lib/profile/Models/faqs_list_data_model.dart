class FaaqsListDataModel {
  bool? success;
  String? message;
  Data? data;

  FaaqsListDataModel({this.success, this.message, this.data});

  FaaqsListDataModel.fromJson(Map<String, dynamic> json) {
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
  List<Faqs>? faqs;

  Data({this.faqs});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['faqs'] != null) {
      faqs = <Faqs>[];
      json['faqs'].forEach((v) {
        faqs!.add(new Faqs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.faqs != null) {
      data['faqs'] = this.faqs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Faqs {
  int? id;
  int? courseId;
  String? question;
  String? answer;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? courseTitle;

  Faqs({this.id, this.courseId, this.question, this.answer, this.status, this.createdAt, this.updatedAt, this.courseTitle});

  Faqs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['course_id'];
    question = json['question'];
    answer = json['answer'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    courseTitle = json['course_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_id'] = this.courseId;
    data['question'] = this.question;
    data['answer'] = this.answer;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['course_title'] = this.courseTitle;
    return data;
  }
}
