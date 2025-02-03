class CourseChapterListDataModel {
  bool? success;
  String? message;
  CourseChapterListData? data;

  CourseChapterListDataModel({this.success, this.message, this.data});

  CourseChapterListDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new CourseChapterListData.fromJson(json['data']) : null;
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

class CourseChapterListData {
  int? coursePurchasedStatus;
  List<Chapter>? chapter;

  CourseChapterListData({this.coursePurchasedStatus, this.chapter});

  CourseChapterListData.fromJson(Map<String, dynamic> json) {
    coursePurchasedStatus = json['course_purchased_status'];
    if (json['Chapter'] != null) {
      chapter = <Chapter>[];
      json['Chapter'].forEach((v) {
        chapter!.add(new Chapter.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_purchased_status'] = this.coursePurchasedStatus;
    if (this.chapter != null) {
      data['Chapter'] = this.chapter!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Chapter {
  int? id;
  String? title;
  String? slug;
  int? courseId;
  int? sylabusId;
  int? parentChapterId;
  String? name;
  String? shortDescription;
  String? description;
  String? notes;
  String? image;
  String? video;
  String? pdf;
  int? orderNo;
  int? status;
  String? createdAt;
  String? updatedAt;
  List<Subchapter>? subchapter;

  Chapter(
      {this.id,
      this.title,
      this.slug,
      this.courseId,
      this.sylabusId,
      this.parentChapterId,
      this.name,
      this.shortDescription,
      this.description,
      this.notes,
      this.image,
      this.video,
      this.pdf,
      this.orderNo,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.subchapter});

  Chapter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    courseId = json['course_id'];
    sylabusId = json['sylabus_id'];
    parentChapterId = json['parent_chapter_id'];
    name = json['name'];
    shortDescription = json['short_description'];
    description = json['description'];
    notes = json['notes'];
    image = json['image'];
    video = json['video'];
    pdf = json['pdf'];
    orderNo = json['order_no'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['subchapter'] != null) {
      subchapter = <Subchapter>[];
      json['subchapter'].forEach((v) {
        subchapter!.add(new Subchapter.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['course_id'] = this.courseId;
    data['sylabus_id'] = this.sylabusId;
    data['parent_chapter_id'] = this.parentChapterId;
    data['name'] = this.name;
    data['short_description'] = this.shortDescription;
    data['description'] = this.description;
    data['notes'] = this.notes;
    data['image'] = this.image;
    data['video'] = this.video;
    data['pdf'] = this.pdf;
    data['order_no'] = this.orderNo;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.subchapter != null) {
      data['subchapter'] = this.subchapter!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subchapter {
  int? id;
  String? title;
  String? slug;
  int? courseId;
  int? sylabusId;
  int? parentChapterId;
  String? name;
  String? shortDescription;
  String? description;
  String? notes;
  String? image;
  String? video;
  String? pdf;
  int? orderNo;
  int? status;
  String? createdAt;
  String? updatedAt;

  Subchapter(
      {this.id,
      this.title,
      this.slug,
      this.courseId,
      this.sylabusId,
      this.parentChapterId,
      this.name,
      this.shortDescription,
      this.description,
      this.notes,
      this.image,
      this.video,
      this.pdf,
      this.orderNo,
      this.status,
      this.createdAt,
      this.updatedAt});

  Subchapter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    courseId = json['course_id'];
    sylabusId = json['sylabus_id'];
    parentChapterId = json['parent_chapter_id'];
    name = json['name'];
    shortDescription = json['short_description'];
    description = json['description'];
    notes = json['notes'];
    image = json['image'];
    video = json['video'];
    pdf = json['pdf'];
    orderNo = json['order_no'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['course_id'] = this.courseId;
    data['sylabus_id'] = this.sylabusId;
    data['parent_chapter_id'] = this.parentChapterId;
    data['name'] = this.name;
    data['short_description'] = this.shortDescription;
    data['description'] = this.description;
    data['notes'] = this.notes;
    data['image'] = this.image;
    data['video'] = this.video;
    data['pdf'] = this.pdf;
    data['order_no'] = this.orderNo;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
