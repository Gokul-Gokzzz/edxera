import 'dart:convert';

class CourseDataEntity {
  bool? success;
  String? message;
  Data? data;

  CourseDataEntity({
    this.success,
    this.message,
    this.data,
  });

  CourseDataEntity copyWith({
    bool? success,
    String? message,
    Data? data,
  }) =>
      CourseDataEntity(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  String toJson() => json.encode(toMap());

  factory CourseDataEntity.fromJson(Map<String, dynamic> json) => CourseDataEntity(
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
  int? coursePurchasedStatus;
  int? totalChapterCount;
  Course? course;
  List<Review>? reviews;
  List<Skill>? skills;
  List<Instructor>? instructors;

  Data({
    this.coursePurchasedStatus,
    this.totalChapterCount,
    this.course,
    this.reviews,
    this.skills,
    this.instructors,
  });

  Data copyWith({
    int? coursePurchasedStatus,
    int? totalChapterCount,
    Course? course,
    List<Review>? reviews,
    List<Skill>? skills,
    List<Instructor>? instructors,
  }) =>
      Data(
        coursePurchasedStatus: coursePurchasedStatus ?? this.coursePurchasedStatus,
        totalChapterCount: totalChapterCount ?? this.totalChapterCount,
        course: course ?? this.course,
        reviews: reviews ?? this.reviews,
        skills: skills ?? this.skills,
        instructors: instructors ?? this.instructors,
      );

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        coursePurchasedStatus: json["course_purchased_status"],
        totalChapterCount: json["total_chapter_count"],
        course: json["Course"] == null ? null : Course.fromMap(json["Course"]),
        reviews: json["reviews"] == null ? [] : List<Review>.from(json["reviews"]!.map((x) => Review.fromMap(x))),
        skills: json["skills"] == null ? [] : List<Skill>.from(json["skills"]!.map((x) => Skill.fromMap(x))),
        instructors: json["instructors"] == null ? [] : List<Instructor>.from(json["instructors"]!.map((x) => Instructor.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "course_purchased_status": coursePurchasedStatus,
        "total_chapter_count": totalChapterCount,
        "Course": course?.toMap(),
        "reviews": reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x.toMap())),
        "skills": skills == null ? [] : List<dynamic>.from(skills!.map((x) => x.toMap())),
        "instructors": instructors == null ? [] : List<dynamic>.from(instructors!.map((x) => x.toMap())),
      };
}

class Course {
  int? id;
  String? courseThumbnail;
  int? chapterCount;
  String? title;
  String? slug;
  String? shortDescription;
  int? userId;
  List<String>? instructorIds;
  int? categoryId;
  String? courseType;
  dynamic capacity;
  dynamic classEndsAt;
  int? languageId;
  dynamic organizationId;
  String? description;
  int? isPrivate;
  String? videoSource;
  dynamic video;
  int? imageMediaId;
  CourseImage? image;
  String? duration;
  int? isDownloadable;
  int? isFree;
  int? price;
  int? isDiscountable;
  String? discountType;
  int? discount;
  DateTime? discountStartAt;
  DateTime? discountEndAt;
  int? isFeatured;
  dynamic deletedAt;
  List<String>? tags;
  int? levelId;
  dynamic subjectId;
  int? isRenewable;
  String? renewAfter;
  String? metaTitle;
  String? metaKeywords;
  String? metaDescription;
  CourseImage? metaImage;
  int? totalLesson;
  int? totalEnrolled;
  int? totalRating;
  int? isPublished;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  Language? language;
  Skill? level;

  Course({
    this.id,
    this.courseThumbnail,
    this.chapterCount,
    this.title,
    this.slug,
    this.shortDescription,
    this.userId,
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
    this.status,
    this.createdAt,
    this.updatedAt,
    this.language,
    this.level,
  });

  Course copyWith({
    int? id,
    String? courseThumbnail,
    int? chapterCount,
    String? title,
    String? slug,
    String? shortDescription,
    int? userId,
    List<String>? instructorIds,
    int? categoryId,
    String? courseType,
    dynamic capacity,
    dynamic classEndsAt,
    int? languageId,
    dynamic organizationId,
    String? description,
    int? isPrivate,
    String? videoSource,
    dynamic video,
    int? imageMediaId,
    CourseImage? image,
    String? duration,
    int? isDownloadable,
    int? isFree,
    int? price,
    int? isDiscountable,
    String? discountType,
    int? discount,
    DateTime? discountStartAt,
    DateTime? discountEndAt,
    int? isFeatured,
    dynamic deletedAt,
    List<String>? tags,
    int? levelId,
    dynamic subjectId,
    int? isRenewable,
    String? renewAfter,
    String? metaTitle,
    String? metaKeywords,
    String? metaDescription,
    CourseImage? metaImage,
    int? totalLesson,
    int? totalEnrolled,
    int? totalRating,
    int? isPublished,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    Language? language,
    Skill? level,
  }) =>
      Course(
        id: id ?? this.id,
        courseThumbnail: courseThumbnail ?? this.courseThumbnail,
        chapterCount: chapterCount ?? this.chapterCount,
        title: title ?? this.title,
        slug: slug ?? this.slug,
        shortDescription: shortDescription ?? this.shortDescription,
        userId: userId ?? this.userId,
        instructorIds: instructorIds ?? this.instructorIds,
        categoryId: categoryId ?? this.categoryId,
        courseType: courseType ?? this.courseType,
        capacity: capacity ?? this.capacity,
        classEndsAt: classEndsAt ?? this.classEndsAt,
        languageId: languageId ?? this.languageId,
        organizationId: organizationId ?? this.organizationId,
        description: description ?? this.description,
        isPrivate: isPrivate ?? this.isPrivate,
        videoSource: videoSource ?? this.videoSource,
        video: video ?? this.video,
        imageMediaId: imageMediaId ?? this.imageMediaId,
        image: image ?? this.image,
        duration: duration ?? this.duration,
        isDownloadable: isDownloadable ?? this.isDownloadable,
        isFree: isFree ?? this.isFree,
        price: price ?? this.price,
        isDiscountable: isDiscountable ?? this.isDiscountable,
        discountType: discountType ?? this.discountType,
        discount: discount ?? this.discount,
        discountStartAt: discountStartAt ?? this.discountStartAt,
        discountEndAt: discountEndAt ?? this.discountEndAt,
        isFeatured: isFeatured ?? this.isFeatured,
        deletedAt: deletedAt ?? this.deletedAt,
        tags: tags ?? this.tags,
        levelId: levelId ?? this.levelId,
        subjectId: subjectId ?? this.subjectId,
        isRenewable: isRenewable ?? this.isRenewable,
        renewAfter: renewAfter ?? this.renewAfter,
        metaTitle: metaTitle ?? this.metaTitle,
        metaKeywords: metaKeywords ?? this.metaKeywords,
        metaDescription: metaDescription ?? this.metaDescription,
        metaImage: metaImage ?? this.metaImage,
        totalLesson: totalLesson ?? this.totalLesson,
        totalEnrolled: totalEnrolled ?? this.totalEnrolled,
        totalRating: totalRating ?? this.totalRating,
        isPublished: isPublished ?? this.isPublished,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        language: language ?? this.language,
        level: level ?? this.level,
      );

  factory Course.fromJson(String str) => Course.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Course.fromMap(Map<String, dynamic> json) => Course(
        id: json["id"],
        courseThumbnail: json["course_thumbnail"],
        chapterCount: json["chapter_count"],
        title: json["title"],
        slug: json["slug"],
        shortDescription: json["short_description"],
        userId: json["user_id"],
        instructorIds: json["instructor_ids"] == null ? [] : List<String>.from(json["instructor_ids"]!.map((x) => x)),
        categoryId: json["category_id"],
        courseType: json["course_type"],
        capacity: json["capacity"],
        classEndsAt: json["class_ends_at"],
        languageId: json["language_id"],
        organizationId: json["organization_id"],
        description: json["description"],
        isPrivate: json["is_private"],
        videoSource: json["video_source"],
        video: json["video"],
        imageMediaId: json["image_media_id"],
        image: json["image"] == null ? null : CourseImage.fromMap(json["image"]),
        duration: json["duration"],
        isDownloadable: json["is_downloadable"],
        isFree: json["is_free"],
        price: json["price"],
        isDiscountable: json["is_discountable"],
        discountType: json["discount_type"],
        discount: json["discount"],
        discountStartAt: json["discount_start_at"] == null ? null : DateTime.parse(json["discount_start_at"]),
        discountEndAt: json["discount_end_at"] == null ? null : DateTime.parse(json["discount_end_at"]),
        isFeatured: json["is_featured"],
        deletedAt: json["deleted_at"],
        tags: json["tags"] == null ? [] : List<String>.from(json["tags"]!.map((x) => x)),
        levelId: json["level_id"],
        subjectId: json["subject_id"],
        isRenewable: json["is_renewable"],
        renewAfter: json["renew_after"],
        metaTitle: json["meta_title"],
        metaKeywords: json["meta_keywords"],
        metaDescription: json["meta_description"],
        metaImage: json["meta_image"] == null ? null : CourseImage.fromMap(json["meta_image"]),
        totalLesson: json["total_lesson"],
        totalEnrolled: json["total_enrolled"],
        totalRating: json["total_rating"],
        isPublished: json["is_published"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        language: json["language"] == null ? null : Language.fromMap(json["language"]),
        level: json["level"] == null ? null : Skill.fromMap(json["level"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "course_thumbnail": courseThumbnail,
        "chapter_count": chapterCount,
        "title": title,
        "slug": slug,
        "short_description": shortDescription,
        "user_id": userId,
        "instructor_ids": instructorIds == null ? [] : List<dynamic>.from(instructorIds!.map((x) => x)),
        "category_id": categoryId,
        "course_type": courseType,
        "capacity": capacity,
        "class_ends_at": classEndsAt,
        "language_id": languageId,
        "organization_id": organizationId,
        "description": description,
        "is_private": isPrivate,
        "video_source": videoSource,
        "video": video,
        "image_media_id": imageMediaId,
        "image": image?.toMap(),
        "duration": duration,
        "is_downloadable": isDownloadable,
        "is_free": isFree,
        "price": price,
        "is_discountable": isDiscountable,
        "discount_type": discountType,
        "discount": discount,
        "discount_start_at": discountStartAt?.toIso8601String(),
        "discount_end_at": discountEndAt?.toIso8601String(),
        "is_featured": isFeatured,
        "deleted_at": deletedAt,
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "level_id": levelId,
        "subject_id": subjectId,
        "is_renewable": isRenewable,
        "renew_after": renewAfter,
        "meta_title": metaTitle,
        "meta_keywords": metaKeywords,
        "meta_description": metaDescription,
        "meta_image": metaImage?.toMap(),
        "total_lesson": totalLesson,
        "total_enrolled": totalEnrolled,
        "total_rating": totalRating,
        "is_published": isPublished,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "language": language?.toMap(),
        "level": level?.toMap(),
      };
}

class CourseImage {
  String? storage;
  String? originalImage;
  String? image40X40;
  String? image80X80;
  String? image68X48;
  String? image190X230;
  String? image163X116;
  String? image295X248;
  String? image417X384;
  String? imageThumbnail;
  String? image402X248;
  String? image1200X630;

  CourseImage({
    this.storage,
    this.originalImage,
    this.image40X40,
    this.image80X80,
    this.image68X48,
    this.image190X230,
    this.image163X116,
    this.image295X248,
    this.image417X384,
    this.imageThumbnail,
    this.image402X248,
    this.image1200X630,
  });

  CourseImage copyWith({
    String? storage,
    String? originalImage,
    String? image40X40,
    String? image80X80,
    String? image68X48,
    String? image190X230,
    String? image163X116,
    String? image295X248,
    String? image417X384,
    String? imageThumbnail,
    String? image402X248,
    String? image1200X630,
  }) =>
      CourseImage(
        storage: storage ?? this.storage,
        originalImage: originalImage ?? this.originalImage,
        image40X40: image40X40 ?? this.image40X40,
        image80X80: image80X80 ?? this.image80X80,
        image68X48: image68X48 ?? this.image68X48,
        image190X230: image190X230 ?? this.image190X230,
        image163X116: image163X116 ?? this.image163X116,
        image295X248: image295X248 ?? this.image295X248,
        image417X384: image417X384 ?? this.image417X384,
        imageThumbnail: imageThumbnail ?? this.imageThumbnail,
        image402X248: image402X248 ?? this.image402X248,
        image1200X630: image1200X630 ?? this.image1200X630,
      );

  factory CourseImage.fromJson(String str) => CourseImage.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CourseImage.fromMap(Map<String, dynamic> json) => CourseImage(
        storage: json["storage"],
        originalImage: json["original_image"],
        image40X40: json["image_40x40"],
        image80X80: json["image_80x80"],
        image68X48: json["image_68x48"],
        image190X230: json["image_190x230"],
        image163X116: json["image_163x116"],
        image295X248: json["image_295x248"],
        image417X384: json["image_417x384"],
        imageThumbnail: json["image_thumbnail"],
        image402X248: json["image_402x248"],
        image1200X630: json["image_1200x630"],
      );

  Map<String, dynamic> toMap() => {
        "storage": storage,
        "original_image": originalImage,
        "image_40x40": image40X40,
        "image_80x80": image80X80,
        "image_68x48": image68X48,
        "image_190x230": image190X230,
        "image_163x116": image163X116,
        "image_295x248": image295X248,
        "image_417x384": image417X384,
        "image_thumbnail": imageThumbnail,
        "image_402x248": image402X248,
        "image_1200x630": image1200X630,
      };
}

class Language {
  int? id;
  String? name;
  String? locale;
  dynamic flag;
  String? textDirection;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Language({
    this.id,
    this.name,
    this.locale,
    this.flag,
    this.textDirection,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Language copyWith({
    int? id,
    String? name,
    String? locale,
    dynamic flag,
    String? textDirection,
    int? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Language(
        id: id ?? this.id,
        name: name ?? this.name,
        locale: locale ?? this.locale,
        flag: flag ?? this.flag,
        textDirection: textDirection ?? this.textDirection,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Language.fromJson(String str) => Language.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Language.fromMap(Map<String, dynamic> json) => Language(
        id: json["id"],
        name: json["name"],
        locale: json["locale"],
        flag: json["flag"],
        textDirection: json["text_direction"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "locale": locale,
        "flag": flag,
        "text_direction": textDirection,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Skill {
  int? id;
  String? title;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Skill({
    this.id,
    this.title,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Skill copyWith({
    int? id,
    String? title,
    int? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Skill(
        id: id ?? this.id,
        title: title ?? this.title,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Skill.fromJson(String str) => Skill.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Skill.fromMap(Map<String, dynamic> json) => Skill(
        id: json["id"],
        title: json["title"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Instructor {
  int? id;
  int? userId;
  dynamic organizationId;
  String? designation;
  dynamic website;
  dynamic expertises;
  SocialLinks? socialLinks;
  String? slug;
  int? courseLimit;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;

  Instructor({
    this.id,
    this.userId,
    this.organizationId,
    this.designation,
    this.website,
    this.expertises,
    this.socialLinks,
    this.slug,
    this.courseLimit,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  Instructor copyWith({
    int? id,
    int? userId,
    dynamic organizationId,
    String? designation,
    dynamic website,
    dynamic expertises,
    SocialLinks? socialLinks,
    String? slug,
    int? courseLimit,
    DateTime? createdAt,
    DateTime? updatedAt,
    User? user,
  }) =>
      Instructor(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        organizationId: organizationId ?? this.organizationId,
        designation: designation ?? this.designation,
        website: website ?? this.website,
        expertises: expertises ?? this.expertises,
        socialLinks: socialLinks ?? this.socialLinks,
        slug: slug ?? this.slug,
        courseLimit: courseLimit ?? this.courseLimit,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        user: user ?? this.user,
      );

  factory Instructor.fromJson(String str) => Instructor.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Instructor.fromMap(Map<String, dynamic> json) => Instructor(
        id: json["id"],
        userId: json["user_id"],
        organizationId: json["organization_id"],
        designation: json["designation"],
        website: json["website"],
        expertises: json["expertises"],
        socialLinks: json["social_links"] == null ? null : SocialLinks.fromMap(json["social_links"]),
        slug: json["slug"],
        courseLimit: json["course_limit"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        user: json["user"] == null ? null : User.fromMap(json["user"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "organization_id": organizationId,
        "designation": designation,
        "website": website,
        "expertises": expertises,
        "social_links": socialLinks?.toMap(),
        "slug": slug,
        "course_limit": courseLimit,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user": user?.toMap(),
      };
}

class SocialLinks {
  String? facebook;
  String? twitter;
  String? instagram;
  String? linkedin;

  SocialLinks({
    this.facebook,
    this.twitter,
    this.instagram,
    this.linkedin,
  });

  SocialLinks copyWith({
    String? facebook,
    String? twitter,
    String? instagram,
    String? linkedin,
  }) =>
      SocialLinks(
        facebook: facebook ?? this.facebook,
        twitter: twitter ?? this.twitter,
        instagram: instagram ?? this.instagram,
        linkedin: linkedin ?? this.linkedin,
      );

  factory SocialLinks.fromJson(String str) => SocialLinks.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SocialLinks.fromMap(Map<String, dynamic> json) => SocialLinks(
        facebook: json["facebook"],
        twitter: json["twitter"],
        instagram: json["instagram"],
        linkedin: json["linkedin"],
      );

  Map<String, dynamic> toMap() => {
        "facebook": facebook,
        "twitter": twitter,
        "instagram": instagram,
        "linkedin": linkedin,
      };
}

class User {
  int? id;
  String? deviceToken;
  String? firstName;
  String? lastName;
  String? email;
  dynamic emailVerifiedAt;
  int? phoneCountryId;
  String? phone;
  List<Permission>? permissions;
  String? userType;
  dynamic firebaseAuthId;
  dynamic languageId;
  dynamic currencyId;
  int? status;
  dynamic images;
  dynamic lastLogin;
  dynamic lastPasswordChange;
  int? isUserBanned;
  int? isDeleted;
  int? roleId;
  String? address;
  dynamic postalCode;
  dynamic countryId;
  dynamic stateId;
  dynamic cityId;
  dynamic gender;
  dynamic dateOfBirth;
  String? about;
  int? isNewsletterEnabled;
  int? isNotificationEnabled;
  int? balance;
  dynamic otp;
  dynamic onesignalPlayerId;
  int? isOnesignalSubscribed;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    this.deviceToken,
    this.firstName,
    this.lastName,
    this.email,
    this.emailVerifiedAt,
    this.phoneCountryId,
    this.phone,
    this.permissions,
    this.userType,
    this.firebaseAuthId,
    this.languageId,
    this.currencyId,
    this.status,
    this.images,
    this.lastLogin,
    this.lastPasswordChange,
    this.isUserBanned,
    this.isDeleted,
    this.roleId,
    this.address,
    this.postalCode,
    this.countryId,
    this.stateId,
    this.cityId,
    this.gender,
    this.dateOfBirth,
    this.about,
    this.isNewsletterEnabled,
    this.isNotificationEnabled,
    this.balance,
    this.otp,
    this.onesignalPlayerId,
    this.isOnesignalSubscribed,
    this.createdAt,
    this.updatedAt,
  });

  User copyWith({
    int? id,
    String? deviceToken,
    String? firstName,
    String? lastName,
    String? email,
    dynamic emailVerifiedAt,
    int? phoneCountryId,
    String? phone,
    List<Permission>? permissions,
    String? userType,
    dynamic firebaseAuthId,
    dynamic languageId,
    dynamic currencyId,
    int? status,
    dynamic images,
    dynamic lastLogin,
    dynamic lastPasswordChange,
    int? isUserBanned,
    int? isDeleted,
    int? roleId,
    String? address,
    dynamic postalCode,
    dynamic countryId,
    dynamic stateId,
    dynamic cityId,
    dynamic gender,
    dynamic dateOfBirth,
    String? about,
    int? isNewsletterEnabled,
    int? isNotificationEnabled,
    int? balance,
    dynamic otp,
    dynamic onesignalPlayerId,
    int? isOnesignalSubscribed,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      User(
        id: id ?? this.id,
        deviceToken: deviceToken ?? this.deviceToken,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
        phoneCountryId: phoneCountryId ?? this.phoneCountryId,
        phone: phone ?? this.phone,
        permissions: permissions ?? this.permissions,
        userType: userType ?? this.userType,
        firebaseAuthId: firebaseAuthId ?? this.firebaseAuthId,
        languageId: languageId ?? this.languageId,
        currencyId: currencyId ?? this.currencyId,
        status: status ?? this.status,
        images: images ?? this.images,
        lastLogin: lastLogin ?? this.lastLogin,
        lastPasswordChange: lastPasswordChange ?? this.lastPasswordChange,
        isUserBanned: isUserBanned ?? this.isUserBanned,
        isDeleted: isDeleted ?? this.isDeleted,
        roleId: roleId ?? this.roleId,
        address: address ?? this.address,
        postalCode: postalCode ?? this.postalCode,
        countryId: countryId ?? this.countryId,
        stateId: stateId ?? this.stateId,
        cityId: cityId ?? this.cityId,
        gender: gender ?? this.gender,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        about: about ?? this.about,
        isNewsletterEnabled: isNewsletterEnabled ?? this.isNewsletterEnabled,
        isNotificationEnabled: isNotificationEnabled ?? this.isNotificationEnabled,
        balance: balance ?? this.balance,
        otp: otp ?? this.otp,
        onesignalPlayerId: onesignalPlayerId ?? this.onesignalPlayerId,
        isOnesignalSubscribed: isOnesignalSubscribed ?? this.isOnesignalSubscribed,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        deviceToken: json["device_token"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        phoneCountryId: json["phone_country_id"],
        phone: json["phone"],
        permissions: json["permissions"] == null ? [] : List<Permission>.from(json["permissions"]!.map((x) => permissionValues.map[x]!)),
        userType: json["user_type"],
        firebaseAuthId: json["firebase_auth_id"],
        languageId: json["language_id"],
        currencyId: json["currency_id"],
        status: json["status"],
        images: json["images"],
        lastLogin: json["last_login"],
        lastPasswordChange: json["last_password_change"],
        isUserBanned: json["is_user_banned"],
        isDeleted: json["is_deleted"],
        roleId: json["role_id"],
        address: json["address"],
        postalCode: json["postal_code"],
        countryId: json["country_id"],
        stateId: json["state_id"],
        cityId: json["city_id"],
        gender: json["gender"],
        dateOfBirth: json["date_of_birth"],
        about: json["about"],
        isNewsletterEnabled: json["is_newsletter_enabled"],
        isNotificationEnabled: json["is_notification_enabled"],
        balance: json["balance"],
        otp: json["otp"],
        onesignalPlayerId: json["onesignal_player_id"],
        isOnesignalSubscribed: json["is_onesignal_subscribed"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "device_token": deviceToken,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "phone_country_id": phoneCountryId,
        "phone": phone,
        "permissions": permissions == null ? [] : List<dynamic>.from(permissions!.map((x) => permissionValues.reverse[x])),
        "user_type": userType,
        "firebase_auth_id": firebaseAuthId,
        "language_id": languageId,
        "currency_id": currencyId,
        "status": status,
        "images": images,
        "last_login": lastLogin,
        "last_password_change": lastPasswordChange,
        "is_user_banned": isUserBanned,
        "is_deleted": isDeleted,
        "role_id": roleId,
        "address": address,
        "postal_code": postalCode,
        "country_id": countryId,
        "state_id": stateId,
        "city_id": cityId,
        "gender": gender,
        "date_of_birth": dateOfBirth,
        "about": about,
        "is_newsletter_enabled": isNewsletterEnabled,
        "is_notification_enabled": isNotificationEnabled,
        "balance": balance,
        "otp": otp,
        "onesignal_player_id": onesignalPlayerId,
        "is_onesignal_subscribed": isOnesignalSubscribed,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

enum Permission { COURSES_EDIT, INSTRUCTORS_SELF_EDIT, LIVES_CLASSES_EDIT, ORGANIZATIONS_EDIT }

final permissionValues = EnumValues({
  "courses.edit": Permission.COURSES_EDIT,
  "instructors.self-edit": Permission.INSTRUCTORS_SELF_EDIT,
  "livesClasses.edit": Permission.LIVES_CLASSES_EDIT,
  "organizations.edit": Permission.ORGANIZATIONS_EDIT
});

class Review {
  int? id;
  int? userId;
  String? rating;
  String? comment;
  int? commentableId;
  String? commentableType;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;

  Review({
    this.id,
    this.userId,
    this.rating,
    this.comment,
    this.commentableId,
    this.commentableType,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  Review copyWith({
    int? id,
    int? userId,
    String? rating,
    String? comment,
    int? commentableId,
    String? commentableType,
    int? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    User? user,
  }) =>
      Review(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        rating: rating ?? this.rating,
        comment: comment ?? this.comment,
        commentableId: commentableId ?? this.commentableId,
        commentableType: commentableType ?? this.commentableType,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        user: user ?? this.user,
      );

  factory Review.fromJson(String str) => Review.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Review.fromMap(Map<String, dynamic> json) => Review(
        id: json["id"],
        userId: json["user_id"],
        rating: json["rating"],
        comment: json["comment"],
        commentableId: json["commentable_id"],
        commentableType: json["commentable_type"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        user: json["user"] == null ? null : User.fromMap(json["user"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "rating": rating,
        "comment": comment,
        "commentable_id": commentableId,
        "commentable_type": commentableType,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user": user?.toMap(),
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
