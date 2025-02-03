class BatchVideoStudyMatrialDataModel {
  bool? success;
  String? message;
  BatchVideoStudyMatrialData? data;

  BatchVideoStudyMatrialDataModel({this.success, this.message, this.data});

  BatchVideoStudyMatrialDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = (json['data'] != null) ? new BatchVideoStudyMatrialData.fromJson(json['data']) : null;
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

class BatchVideoStudyMatrialData {
  int? chapterCount;
  List<ChapterListForUser>? chapterListForUser;

  BatchVideoStudyMatrialData({this.chapterCount, this.chapterListForUser});

  BatchVideoStudyMatrialData.fromJson(Map<String, dynamic> json) {
    chapterCount = json['chapter_count'];
    if (json['chapter_list_for_user'] != null) {
      chapterListForUser = <ChapterListForUser>[];
      json['chapter_list_for_user'].forEach((v) {
        chapterListForUser!.add(new ChapterListForUser.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chapter_count'] = this.chapterCount;
    if (this.chapterListForUser != null) {
      data['chapter_list_for_user'] = this.chapterListForUser!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChapterListForUser {
  String? chaptersTitle;
  String? chaptersNotes;
  String? chaptersImage;
  String? videos;
  String? youtubelink;
  String? studyMaterials;
  int? pkIntStudyPlanItemsId;
  int? fkIntStudyPlansId;
  int? batchId;
  String? title;
  String? type;
  int? chapterId;
  int? assigmentId;
  int? examId;
  List<SubChapterFiles>? subChapterFiles;
  List<OtherFiles>? otherFiles;

  ChapterListForUser(
      {this.chaptersTitle,
      this.chaptersNotes,
      this.chaptersImage,
      this.videos,
      this.studyMaterials,
      this.pkIntStudyPlanItemsId,
      this.fkIntStudyPlansId,
      this.batchId,
      this.title,
      this.type,
      this.chapterId,
      this.assigmentId,
      this.examId,
      this.youtubelink,
      this.subChapterFiles,
      this.otherFiles});

  ChapterListForUser.fromJson(Map<String, dynamic> json) {
    chaptersTitle = json['chapters_title'];
    chaptersNotes = json['chapters_notes'];
    chaptersImage = json['chapters_image'];
    videos = json['videos'];
    youtubelink = json['youtube_link'];
    studyMaterials = json['study_materials'];
    pkIntStudyPlanItemsId = json['pk_int_study_plan_items_id'];
    fkIntStudyPlansId = json['fk_int_study_plans_id'];
    batchId = json['batch_id'];
    title = json['title'];
    type = json['type'];
    chapterId = json['chapter_id'];
    assigmentId = json['assigment_id'];
    examId = json['exam_id'];
    if (json['sub_chapter_files'] != null) {
      subChapterFiles = <SubChapterFiles>[];
      json['sub_chapter_files'].forEach((v) {
        subChapterFiles!.add(new SubChapterFiles.fromJson(v));
      });
    }
    if (json['other_files'] != null) {
      otherFiles = <OtherFiles>[];
      json['other_files'].forEach((v) {
        otherFiles!.add(new OtherFiles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chapters_title'] = this.chaptersTitle;
    data['chapters_notes'] = this.chaptersNotes;
    data['chapters_image'] = this.chaptersImage;
    data['videos'] = this.videos;
    data['youtube_link'] = this.youtubelink;
    data['study_materials'] = this.studyMaterials;
    data['pk_int_study_plan_items_id'] = this.pkIntStudyPlanItemsId;
    data['fk_int_study_plans_id'] = this.fkIntStudyPlansId;
    data['batch_id'] = this.batchId;
    data['title'] = this.title;
    data['type'] = this.type;
    data['chapter_id'] = this.chapterId;
    data['assigment_id'] = this.assigmentId;
    data['exam_id'] = this.examId;
    if (this.subChapterFiles != null) {
      data['sub_chapter_files'] = this.subChapterFiles!.map((v) => v.toJson()).toList();
    }
    if (this.otherFiles != null) {
      data['other_files'] = this.otherFiles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubChapterFiles {
  String? subChaptersNotes;
  String? subChaptersImage;
  dynamic subChaptersVideos;
  String? subChapterYoutubeLink;
  String? subChaptersStudyMaterials;

  SubChapterFiles({
    this.subChaptersNotes,
    this.subChaptersImage,
    this.subChaptersVideos,
    this.subChapterYoutubeLink,
    this.subChaptersStudyMaterials,
  });

  factory SubChapterFiles.fromJson(Map<String, dynamic> json) => SubChapterFiles(
        subChaptersNotes: json["sub_chapters_notes"],
        subChaptersImage: json["sub_chapters_image"],
        subChaptersVideos: json["sub_chapters_videos"],
        subChapterYoutubeLink: json["sub_chapter_youtube_link"],
        subChaptersStudyMaterials: json["sub_chapters_study_materials"],
      );

  Map<String, dynamic> toJson() => {
        "sub_chapters_notes": subChaptersNotes,
        "sub_chapters_image": subChaptersImage,
        "sub_chapters_videos": subChaptersVideos,
        "sub_chapter_youtube_link": subChapterYoutubeLink,
        "sub_chapters_study_materials": subChaptersStudyMaterials,
      };
}

class OtherFiles {
  String? otherFilesNotes;
  String? otherFilesImage;
  String? otherFilesVideos;
  String? otherFilesStudyMaterials;

  OtherFiles({this.otherFilesNotes, this.otherFilesImage, this.otherFilesVideos, this.otherFilesStudyMaterials});

  OtherFiles.fromJson(Map<String, dynamic> json) {
    otherFilesNotes = json['other_files_notes'];
    otherFilesImage = json['other_files_image'];
    otherFilesVideos = json['other_files_videos'];
    otherFilesStudyMaterials = json['other_files_study_materials'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['other_files_notes'] = this.otherFilesNotes;
    data['other_files_image'] = this.otherFilesImage;
    data['other_files_videos'] = this.otherFilesVideos;
    data['other_files_study_materials'] = this.otherFilesStudyMaterials;
    return data;
  }
}
