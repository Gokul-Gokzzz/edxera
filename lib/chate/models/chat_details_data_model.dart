class GetChatDetailsDataModel {
  bool? success;
  String? message;
  Data? data;

  GetChatDetailsDataModel({this.success, this.message, this.data});

  GetChatDetailsDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  List<ChatDetails>? chatDetails;

  Data({this.chatDetails});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['chat_details'] != null) {
      chatDetails = <ChatDetails>[];
      json['chat_details'].forEach((v) {
        chatDetails!.add(new ChatDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.chatDetails != null) {
      data['chat_details'] = this.chatDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChatDetails {
  int? id;
  int? instructorId;
  int? userId;
  String? sentBy;
  String? message;
  String? mediaFile;
  String? sentDate;
  String? sentTime;
  String? createdAt;
  String? updatedAt;

  ChatDetails(
      {this.id,
      this.instructorId,
      this.userId,
      this.sentBy,
      this.message,
      this.mediaFile,
      this.sentDate,
      this.sentTime,
      this.createdAt,
      this.updatedAt});

  ChatDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instructorId = json['instructor_id'];
    userId = json['user_id'];
    sentBy = json['sent_by'];
    message = json['message'];
    mediaFile = json['media_file'];
    sentDate = json['sent_date'];
    sentTime = json['sent_time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['instructor_id'] = this.instructorId;
    data['user_id'] = this.userId;
    data['sent_by'] = this.sentBy;
    data['message'] = this.message;
    data['media_file'] = this.mediaFile;
    data['sent_date'] = this.sentDate;
    data['sent_time'] = this.sentTime;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
