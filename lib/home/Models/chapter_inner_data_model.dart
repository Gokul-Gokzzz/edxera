class ChapterInnerDataModel {
  bool? success;
  String? message;
  Data? data;

  ChapterInnerDataModel({this.success, this.message, this.data});

  ChapterInnerDataModel.fromJson(Map<String, dynamic> json) {
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
  Chapter? chapter;

  Data({this.chapter});

  Data.fromJson(Map<String, dynamic> json) {
    chapter = json['Chapter'] != null ? new Chapter.fromJson(json['Chapter']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.chapter != null) {
      data['Chapter'] = this.chapter!.toJson();
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
  String? youTubeLink;
  String? pdf;
  int? orderNo;
  int? status;
  String? createdAt;
  String? updatedAt;

  Chapter({
    this.id,
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
    this.youTubeLink,
    this.pdf,
    this.orderNo,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

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
    youTubeLink = json['you_tube_link'];
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
    data['you_tube_link'] = this.youTubeLink;
    data['pdf'] = this.pdf;
    data['order_no'] = this.orderNo;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;

    return data;
  }
}
