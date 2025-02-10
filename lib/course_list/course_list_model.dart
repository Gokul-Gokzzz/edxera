// import 'dart:convert';

// CourseListModel CourseListModelFromJson(String str) =>
//     CourseListModel.fromJson(json.decode(str));

// String CourseListModelToJson(CourseListModel data) =>
//     json.encode(data.toJson());

// class CourseListModel {
//   bool? success;
//   String? message;
//   List<Datum>? data;

//   CourseListModel({
//     this.success,
//     this.message,
//     this.data,
//   });

//   factory CourseListModel.fromJson(Map<String, dynamic> json) =>
//       CourseListModel(
//         success: json["success"],
//         message: json["message"],
//         data: json["data"] == null
//             ? []
//             : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "success": success,
//         "message": message,
//         "data": data == null
//             ? []
//             : List<dynamic>.from(data!.map((x) => x.toJson())),
//       };
// }

// class Datum {
//   int? id;
//   int? isShow;
//   String? courseThumbnail;
//   int? chapterCount;
//   String? title;
//   String? slug;
//   String? shortDescription;
//   int? userId;
//   List<String>? instructorIds;
//   int? categoryId;
//   String? courseType;
//   dynamic capacity;
//   dynamic classEndsAt;
//   int? languageId;
//   dynamic organizationId;
//   String? description;
//   int? isPrivate;
//   String? videoSource;
//   Video? video;
//   int? imageMediaId;
//   Image? image;
//   String? duration;
//   int? isDownloadable;
//   int? isFree;
//   int? price;
//   int? isDiscountable;
//   String? discountType;
//   int? discount;
//   DateTime? discountStartAt;
//   DateTime? discountEndAt;
//   int? isFeatured;
//   dynamic deletedAt;
//   List<String>? tags;
//   int? levelId;
//   dynamic subjectId;
//   int? isRenewable;
//   String? renewAfter;
//   String? metaTitle;
//   String? metaKeywords;
//   String? metaDescription;
//   Image? metaImage;
//   int? totalLesson;
//   int? totalEnrolled;
//   int? totalRating;
//   int? isPublished;
//   String? status;
//   // int? courseLikeCount;
//   // int? courseViewCount;
//   int? courseCommentCount;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   int? isLiked;

//   Datum({
//     this.id,
//     this.isShow,
//     this.courseThumbnail,
//     this.chapterCount,
//     this.title,
//     this.slug,
//     this.shortDescription,
//     this.userId,
//     this.instructorIds,
//     this.categoryId,
//     this.courseType,
//     this.capacity,
//     this.classEndsAt,
//     this.languageId,
//     this.organizationId,
//     this.description,
//     this.isPrivate,
//     this.videoSource,
//     this.video,
//     this.imageMediaId,
//     this.image,
//     this.duration,
//     this.isDownloadable,
//     this.isFree,
//     this.price,
//     this.isDiscountable,
//     this.discountType,
//     this.discount,
//     this.discountStartAt,
//     this.discountEndAt,
//     this.isFeatured,
//     this.deletedAt,
//     this.tags,
//     this.levelId,
//     this.subjectId,
//     this.isRenewable,
//     this.renewAfter,
//     this.metaTitle,
//     this.metaKeywords,
//     this.metaDescription,
//     this.metaImage,
//     this.totalLesson,
//     this.totalEnrolled,
//     this.totalRating,
//     this.isPublished,
//     this.status,
//     // this.courseLikeCount,
//     // this.courseViewCount,
//     this.courseCommentCount,
//     this.createdAt,
//     this.updatedAt,
//     this.isLiked,
//   });

//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         id: json["id"],
//         isShow: json["is_show"],
//         courseThumbnail: json["course_thumbnail"],
//         chapterCount: json["chapter_count"],
//         title: json["title"],
//         slug: json["slug"],
//         shortDescription: json["short_description"],
//         userId: json["user_id"],
//         instructorIds: json["instructor_ids"] == null
//             ? []
//             : List<String>.from(json["instructor_ids"]!.map((x) => x)),
//         categoryId: json["category_id"],
//         courseType: json["course_type"],
//         capacity: json["capacity"],
//         classEndsAt: json["class_ends_at"],
//         languageId: json["language_id"],
//         organizationId: json["organization_id"],
//         description: json["description"],
//         isPrivate: json["is_private"],
//         videoSource: json["video_source"],
//         video: json["video"] == null ? null : Video.fromJson(json["video"]),
//         imageMediaId: json["image_media_id"],
//         image: json["image"] == null ? null : Image.fromJson(json["image"]),
//         duration: json["duration"],
//         isDownloadable: json["is_downloadable"],
//         isFree: json["is_free"],
//         price: json["price"],
//         isDiscountable: json["is_discountable"],
//         discountType: json["discount_type"],
//         discount: json["discount"],
//         discountStartAt: json["discount_start_at"] == null
//             ? null
//             : DateTime.parse(json["discount_start_at"]),
//         discountEndAt: json["discount_end_at"] == null
//             ? null
//             : DateTime.parse(json["discount_end_at"]),
//         isFeatured: json["is_featured"],
//         deletedAt: json["deleted_at"],
//         tags: json["tags"] == null
//             ? []
//             : List<String>.from(json["tags"]!.map((x) => x)),
//         levelId: json["level_id"],
//         subjectId: json["subject_id"],
//         isRenewable: json["is_renewable"],
//         renewAfter: json["renew_after"],
//         metaTitle: json["meta_title"],
//         metaKeywords: json["meta_keywords"],
//         metaDescription: json["meta_description"],
//         metaImage: json["meta_image"] == null
//             ? null
//             : Image.fromJson(json["meta_image"]),
//         totalLesson: json["total_lesson"],
//         totalEnrolled: json["total_enrolled"],
//         totalRating: json["total_rating"],
//         isPublished: json["is_published"],
//         status: json["status"],
//         // courseLikeCount: json["course_like_count"],
//         // courseViewCount: json["course_view_count"],
//         courseCommentCount: json["course_comment_count"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//         isLiked: json["is_liked"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "is_show": isShow,
//         "course_thumbnail": courseThumbnail,
//         "chapter_count": chapterCount,
//         "title": title,
//         "slug": slug,
//         "short_description": shortDescription,
//         "user_id": userId,
//         "instructor_ids": instructorIds == null
//             ? []
//             : List<dynamic>.from(instructorIds!.map((x) => x)),
//         "category_id": categoryId,
//         "course_type": courseType,
//         "capacity": capacity,
//         "class_ends_at": classEndsAt,
//         "language_id": languageId,
//         "organization_id": organizationId,
//         "description": description,
//         "is_private": isPrivate,
//         "video_source": videoSource,
//         "video": video?.toJson(),
//         "image_media_id": imageMediaId,
//         "image": image?.toJson(),
//         "duration": duration,
//         "is_downloadable": isDownloadable,
//         "is_free": isFree,
//         "price": price,
//         "is_discountable": isDiscountable,
//         "discount_type": discountType,
//         "discount": discount,
//         "discount_start_at": discountStartAt?.toIso8601String(),
//         "discount_end_at": discountEndAt?.toIso8601String(),
//         "is_featured": isFeatured,
//         "deleted_at": deletedAt,
//         "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
//         "level_id": levelId,
//         "subject_id": subjectId,
//         "is_renewable": isRenewable,
//         "renew_after": renewAfter,
//         "meta_title": metaTitle,
//         "meta_keywords": metaKeywords,
//         "meta_description": metaDescription,
//         "meta_image": metaImage?.toJson(),
//         "total_lesson": totalLesson,
//         "total_enrolled": totalEnrolled,
//         "total_rating": totalRating,
//         "is_published": isPublished,
//         "status": status,
//         // "course_like_count": courseLikeCount,
//         // "course_view_count": courseViewCount,
//         "course_comment_count": courseCommentCount,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "is_liked": isLiked,
//       };
// }

// class Image {
//   Storage? storage;
//   String? originalImage;
//   String? image40X40;
//   String? image80X80;
//   String? image68X48;
//   String? image190X230;
//   String? image163X116;
//   String? image295X248;
//   String? image417X384;
//   String? imageThumbnail;
//   String? image402X248;
//   String? image1200X630;
//   String? image305X150;

//   Image({
//     this.storage,
//     this.originalImage,
//     this.image40X40,
//     this.image80X80,
//     this.image68X48,
//     this.image190X230,
//     this.image163X116,
//     this.image295X248,
//     this.image417X384,
//     this.imageThumbnail,
//     this.image402X248,
//     this.image1200X630,
//     this.image305X150,
//   });

//   factory Image.fromJson(Map<String, dynamic> json) => Image(
//         storage: storageValues.map[json["storage"]]!,
//         originalImage: json["original_image"],
//         image40X40: json["image_40x40"],
//         image80X80: json["image_80x80"],
//         image68X48: json["image_68x48"],
//         image190X230: json["image_190x230"],
//         image163X116: json["image_163x116"],
//         image295X248: json["image_295x248"],
//         image417X384: json["image_417x384"],
//         imageThumbnail: json["image_thumbnail"],
//         image402X248: json["image_402x248"],
//         image1200X630: json["image_1200x630"],
//         image305X150: json["image_305x150"],
//       );

//   Map<String, dynamic> toJson() => {
//         "storage": storageValues.reverse[storage],
//         "original_image": originalImage,
//         "image_40x40": image40X40,
//         "image_80x80": image80X80,
//         "image_68x48": image68X48,
//         "image_190x230": image190X230,
//         "image_163x116": image163X116,
//         "image_295x248": image295X248,
//         "image_417x384": image417X384,
//         "image_thumbnail": imageThumbnail,
//         "image_402x248": image402X248,
//         "image_1200x630": image1200X630,
//         "image_305x150": image305X150,
//       };
// }

// enum Storage { LOCAL }

// final storageValues = EnumValues({"local": Storage.LOCAL});

// class Video {
//   Storage? storage;
//   String? image;

//   Video({
//     this.storage,
//     this.image,
//   });

//   factory Video.fromJson(Map<String, dynamic> json) => Video(
//         storage: storageValues.map[json["storage"]]!,
//         image: json["image"],
//       );

//   Map<String, dynamic> toJson() => {
//         "storage": storageValues.reverse[storage],
//         "image": image,
//       };
// }

// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }

class CourseListModel {
  final int id;
  final String title;
  final String duration;
  final String shortDescription;
  final String courseThumbnail;
  final int chapterCount;
  final int price;

  CourseListModel({
    required this.id,
    required this.title,
    required this.duration,
    required this.shortDescription,
    required this.courseThumbnail,
    required this.chapterCount,
    required this.price,
  });

  factory CourseListModel.fromJson(Map<String, dynamic> json) {
    return CourseListModel(
      id: json['id'],
      title: json['title'],
      shortDescription: json['short_description'],
      courseThumbnail: json['course_thumbnail'],
      chapterCount: json['chapter_count'],
      price: json['price'],
      duration: json['duration'],
    );
  }
}
