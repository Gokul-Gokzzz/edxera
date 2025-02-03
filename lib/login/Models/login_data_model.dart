class LoginDataModel {
  bool? success;
  String? message;
  LoginData? data;

  LoginDataModel({this.success, this.message, this.data});

  LoginDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new LoginData.fromJson(json['data']) : null;
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

class LoginData {
  int? id;
  String? name;
  int? roleId;
  String? phone;
  String? email;
  String? location;
  String? profileImage;

  LoginData({this.id, this.name, this.roleId, this.phone, this.email, this.location, this.profileImage});

  LoginData.fromJson(Map<String, dynamic> json) {
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
