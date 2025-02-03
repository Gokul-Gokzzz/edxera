// import 'package:edxera/generated/json/base/json_convert_content.dart';
// import 'package:edxera/My_cources/Models/course_data_entity.dart';
//
// CourseDataEntity $CourseDataEntityFromJson(Map<String, dynamic> json) {
//   final CourseDataEntity courseDataEntity = CourseDataEntity();
//   final bool? success = jsonConvert.convert<bool>(json['success']);
//   if (success != null) {
//     courseDataEntity.success = success;
//   }
//   final String? message = jsonConvert.convert<String>(json['message']);
//   if (message != null) {
//     courseDataEntity.message = message;
//   }
//   final CourseDataData? data = jsonConvert.convert<CourseDataData>(
//       json['data']);
//   if (data != null) {
//     courseDataEntity.data = data;
//   }
//   return courseDataEntity;
// }
//
// Map<String, dynamic> $CourseDataEntityToJson(CourseDataEntity entity) {
//   final Map<String, dynamic> data = <String, dynamic>{};
//   data['success'] = entity.success;
//   data['message'] = entity.message;
//   data['data'] = entity.data.toJson();
//   return data;
// }
//
// extension CourseDataEntityExtension on CourseDataEntity {
//   CourseDataEntity copyWith({
//     bool? success,
//     String? message,
//     CourseDataData? data,
//   }) {
//     return CourseDataEntity()
//       ..success = success ?? this.success
//       ..message = message ?? this.message
//       ..data = data ?? this.data;
//   }
// }
//
// CourseDataData $CourseDataDataFromJson(Map<String, dynamic> json) {
//   final CourseDataData courseDataData = CourseDataData();
//   final int? coursePurchasedStatus = jsonConvert.convert<int>(
//       json['course_purchased_status']);
//   if (coursePurchasedStatus != null) {
//     courseDataData.coursePurchasedStatus = coursePurchasedStatus;
//   }
//   final int? totalChapterCount = jsonConvert.convert<int>(
//       json['total_chapter_count']);
//   if (totalChapterCount != null) {
//     courseDataData.totalChapterCount = totalChapterCount;
//   }
//   final CourseDataDataCourse? course = jsonConvert.convert<
//       CourseDataDataCourse>(json['Course']);
//   if (course != null) {
//     courseDataData.course = course;
//   }
//   final List<dynamic>? reviews = (json['reviews'] as List<dynamic>?)?.map(
//           (e) => e).toList();
//   if (reviews != null) {
//     courseDataData.reviews = reviews;
//   }
//   final List<CourseDataDataSkills>? skills = (json['skills'] as List<dynamic>?)
//       ?.map(
//           (e) =>
//       jsonConvert.convert<CourseDataDataSkills>(e) as CourseDataDataSkills)
//       .toList();
//   if (skills != null) {
//     courseDataData.skills = skills;
//   }
//   final List<
//       CourseDataDataInstructors>? instructors = (json['instructors'] as List<
//       dynamic>?)?.map(
//           (e) =>
//       jsonConvert.convert<CourseDataDataInstructors>(
//           e) as CourseDataDataInstructors).toList();
//   if (instructors != null) {
//     courseDataData.instructors = instructors;
//   }
//   final CourseDataDataSylabus? sylabus = jsonConvert.convert<
//       CourseDataDataSylabus>(json['sylabus']);
//   if (sylabus != null) {
//     courseDataData.sylabus = sylabus;
//   }
//   return courseDataData;
// }
//
// Map<String, dynamic> $CourseDataDataToJson(CourseDataData entity) {
//   final Map<String, dynamic> data = <String, dynamic>{};
//   data['course_purchased_status'] = entity.coursePurchasedStatus;
//   data['total_chapter_count'] = entity.totalChapterCount;
//   data['Course'] = entity.course.toJson();
//   data['reviews'] = entity.reviews;
//   data['skills'] = entity.skills.map((v) => v.toJson()).toList();
//   data['instructors'] = entity.instructors.map((v) => v.toJson()).toList();
//   data['sylabus'] = entity.sylabus.toJson();
//   return data;
// }
//
// extension CourseDataDataExtension on CourseDataData {
//   CourseDataData copyWith({
//     int? coursePurchasedStatus,
//     int? totalChapterCount,
//     CourseDataDataCourse? course,
//     List<dynamic>? reviews,
//     List<CourseDataDataSkills>? skills,
//     List<CourseDataDataInstructors>? instructors,
//     CourseDataDataSylabus? sylabus,
//   }) {
//     return CourseDataData()
//       ..coursePurchasedStatus = coursePurchasedStatus ??
//           this.coursePurchasedStatus
//       ..totalChapterCount = totalChapterCount ?? this.totalChapterCount
//       ..course = course ?? this.course
//       ..reviews = reviews ?? this.reviews
//       ..skills = skills ?? this.skills
//       ..instructors = instructors ?? this.instructors
//       ..sylabus = sylabus ?? this.sylabus;
//   }
// }
//
// CourseDataDataCourse $CourseDataDataCourseFromJson(Map<String, dynamic> json) {
//   final CourseDataDataCourse courseDataDataCourse = CourseDataDataCourse();
//   final int? id = jsonConvert.convert<int>(json['id']);
//   if (id != null) {
//     courseDataDataCourse.id = id;
//   }
//   final String? courseThumbnail = jsonConvert.convert<String>(
//       json['course_thumbnail']);
//   if (courseThumbnail != null) {
//     courseDataDataCourse.courseThumbnail = courseThumbnail;
//   }
//   final int? chapterCount = jsonConvert.convert<int>(json['chapter_count']);
//   if (chapterCount != null) {
//     courseDataDataCourse.chapterCount = chapterCount;
//   }
//   final String? title = jsonConvert.convert<String>(json['title']);
//   if (title != null) {
//     courseDataDataCourse.title = title;
//   }
//   final String? slug = jsonConvert.convert<String>(json['slug']);
//   if (slug != null) {
//     courseDataDataCourse.slug = slug;
//   }
//   final String? shortDescription = jsonConvert.convert<String>(
//       json['short_description']);
//   if (shortDescription != null) {
//     courseDataDataCourse.shortDescription = shortDescription;
//   }
//   final int? userId = jsonConvert.convert<int>(json['user_id']);
//   if (userId != null) {
//     courseDataDataCourse.userId = userId;
//   }
//   final List<String>? instructorIds = (json['instructor_ids'] as List<dynamic>?)
//       ?.map(
//           (e) => jsonConvert.convert<String>(e) as String)
//       .toList();
//   if (instructorIds != null) {
//     courseDataDataCourse.instructorIds = instructorIds;
//   }
//   final int? categoryId = jsonConvert.convert<int>(json['category_id']);
//   if (categoryId != null) {
//     courseDataDataCourse.categoryId = categoryId;
//   }
//   final String? courseType = jsonConvert.convert<String>(json['course_type']);
//   if (courseType != null) {
//     courseDataDataCourse.courseType = courseType;
//   }
//   final dynamic capacity = json['capacity'];
//   if (capacity != null) {
//     courseDataDataCourse.capacity = capacity;
//   }
//   final dynamic classEndsAt = json['class_ends_at'];
//   if (classEndsAt != null) {
//     courseDataDataCourse.classEndsAt = classEndsAt;
//   }
//   final int? languageId = jsonConvert.convert<int>(json['language_id']);
//   if (languageId != null) {
//     courseDataDataCourse.languageId = languageId;
//   }
//   final int? organizationId = jsonConvert.convert<int>(json['organization_id']);
//   if (organizationId != null) {
//     courseDataDataCourse.organizationId = organizationId;
//   }
//   final String? description = jsonConvert.convert<String>(json['description']);
//   if (description != null) {
//     courseDataDataCourse.description = description;
//   }
//   final int? isPrivate = jsonConvert.convert<int>(json['is_private']);
//   if (isPrivate != null) {
//     courseDataDataCourse.isPrivate = isPrivate;
//   }
//   final String? videoSource = jsonConvert.convert<String>(json['video_source']);
//   if (videoSource != null) {
//     courseDataDataCourse.videoSource = videoSource;
//   }
//   final dynamic video = json['video'];
//   if (video != null) {
//     courseDataDataCourse.video = video;
//   }
//   final int? imageMediaId = jsonConvert.convert<int>(json['image_media_id']);
//   if (imageMediaId != null) {
//     courseDataDataCourse.imageMediaId = imageMediaId;
//   }
//   final CourseDataDataCourseImage? image = jsonConvert.convert<
//       CourseDataDataCourseImage>(json['image']);
//   if (image != null) {
//     courseDataDataCourse.image = image;
//   }
//   final String? duration = jsonConvert.convert<String>(json['duration']);
//   if (duration != null) {
//     courseDataDataCourse.duration = duration;
//   }
//   final int? isDownloadable = jsonConvert.convert<int>(json['is_downloadable']);
//   if (isDownloadable != null) {
//     courseDataDataCourse.isDownloadable = isDownloadable;
//   }
//   final int? isFree = jsonConvert.convert<int>(json['is_free']);
//   if (isFree != null) {
//     courseDataDataCourse.isFree = isFree;
//   }
//   final int? price = jsonConvert.convert<int>(json['price']);
//   if (price != null) {
//     courseDataDataCourse.price = price;
//   }
//   final int? isDiscountable = jsonConvert.convert<int>(json['is_discountable']);
//   if (isDiscountable != null) {
//     courseDataDataCourse.isDiscountable = isDiscountable;
//   }
//   final String? discountType = jsonConvert.convert<String>(
//       json['discount_type']);
//   if (discountType != null) {
//     courseDataDataCourse.discountType = discountType;
//   }
//   final int? discount = jsonConvert.convert<int>(json['discount']);
//   if (discount != null) {
//     courseDataDataCourse.discount = discount;
//   }
//   final dynamic discountStartAt = json['discount_start_at'];
//   if (discountStartAt != null) {
//     courseDataDataCourse.discountStartAt = discountStartAt;
//   }
//   final dynamic discountEndAt = json['discount_end_at'];
//   if (discountEndAt != null) {
//     courseDataDataCourse.discountEndAt = discountEndAt;
//   }
//   final int? isFeatured = jsonConvert.convert<int>(json['is_featured']);
//   if (isFeatured != null) {
//     courseDataDataCourse.isFeatured = isFeatured;
//   }
//   final dynamic deletedAt = json['deleted_at'];
//   if (deletedAt != null) {
//     courseDataDataCourse.deletedAt = deletedAt;
//   }
//   final List<String>? tags = (json['tags'] as List<dynamic>?)?.map(
//           (e) => jsonConvert.convert<String>(e) as String).toList();
//   if (tags != null) {
//     courseDataDataCourse.tags = tags;
//   }
//   final int? levelId = jsonConvert.convert<int>(json['level_id']);
//   if (levelId != null) {
//     courseDataDataCourse.levelId = levelId;
//   }
//   final int? subjectId = jsonConvert.convert<int>(json['subject_id']);
//   if (subjectId != null) {
//     courseDataDataCourse.subjectId = subjectId;
//   }
//   final int? isRenewable = jsonConvert.convert<int>(json['is_renewable']);
//   if (isRenewable != null) {
//     courseDataDataCourse.isRenewable = isRenewable;
//   }
//   final String? renewAfter = jsonConvert.convert<String>(json['renew_after']);
//   if (renewAfter != null) {
//     courseDataDataCourse.renewAfter = renewAfter;
//   }
//   final String? metaTitle = jsonConvert.convert<String>(json['meta_title']);
//   if (metaTitle != null) {
//     courseDataDataCourse.metaTitle = metaTitle;
//   }
//   final String? metaKeywords = jsonConvert.convert<String>(
//       json['meta_keywords']);
//   if (metaKeywords != null) {
//     courseDataDataCourse.metaKeywords = metaKeywords;
//   }
//   final String? metaDescription = jsonConvert.convert<String>(
//       json['meta_description']);
//   if (metaDescription != null) {
//     courseDataDataCourse.metaDescription = metaDescription;
//   }
//   final CourseDataDataCourseMetaImage? metaImage = jsonConvert.convert<
//       CourseDataDataCourseMetaImage>(json['meta_image']);
//   if (metaImage != null) {
//     courseDataDataCourse.metaImage = metaImage;
//   }
//   final int? totalLesson = jsonConvert.convert<int>(json['total_lesson']);
//   if (totalLesson != null) {
//     courseDataDataCourse.totalLesson = totalLesson;
//   }
//   final int? totalEnrolled = jsonConvert.convert<int>(json['total_enrolled']);
//   if (totalEnrolled != null) {
//     courseDataDataCourse.totalEnrolled = totalEnrolled;
//   }
//   final int? totalRating = jsonConvert.convert<int>(json['total_rating']);
//   if (totalRating != null) {
//     courseDataDataCourse.totalRating = totalRating;
//   }
//   final int? isPublished = jsonConvert.convert<int>(json['is_published']);
//   if (isPublished != null) {
//     courseDataDataCourse.isPublished = isPublished;
//   }
//   final String? status = jsonConvert.convert<String>(json['status']);
//   if (status != null) {
//     courseDataDataCourse.status = status;
//   }
//   final String? createdAt = jsonConvert.convert<String>(json['created_at']);
//   if (createdAt != null) {
//     courseDataDataCourse.createdAt = createdAt;
//   }
//   final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
//   if (updatedAt != null) {
//     courseDataDataCourse.updatedAt = updatedAt;
//   }
//   final CourseDataDataCourseLanguage? language = jsonConvert.convert<
//       CourseDataDataCourseLanguage>(json['language']);
//   if (language != null) {
//     courseDataDataCourse.language = language;
//   }
//   final CourseDataDataCourseLevel? level = jsonConvert.convert<
//       CourseDataDataCourseLevel>(json['level']);
//   if (level != null) {
//     courseDataDataCourse.level = level;
//   }
//   return courseDataDataCourse;
// }
//
// Map<String, dynamic> $CourseDataDataCourseToJson(CourseDataDataCourse entity) {
//   final Map<String, dynamic> data = <String, dynamic>{};
//   data['id'] = entity.id;
//   data['course_thumbnail'] = entity.courseThumbnail;
//   data['chapter_count'] = entity.chapterCount;
//   data['title'] = entity.title;
//   data['slug'] = entity.slug;
//   data['short_description'] = entity.shortDescription;
//   data['user_id'] = entity.userId;
//   data['instructor_ids'] = entity.instructorIds;
//   data['category_id'] = entity.categoryId;
//   data['course_type'] = entity.courseType;
//   data['capacity'] = entity.capacity;
//   data['class_ends_at'] = entity.classEndsAt;
//   data['language_id'] = entity.languageId;
//   data['organization_id'] = entity.organizationId;
//   data['description'] = entity.description;
//   data['is_private'] = entity.isPrivate;
//   data['video_source'] = entity.videoSource;
//   data['video'] = entity.video;
//   data['image_media_id'] = entity.imageMediaId;
//   data['image'] = entity.image.toJson();
//   data['duration'] = entity.duration;
//   data['is_downloadable'] = entity.isDownloadable;
//   data['is_free'] = entity.isFree;
//   data['price'] = entity.price;
//   data['is_discountable'] = entity.isDiscountable;
//   data['discount_type'] = entity.discountType;
//   data['discount'] = entity.discount;
//   data['discount_start_at'] = entity.discountStartAt;
//   data['discount_end_at'] = entity.discountEndAt;
//   data['is_featured'] = entity.isFeatured;
//   data['deleted_at'] = entity.deletedAt;
//   data['tags'] = entity.tags;
//   data['level_id'] = entity.levelId;
//   data['subject_id'] = entity.subjectId;
//   data['is_renewable'] = entity.isRenewable;
//   data['renew_after'] = entity.renewAfter;
//   data['meta_title'] = entity.metaTitle;
//   data['meta_keywords'] = entity.metaKeywords;
//   data['meta_description'] = entity.metaDescription;
//   data['meta_image'] = entity.metaImage.toJson();
//   data['total_lesson'] = entity.totalLesson;
//   data['total_enrolled'] = entity.totalEnrolled;
//   data['total_rating'] = entity.totalRating;
//   data['is_published'] = entity.isPublished;
//   data['status'] = entity.status;
//   data['created_at'] = entity.createdAt;
//   data['updated_at'] = entity.updatedAt;
//   data['language'] = entity.language.toJson();
//   data['level'] = entity.level.toJson();
//   return data;
// }
//
// extension CourseDataDataCourseExtension on CourseDataDataCourse {
//   CourseDataDataCourse copyWith({
//     int? id,
//     String? courseThumbnail,
//     int? chapterCount,
//     String? title,
//     String? slug,
//     String? shortDescription,
//     int? userId,
//     List<String>? instructorIds,
//     int? categoryId,
//     String? courseType,
//     dynamic capacity,
//     dynamic classEndsAt,
//     int? languageId,
//     int? organizationId,
//     String? description,
//     int? isPrivate,
//     String? videoSource,
//     dynamic video,
//     int? imageMediaId,
//     CourseDataDataCourseImage? image,
//     String? duration,
//     int? isDownloadable,
//     int? isFree,
//     int? price,
//     int? isDiscountable,
//     String? discountType,
//     int? discount,
//     dynamic discountStartAt,
//     dynamic discountEndAt,
//     int? isFeatured,
//     dynamic deletedAt,
//     List<String>? tags,
//     int? levelId,
//     int? subjectId,
//     int? isRenewable,
//     String? renewAfter,
//     String? metaTitle,
//     String? metaKeywords,
//     String? metaDescription,
//     CourseDataDataCourseMetaImage? metaImage,
//     int? totalLesson,
//     int? totalEnrolled,
//     int? totalRating,
//     int? isPublished,
//     String? status,
//     String? createdAt,
//     String? updatedAt,
//     CourseDataDataCourseLanguage? language,
//     CourseDataDataCourseLevel? level,
//   }) {
//     return CourseDataDataCourse()
//       ..id = id ?? this.id
//       ..courseThumbnail = courseThumbnail ?? this.courseThumbnail
//       ..chapterCount = chapterCount ?? this.chapterCount
//       ..title = title ?? this.title
//       ..slug = slug ?? this.slug
//       ..shortDescription = shortDescription ?? this.shortDescription
//       ..userId = userId ?? this.userId
//       ..instructorIds = instructorIds ?? this.instructorIds
//       ..categoryId = categoryId ?? this.categoryId
//       ..courseType = courseType ?? this.courseType
//       ..capacity = capacity ?? this.capacity
//       ..classEndsAt = classEndsAt ?? this.classEndsAt
//       ..languageId = languageId ?? this.languageId
//       ..organizationId = organizationId ?? this.organizationId
//       ..description = description ?? this.description
//       ..isPrivate = isPrivate ?? this.isPrivate
//       ..videoSource = videoSource ?? this.videoSource
//       ..video = video ?? this.video
//       ..imageMediaId = imageMediaId ?? this.imageMediaId
//       ..image = image ?? this.image
//       ..duration = duration ?? this.duration
//       ..isDownloadable = isDownloadable ?? this.isDownloadable
//       ..isFree = isFree ?? this.isFree
//       ..price = price ?? this.price
//       ..isDiscountable = isDiscountable ?? this.isDiscountable
//       ..discountType = discountType ?? this.discountType
//       ..discount = discount ?? this.discount
//       ..discountStartAt = discountStartAt ?? this.discountStartAt
//       ..discountEndAt = discountEndAt ?? this.discountEndAt
//       ..isFeatured = isFeatured ?? this.isFeatured
//       ..deletedAt = deletedAt ?? this.deletedAt
//       ..tags = tags ?? this.tags
//       ..levelId = levelId ?? this.levelId
//       ..subjectId = subjectId ?? this.subjectId
//       ..isRenewable = isRenewable ?? this.isRenewable
//       ..renewAfter = renewAfter ?? this.renewAfter
//       ..metaTitle = metaTitle ?? this.metaTitle
//       ..metaKeywords = metaKeywords ?? this.metaKeywords
//       ..metaDescription = metaDescription ?? this.metaDescription
//       ..metaImage = metaImage ?? this.metaImage
//       ..totalLesson = totalLesson ?? this.totalLesson
//       ..totalEnrolled = totalEnrolled ?? this.totalEnrolled
//       ..totalRating = totalRating ?? this.totalRating
//       ..isPublished = isPublished ?? this.isPublished
//       ..status = status ?? this.status
//       ..createdAt = createdAt ?? this.createdAt
//       ..updatedAt = updatedAt ?? this.updatedAt
//       ..language = language ?? this.language
//       ..level = level ?? this.level;
//   }
// }
//
// CourseDataDataCourseImage $CourseDataDataCourseImageFromJson(
//     Map<String, dynamic> json) {
//   final CourseDataDataCourseImage courseDataDataCourseImage = CourseDataDataCourseImage();
//   final String? storage = jsonConvert.convert<String>(json['storage']);
//   if (storage != null) {
//     courseDataDataCourseImage.storage = storage;
//   }
//   final String? originalImage = jsonConvert.convert<String>(
//       json['original_image']);
//   if (originalImage != null) {
//     courseDataDataCourseImage.originalImage = originalImage;
//   }
//   final String? image40x40 = jsonConvert.convert<String>(json['image_40x40']);
//   if (image40x40 != null) {
//     courseDataDataCourseImage.image40x40 = image40x40;
//   }
//   final String? image80x80 = jsonConvert.convert<String>(json['image_80x80']);
//   if (image80x80 != null) {
//     courseDataDataCourseImage.image80x80 = image80x80;
//   }
//   final String? image68x48 = jsonConvert.convert<String>(json['image_68x48']);
//   if (image68x48 != null) {
//     courseDataDataCourseImage.image68x48 = image68x48;
//   }
//   final String? image190x230 = jsonConvert.convert<String>(
//       json['image_190x230']);
//   if (image190x230 != null) {
//     courseDataDataCourseImage.image190x230 = image190x230;
//   }
//   final String? image163x116 = jsonConvert.convert<String>(
//       json['image_163x116']);
//   if (image163x116 != null) {
//     courseDataDataCourseImage.image163x116 = image163x116;
//   }
//   final String? image295x248 = jsonConvert.convert<String>(
//       json['image_295x248']);
//   if (image295x248 != null) {
//     courseDataDataCourseImage.image295x248 = image295x248;
//   }
//   final String? image417x384 = jsonConvert.convert<String>(
//       json['image_417x384']);
//   if (image417x384 != null) {
//     courseDataDataCourseImage.image417x384 = image417x384;
//   }
//   final String? imageThumbnail = jsonConvert.convert<String>(
//       json['image_thumbnail']);
//   if (imageThumbnail != null) {
//     courseDataDataCourseImage.imageThumbnail = imageThumbnail;
//   }
//   final String? image402x238 = jsonConvert.convert<String>(
//       json['image_402x238']);
//   if (image402x238 != null) {
//     courseDataDataCourseImage.image402x238 = image402x238;
//   }
//   final String? image1200x630 = jsonConvert.convert<String>(
//       json['image_1200x630']);
//   if (image1200x630 != null) {
//     courseDataDataCourseImage.image1200x630 = image1200x630;
//   }
//   final String? image402x248 = jsonConvert.convert<String>(
//       json['image_402x248']);
//   if (image402x248 != null) {
//     courseDataDataCourseImage.image402x248 = image402x248;
//   }
//   return courseDataDataCourseImage;
// }
//
// Map<String, dynamic> $CourseDataDataCourseImageToJson(
//     CourseDataDataCourseImage entity) {
//   final Map<String, dynamic> data = <String, dynamic>{};
//   data['storage'] = entity.storage;
//   data['original_image'] = entity.originalImage;
//   data['image_40x40'] = entity.image40x40;
//   data['image_80x80'] = entity.image80x80;
//   data['image_68x48'] = entity.image68x48;
//   data['image_190x230'] = entity.image190x230;
//   data['image_163x116'] = entity.image163x116;
//   data['image_295x248'] = entity.image295x248;
//   data['image_417x384'] = entity.image417x384;
//   data['image_thumbnail'] = entity.imageThumbnail;
//   data['image_402x238'] = entity.image402x238;
//   data['image_1200x630'] = entity.image1200x630;
//   data['image_402x248'] = entity.image402x248;
//   return data;
// }
//
// extension CourseDataDataCourseImageExtension on CourseDataDataCourseImage {
//   CourseDataDataCourseImage copyWith({
//     String? storage,
//     String? originalImage,
//     String? image40x40,
//     String? image80x80,
//     String? image68x48,
//     String? image190x230,
//     String? image163x116,
//     String? image295x248,
//     String? image417x384,
//     String? imageThumbnail,
//     String? image402x238,
//     String? image1200x630,
//     String? image402x248,
//   }) {
//     return CourseDataDataCourseImage()
//       ..storage = storage ?? this.storage
//       ..originalImage = originalImage ?? this.originalImage
//       ..image40x40 = image40x40 ?? this.image40x40
//       ..image80x80 = image80x80 ?? this.image80x80
//       ..image68x48 = image68x48 ?? this.image68x48
//       ..image190x230 = image190x230 ?? this.image190x230
//       ..image163x116 = image163x116 ?? this.image163x116
//       ..image295x248 = image295x248 ?? this.image295x248
//       ..image417x384 = image417x384 ?? this.image417x384
//       ..imageThumbnail = imageThumbnail ?? this.imageThumbnail
//       ..image402x238 = image402x238 ?? this.image402x238
//       ..image1200x630 = image1200x630 ?? this.image1200x630
//       ..image402x248 = image402x248 ?? this.image402x248;
//   }
// }
//
// CourseDataDataCourseMetaImage $CourseDataDataCourseMetaImageFromJson(
//     Map<String, dynamic> json) {
//   final CourseDataDataCourseMetaImage courseDataDataCourseMetaImage = CourseDataDataCourseMetaImage();
//   final String? storage = jsonConvert.convert<String>(json['storage']);
//   if (storage != null) {
//     courseDataDataCourseMetaImage.storage = storage;
//   }
//   final String? originalImage = jsonConvert.convert<String>(
//       json['original_image']);
//   if (originalImage != null) {
//     courseDataDataCourseMetaImage.originalImage = originalImage;
//   }
//   final String? image40x40 = jsonConvert.convert<String>(json['image_40x40']);
//   if (image40x40 != null) {
//     courseDataDataCourseMetaImage.image40x40 = image40x40;
//   }
//   final String? image80x80 = jsonConvert.convert<String>(json['image_80x80']);
//   if (image80x80 != null) {
//     courseDataDataCourseMetaImage.image80x80 = image80x80;
//   }
//   final String? image68x48 = jsonConvert.convert<String>(json['image_68x48']);
//   if (image68x48 != null) {
//     courseDataDataCourseMetaImage.image68x48 = image68x48;
//   }
//   final String? image190x230 = jsonConvert.convert<String>(
//       json['image_190x230']);
//   if (image190x230 != null) {
//     courseDataDataCourseMetaImage.image190x230 = image190x230;
//   }
//   final String? image163x116 = jsonConvert.convert<String>(
//       json['image_163x116']);
//   if (image163x116 != null) {
//     courseDataDataCourseMetaImage.image163x116 = image163x116;
//   }
//   final String? image295x248 = jsonConvert.convert<String>(
//       json['image_295x248']);
//   if (image295x248 != null) {
//     courseDataDataCourseMetaImage.image295x248 = image295x248;
//   }
//   final String? image417x384 = jsonConvert.convert<String>(
//       json['image_417x384']);
//   if (image417x384 != null) {
//     courseDataDataCourseMetaImage.image417x384 = image417x384;
//   }
//   final String? imageThumbnail = jsonConvert.convert<String>(
//       json['image_thumbnail']);
//   if (imageThumbnail != null) {
//     courseDataDataCourseMetaImage.imageThumbnail = imageThumbnail;
//   }
//   final String? image402x238 = jsonConvert.convert<String>(
//       json['image_402x238']);
//   if (image402x238 != null) {
//     courseDataDataCourseMetaImage.image402x238 = image402x238;
//   }
//   final String? image1200x630 = jsonConvert.convert<String>(
//       json['image_1200x630']);
//   if (image1200x630 != null) {
//     courseDataDataCourseMetaImage.image1200x630 = image1200x630;
//   }
//   final String? image402x248 = jsonConvert.convert<String>(
//       json['image_402x248']);
//   if (image402x248 != null) {
//     courseDataDataCourseMetaImage.image402x248 = image402x248;
//   }
//   return courseDataDataCourseMetaImage;
// }
//
// Map<String, dynamic> $CourseDataDataCourseMetaImageToJson(
//     CourseDataDataCourseMetaImage entity) {
//   final Map<String, dynamic> data = <String, dynamic>{};
//   data['storage'] = entity.storage;
//   data['original_image'] = entity.originalImage;
//   data['image_40x40'] = entity.image40x40;
//   data['image_80x80'] = entity.image80x80;
//   data['image_68x48'] = entity.image68x48;
//   data['image_190x230'] = entity.image190x230;
//   data['image_163x116'] = entity.image163x116;
//   data['image_295x248'] = entity.image295x248;
//   data['image_417x384'] = entity.image417x384;
//   data['image_thumbnail'] = entity.imageThumbnail;
//   data['image_402x238'] = entity.image402x238;
//   data['image_1200x630'] = entity.image1200x630;
//   data['image_402x248'] = entity.image402x248;
//   return data;
// }
//
// extension CourseDataDataCourseMetaImageExtension on CourseDataDataCourseMetaImage {
//   CourseDataDataCourseMetaImage copyWith({
//     String? storage,
//     String? originalImage,
//     String? image40x40,
//     String? image80x80,
//     String? image68x48,
//     String? image190x230,
//     String? image163x116,
//     String? image295x248,
//     String? image417x384,
//     String? imageThumbnail,
//     String? image402x238,
//     String? image1200x630,
//     String? image402x248,
//   }) {
//     return CourseDataDataCourseMetaImage()
//       ..storage = storage ?? this.storage
//       ..originalImage = originalImage ?? this.originalImage
//       ..image40x40 = image40x40 ?? this.image40x40
//       ..image80x80 = image80x80 ?? this.image80x80
//       ..image68x48 = image68x48 ?? this.image68x48
//       ..image190x230 = image190x230 ?? this.image190x230
//       ..image163x116 = image163x116 ?? this.image163x116
//       ..image295x248 = image295x248 ?? this.image295x248
//       ..image417x384 = image417x384 ?? this.image417x384
//       ..imageThumbnail = imageThumbnail ?? this.imageThumbnail
//       ..image402x238 = image402x238 ?? this.image402x238
//       ..image1200x630 = image1200x630 ?? this.image1200x630
//       ..image402x248 = image402x248 ?? this.image402x248;
//   }
// }
//
// CourseDataDataCourseLanguage $CourseDataDataCourseLanguageFromJson(
//     Map<String, dynamic> json) {
//   final CourseDataDataCourseLanguage courseDataDataCourseLanguage = CourseDataDataCourseLanguage();
//   final int? id = jsonConvert.convert<int>(json['id']);
//   if (id != null) {
//     courseDataDataCourseLanguage.id = id;
//   }
//   final String? name = jsonConvert.convert<String>(json['name']);
//   if (name != null) {
//     courseDataDataCourseLanguage.name = name;
//   }
//   final String? locale = jsonConvert.convert<String>(json['locale']);
//   if (locale != null) {
//     courseDataDataCourseLanguage.locale = locale;
//   }
//   final dynamic flag = json['flag'];
//   if (flag != null) {
//     courseDataDataCourseLanguage.flag = flag;
//   }
//   final String? textDirection = jsonConvert.convert<String>(
//       json['text_direction']);
//   if (textDirection != null) {
//     courseDataDataCourseLanguage.textDirection = textDirection;
//   }
//   final int? status = jsonConvert.convert<int>(json['status']);
//   if (status != null) {
//     courseDataDataCourseLanguage.status = status;
//   }
//   final String? createdAt = jsonConvert.convert<String>(json['created_at']);
//   if (createdAt != null) {
//     courseDataDataCourseLanguage.createdAt = createdAt;
//   }
//   final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
//   if (updatedAt != null) {
//     courseDataDataCourseLanguage.updatedAt = updatedAt;
//   }
//   return courseDataDataCourseLanguage;
// }
//
// Map<String, dynamic> $CourseDataDataCourseLanguageToJson(
//     CourseDataDataCourseLanguage entity) {
//   final Map<String, dynamic> data = <String, dynamic>{};
//   data['id'] = entity.id;
//   data['name'] = entity.name;
//   data['locale'] = entity.locale;
//   data['flag'] = entity.flag;
//   data['text_direction'] = entity.textDirection;
//   data['status'] = entity.status;
//   data['created_at'] = entity.createdAt;
//   data['updated_at'] = entity.updatedAt;
//   return data;
// }
//
// extension CourseDataDataCourseLanguageExtension on CourseDataDataCourseLanguage {
//   CourseDataDataCourseLanguage copyWith({
//     int? id,
//     String? name,
//     String? locale,
//     dynamic flag,
//     String? textDirection,
//     int? status,
//     String? createdAt,
//     String? updatedAt,
//   }) {
//     return CourseDataDataCourseLanguage()
//       ..id = id ?? this.id
//       ..name = name ?? this.name
//       ..locale = locale ?? this.locale
//       ..flag = flag ?? this.flag
//       ..textDirection = textDirection ?? this.textDirection
//       ..status = status ?? this.status
//       ..createdAt = createdAt ?? this.createdAt
//       ..updatedAt = updatedAt ?? this.updatedAt;
//   }
// }
//
// CourseDataDataCourseLevel $CourseDataDataCourseLevelFromJson(
//     Map<String, dynamic> json) {
//   final CourseDataDataCourseLevel courseDataDataCourseLevel = CourseDataDataCourseLevel();
//   final int? id = jsonConvert.convert<int>(json['id']);
//   if (id != null) {
//     courseDataDataCourseLevel.id = id;
//   }
//   final String? title = jsonConvert.convert<String>(json['title']);
//   if (title != null) {
//     courseDataDataCourseLevel.title = title;
//   }
//   final int? status = jsonConvert.convert<int>(json['status']);
//   if (status != null) {
//     courseDataDataCourseLevel.status = status;
//   }
//   final String? createdAt = jsonConvert.convert<String>(json['created_at']);
//   if (createdAt != null) {
//     courseDataDataCourseLevel.createdAt = createdAt;
//   }
//   final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
//   if (updatedAt != null) {
//     courseDataDataCourseLevel.updatedAt = updatedAt;
//   }
//   return courseDataDataCourseLevel;
// }
//
// Map<String, dynamic> $CourseDataDataCourseLevelToJson(
//     CourseDataDataCourseLevel entity) {
//   final Map<String, dynamic> data = <String, dynamic>{};
//   data['id'] = entity.id;
//   data['title'] = entity.title;
//   data['status'] = entity.status;
//   data['created_at'] = entity.createdAt;
//   data['updated_at'] = entity.updatedAt;
//   return data;
// }
//
// extension CourseDataDataCourseLevelExtension on CourseDataDataCourseLevel {
//   CourseDataDataCourseLevel copyWith({
//     int? id,
//     String? title,
//     int? status,
//     String? createdAt,
//     String? updatedAt,
//   }) {
//     return CourseDataDataCourseLevel()
//       ..id = id ?? this.id
//       ..title = title ?? this.title
//       ..status = status ?? this.status
//       ..createdAt = createdAt ?? this.createdAt
//       ..updatedAt = updatedAt ?? this.updatedAt;
//   }
// }
//
// CourseDataDataSkills $CourseDataDataSkillsFromJson(Map<String, dynamic> json) {
//   final CourseDataDataSkills courseDataDataSkills = CourseDataDataSkills();
//   final int? id = jsonConvert.convert<int>(json['id']);
//   if (id != null) {
//     courseDataDataSkills.id = id;
//   }
//   final String? title = jsonConvert.convert<String>(json['title']);
//   if (title != null) {
//     courseDataDataSkills.title = title;
//   }
//   final int? status = jsonConvert.convert<int>(json['status']);
//   if (status != null) {
//     courseDataDataSkills.status = status;
//   }
//   final String? createdAt = jsonConvert.convert<String>(json['created_at']);
//   if (createdAt != null) {
//     courseDataDataSkills.createdAt = createdAt;
//   }
//   final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
//   if (updatedAt != null) {
//     courseDataDataSkills.updatedAt = updatedAt;
//   }
//   return courseDataDataSkills;
// }
//
// Map<String, dynamic> $CourseDataDataSkillsToJson(CourseDataDataSkills entity) {
//   final Map<String, dynamic> data = <String, dynamic>{};
//   data['id'] = entity.id;
//   data['title'] = entity.title;
//   data['status'] = entity.status;
//   data['created_at'] = entity.createdAt;
//   data['updated_at'] = entity.updatedAt;
//   return data;
// }
//
// extension CourseDataDataSkillsExtension on CourseDataDataSkills {
//   CourseDataDataSkills copyWith({
//     int? id,
//     String? title,
//     int? status,
//     String? createdAt,
//     String? updatedAt,
//   }) {
//     return CourseDataDataSkills()
//       ..id = id ?? this.id
//       ..title = title ?? this.title
//       ..status = status ?? this.status
//       ..createdAt = createdAt ?? this.createdAt
//       ..updatedAt = updatedAt ?? this.updatedAt;
//   }
// }
//
// CourseDataDataInstructors $CourseDataDataInstructorsFromJson(
//     Map<String, dynamic> json) {
//   final CourseDataDataInstructors courseDataDataInstructors = CourseDataDataInstructors();
//   final int? id = jsonConvert.convert<int>(json['id']);
//   if (id != null) {
//     courseDataDataInstructors.id = id;
//   }
//   final int? userId = jsonConvert.convert<int>(json['user_id']);
//   if (userId != null) {
//     courseDataDataInstructors.userId = userId;
//   }
//   final int? organizationId = jsonConvert.convert<int>(json['organization_id']);
//   if (organizationId != null) {
//     courseDataDataInstructors.organizationId = organizationId;
//   }
//   final String? designation = jsonConvert.convert<String>(json['designation']);
//   if (designation != null) {
//     courseDataDataInstructors.designation = designation;
//   }
//   final String? website = jsonConvert.convert<String>(json['website']);
//   if (website != null) {
//     courseDataDataInstructors.website = website;
//   }
//   final dynamic expertises = json['expertises'];
//   if (expertises != null) {
//     courseDataDataInstructors.expertises = expertises;
//   }
//   final CourseDataDataInstructorsSocialLinks? socialLinks = jsonConvert.convert<
//       CourseDataDataInstructorsSocialLinks>(json['social_links']);
//   if (socialLinks != null) {
//     courseDataDataInstructors.socialLinks = socialLinks;
//   }
//   final String? slug = jsonConvert.convert<String>(json['slug']);
//   if (slug != null) {
//     courseDataDataInstructors.slug = slug;
//   }
//   final int? courseLimit = jsonConvert.convert<int>(json['course_limit']);
//   if (courseLimit != null) {
//     courseDataDataInstructors.courseLimit = courseLimit;
//   }
//   final String? createdAt = jsonConvert.convert<String>(json['created_at']);
//   if (createdAt != null) {
//     courseDataDataInstructors.createdAt = createdAt;
//   }
//   final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
//   if (updatedAt != null) {
//     courseDataDataInstructors.updatedAt = updatedAt;
//   }
//   final CourseDataDataInstructorsUser? user = jsonConvert.convert<
//       CourseDataDataInstructorsUser>(json['user']);
//   if (user != null) {
//     courseDataDataInstructors.user = user;
//   }
//   return courseDataDataInstructors;
// }
//
// Map<String, dynamic> $CourseDataDataInstructorsToJson(
//     CourseDataDataInstructors entity) {
//   final Map<String, dynamic> data = <String, dynamic>{};
//   data['id'] = entity.id;
//   data['user_id'] = entity.userId;
//   data['organization_id'] = entity.organizationId;
//   data['designation'] = entity.designation;
//   data['website'] = entity.website;
//   data['expertises'] = entity.expertises;
//   data['social_links'] = entity.socialLinks.toJson();
//   data['slug'] = entity.slug;
//   data['course_limit'] = entity.courseLimit;
//   data['created_at'] = entity.createdAt;
//   data['updated_at'] = entity.updatedAt;
//   data['user'] = entity.user.toJson();
//   return data;
// }
//
// extension CourseDataDataInstructorsExtension on CourseDataDataInstructors {
//   CourseDataDataInstructors copyWith({
//     int? id,
//     int? userId,
//     int? organizationId,
//     String? designation,
//     String? website,
//     dynamic expertises,
//     CourseDataDataInstructorsSocialLinks? socialLinks,
//     String? slug,
//     int? courseLimit,
//     String? createdAt,
//     String? updatedAt,
//     CourseDataDataInstructorsUser? user,
//   }) {
//     return CourseDataDataInstructors()
//       ..id = id ?? this.id
//       ..userId = userId ?? this.userId
//       ..organizationId = organizationId ?? this.organizationId
//       ..designation = designation ?? this.designation
//       ..website = website ?? this.website
//       ..expertises = expertises ?? this.expertises
//       ..socialLinks = socialLinks ?? this.socialLinks
//       ..slug = slug ?? this.slug
//       ..courseLimit = courseLimit ?? this.courseLimit
//       ..createdAt = createdAt ?? this.createdAt
//       ..updatedAt = updatedAt ?? this.updatedAt
//       ..user = user ?? this.user;
//   }
// }
//
// CourseDataDataInstructorsSocialLinks $CourseDataDataInstructorsSocialLinksFromJson(
//     Map<String, dynamic> json) {
//   final CourseDataDataInstructorsSocialLinks courseDataDataInstructorsSocialLinks = CourseDataDataInstructorsSocialLinks();
//   final String? facebook = jsonConvert.convert<String>(json['facebook']);
//   if (facebook != null) {
//     courseDataDataInstructorsSocialLinks.facebook = facebook;
//   }
//   final String? twitter = jsonConvert.convert<String>(json['twitter']);
//   if (twitter != null) {
//     courseDataDataInstructorsSocialLinks.twitter = twitter;
//   }
//   final String? instagram = jsonConvert.convert<String>(json['instagram']);
//   if (instagram != null) {
//     courseDataDataInstructorsSocialLinks.instagram = instagram;
//   }
//   final String? linkedin = jsonConvert.convert<String>(json['linkedin']);
//   if (linkedin != null) {
//     courseDataDataInstructorsSocialLinks.linkedin = linkedin;
//   }
//   final String? youtube = jsonConvert.convert<String>(json['youtube']);
//   if (youtube != null) {
//     courseDataDataInstructorsSocialLinks.youtube = youtube;
//   }
//   return courseDataDataInstructorsSocialLinks;
// }
//
// Map<String, dynamic> $CourseDataDataInstructorsSocialLinksToJson(
//     CourseDataDataInstructorsSocialLinks entity) {
//   final Map<String, dynamic> data = <String, dynamic>{};
//   data['facebook'] = entity.facebook;
//   data['twitter'] = entity.twitter;
//   data['instagram'] = entity.instagram;
//   data['linkedin'] = entity.linkedin;
//   data['youtube'] = entity.youtube;
//   return data;
// }
//
// extension CourseDataDataInstructorsSocialLinksExtension on CourseDataDataInstructorsSocialLinks {
//   CourseDataDataInstructorsSocialLinks copyWith({
//     String? facebook,
//     String? twitter,
//     String? instagram,
//     String? linkedin,
//     String? youtube,
//   }) {
//     return CourseDataDataInstructorsSocialLinks()
//       ..facebook = facebook ?? this.facebook
//       ..twitter = twitter ?? this.twitter
//       ..instagram = instagram ?? this.instagram
//       ..linkedin = linkedin ?? this.linkedin
//       ..youtube = youtube ?? this.youtube;
//   }
// }
//
// CourseDataDataInstructorsUser $CourseDataDataInstructorsUserFromJson(
//     Map<String, dynamic> json) {
//   final CourseDataDataInstructorsUser courseDataDataInstructorsUser = CourseDataDataInstructorsUser();
//   final int? id = jsonConvert.convert<int>(json['id']);
//   if (id != null) {
//     courseDataDataInstructorsUser.id = id;
//   }
//   final String? deviceToken = jsonConvert.convert<String>(json['device_token']);
//   if (deviceToken != null) {
//     courseDataDataInstructorsUser.deviceToken = deviceToken;
//   }
//   final String? firstName = jsonConvert.convert<String>(json['first_name']);
//   if (firstName != null) {
//     courseDataDataInstructorsUser.firstName = firstName;
//   }
//   final String? lastName = jsonConvert.convert<String>(json['last_name']);
//   if (lastName != null) {
//     courseDataDataInstructorsUser.lastName = lastName;
//   }
//   final String? email = jsonConvert.convert<String>(json['email']);
//   if (email != null) {
//     courseDataDataInstructorsUser.email = email;
//   }
//   final String? emailVerifiedAt = jsonConvert.convert<String>(
//       json['email_verified_at']);
//   if (emailVerifiedAt != null) {
//     courseDataDataInstructorsUser.emailVerifiedAt = emailVerifiedAt;
//   }
//   final int? phoneCountryId = jsonConvert.convert<int>(
//       json['phone_country_id']);
//   if (phoneCountryId != null) {
//     courseDataDataInstructorsUser.phoneCountryId = phoneCountryId;
//   }
//   final String? phone = jsonConvert.convert<String>(json['phone']);
//   if (phone != null) {
//     courseDataDataInstructorsUser.phone = phone;
//   }
//   final List<dynamic>? permissions = (json['permissions'] as List<dynamic>?)
//       ?.map(
//           (e) => e)
//       .toList();
//   if (permissions != null) {
//     courseDataDataInstructorsUser.permissions = permissions;
//   }
//   final String? userType = jsonConvert.convert<String>(json['user_type']);
//   if (userType != null) {
//     courseDataDataInstructorsUser.userType = userType;
//   }
//   final dynamic firebaseAuthId = json['firebase_auth_id'];
//   if (firebaseAuthId != null) {
//     courseDataDataInstructorsUser.firebaseAuthId = firebaseAuthId;
//   }
//   final dynamic languageId = json['language_id'];
//   if (languageId != null) {
//     courseDataDataInstructorsUser.languageId = languageId;
//   }
//   final dynamic currencyId = json['currency_id'];
//   if (currencyId != null) {
//     courseDataDataInstructorsUser.currencyId = currencyId;
//   }
//   final int? status = jsonConvert.convert<int>(json['status']);
//   if (status != null) {
//     courseDataDataInstructorsUser.status = status;
//   }
//   final dynamic images = json['images'];
//   if (images != null) {
//     courseDataDataInstructorsUser.images = images;
//   }
//   final dynamic lastLogin = json['last_login'];
//   if (lastLogin != null) {
//     courseDataDataInstructorsUser.lastLogin = lastLogin;
//   }
//   final dynamic lastPasswordChange = json['last_password_change'];
//   if (lastPasswordChange != null) {
//     courseDataDataInstructorsUser.lastPasswordChange = lastPasswordChange;
//   }
//   final int? isUserBanned = jsonConvert.convert<int>(json['is_user_banned']);
//   if (isUserBanned != null) {
//     courseDataDataInstructorsUser.isUserBanned = isUserBanned;
//   }
//   final int? isDeleted = jsonConvert.convert<int>(json['is_deleted']);
//   if (isDeleted != null) {
//     courseDataDataInstructorsUser.isDeleted = isDeleted;
//   }
//   final int? roleId = jsonConvert.convert<int>(json['role_id']);
//   if (roleId != null) {
//     courseDataDataInstructorsUser.roleId = roleId;
//   }
//   final String? address = jsonConvert.convert<String>(json['address']);
//   if (address != null) {
//     courseDataDataInstructorsUser.address = address;
//   }
//   final dynamic postalCode = json['postal_code'];
//   if (postalCode != null) {
//     courseDataDataInstructorsUser.postalCode = postalCode;
//   }
//   final dynamic countryId = json['country_id'];
//   if (countryId != null) {
//     courseDataDataInstructorsUser.countryId = countryId;
//   }
//   final dynamic stateId = json['state_id'];
//   if (stateId != null) {
//     courseDataDataInstructorsUser.stateId = stateId;
//   }
//   final dynamic cityId = json['city_id'];
//   if (cityId != null) {
//     courseDataDataInstructorsUser.cityId = cityId;
//   }
//   final dynamic gender = json['gender'];
//   if (gender != null) {
//     courseDataDataInstructorsUser.gender = gender;
//   }
//   final dynamic dateOfBirth = json['date_of_birth'];
//   if (dateOfBirth != null) {
//     courseDataDataInstructorsUser.dateOfBirth = dateOfBirth;
//   }
//   final String? about = jsonConvert.convert<String>(json['about']);
//   if (about != null) {
//     courseDataDataInstructorsUser.about = about;
//   }
//   final int? isNewsletterEnabled = jsonConvert.convert<int>(
//       json['is_newsletter_enabled']);
//   if (isNewsletterEnabled != null) {
//     courseDataDataInstructorsUser.isNewsletterEnabled = isNewsletterEnabled;
//   }
//   final int? isNotificationEnabled = jsonConvert.convert<int>(
//       json['is_notification_enabled']);
//   if (isNotificationEnabled != null) {
//     courseDataDataInstructorsUser.isNotificationEnabled = isNotificationEnabled;
//   }
//   final int? balance = jsonConvert.convert<int>(json['balance']);
//   if (balance != null) {
//     courseDataDataInstructorsUser.balance = balance;
//   }
//   final dynamic otp = json['otp'];
//   if (otp != null) {
//     courseDataDataInstructorsUser.otp = otp;
//   }
//   final dynamic onesignalPlayerId = json['onesignal_player_id'];
//   if (onesignalPlayerId != null) {
//     courseDataDataInstructorsUser.onesignalPlayerId = onesignalPlayerId;
//   }
//   final int? isOnesignalSubscribed = jsonConvert.convert<int>(
//       json['is_onesignal_subscribed']);
//   if (isOnesignalSubscribed != null) {
//     courseDataDataInstructorsUser.isOnesignalSubscribed = isOnesignalSubscribed;
//   }
//   final String? createdAt = jsonConvert.convert<String>(json['created_at']);
//   if (createdAt != null) {
//     courseDataDataInstructorsUser.createdAt = createdAt;
//   }
//   final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
//   if (updatedAt != null) {
//     courseDataDataInstructorsUser.updatedAt = updatedAt;
//   }
//   return courseDataDataInstructorsUser;
// }
//
// Map<String, dynamic> $CourseDataDataInstructorsUserToJson(
//     CourseDataDataInstructorsUser entity) {
//   final Map<String, dynamic> data = <String, dynamic>{};
//   data['id'] = entity.id;
//   data['device_token'] = entity.deviceToken;
//   data['first_name'] = entity.firstName;
//   data['last_name'] = entity.lastName;
//   data['email'] = entity.email;
//   data['email_verified_at'] = entity.emailVerifiedAt;
//   data['phone_country_id'] = entity.phoneCountryId;
//   data['phone'] = entity.phone;
//   data['permissions'] = entity.permissions;
//   data['user_type'] = entity.userType;
//   data['firebase_auth_id'] = entity.firebaseAuthId;
//   data['language_id'] = entity.languageId;
//   data['currency_id'] = entity.currencyId;
//   data['status'] = entity.status;
//   data['images'] = entity.images;
//   data['last_login'] = entity.lastLogin;
//   data['last_password_change'] = entity.lastPasswordChange;
//   data['is_user_banned'] = entity.isUserBanned;
//   data['is_deleted'] = entity.isDeleted;
//   data['role_id'] = entity.roleId;
//   data['address'] = entity.address;
//   data['postal_code'] = entity.postalCode;
//   data['country_id'] = entity.countryId;
//   data['state_id'] = entity.stateId;
//   data['city_id'] = entity.cityId;
//   data['gender'] = entity.gender;
//   data['date_of_birth'] = entity.dateOfBirth;
//   data['about'] = entity.about;
//   data['is_newsletter_enabled'] = entity.isNewsletterEnabled;
//   data['is_notification_enabled'] = entity.isNotificationEnabled;
//   data['balance'] = entity.balance;
//   data['otp'] = entity.otp;
//   data['onesignal_player_id'] = entity.onesignalPlayerId;
//   data['is_onesignal_subscribed'] = entity.isOnesignalSubscribed;
//   data['created_at'] = entity.createdAt;
//   data['updated_at'] = entity.updatedAt;
//   return data;
// }
//
// extension CourseDataDataInstructorsUserExtension on CourseDataDataInstructorsUser {
//   CourseDataDataInstructorsUser copyWith({
//     int? id,
//     String? deviceToken,
//     String? firstName,
//     String? lastName,
//     String? email,
//     String? emailVerifiedAt,
//     int? phoneCountryId,
//     String? phone,
//     List<dynamic>? permissions,
//     String? userType,
//     dynamic firebaseAuthId,
//     dynamic languageId,
//     dynamic currencyId,
//     int? status,
//     dynamic images,
//     dynamic lastLogin,
//     dynamic lastPasswordChange,
//     int? isUserBanned,
//     int? isDeleted,
//     int? roleId,
//     String? address,
//     dynamic postalCode,
//     dynamic countryId,
//     dynamic stateId,
//     dynamic cityId,
//     dynamic gender,
//     dynamic dateOfBirth,
//     String? about,
//     int? isNewsletterEnabled,
//     int? isNotificationEnabled,
//     int? balance,
//     dynamic otp,
//     dynamic onesignalPlayerId,
//     int? isOnesignalSubscribed,
//     String? createdAt,
//     String? updatedAt,
//   }) {
//     return CourseDataDataInstructorsUser()
//       ..id = id ?? this.id
//       ..deviceToken = deviceToken ?? this.deviceToken
//       ..firstName = firstName ?? this.firstName
//       ..lastName = lastName ?? this.lastName
//       ..email = email ?? this.email
//       ..emailVerifiedAt = emailVerifiedAt ?? this.emailVerifiedAt
//       ..phoneCountryId = phoneCountryId ?? this.phoneCountryId
//       ..phone = phone ?? this.phone
//       ..permissions = permissions ?? this.permissions
//       ..userType = userType ?? this.userType
//       ..firebaseAuthId = firebaseAuthId ?? this.firebaseAuthId
//       ..languageId = languageId ?? this.languageId
//       ..currencyId = currencyId ?? this.currencyId
//       ..status = status ?? this.status
//       ..images = images ?? this.images
//       ..lastLogin = lastLogin ?? this.lastLogin
//       ..lastPasswordChange = lastPasswordChange ?? this.lastPasswordChange
//       ..isUserBanned = isUserBanned ?? this.isUserBanned
//       ..isDeleted = isDeleted ?? this.isDeleted
//       ..roleId = roleId ?? this.roleId
//       ..address = address ?? this.address
//       ..postalCode = postalCode ?? this.postalCode
//       ..countryId = countryId ?? this.countryId
//       ..stateId = stateId ?? this.stateId
//       ..cityId = cityId ?? this.cityId
//       ..gender = gender ?? this.gender
//       ..dateOfBirth = dateOfBirth ?? this.dateOfBirth
//       ..about = about ?? this.about
//       ..isNewsletterEnabled = isNewsletterEnabled ?? this.isNewsletterEnabled
//       ..isNotificationEnabled = isNotificationEnabled ??
//           this.isNotificationEnabled
//       ..balance = balance ?? this.balance
//       ..otp = otp ?? this.otp
//       ..onesignalPlayerId = onesignalPlayerId ?? this.onesignalPlayerId
//       ..isOnesignalSubscribed = isOnesignalSubscribed ??
//           this.isOnesignalSubscribed
//       ..createdAt = createdAt ?? this.createdAt
//       ..updatedAt = updatedAt ?? this.updatedAt;
//   }
// }
//
// CourseDataDataSylabus $CourseDataDataSylabusFromJson(
//     Map<String, dynamic> json) {
//   final CourseDataDataSylabus courseDataDataSylabus = CourseDataDataSylabus();
//   final int? id = jsonConvert.convert<int>(json['id']);
//   if (id != null) {
//     courseDataDataSylabus.id = id;
//   }
//   final String? title = jsonConvert.convert<String>(json['title']);
//   if (title != null) {
//     courseDataDataSylabus.title = title;
//   }
//   final int? courseId = jsonConvert.convert<int>(json['course_id']);
//   if (courseId != null) {
//     courseDataDataSylabus.courseId = courseId;
//   }
//   final int? orderNo = jsonConvert.convert<int>(json['order_no']);
//   if (orderNo != null) {
//     courseDataDataSylabus.orderNo = orderNo;
//   }
//   final int? status = jsonConvert.convert<int>(json['status']);
//   if (status != null) {
//     courseDataDataSylabus.status = status;
//   }
//   final String? createdAt = jsonConvert.convert<String>(json['created_at']);
//   if (createdAt != null) {
//     courseDataDataSylabus.createdAt = createdAt;
//   }
//   final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
//   if (updatedAt != null) {
//     courseDataDataSylabus.updatedAt = updatedAt;
//   }
//   return courseDataDataSylabus;
// }
//
// Map<String, dynamic> $CourseDataDataSylabusToJson(
//     CourseDataDataSylabus entity) {
//   final Map<String, dynamic> data = <String, dynamic>{};
//   data['id'] = entity.id;
//   data['title'] = entity.title;
//   data['course_id'] = entity.courseId;
//   data['order_no'] = entity.orderNo;
//   data['status'] = entity.status;
//   data['created_at'] = entity.createdAt;
//   data['updated_at'] = entity.updatedAt;
//   return data;
// }
//
// extension CourseDataDataSylabusExtension on CourseDataDataSylabus {
//   CourseDataDataSylabus copyWith({
//     int? id,
//     String? title,
//     int? courseId,
//     int? orderNo,
//     int? status,
//     String? createdAt,
//     String? updatedAt,
//   }) {
//     return CourseDataDataSylabus()
//       ..id = id ?? this.id
//       ..title = title ?? this.title
//       ..courseId = courseId ?? this.courseId
//       ..orderNo = orderNo ?? this.orderNo
//       ..status = status ?? this.status
//       ..createdAt = createdAt ?? this.createdAt
//       ..updatedAt = updatedAt ?? this.updatedAt;
//   }
// }
