import 'package:edxera/generated/json/base/json_field.dart';
import 'package:edxera/generated/json/announcements_entity.g.dart';
import 'dart:convert';
export 'package:edxera/generated/json/announcements_entity.g.dart';

@JsonSerializable()
class AnnouncementsEntity {
  bool success = false;
  String message = "";
  AnnouncementsData data = new AnnouncementsData();

  AnnouncementsEntity();

  // AnnouncementsEntity(this.success, this.message, this.data);

  factory AnnouncementsEntity.fromJson(Map<String, dynamic> json) => $AnnouncementsEntityFromJson(json);

  Map<String, dynamic> toJson() => $AnnouncementsEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class AnnouncementsData {
  @JSONField(name: "batch_announcements")
  List<AnnouncementsDataBatchAnnouncements> batchAnnouncements = [];

  AnnouncementsData();

  factory AnnouncementsData.fromJson(Map<String, dynamic> json) => $AnnouncementsDataFromJson(json);

  Map<String, dynamic> toJson() => $AnnouncementsDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class AnnouncementsDataBatchAnnouncements {
  int id = 0;
  String title = "";
  @JSONField(name: "batch_id")
  int batchId = 0;
  @JSONField(name: "announcement_date")
  String announcementDate = "";
  int status = 0;
  @JSONField(name: "created_at")
  String createdAt = "";
  @JSONField(name: "updated_at")
  String updatedAt = "";

  AnnouncementsDataBatchAnnouncements();

  factory AnnouncementsDataBatchAnnouncements.fromJson(Map<String, dynamic> json) => $AnnouncementsDataBatchAnnouncementsFromJson(json);

  Map<String, dynamic> toJson() => $AnnouncementsDataBatchAnnouncementsToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
