import 'dart:convert';

class CategoryWiseReelsModel {
  bool? success;
  String? message;
  List<ReelsModel>? data;

  CategoryWiseReelsModel({
    this.success,
    this.message,
    this.data,
  });

  CategoryWiseReelsModel copyWith({
    bool? success,
    String? message,
    List<ReelsModel>? data,
  }) =>
      CategoryWiseReelsModel(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory CategoryWiseReelsModel.fromJson(String str) => CategoryWiseReelsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoryWiseReelsModel.fromMap(Map<String, dynamic> json) => CategoryWiseReelsModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<ReelsModel>.from(json["data"]!.map((x) => ReelsModel.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class ReelsModel {
  int? courseId;
  String? courseTitle;
  List<ReelsList>? reelsList;

  ReelsModel({
    this.courseId,
    this.courseTitle,
    this.reelsList,
  });

  ReelsModel copyWith({
    int? courseId,
    String? courseTitle,
    List<ReelsList>? reelsList,
  }) =>
      ReelsModel(
        courseId: courseId ?? this.courseId,
        courseTitle: courseTitle ?? this.courseTitle,
        reelsList: reelsList ?? this.reelsList,
      );

  factory ReelsModel.fromJson(String str) => ReelsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ReelsModel.fromMap(Map<String, dynamic> json) => ReelsModel(
    courseId: json["course_id"],
    courseTitle: json["course_title"],
    reelsList: json["reels_list"] == null ? [] : List<ReelsList>.from(json["reels_list"]!.map((x) => ReelsList.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "course_id": courseId,
    "course_title": courseTitle,
    "reels_list": reelsList == null ? [] : List<dynamic>.from(reelsList!.map((x) => x.toMap())),
  };
}

class ReelsList {
  int? courseReelsId;
  int? courseId;
  int? isLiked;
  String? courseReelVideo;
  String? courseReelThumbnail;
  String? courseReelYoutubeLink;
  String? reelTags;
  String? reelDescription;
  int? courseReelLikeCount;
  int? courseReelViewCount;
  int? courseReelCommentCount;
  DateTime? createdAt;
  String? updatedAt;

  ReelsList({
    this.courseReelsId,
    this.courseId,
    this.isLiked,
    this.courseReelThumbnail,
    this.courseReelVideo,
    this.courseReelYoutubeLink,
    this.reelTags,
    this.reelDescription,
    this.courseReelLikeCount,
    this.courseReelViewCount,
    this.courseReelCommentCount,
    this.createdAt,
    this.updatedAt,
  });

  ReelsList copyWith({
    int? courseReelsId,
    int? courseId,
    int? isLiked,
    String? courseReelVideo,
    String? courseReelThumbnail,
    String? courseReelYoutubeLink,
    String? reelTags,
    String? reelDescription,
    int? courseReelLikeCount,
    int? courseReelViewCount,
    int? courseReelCommentCount,
    DateTime? createdAt,
    String? updatedAt,
  }) =>
      ReelsList(
        courseReelsId: courseReelsId ?? this.courseReelsId,
        isLiked: isLiked ?? this.isLiked,
        courseId: courseId ?? this.courseId,
        courseReelThumbnail: courseReelThumbnail ?? this.courseReelThumbnail,
        courseReelVideo: courseReelVideo ?? this.courseReelVideo,
        courseReelYoutubeLink: courseReelYoutubeLink ?? this.courseReelYoutubeLink,
        reelTags: reelTags ?? this.reelTags,
        reelDescription: reelDescription ?? this.reelDescription,
        courseReelLikeCount: courseReelLikeCount ?? this.courseReelLikeCount,
        courseReelViewCount: courseReelViewCount ?? this.courseReelViewCount,
        courseReelCommentCount: courseReelCommentCount ?? this.courseReelCommentCount,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory ReelsList.fromJson(String str) => ReelsList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ReelsList.fromMap(Map<String, dynamic> json) => ReelsList(
    courseReelsId: json["course_reels_id"],
    isLiked: json["is_liked"],
    courseId: json["course_id"],
    courseReelThumbnail: json["course_reel_thumbnail"],
    courseReelVideo: json["course_reel_video"],
    courseReelYoutubeLink: json["course_reel_youtube_link"],
    reelTags: json["reel_tags"],
    reelDescription: json["reel_description"],
    courseReelLikeCount: json["course_reel_like_count"],
    courseReelViewCount: json["course_reel_view_count"],
    courseReelCommentCount: json["course_reel_comment_count"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toMap() => {
    "course_reels_id": courseReelsId,
    "is_liked": isLiked,
    "course_reel_thumbnail": courseReelThumbnail,
    "course_id": courseId,
    "course_reel_video": courseReelVideo,
    "course_reel_youtube_link": courseReelYoutubeLink,
    "reel_tags": reelTags,
    "reel_description": reelDescription,
    "course_reel_like_count": courseReelLikeCount,
    "course_reel_view_count": courseReelViewCount,
    "course_reel_comment_count": courseReelCommentCount,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt,
  };
}
