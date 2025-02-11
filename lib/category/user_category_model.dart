import 'dart:convert';

class UserCategory {
  bool? success;
  String? message;
  List<Datum>? data;

  UserCategory({
    this.success,
    this.message,
    this.data,
  });

  UserCategory copyWith({
    bool? success,
    String? message,
    List<Datum>? data,
  }) =>
      UserCategory(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );


  String toJson() => json.encode(toMap());

  factory UserCategory.fromJson(Map<String, dynamic> json) => UserCategory(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toMap() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class Datum {
  int? id;
  String? title;

  Datum({
    this.id,
    this.title,
   });

  Datum copyWith({
    int? id,
    String? title,
    String? image,
  }) =>
      Datum(
        id: id ?? this.id,
        title: title ?? this.title,
       );


  String toJson() => json.encode(toMap());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
   );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
   };
}
