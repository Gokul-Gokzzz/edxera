class HomeDashboardDataModel {
  bool? success;
  String? message;
  List<HomeDashboardData>? data;

  HomeDashboardDataModel({this.success, this.message, this.data});

  HomeDashboardDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <HomeDashboardData>[];
      json['data'].forEach((v) {
        data!.add(new HomeDashboardData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HomeDashboardData {
  String? sectionType;
  List<Sliders>? sliders;
  List<Categories>? categories;

  HomeDashboardData({this.sectionType, this.sliders, this.categories});

  HomeDashboardData.fromJson(Map<String, dynamic> json) {
    sectionType = json['section_type'];
    if (json['sliders'] != null) {
      sliders = <Sliders>[];
      json['sliders'].forEach((v) {
        sliders!.add(new Sliders.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['section_type'] = this.sectionType;
    if (this.sliders != null) {
      data['sliders'] = this.sliders!.map((v) => v.toJson()).toList();
    }
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sliders {
  int? id;
  int? courseId;
  String? title;
  String? subTitle;
  String? btnText;
  String? type;
  int? btnLink;
  String? image;

  Sliders({this.id, this.courseId, this.title, this.subTitle, this.btnText, this.type, this.btnLink, this.image});

  Sliders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['course_id'];
    title = json['title'];
    subTitle = json['sub_title'];
    btnText = json['btn_text'];
    type = json['type'];
    btnLink = json['btn_link'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_id'] = this.courseId;
    data['title'] = this.title;
    data['sub_title'] = this.subTitle;
    data['btn_text'] = this.btnText;
    data['type'] = this.type;
    data['btn_link'] = this.btnLink;
    data['image'] = this.image;
    return data;
  }
}

class Categories {
  int? id;
  String? title;
  String? icon;
  Image? image;
  int? totalCourses;

  Categories({this.id, this.title, this.icon, this.image, this.totalCourses});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    icon = json['icon'];
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    totalCourses = json['total_courses'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['icon'] = this.icon;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    data['total_courses'] = this.totalCourses;
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
      this.image402x238});

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
    return data;
  }
}
