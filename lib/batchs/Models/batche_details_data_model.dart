class SuccesFullDataModel {
  bool? success;
  String? message;

  SuccesFullDataModel({
    this.success,
    this.message,
  });

  SuccesFullDataModel.fromJson(Map<String, dynamic> json) {
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

class BatcheDetailsDataModel {
  bool? success;
  String? message;
  Data? data;

  BatcheDetailsDataModel({this.success, this.message, this.data});

  BatcheDetailsDataModel.fromJson(Map<String, dynamic> json) {
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
  int? coursePurchasedStatus;
  int? joinRequestStatus;
  int? requestAcceptedStatus;
  Batches? batches;
  List<Timings>? timings;
  List<Attendence>? attendence;

  Data({this.coursePurchasedStatus, this.joinRequestStatus, this.requestAcceptedStatus, this.batches, this.timings, this.attendence});

  Data.fromJson(Map<String, dynamic> json) {
    coursePurchasedStatus = json['course_purchased_status'];
    joinRequestStatus = json['join_request_status'];
    requestAcceptedStatus = json['request_accepted_status'];
    batches = json['batches'] != null ? new Batches.fromJson(json['batches']) : null;
    if (json['timings'] != null) {
      timings = <Timings>[];
      json['timings'].forEach((v) {
        timings!.add(new Timings.fromJson(v));
      });
    }
    if (json['attendence'] != null) {
      attendence = <Attendence>[];
      json['attendence'].forEach((v) {
        attendence!.add(new Attendence.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_purchased_status'] = this.coursePurchasedStatus;
    data['join_request_status'] = this.joinRequestStatus;
    data['request_accepted_status'] = this.requestAcceptedStatus;
    if (this.batches != null) {
      data['batches'] = this.batches!.toJson();
    }
    if (this.timings != null) {
      data['timings'] = this.timings!.map((v) => v.toJson()).toList();
    }
    if (this.attendence != null) {
      data['attendence'] = this.attendence!.map((v) => v.toJson()).toList();
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
      this.courseTitle});

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
    return data;
  }
}

class Timings {
  int? id;
  int? batchId;
  String? day;
  String? fromTime;
  String? toTime;
  int? orderNo;
  int? status;
  String? createdAt;
  String? updatedAt;

  Timings({this.id, this.batchId, this.day, this.fromTime, this.toTime, this.orderNo, this.status, this.createdAt, this.updatedAt});

  Timings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    batchId = json['batch_id'];
    day = json['day'];
    fromTime = json['from_time'];
    toTime = json['to_time'];
    orderNo = json['order_no'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['batch_id'] = this.batchId;
    data['day'] = this.day;
    data['from_time'] = this.fromTime;
    data['to_time'] = this.toTime;
    data['order_no'] = this.orderNo;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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
