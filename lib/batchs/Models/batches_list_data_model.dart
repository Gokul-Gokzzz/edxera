class BatchesListDataModel {
  bool? success;
  String? message = "";
  late Data? data;

  BatchesListDataModel({this.success, this.message, this.data});

  BatchesListDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : new Data();
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
  List<Batches>? batches = [];

  Data({this.batches});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['batches'] != null) {
      batches = <Batches>[];
      json['batches'].forEach((v) {
        batches!.add(new Batches.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.batches != null) {
      data['batches'] = this.batches!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Batches {
  int? id;
  int? courseId;
  String? batchCode;
  String? name;
  String? fromDate;
  String? toDate;
  String? fee;
  String? days;
  int? orderNo;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? courseTitle;
  int? joinRequestStatus;
  int? requestAcceptedStatus;

  Batches(
      {this.id,
      this.courseId,
      this.batchCode,
      this.name,
      this.fromDate,
      this.toDate,
      this.fee,
      this.days,
      this.orderNo,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.courseTitle,
      this.joinRequestStatus,
      this.requestAcceptedStatus});

  Batches.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['course_id'];
    batchCode = json['batch_code'];
    name = json['name'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    fee = json['fee'];
    days = json['days'];
    orderNo = json['order_no'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    courseTitle = json['course_title'];
    joinRequestStatus = json['join_request_status'];
    requestAcceptedStatus = json['request_accepted_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_id'] = this.courseId;
    data['batch_code'] = this.batchCode;
    data['name'] = this.name;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['fee'] = this.fee;
    data['days'] = this.days;
    data['order_no'] = this.orderNo;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['course_title'] = this.courseTitle;
    data['join_request_status'] = this.joinRequestStatus;
    data['request_accepted_status'] = this.requestAcceptedStatus;
    return data;
  }
}

class BatchesJoinCodeDataModel {
  bool? success;
  String? message;

  BatchesJoinCodeDataModel({
    this.success,
    this.message,
  });

  BatchesJoinCodeDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;

    return data;
  }
}
