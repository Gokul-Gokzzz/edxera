class TestimonialDataListDataModel {
  bool? success;
  String? message;
  Data? data;

  TestimonialDataListDataModel({this.success, this.message, this.data});

  TestimonialDataListDataModel.fromJson(Map<String, dynamic> json) {
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
  List<Testimonial>? testimonial;

  Data({this.testimonial});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['testimonial'] != null) {
      testimonial = <Testimonial>[];
      json['testimonial'].forEach((v) {
        testimonial!.add(new Testimonial.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.testimonial != null) {
      data['testimonial'] = this.testimonial!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Testimonial {
  int? id;
  String? name;
  String? description;
  int? mediaId;
  Image? image;
  String? video;
  int? status;
  String? createdAt;
  String? updatedAt;

  Testimonial({this.id, this.name, this.description, this.mediaId, this.image, this.video, this.status, this.createdAt, this.updatedAt});

  Testimonial.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    mediaId = json['media_id'];
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    video = json['video'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['media_id'] = this.mediaId;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    data['video'] = this.video;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Image {
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
  String? image402x238;
  String? image1200x630;
  String? image282x282;

  Image(
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
      this.image402x238,
      this.image1200x630,
      this.image282x282});

  Image.fromJson(Map<String, dynamic> json) {
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
    image402x238 = json['image_402x238'];
    image1200x630 = json['image_1200x630'];
    image282x282 = json['image_282x282'];
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
    data['image_402x238'] = this.image402x238;
    data['image_1200x630'] = this.image1200x630;
    data['image_282x282'] = this.image282x282;
    return data;
  }
}
