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
  String? jobLocation;
  String? jobSalaryMin;
  String? jobSalaryMax;
  String? companyName;
  String? workType;
  String? jobType;
  String? experience;
  String? responsibilities;
  String? requirements;
  String? skills;
  String? preferrredQualifications;
  String? applicationDeadline;
  String? jobBenefits;
  String? companyWebsite;
  String? companyLogo;
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
    this.jobLocation,
    this.jobSalaryMin,
    this.jobSalaryMax,
    this.companyName,
    this.workType,
    this.jobType,
    this.experience,
    this.responsibilities,
    this.requirements,
    this.skills,
    this.preferrredQualifications,
    this.applicationDeadline,
    this.jobBenefits,
    this.companyWebsite,
    this.companyLogo,
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
        jobLocation: json["job_location"],
        jobSalaryMin: json["job_salary_min"],
        jobSalaryMax: json["job_salary_max"],
        companyName: json["company_name"],
        workType: json["work_type"],
        jobType: json["job_type"],
        experience: json["experience"],
        responsibilities: json["responsibilities"],
        requirements: json["requirements"],
        skills: json["skills"],
        preferrredQualifications: json["preferrred_qualifications"],
        applicationDeadline: json["application_deadline"],
        jobBenefits: json["job_benefits"],
        companyWebsite: json["company_website"],
        companyLogo: json["company_logo"],
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
        "job_location": jobLocation,
        "job_salary_min": jobSalaryMin,
        "job_salary_max": jobSalaryMax,
        "company_name": companyName,
        "work_type": workType,
        "job_type": jobType,
        "experience": experience,
        "responsibilities": responsibilities,
        "requirements": requirements,
        "skills": skills,
        "preferrred_qualifications": preferrredQualifications,
        "application_deadline": applicationDeadline,
        "job_benefits": jobBenefits,
        "company_website": companyWebsite,
        "company_logo": companyLogo,
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
