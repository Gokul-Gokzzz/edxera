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

  factory ReelResponse.fromJson(String str) =>
      ReelResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ReelResponse.fromMap(Map<String, dynamic> json) => ReelResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<ReelModel>.from(
                json["data"]!.map((x) => ReelModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class ReelModel {
  int? id;
  String? title;
  String? courseReelVideo;
  String? courseThumbnail;
  int? courseReelLikeCount;
  int? courseReelViewCount;
  int? courseReelCommentCount;
  int? isLiked;
  int? course_reels_id;

  ReelModel({
    this.id,
    this.title,
    this.course_reels_id,
    this.courseReelVideo,
    this.courseThumbnail,
    this.courseReelLikeCount,
    this.courseReelViewCount,
    this.courseReelCommentCount,
    this.isLiked,
  });

  ReelModel copyWith({
    int? id,
    int? course_reels_id,
    String? title,
    String? courseReelVideo,
    String? courseThumbnail,
    int? courseReelLikeCount,
    int? courseReelViewCount,
    int? courseReelCommentCount,
    int? isLiked,
  }) =>
      ReelModel(
        id: id ?? this.id,
        course_reels_id: course_reels_id ?? this.course_reels_id,
        title: title ?? this.title,
        courseReelVideo: courseReelVideo ?? this.courseReelVideo,
        courseThumbnail: courseThumbnail ?? this.courseThumbnail,
        courseReelLikeCount: courseReelLikeCount ?? this.courseReelLikeCount,
        courseReelViewCount: courseReelViewCount ?? this.courseReelViewCount,
        courseReelCommentCount:
            courseReelCommentCount ?? this.courseReelCommentCount,
        isLiked: isLiked ?? this.isLiked,
      );

  factory ReelModel.fromJson(String str) => ReelModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ReelModel.fromMap(Map<String, dynamic> json) => ReelModel(
        id: json["id"],
        course_reels_id: json["course_reels_id"],
        title: json["title"],
        courseReelVideo: json["course_reel_video"],
        courseThumbnail: json["course_thumbnail"],
        courseReelLikeCount: json["course_reel_like_count"],
        courseReelViewCount: json["course_reel_view_count"],
        courseReelCommentCount: json["course_reel_comment_count"],
        isLiked: json["is_liked"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "course_reels_id": course_reels_id,
        "title": title,
        "course_reel_video": courseReelVideo,
        "course_thumbnail": courseThumbnail,
        "course_reel_like_count": courseReelLikeCount,
        "course_reel_view_count": courseReelViewCount,
        "course_reel_comment_count": courseReelCommentCount,
        "is_liked": isLiked,
      };
}
