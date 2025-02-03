class IntructorsChatListDataModel {
  bool? success;
  String? message;
  Data? data;

  IntructorsChatListDataModel({this.success, this.message, this.data});

  IntructorsChatListDataModel.fromJson(Map<String, dynamic> json) {
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
  List<IntructorsListForChat>? intructorsListForChat;

  Data({this.intructorsListForChat});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['intructors_list_for_chat'] != null) {
      intructorsListForChat = <IntructorsListForChat>[];
      json['intructors_list_for_chat'].forEach((v) {
        intructorsListForChat!.add(new IntructorsListForChat.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.intructorsListForChat != null) {
      data['intructors_list_for_chat'] = this.intructorsListForChat!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class IntructorsListForChat {
  int? id;
  int? userId;
  int? organizationId;
  String? designation;
  String? website;
  String? socialLinks;
  String? slug;
  String? createdAt;
  String? updatedAt;
  User? user;

  IntructorsListForChat(
      {this.id,
      this.userId,
      this.organizationId,
      this.designation,
      this.website,
      this.socialLinks,
      this.slug,
      this.createdAt,
      this.updatedAt,
      this.user});

  IntructorsListForChat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    organizationId = json['organization_id'];
    designation = json['designation'];
    website = json['website'];

    socialLinks = json['social_links'];
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

    data['social_links'] = this.socialLinks;
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
  String? phoneCountryId;
  String? phone;
  String? permissions;
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
    permissions = json['permissions'];
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
