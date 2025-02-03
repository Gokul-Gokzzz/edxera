class CourseDataModel {
  bool? success;
  String? message;
  Data? data;

  CourseDataModel({this.success, this.message, this.data});

  CourseDataModel.fromJson(Map<String, dynamic> json) {
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
  List<UserCourses>? userCourses;

  Data({this.userCourses});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['user_courses'] != null) {
      userCourses = <UserCourses>[];
      json['user_courses'].forEach((v) {
        userCourses!.add(new UserCourses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userCourses != null) {
      data['user_courses'] = this.userCourses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserCourses {
  int? id;
  int? courseId;
  int? userId;
  String? courseProgressStatus;
  int? courseProgressPercentage;
  int? remainingChapters;
  int? remainingAssignments;
  int? remainingExamMcq;
  int? remainingExamDescription;
  String? createdAt;
  String? updatedAt;
  String? courseThumbnail;
  int? chapterCount;
  String? title;
  String? slug;
  String? shortDescription;
  String? instructorIds;
  int? categoryId;
  String? courseType;
  String? capacity;
  String? classEndsAt;
  int? languageId;
  int? organizationId;
  String? description;
  int? isPrivate;
  String? videoSource;
  String? video;
  int? imageMediaId;
  String? image;
  String? duration;
  int? isDownloadable;
  int? isFree;
  int? price;
  int? isDiscountable;
  String? discountType;
  int? discount;
  String? discountStartAt;
  String? discountEndAt;
  int? isFeatured;
  String? deletedAt;
  String? tags;
  int? levelId;
  int? subjectId;
  int? isRenewable;
  String? renewAfter;
  String? metaTitle;
  String? metaKeywords;
  String? metaDescription;
  String? metaImage;
  int? totalLesson;
  int? totalEnrolled;
  int? totalRating;
  int? isPublished;
  String? status;

  UserCourses(
      {this.id,
      this.courseId,
      this.userId,
      this.courseProgressStatus,
      this.courseProgressPercentage,
      this.remainingChapters,
      this.remainingAssignments,
      this.remainingExamMcq,
      this.remainingExamDescription,
      this.createdAt,
      this.updatedAt,
      this.courseThumbnail,
      this.chapterCount,
      this.title,
      this.slug,
      this.shortDescription,
      this.instructorIds,
      this.categoryId,
      this.courseType,
      this.capacity,
      this.classEndsAt,
      this.languageId,
      this.organizationId,
      this.description,
      this.isPrivate,
      this.videoSource,
      this.video,
      this.imageMediaId,
      this.image,
      this.duration,
      this.isDownloadable,
      this.isFree,
      this.price,
      this.isDiscountable,
      this.discountType,
      this.discount,
      this.discountStartAt,
      this.discountEndAt,
      this.isFeatured,
      this.deletedAt,
      this.tags,
      this.levelId,
      this.subjectId,
      this.isRenewable,
      this.renewAfter,
      this.metaTitle,
      this.metaKeywords,
      this.metaDescription,
      this.metaImage,
      this.totalLesson,
      this.totalEnrolled,
      this.totalRating,
      this.isPublished,
      this.status});

  UserCourses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['course_id'];
    userId = json['user_id'];
    courseProgressStatus = json['course_progress_status'];
    courseProgressPercentage = json['course_progress_percentage'];
    remainingChapters = json['remaining_chapters'];
    remainingAssignments = json['remaining_assignments'];
    remainingExamMcq = json['remaining_exam_mcq'];
    remainingExamDescription = json['remaining_exam_description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    courseThumbnail = json['course_thumbnail'];
    chapterCount = json['chapter_count'];
    title = json['title'];
    slug = json['slug'];
    shortDescription = json['short_description'];
    instructorIds = json['instructor_ids'];
    categoryId = json['category_id'];
    courseType = json['course_type'];
    capacity = json['capacity'];
    classEndsAt = json['class_ends_at'];
    languageId = json['language_id'];
    organizationId = json['organization_id'];
    description = json['description'];
    isPrivate = json['is_private'];
    videoSource = json['video_source'];
    video = json['video'];
    imageMediaId = json['image_media_id'];
    image = json['image'];
    duration = json['duration'];
    isDownloadable = json['is_downloadable'];
    isFree = json['is_free'];
    price = json['price'];
    isDiscountable = json['is_discountable'];
    discountType = json['discount_type'];
    discount = json['discount'];
    discountStartAt = json['discount_start_at'];
    discountEndAt = json['discount_end_at'];
    isFeatured = json['is_featured'];
    deletedAt = json['deleted_at'];
    tags = json['tags'];
    levelId = json['level_id'];
    subjectId = json['subject_id'];
    isRenewable = json['is_renewable'];
    renewAfter = json['renew_after'];
    metaTitle = json['meta_title'];
    metaKeywords = json['meta_keywords'];
    metaDescription = json['meta_description'];
    metaImage = json['meta_image'];
    totalLesson = json['total_lesson'];
    totalEnrolled = json['total_enrolled'];
    totalRating = json['total_rating'];
    isPublished = json['is_published'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_id'] = this.courseId;
    data['user_id'] = this.userId;
    data['course_progress_status'] = this.courseProgressStatus;
    data['course_progress_percentage'] = this.courseProgressPercentage;
    data['remaining_chapters'] = this.remainingChapters;
    data['remaining_assignments'] = this.remainingAssignments;
    data['remaining_exam_mcq'] = this.remainingExamMcq;
    data['remaining_exam_description'] = this.remainingExamDescription;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['course_thumbnail'] = this.courseThumbnail;
    data['chapter_count'] = this.chapterCount;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['short_description'] = this.shortDescription;
    data['instructor_ids'] = this.instructorIds;
    data['category_id'] = this.categoryId;
    data['course_type'] = this.courseType;
    data['capacity'] = this.capacity;
    data['class_ends_at'] = this.classEndsAt;
    data['language_id'] = this.languageId;
    data['organization_id'] = this.organizationId;
    data['description'] = this.description;
    data['is_private'] = this.isPrivate;
    data['video_source'] = this.videoSource;
    data['video'] = this.video;
    data['image_media_id'] = this.imageMediaId;
    data['image'] = this.image;
    data['duration'] = this.duration;
    data['is_downloadable'] = this.isDownloadable;
    data['is_free'] = this.isFree;
    data['price'] = this.price;
    data['is_discountable'] = this.isDiscountable;
    data['discount_type'] = this.discountType;
    data['discount'] = this.discount;
    data['discount_start_at'] = this.discountStartAt;
    data['discount_end_at'] = this.discountEndAt;
    data['is_featured'] = this.isFeatured;
    data['deleted_at'] = this.deletedAt;
    data['tags'] = this.tags;
    data['level_id'] = this.levelId;
    data['subject_id'] = this.subjectId;
    data['is_renewable'] = this.isRenewable;
    data['renew_after'] = this.renewAfter;
    data['meta_title'] = this.metaTitle;
    data['meta_keywords'] = this.metaKeywords;
    data['meta_description'] = this.metaDescription;
    data['meta_image'] = this.metaImage;
    data['total_lesson'] = this.totalLesson;
    data['total_enrolled'] = this.totalEnrolled;
    data['total_rating'] = this.totalRating;
    data['is_published'] = this.isPublished;
    data['status'] = this.status;
    return data;
  }
}
