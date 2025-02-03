// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  bool? success;
  String? message;
  List<Datum>? data;

  CategoryModel({
    this.success,
    this.message,
    this.data,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? isCategorySelected;
  int? id;
  String? title;
  Image? image;

  Datum({
    this.isCategorySelected,
    this.id,
    this.title,
    this.image,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        isCategorySelected: json["is_category_selected"],
        id: json["id"],
        title: json["title"],
        image: json["image"] == null ? null : Image.fromJson(json["image"]),
      );

  Map<String, dynamic> toJson() => {
        "is_category_selected": isCategorySelected,
        "id": id,
        "title": title,
        "image": image?.toJson(),
      };
}

class Image {
  Storage? storage;
  String? originalImage;
  String? image40X40;
  String? image80X80;
  String? image68X48;
  String? image190X230;
  String? image163X116;
  String? image295X248;
  String? image417X384;
  String? imageThumbnail;
  String? image402X238;
  String? image1200X630;

  Image({
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
    this.image402X238,
    this.image1200X630,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        storage: storageValues.map[json["storage"]]!,
        originalImage: json["original_image"],
        image40X40: json["image_40x40"],
        image80X80: json["image_80x80"],
        image68X48: json["image_68x48"],
        image190X230: json["image_190x230"],
        image163X116: json["image_163x116"],
        image295X248: json["image_295x248"],
        image417X384: json["image_417x384"],
        imageThumbnail: json["image_thumbnail"],
        image402X238: json["image_402x238"],
        image1200X630: json["image_1200x630"],
      );

  Map<String, dynamic> toJson() => {
        "storage": storageValues.reverse[storage],
        "original_image": originalImage,
        "image_40x40": image40X40,
        "image_80x80": image80X80,
        "image_68x48": image68X48,
        "image_190x230": image190X230,
        "image_163x116": image163X116,
        "image_295x248": image295X248,
        "image_417x384": image417X384,
        "image_thumbnail": imageThumbnail,
        "image_402x238": image402X238,
        "image_1200x630": image1200X630,
      };
}

enum Storage { LOCAL }

final storageValues = EnumValues({"local": Storage.LOCAL});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
