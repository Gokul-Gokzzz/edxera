class NotificationCountDataModel {
  bool? success;
  String? message;
  Data? data;

  NotificationCountDataModel({this.success, this.message, this.data});

  NotificationCountDataModel.fromJson(Map<String, dynamic> json) {
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
  int? readNotification;
  int? unreadNotification;

  Data({this.readNotification, this.unreadNotification});

  Data.fromJson(Map<String, dynamic> json) {
    readNotification = json['read_notification'];
    unreadNotification = json['unread_notification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['read_notification'] = this.readNotification;
    data['unread_notification'] = this.unreadNotification;
    return data;
  }
}
