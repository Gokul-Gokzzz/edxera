class ContactUsDataModel {
  bool? success;
  String? message;
  Data? data;

  ContactUsDataModel({this.success, this.message, this.data});

  ContactUsDataModel.fromJson(Map<String, dynamic> json) {
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
  Details? details;

  Data({this.details});

  Data.fromJson(Map<String, dynamic> json) {
    details = json['Details'] != null ? new Details.fromJson(json['Details']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.details != null) {
      data['Details'] = this.details!.toJson();
    }
    return data;
  }
}

class Details {
  int? id;
  String? customerService;
  String? website;
  String? whatsapp;
  String? facebook;
  String? instagram;
  String? twitter;
  String? mobile;
  String? landline;

  Details({this.id, this.customerService, this.website, this.whatsapp, this.facebook, this.instagram, this.twitter, this.mobile, this.landline});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerService = json['customer_service'];
    website = json['website'];
    whatsapp = json['whatsapp'];
    facebook = json['facebook'];
    instagram = json['instagram'];
    twitter = json['twitter'];
    mobile = json['mobile'];
    landline = json['landline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_service'] = this.customerService;
    data['website'] = this.website;
    data['whatsapp'] = this.whatsapp;
    data['facebook'] = this.facebook;
    data['instagram'] = this.instagram;
    data['twitter'] = this.twitter;
    data['mobile'] = this.mobile;
    data['landline'] = this.landline;
    return data;
  }
}
