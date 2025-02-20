import 'dart:convert';

class UserProfile {
  bool? success;
  String? message;
  UserData? data;

  UserProfile({this.success, this.message, this.data});

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        success: json["success"],
        message: json["message"],
        data: json["data"] != null ? UserData.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class UserData {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? address;
  String? qualification;
  DateTime? dateOfBirth;
  String? gender;
  String? profileImage;
  String? resume;

  UserData({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.address,
    this.qualification,
    this.dateOfBirth,
    this.gender,
    this.profileImage,
    this.resume,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        address: json["address"],
        qualification: json["qualification"],
        dateOfBirth: json["date_of_birth"] != null
            ? DateTime.parse(json["date_of_birth"])
            : null,
        gender: json["gender"],
        profileImage: json["profile_image"],
        resume: json["resume"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "address": address,
        "qualification": qualification,
        "date_of_birth": dateOfBirth?.toIso8601String(),
        "gender": gender,
        "profile_image": profileImage,
        "resume": resume,
      };
}
