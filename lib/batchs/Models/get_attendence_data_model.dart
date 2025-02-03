class GetAttendenceDataModel {
  bool? success;
  String? message;
  Data? data;

  GetAttendenceDataModel({this.success, this.message, this.data});

  GetAttendenceDataModel.fromJson(Map<String, dynamic> json) {
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
  int? present;
  int? late;
  int? notPresent;
  List<Attendence>? attendence;

  Data({this.present, this.late, this.notPresent, this.attendence});

  Data.fromJson(Map<String, dynamic> json) {
    present = json['present'];
    late = json['late'];
    notPresent = json['not_present'];
    if (json['attendence'] != null) {
      attendence = <Attendence>[];
      json['attendence'].forEach((v) {
        attendence!.add(new Attendence.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['present'] = this.present;
    data['late'] = this.late;
    data['not_present'] = this.notPresent;
    if (this.attendence != null) {
      data['attendence'] = this.attendence!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attendence {
  int? id;
  int? batchId;
  int? userId;
  String? date;
  String? attendenceType;
  int? orderNo;
  int? status;
  String? createdAt;
  String? updatedAt;

  Attendence({this.id, this.batchId, this.userId, this.date, this.attendenceType, this.orderNo, this.status, this.createdAt, this.updatedAt});

  Attendence.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    batchId = json['batch_id'];
    userId = json['user_id'];
    date = json['date'];
    attendenceType = json['attendence_type'];
    orderNo = json['order_no'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['batch_id'] = this.batchId;
    data['user_id'] = this.userId;
    data['date'] = this.date;
    data['attendence_type'] = this.attendenceType;
    data['order_no'] = this.orderNo;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
