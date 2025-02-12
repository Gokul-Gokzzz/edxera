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
  int? courseId;
  String? title;
  String? courseReelVideo;
  String? courseReelYoutubeLink;
  String? courseThumbnail;
  int? courseReelLikeCount;
  int? courseReelViewCount;
  int? courseReelCommentCount;
  int? courseReelId;
  int? isLiked;

  ReelModel({
    this.id,
    this.courseId,
    this.title,
    this.courseReelVideo,
    this.courseReelYoutubeLink,
    this.courseThumbnail,
    this.courseReelLikeCount,
    this.courseReelViewCount,
    this.courseReelCommentCount,
    this.courseReelId,
    this.isLiked,
  });

  ReelModel copyWith({
    int? id,
    String? title,
    String? courseReelVideo,
    String? courseReelYoutubeLink,
    String? courseThumbnail,
    int? courseLikeCount,
    int? courseViewCount,
    int? courseCommentCount,
    int? courseReelId,
    int? isLiked,
  }) =>
      ReelModel(
        id: id ?? this.id,
        courseId: courseId ?? this.courseId,
        title: title ?? this.title,
        courseReelVideo: courseReelVideo ?? this.courseReelVideo,
        courseThumbnail: courseThumbnail ?? this.courseThumbnail,
        courseReelLikeCount: courseLikeCount ?? this.courseReelLikeCount,
        courseReelViewCount: courseViewCount ?? this.courseReelViewCount,
        courseReelCommentCount:
            courseCommentCount ?? this.courseReelCommentCount,
        isLiked: isLiked ?? this.isLiked,
        courseReelId: courseReelId ?? this.courseReelId,
        courseReelYoutubeLink:
            courseReelYoutubeLink ?? this.courseReelYoutubeLink,
      );

  factory ReelModel.fromJson(String str) => ReelModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ReelModel.fromMap(Map<String, dynamic> json) => ReelModel(
        id: json["id"],
        courseId: json["course_id"],
        title: json["title"],
        courseReelVideo: json["course_reel_video"],
        courseReelYoutubeLink: json["cource_reel_youtube_link"],
        courseThumbnail: json["course_thumbnail"],
        courseReelLikeCount: json["course_reel_like_count"],
        courseReelViewCount: json["course_reel_view_count"],
        courseReelCommentCount: json["course_reel_comment_count"],
        courseReelId: json["course_reels_id"],
        isLiked: json["is_liked"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "course_id": courseId,
        "title": title,
        "course_reel_video": courseReelVideo,
        "cource_reel_youtube_link": courseReelYoutubeLink,
        "course_thumbnail": courseThumbnail,
        "course_like_count": courseReelLikeCount,
        "course_view_count": courseReelViewCount,
        "course_comment_count": courseReelCommentCount,
        "course_reels_id": courseReelId,
        "is_liked": isLiked,
      };
}
