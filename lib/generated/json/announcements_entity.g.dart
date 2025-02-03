import 'package:edxera/generated/json/base/json_convert_content.dart';
import 'package:edxera/batchs/Models/announcements_entity.dart';

AnnouncementsEntity $AnnouncementsEntityFromJson(Map<String, dynamic> json) {
  final AnnouncementsEntity announcementsEntity = AnnouncementsEntity();
  final bool? success = jsonConvert.convert<bool>(json['success']);
  if (success != null) {
    announcementsEntity.success = success;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    announcementsEntity.message = message;
  }
  final AnnouncementsData? data = jsonConvert.convert<AnnouncementsData>(json['data']);
  if (data != null) {
    announcementsEntity.data = data;
  }
  return announcementsEntity;
}

Map<String, dynamic> $AnnouncementsEntityToJson(AnnouncementsEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['success'] = entity.success;
  data['message'] = entity.message;
  data['data'] = entity.data.toJson();
  return data;
}

extension AnnouncementsEntityExtension on AnnouncementsEntity {
  AnnouncementsEntity copyWith({
    bool? success,
    String? message,
    AnnouncementsData? data,
  }) {
    return AnnouncementsEntity()
      ..success = success ?? this.success
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

AnnouncementsData $AnnouncementsDataFromJson(Map<String, dynamic> json) {
  final AnnouncementsData announcementsData = AnnouncementsData();
  final List<AnnouncementsDataBatchAnnouncements>? batchAnnouncements = (json['batch_announcements'] as List<dynamic>?)
      ?.map((e) => jsonConvert.convert<AnnouncementsDataBatchAnnouncements>(e) as AnnouncementsDataBatchAnnouncements)
      .toList();
  if (batchAnnouncements != null) {
    announcementsData.batchAnnouncements = batchAnnouncements;
  }
  return announcementsData;
}

Map<String, dynamic> $AnnouncementsDataToJson(AnnouncementsData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['batch_announcements'] = entity.batchAnnouncements.map((v) => v.toJson()).toList();
  return data;
}

extension AnnouncementsDataExtension on AnnouncementsData {
  AnnouncementsData copyWith({
    List<AnnouncementsDataBatchAnnouncements>? batchAnnouncements,
  }) {
    return AnnouncementsData()..batchAnnouncements = batchAnnouncements ?? this.batchAnnouncements;
  }
}

AnnouncementsDataBatchAnnouncements $AnnouncementsDataBatchAnnouncementsFromJson(Map<String, dynamic> json) {
  final AnnouncementsDataBatchAnnouncements announcementsDataBatchAnnouncements = AnnouncementsDataBatchAnnouncements();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    announcementsDataBatchAnnouncements.id = id;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    announcementsDataBatchAnnouncements.title = title;
  }
  final int? batchId = jsonConvert.convert<int>(json['batch_id']);
  if (batchId != null) {
    announcementsDataBatchAnnouncements.batchId = batchId;
  }
  final String? announcementDate = jsonConvert.convert<String>(json['announcement_date']);
  if (announcementDate != null) {
    announcementsDataBatchAnnouncements.announcementDate = announcementDate;
  }
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    announcementsDataBatchAnnouncements.status = status;
  }
  final String? createdAt = jsonConvert.convert<String>(json['created_at']);
  if (createdAt != null) {
    announcementsDataBatchAnnouncements.createdAt = createdAt;
  }
  final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
  if (updatedAt != null) {
    announcementsDataBatchAnnouncements.updatedAt = updatedAt;
  }
  return announcementsDataBatchAnnouncements;
}

Map<String, dynamic> $AnnouncementsDataBatchAnnouncementsToJson(AnnouncementsDataBatchAnnouncements entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['title'] = entity.title;
  data['batch_id'] = entity.batchId;
  data['announcement_date'] = entity.announcementDate;
  data['status'] = entity.status;
  data['created_at'] = entity.createdAt;
  data['updated_at'] = entity.updatedAt;
  return data;
}

extension AnnouncementsDataBatchAnnouncementsExtension on AnnouncementsDataBatchAnnouncements {
  AnnouncementsDataBatchAnnouncements copyWith({
    int? id,
    String? title,
    int? batchId,
    String? announcementDate,
    int? status,
    String? createdAt,
    String? updatedAt,
  }) {
    return AnnouncementsDataBatchAnnouncements()
      ..id = id ?? this.id
      ..title = title ?? this.title
      ..batchId = batchId ?? this.batchId
      ..announcementDate = announcementDate ?? this.announcementDate
      ..status = status ?? this.status
      ..createdAt = createdAt ?? this.createdAt
      ..updatedAt = updatedAt ?? this.updatedAt;
  }
}
