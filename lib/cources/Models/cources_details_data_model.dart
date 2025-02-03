class CourseDetailsDataModel {
  bool? success;
  String? message;
  Data? data;

  CourseDetailsDataModel({this.success, this.message, this.data});

  CourseDetailsDataModel.fromJson(Map<String, dynamic> json) {
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
  int? coursePurchasedStatus;
  int? totalChapterCount;
  Course? course;
  List<Reviews>? reviews;
  List<Level>? skills;
  List<Instructors>? instructors;
  Sylabus? sylabus;

  Data({this.coursePurchasedStatus, this.totalChapterCount, this.course, this.reviews, this.skills, this.instructors, this.sylabus});

  Data.fromJson(Map<String, dynamic> json) {
    coursePurchasedStatus = json['course_purchased_status'];
    totalChapterCount = json['total_chapter_count'];
    course = json['Course'] != null ? new Course.fromJson(json['Course']) : null;
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
      });
    }
    if (json['skills'] != null) {
      skills = <Level>[];
      json['skills'].forEach((v) {
        skills!.add(new Level.fromJson(v));
      });
    }
    if (json['instructors'] != null) {
      instructors = <Instructors>[];
      json['instructors'].forEach((v) {
        instructors!.add(new Instructors.fromJson(v));
      });
    }
    sylabus = json['sylabus'] != null ? new Sylabus.fromJson(json['sylabus']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_purchased_status'] = this.coursePurchasedStatus;
    data['total_chapter_count'] = this.totalChapterCount;
    if (this.course != null) {
      data['Course'] = this.course!.toJson();
    }
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    if (this.skills != null) {
      data['skills'] = this.skills!.map((v) => v.toJson()).toList();
    }
    if (this.instructors != null) {
      data['instructors'] = this.instructors!.map((v) => v.toJson()).toList();
    }
    if (this.sylabus != null) {
      data['sylabus'] = this.sylabus!.toJson();
    }
    return data;
  }
}

class Course {
  int? id;
  String? title;
  String? slug;
  String? shortDescription;
  int? userId;
  List<String>? instructorIds;
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
  Images? image;
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
  List<String>? tags;
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
  String? createdAt;
  String? updatedAt;
  Language? language;
  Level? level;

  Course(
      {this.id,
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
      this.level});

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    shortDescription = json['short_description'];
    userId = json['user_id'];
    instructorIds = json['instructor_ids'].cast<String>();
    categoryId = json['category_id'];
    courseType = json['course_type'];
    capacity = json['capacity'];
    classEndsAt = json['class_ends_at'];
    languageId = json['language_id'];
    organizationId = json['organization_id'];
    description = json['description'];
    isPrivate = json['is_private'];
    videoSource = json['video_source'];
    // video = json['video'] != null ? new Video.fromJson(json['video']) : Video();
    video = json['video'];
    imageMediaId = json['image_media_id'];
    image = json['image'] != null ? new Images.fromJson(json['image']) : null;

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
    tags = json['tags'].cast<String>();
    levelId = json['level_id'];
    subjectId = json['subject_id'];
    isRenewable = json['is_renewable'];
    renewAfter = json['renew_after'];
    metaTitle = json['meta_title'];
    metaKeywords = json['meta_keywords'];
    metaDescription = json['meta_description'];
    //metaImage = json['meta_image'];
    totalLesson = json['total_lesson'];
    totalEnrolled = json['total_enrolled'];
    totalRating = json['total_rating'];
    isPublished = json['is_published'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    language = json['language'] != null ? new Language.fromJson(json['language']) : null;
    level = json['level'] != null ? new Level.fromJson(json['level']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['short_description'] = this.shortDescription;
    data['user_id'] = this.userId;
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
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
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
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.language != null) {
      data['language'] = this.language!.toJson();
    }
    if (this.level != null) {
      data['level'] = this.level!.toJson();
    }
    return data;
  }
}

class Video {
  String? storage;
  String? image;

  Video({this.storage, this.image});

  Video.fromJson(Map<String, dynamic> json) {
    storage = json['storage'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['storage'] = this.storage;
    data['image'] = this.image;
    return data;
  }
}

class Images {
  String? storage;
  String? originalImage;
  String? image40x40;
  String? image80x80;
  String? image68x48;
  String? image190x230;
  String? image163x116;
  String? image295x248;
  String? image417x384;
  String? imageThumbnail;
  String? image402x248;

  Images(
      {this.storage,
      this.originalImage,
      this.image40x40,
      this.image80x80,
      this.image68x48,
      this.image190x230,
      this.image163x116,
      this.image295x248,
      this.image417x384,
      this.imageThumbnail,
      this.image402x248});

  Images.fromJson(Map<String, dynamic> json) {
    storage = json['storage'];
    originalImage = json['original_image'];
    image40x40 = json['image_40x40'];
    image80x80 = json['image_80x80'];
    image68x48 = json['image_68x48'];
    image190x230 = json['image_190x230'];
    image163x116 = json['image_163x116'];
    image295x248 = json['image_295x248'];
    image417x384 = json['image_417x384'];
    imageThumbnail = json['image_thumbnail'];
    image402x248 = json['image_402x248'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['storage'] = this.storage;
    data['original_image'] = this.originalImage;
    data['image_40x40'] = this.image40x40;
    data['image_80x80'] = this.image80x80;
    data['image_68x48'] = this.image68x48;
    data['image_190x230'] = this.image190x230;
    data['image_163x116'] = this.image163x116;
    data['image_295x248'] = this.image295x248;
    data['image_417x384'] = this.image417x384;
    data['image_thumbnail'] = this.imageThumbnail;
    data['image_402x248'] = this.image402x248;
    return data;
  }
}

class Language {
  int? id;
  String? name;
  String? locale;
  String? flag;
  String? textDirection;
  int? status;
  String? createdAt;
  String? updatedAt;

  Language({this.id, this.name, this.locale, this.flag, this.textDirection, this.status, this.createdAt, this.updatedAt});

  Language.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    locale = json['locale'];
    flag = json['flag'];
    textDirection = json['text_direction'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['locale'] = this.locale;
    data['flag'] = this.flag;
    data['text_direction'] = this.textDirection;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Level {
  int? id;
  String? title;
  int? status;
  String? createdAt;
  String? updatedAt;

  Level({this.id, this.title, this.status, this.createdAt, this.updatedAt});

  Level.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Reviews {
  int? id;
  int? userId;
  String? rating;
  String? comment;
  int? commentableId;
  String? commentableType;
  int? status;
  String? createdAt;
  String? updatedAt;
  UserDataSet? userDataSet;

  Reviews(
      {this.id,
      this.userId,
      this.rating,
      this.comment,
      this.commentableId,
      this.commentableType,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.userDataSet});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    rating = json['rating'];
    comment = json['comment'];
    commentableId = json['commentable_id'];
    commentableType = json['commentable_type'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userDataSet = json['user_data_set'] != null ? new UserDataSet.fromJson(json['user_data_set']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['rating'] = this.rating;
    data['comment'] = this.comment;
    data['commentable_id'] = this.commentableId;
    data['commentable_type'] = this.commentableType;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.userDataSet != null) {
      data['user_data_set'] = this.userDataSet!.toJson();
    }
    return data;
  }
}

class UserDataSet {
  int? id;
  String? name;
  int? roleId;
  String? phone;
  String? email;
  String? location;
  String? profileImage;

  UserDataSet({this.id, this.name, this.roleId, this.phone, this.email, this.location, this.profileImage});

  UserDataSet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    roleId = json['role_id'];
    phone = json['phone'];
    email = json['email'];
    location = json['location'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['role_id'] = this.roleId;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['location'] = this.location;
    data['profile_image'] = this.profileImage;
    return data;
  }
}

class SocialLinks {
  String? facebook;
  String? twitter;
  String? instagram;
  String? linkedin;
  String? youtube;

  SocialLinks({this.facebook, this.twitter, this.instagram, this.linkedin, this.youtube});

  SocialLinks.fromJson(Map<String, dynamic> json) {
    facebook = json['facebook'];
    twitter = json['twitter'];
    instagram = json['instagram'];
    linkedin = json['linkedin'];
    youtube = json['youtube'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['facebook'] = this.facebook;
    data['twitter'] = this.twitter;
    data['instagram'] = this.instagram;
    data['linkedin'] = this.linkedin;
    data['youtube'] = this.youtube;
    return data;
  }
}

class Instructors {
  int? id;
  int? userId;
  int? organizationId;
  String? designation;
  String? website;
  List<String>? expertises;
  SocialLinks? socialLinks;
  String? slug;
  String? createdAt;
  String? updatedAt;
  User? user;

  Instructors(
      {this.id,
      this.userId,
      this.organizationId,
      this.designation,
      this.website,
      this.expertises,
      this.socialLinks,
      this.slug,
      this.createdAt,
      this.updatedAt,
      this.user});

  Instructors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    organizationId = json['organization_id'];
    designation = json['designation'];
    website = json['website'];
    // if (json['expertises'] != null) {
    //   expertises = <String>[];
    //   json['expertises'].forEach((v) {
    //     expertises!.add(new String.fromJson(v));
    //   });
    // }
    socialLinks = json['social_links'] != null ? new SocialLinks.fromJson(json['social_links']) : null;
    slug = json['slug'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['organization_id'] = this.organizationId;
    data['designation'] = this.designation;
    data['website'] = this.website;
    // if (this.expertises != null) {
    //   data['expertises'] = this.expertises!.map((v) => v.toJson()).toList();
    // }
    if (this.socialLinks != null) {
      data['social_links'] = this.socialLinks!.toJson();
    }
    data['slug'] = this.slug;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? emailVerifiedAt;
  int? phoneCountryId;
  String? phone;
  List<String>? permissions;
  String? userType;
  String? firebaseAuthId;
  String? languageId;
  String? currencyId;
  int? status;
  String? images;
  String? lastLogin;
  String? lastPasswordChange;
  int? isUserBanned;
  int? isDeleted;
  int? roleId;
  String? address;
  String? postalCode;
  String? countryId;
  String? stateId;
  String? cityId;
  String? gender;
  String? dateOfBirth;
  String? about;
  int? isNewsletterEnabled;
  int? isNotificationEnabled;
  int? balance;
  String? otp;
  String? onesignalPlayerId;
  int? isOnesignalSubscribed;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
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
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    phoneCountryId = json['phone_country_id'];
    phone = json['phone'];
    permissions = json['permissions'] != null ? json['permissions'].cast<String>() : [];
    userType = json['user_type'];
    firebaseAuthId = json['firebase_auth_id'];
    languageId = json['language_id'];
    currencyId = json['currency_id'];
    status = json['status'];
    images = json['images'];
    lastLogin = json['last_login'];
    lastPasswordChange = json['last_password_change'];
    isUserBanned = json['is_user_banned'];
    isDeleted = json['is_deleted'];
    roleId = json['role_id'];
    address = json['address'];
    postalCode = json['postal_code'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    gender = json['gender'];
    dateOfBirth = json['date_of_birth'];
    about = json['about'];
    isNewsletterEnabled = json['is_newsletter_enabled'];
    isNotificationEnabled = json['is_notification_enabled'];
    balance = json['balance'];
    otp = json['otp'];
    onesignalPlayerId = json['onesignal_player_id'];
    isOnesignalSubscribed = json['is_onesignal_subscribed'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['phone_country_id'] = this.phoneCountryId;
    data['phone'] = this.phone;
    data['permissions'] = this.permissions;
    data['user_type'] = this.userType;
    data['firebase_auth_id'] = this.firebaseAuthId;
    data['language_id'] = this.languageId;
    data['currency_id'] = this.currencyId;
    data['status'] = this.status;
    data['images'] = this.images;
    data['last_login'] = this.lastLogin;
    data['last_password_change'] = this.lastPasswordChange;
    data['is_user_banned'] = this.isUserBanned;
    data['is_deleted'] = this.isDeleted;
    data['role_id'] = this.roleId;
    data['address'] = this.address;
    data['postal_code'] = this.postalCode;
    data['country_id'] = this.countryId;
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
    data['gender'] = this.gender;
    data['date_of_birth'] = this.dateOfBirth;
    data['about'] = this.about;
    data['is_newsletter_enabled'] = this.isNewsletterEnabled;
    data['is_notification_enabled'] = this.isNotificationEnabled;
    data['balance'] = this.balance;
    data['otp'] = this.otp;
    data['onesignal_player_id'] = this.onesignalPlayerId;
    data['is_onesignal_subscribed'] = this.isOnesignalSubscribed;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Sylabus {
  int? id;
  String? title;
  String? slug;
  int? courseId;
  int? orderNo;
  int? status;
  String? createdAt;
  String? updatedAt;

  Sylabus({this.id, this.title, this.slug, this.courseId, this.orderNo, this.status, this.createdAt, this.updatedAt});

  Sylabus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    courseId = json['course_id'];
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
    data['order_no'] = this.orderNo;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
