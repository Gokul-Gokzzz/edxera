import 'dart:convert';

class CategoriesModel {
  bool? success;
  String? message;
  Data? data;

  CategoriesModel({
    this.success,
    this.message,
    this.data,
  });

  CategoriesModel copyWith({
    bool? success,
    String? message,
    Data? data,
  }) =>
      CategoriesModel(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory CategoriesModel.fromJson(String str) => CategoriesModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoriesModel.fromMap(Map<String, dynamic> json) => CategoriesModel(
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
  List<Category>? categories;

  Data({
    this.categories,
  });

  Data copyWith({
    List<Category>? categories,
  }) =>
      Data(
        categories: categories ?? this.categories,
      );

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toMap())),
      };
}

class Category {
  int? id;
  String? title;
  String? slug;
  int? parentId;
  dynamic icon;
  dynamic image;
  String? imageMediaId;
  dynamic position;
  int? ordering;
  int? isFeatured;
  int? totalCourses;
  String? metaTitle;
  String? metaKeywords;
  String? metaDescription;
  dynamic metaImage;
  int? status;
  String? type;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Category>? subCategories;
  int? activeCoursesCount;

  Category({
    this.id,
    this.title,
    this.slug,
    this.parentId,
    this.icon,
    this.image,
    this.imageMediaId,
    this.position,
    this.ordering,
    this.isFeatured,
    this.totalCourses,
    this.metaTitle,
    this.metaKeywords,
    this.metaDescription,
    this.metaImage,
    this.status,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.subCategories,
    this.activeCoursesCount,
  });

  Category copyWith({
    int? id,
    String? title,
    String? slug,
    int? parentId,
    dynamic icon,
    dynamic image,
    String? imageMediaId,
    dynamic position,
    int? ordering,
    int? isFeatured,
    int? totalCourses,
    String? metaTitle,
    String? metaKeywords,
    String? metaDescription,
    dynamic metaImage,
    int? status,
    String? type,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<Category>? subCategories,
    int? activeCoursesCount,
  }) =>
      Category(
        id: id ?? this.id,
        title: title ?? this.title,
        slug: slug ?? this.slug,
        parentId: parentId ?? this.parentId,
        icon: icon ?? this.icon,
        image: image ?? this.image,
        imageMediaId: imageMediaId ?? this.imageMediaId,
        position: position ?? this.position,
        ordering: ordering ?? this.ordering,
        isFeatured: isFeatured ?? this.isFeatured,
        totalCourses: totalCourses ?? this.totalCourses,
        metaTitle: metaTitle ?? this.metaTitle,
        metaKeywords: metaKeywords ?? this.metaKeywords,
        metaDescription: metaDescription ?? this.metaDescription,
        metaImage: metaImage ?? this.metaImage,
        status: status ?? this.status,
        type: type ?? this.type,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        subCategories: subCategories ?? this.subCategories,
        activeCoursesCount: activeCoursesCount ?? this.activeCoursesCount,
      );

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        id: json["id"],
        title: json["title"],
        slug: json["slug"],
        parentId: json["parent_id"],
        icon: json["icon"],
        image: json["image"],
        imageMediaId: json["image_media_id"],
        position: json["position"],
        ordering: json["ordering"],
        isFeatured: json["is_featured"],
        totalCourses: json["total_courses"],
        metaTitle: json["meta_title"],
        metaKeywords: json["meta_keywords"],
        metaDescription: json["meta_description"],
        metaImage: json["meta_image"],
        status: json["status"],
        type: json["type"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        subCategories: json["sub_categories"] == null ? [] : List<Category>.from(json["sub_categories"]!.map((x) => Category.fromMap(x))),
        activeCoursesCount: json["active_courses_count"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "slug": slug,
        "parent_id": parentId,
        "icon": icon,
        "image": image,
        "image_media_id": imageMediaId,
        "position": position,
        "ordering": ordering,
        "is_featured": isFeatured,
        "total_courses": totalCourses,
        "meta_title": metaTitle,
        "meta_keywords": metaKeywords,
        "meta_description": metaDescription,
        "meta_image": metaImage,
        "status": status,
        "type": type,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "sub_categories": subCategories == null ? [] : List<dynamic>.from(subCategories!.map((x) => x.toMap())),
        "active_courses_count": activeCoursesCount,
      };
}
