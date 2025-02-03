class UserDataModel {
  bool? success;
  String? message;
  UserData? data;

  UserDataModel({this.success, this.message, this.data});

  UserDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new UserData.fromJson(json['data']) : null;
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

class UserData {
  int? id;
  String? name;
  String? firstName;
  String? lastName;
  String? gender;
  String? email;
  String? phone;
  String? dateOfBirth;
  String? address;
  String? image;
  bool? isEmailAdded;
  bool? isPhoneAdded;
  bool? isFbConnected;
  bool? isGoogleConnected;
  bool? isTwitterConnected;
  bool? isAppleConnected;

  UserData(
      {this.id,
      this.name,
      this.firstName,
      this.lastName,
      this.gender,
      this.email,
      this.phone,
      this.dateOfBirth,
      this.address,
      this.image,
      this.isEmailAdded,
      this.isPhoneAdded,
      this.isFbConnected,
      this.isGoogleConnected,
      this.isTwitterConnected,
      this.isAppleConnected});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    gender = json['gender'];
    email = json['email'];
    phone = json['phone'];
    dateOfBirth = json['date_of_birth'];
    address = json['address'];
    image = json['image'];
    isEmailAdded = json['is_email_added'];
    isPhoneAdded = json['is_phone_added'];
    isFbConnected = json['is_fb_connected'];
    isGoogleConnected = json['is_google_connected'];
    isTwitterConnected = json['is_twitter_connected'];
    isAppleConnected = json['is_apple_connected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['gender'] = this.gender;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['date_of_birth'] = this.dateOfBirth;
    data['address'] = this.address;
    data['image'] = this.image;
    data['is_email_added'] = this.isEmailAdded;
    data['is_phone_added'] = this.isPhoneAdded;
    data['is_fb_connected'] = this.isFbConnected;
    data['is_google_connected'] = this.isGoogleConnected;
    data['is_twitter_connected'] = this.isTwitterConnected;
    data['is_apple_connected'] = this.isAppleConnected;
    return data;
  }
}
