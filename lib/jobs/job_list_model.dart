// To parse this JSON data, do
//
//     final jobListModel = jobListModelFromJson(jsonString);

import 'dart:convert';

JobListModel jobListModelFromJson(String str) =>
    JobListModel.fromJson(json.decode(str));

String jobListModelToJson(JobListModel data) => json.encode(data.toJson());

class JobListModel {
  bool? success;
  String? message;
  List<Datum>? data;

  JobListModel({
    this.success,
    this.message,
    this.data,
  });

  factory JobListModel.fromJson(Map<String, dynamic> json) => JobListModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? id;
  int? userId;
  int? jobCategoryId;
  String? title;
  String? shortDescription;
  String? description;
  String? contactWhatsappNumber;
  String? contactEmail;
  String? contactLink;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? deletionAllowedStatus;
  int? applyAalowedStatus;

  Datum({
    this.id,
    this.userId,
    this.jobCategoryId,
    this.title,
    this.shortDescription,
    this.description,
    this.contactWhatsappNumber,
    this.contactEmail,
    this.contactLink,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletionAllowedStatus,
    this.applyAalowedStatus,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        jobCategoryId: json["job_category_id"],
        title: json["title"],
        shortDescription: json["short_description"],
        description: json["description"],
        contactWhatsappNumber: json["contact_whatsapp_number"],
        contactEmail: json["contact_email"],
        contactLink: json["contact_link"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletionAllowedStatus: json["deletion_allowed_status"],
        applyAalowedStatus: json["apply_aalowed_status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "job_category_id": jobCategoryId,
        "title": title,
        "short_description": shortDescription,
        "description": description,
        "contact_whatsapp_number": contactWhatsappNumber,
        "contact_email": contactEmail,
        "contact_link": contactLink,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deletion_allowed_status": deletionAllowedStatus,
        "apply_aalowed_status": applyAalowedStatus,
      };
}
