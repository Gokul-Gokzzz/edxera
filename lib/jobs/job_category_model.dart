import 'dart:convert';

class JobCategory {
  int? id;
  String? title;

  JobCategory({
    this.id,
    this.title,
  });

  JobCategory copyWith({
    int? id,
    String? title,
  }) =>
      JobCategory(
        id: id ?? this.id,
        title: title ?? this.title,
      );

  factory JobCategory.fromJson(String str) => JobCategory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory JobCategory.fromMap(Map<String, dynamic> json) => JobCategory(
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
  };
}
