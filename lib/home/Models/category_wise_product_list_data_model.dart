class CategoryWiseCourseListDataModel {
  bool? success;
  String? message;
  Data? data;

  CategoryWiseCourseListDataModel({this.success, this.message, this.data});

  CategoryWiseCourseListDataModel.fromJson(Map<String, dynamic> json) {
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
  List<Courses>? courses;

  Data({this.courses});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['courses'] != null) {
      courses = <Courses>[];
      json['courses'].forEach((v) {
        courses!.add(new Courses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.courses != null) {
      data['courses'] = this.courses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Courses {
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

  Courses(
      {this.id,
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
      this.discountedPrice});

  Courses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseThumbnail = json['course_thumbnail'];
    thumbnail = json['thumbnail'];
    title = json['title'];
    totalLessons = json['total_lessons'];
    totalEnrolls = json['total_enrolls'];
    isFree = json['is_free'];
    totalRating = json['total_rating'];
    price = json['price'];
    isDiscounted = json['is_discounted'];
    discountType = json['discount_type'];
    discountedPrice = json['discounted_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_thumbnail'] = this.courseThumbnail;
    data['thumbnail'] = this.thumbnail;
    data['title'] = this.title;
    data['total_lessons'] = this.totalLessons;
    data['total_enrolls'] = this.totalEnrolls;
    data['is_free'] = this.isFree;
    data['total_rating'] = this.totalRating;
    data['price'] = this.price;
    data['is_discounted'] = this.isDiscounted;
    data['discount_type'] = this.discountType;
    data['discounted_price'] = this.discountedPrice;
    return data;
  }
}
