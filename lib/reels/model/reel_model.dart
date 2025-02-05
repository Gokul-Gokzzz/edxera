import 'dart:convert';

class ReelResponse {
  bool? success;
  String? message;
  List<ReelModel>? data;

  ReelResponse({
    this.success,
    this.message,
    this.data,
  });

  ReelResponse copyWith({
    bool? success,
    String? message,
    List<ReelModel>? data,
  }) =>
      ReelResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory ReelResponse.fromJson(String str) => ReelResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ReelResponse.fromMap(Map<String, dynamic> json) => ReelResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<ReelModel>.from(json["data"]!.map((x) => ReelModel.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class ReelModel {
  int? id;
  String? title;
  String? courseReelVideo;
  String? courseThumbnail;
  int? courseLikeCount;
  int? courseViewCount;
  int? courseCommentCount;
  int? isLiked;

  ReelModel({
    this.id,
    this.title,
    this.courseReelVideo,
    this.courseThumbnail,
    this.courseLikeCount,
    this.courseViewCount,
    this.courseCommentCount,
    this.isLiked,
  });

  ReelModel copyWith({
    int? id,
    String? title,
    String? courseReelVideo,
    String? courseThumbnail,
    int? courseLikeCount,
    int? courseViewCount,
    int? courseCommentCount,
    int? isLiked,
  }) =>
      ReelModel(
        id: id ?? this.id,
        title: title ?? this.title,
        courseReelVideo: courseReelVideo ?? this.courseReelVideo,
        courseThumbnail: courseThumbnail ?? this.courseThumbnail,
        courseLikeCount: courseLikeCount ?? this.courseLikeCount,
        courseViewCount: courseViewCount ?? this.courseViewCount,
        courseCommentCount: courseCommentCount ?? this.courseCommentCount,
        isLiked: isLiked ?? this.isLiked,
      );

  factory ReelModel.fromJson(String str) => ReelModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ReelModel.fromMap(Map<String, dynamic> json) => ReelModel(
    id: json["id"],
    title: json["title"],
    courseReelVideo: json["course_reel_video"],
    courseThumbnail: json["course_thumbnail"],
    courseLikeCount: json["course_like_count"],
    courseViewCount: json["course_view_count"],
    courseCommentCount: json["course_comment_count"],
    isLiked: json["is_liked"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "course_reel_video": courseReelVideo,
    "course_thumbnail": courseThumbnail,
    "course_like_count": courseLikeCount,
    "course_view_count": courseViewCount,
    "course_comment_count": courseCommentCount,
    "is_liked": isLiked,
  };
}
