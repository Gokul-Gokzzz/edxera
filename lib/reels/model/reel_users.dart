import 'dart:convert';

class ReelUser {
  int? id;
  int? courseId;
  int? userId;
  String? comment;
  String? likedUserName;

  ReelUser({
    this.id,
    this.courseId,
    this.userId,
    this.comment,
    this.likedUserName,
  });

  ReelUser copyWith({
    int? id,
    int? courseId,
    int? userId,
    String? likedUserName,
    String? comment,
  }) =>
      ReelUser(
        id: id ?? this.id,
        courseId: courseId ?? this.courseId,
        userId: userId ?? this.userId,
        likedUserName: likedUserName ?? this.likedUserName,
        comment: comment ?? this.comment,
      );

  factory ReelUser.fromJson(String str) => ReelUser.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ReelUser.fromMap(Map<String, dynamic> json) => ReelUser(
        id: json["id"],
        courseId: json["course_id"],
        userId: json["user_id"],
        comment: json["comment"],
        likedUserName: json["liked_user_name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "course_id": courseId,
        "user_id": userId,
        "liked_user_name": likedUserName,
        "comment": comment,
      };
}
