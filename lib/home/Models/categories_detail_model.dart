import 'dart:convert';

class CategoriesDetailModel {
  bool? success;
  String? message;
  Data? data;

  CategoriesDetailModel({
    this.success,
    this.message,
    this.data,
  });

  CategoriesDetailModel copyWith({
    bool? success,
    String? message,
    Data? data,
  }) =>
      CategoriesDetailModel(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory CategoriesDetailModel.fromJson(String str) => CategoriesDetailModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoriesDetailModel.fromMap(Map<String, dynamic> json) => CategoriesDetailModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data": data?.toMap(),
      };
}

class Data {
  List<Course>? courses;

  Data({
    this.courses,
  });

  Data copyWith({
    List<Course>? courses,
  }) =>
      Data(
        courses: courses ?? this.courses,
      );

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        courses: json["courses"] == null ? [] : List<Course>.from(json["courses"]!.map((x) => Course.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "courses": courses == null ? [] : List<dynamic>.from(courses!.map((x) => x.toMap())),
      };
}

class Course {
  int? id;
  String? courseThumbnail;
  String? thumbnail;
  String? title;
  int? totalLessons;
  int? totalEnrolls;
  bool? isFree;
  String? totalRating;
  String? price;
  bool? isDiscounted;
  String? discountType;
  String? discountedPrice;

  Course({
    this.id,
    this.courseThumbnail,
    this.thumbnail,
    this.title,
    this.totalLessons,
    this.totalEnrolls,
    this.isFree,
    this.totalRating,
    this.price,
    this.isDiscounted,
    this.discountType,
    this.discountedPrice,
  });

  Course copyWith({
    int? id,
    String? courseThumbnail,
    String? thumbnail,
    String? title,
    int? totalLessons,
    int? totalEnrolls,
    bool? isFree,
    String? totalRating,
    String? price,
    bool? isDiscounted,
    String? discountType,
    String? discountedPrice,
  }) =>
      Course(
        id: id ?? this.id,
        courseThumbnail: courseThumbnail ?? this.courseThumbnail,
        thumbnail: thumbnail ?? this.thumbnail,
        title: title ?? this.title,
        totalLessons: totalLessons ?? this.totalLessons,
        totalEnrolls: totalEnrolls ?? this.totalEnrolls,
        isFree: isFree ?? this.isFree,
        totalRating: totalRating ?? this.totalRating,
        price: price ?? this.price,
        isDiscounted: isDiscounted ?? this.isDiscounted,
        discountType: discountType ?? this.discountType,
        discountedPrice: discountedPrice ?? this.discountedPrice,
      );

  factory Course.fromJson(String str) => Course.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Course.fromMap(Map<String, dynamic> json) => Course(
        id: json["id"],
        courseThumbnail: json["course_thumbnail"],
        thumbnail: json["thumbnail"],
        title: json["title"],
        totalLessons: json["total_lessons"],
        totalEnrolls: json["total_enrolls"],
        isFree: json["is_free"],
        totalRating: json["total_rating"],
        price: json["price"],
        isDiscounted: json["is_discounted"],
        discountType: json["discount_type"],
        discountedPrice: json["discounted_price"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "course_thumbnail": courseThumbnail,
        "thumbnail": thumbnail,
        "title": title,
        "total_lessons": totalLessons,
        "total_enrolls": totalEnrolls,
        "is_free": isFree,
        "total_rating": totalRating,
        "price": price,
        "is_discounted": isDiscounted,
        "discount_type": discountType,
        "discounted_price": discountedPrice,
      };
}
