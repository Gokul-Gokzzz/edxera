class GetChatHeadsDataModel {
  bool? success;
  String? message;
  Data? data;

  GetChatHeadsDataModel({this.success, this.message, this.data});

  GetChatHeadsDataModel.fromJson(Map<String, dynamic> json) {
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
  List<ChatHeads>? chatHeads;

  Data({this.chatHeads});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['chat_heads'] != null) {
      chatHeads = <ChatHeads>[];
      json['chat_heads'].forEach((v) {
        chatHeads!.add(new ChatHeads.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.chatHeads != null) {
      data['chat_heads'] = this.chatHeads!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChatHeads {
  int? instructorId;
  String? sentBy;
  String? lastMessage;
  String? mediaFile;
  String? sentDate;
  String? sentTime;

  ChatHeads({this.instructorId, this.sentBy, this.lastMessage, this.mediaFile, this.sentDate, this.sentTime});

  ChatHeads.fromJson(Map<String, dynamic> json) {
    instructorId = json['instructor_id'];
    sentBy = json['sent_by'];
    lastMessage = json['last_message'];
    mediaFile = json['media_file'];
    sentDate = json['sent_date'];
    sentTime = json['sent_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['instructor_id'] = this.instructorId;
    data['sent_by'] = this.sentBy;
    data['last_message'] = this.lastMessage;
    data['media_file'] = this.mediaFile;
    data['sent_date'] = this.sentDate;
    data['sent_time'] = this.sentTime;
    return data;
  }
}
