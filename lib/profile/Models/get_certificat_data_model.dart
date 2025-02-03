class GetCourseCertificateDataModel {
  bool? success;
  String? message;
  Data? data;

  GetCourseCertificateDataModel({this.success, this.message, this.data});

  GetCourseCertificateDataModel.fromJson(Map<String, dynamic> json) {
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
  List<CourseCertificate>? courseCertificate;

  Data({this.courseCertificate});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['course_certificate'] != null) {
      courseCertificate = <CourseCertificate>[];
      json['course_certificate'].forEach((v) {
        courseCertificate!.add(new CourseCertificate.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.courseCertificate != null) {
      data['course_certificate'] = this.courseCertificate!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CourseCertificate {
  int? id;
  int? courseId;
  int? userId;
  String? certificateFile;
  String? issuedDate;
  String? courseCompletedDate;
  Null? createdAt;
  Null? updatedAt;

  CourseCertificate(
      {this.id, this.courseId, this.userId, this.certificateFile, this.issuedDate, this.courseCompletedDate, this.createdAt, this.updatedAt});

  CourseCertificate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['course_id'];
    userId = json['user_id'];
    certificateFile = json['certificate_file'];
    issuedDate = json['issued_date'];
    courseCompletedDate = json['course_completed_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_id'] = this.courseId;
    data['user_id'] = this.userId;
    data['certificate_file'] = this.certificateFile;
    data['issued_date'] = this.issuedDate;
    data['course_completed_date'] = this.courseCompletedDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
