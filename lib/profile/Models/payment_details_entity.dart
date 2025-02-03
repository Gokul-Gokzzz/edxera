import 'package:edxera/generated/json/base/json_field.dart';
import 'package:edxera/generated/json/payment_details_entity.g.dart';
import 'dart:convert';
export 'package:edxera/generated/json/payment_details_entity.g.dart';

@JsonSerializable()
class PaymentDetailsEntity {
  bool? success = false;
  String? message = '';
  PaymentDetailsData data = new PaymentDetailsData();

  PaymentDetailsEntity();

  factory PaymentDetailsEntity.fromJson(Map<String, dynamic> json) => $PaymentDetailsEntityFromJson(json);

  Map<String, dynamic> toJson() => $PaymentDetailsEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class PaymentDetailsData {
  @JSONField(name: "student_details")
  String? studentDetails = '';
  String? email = '';
  List<PaymentDetailsDataFee> fee = [];

  PaymentDetailsData();

  factory PaymentDetailsData.fromJson(Map<String, dynamic> json) => $PaymentDetailsDataFromJson(json);

  Map<String, dynamic> toJson() => $PaymentDetailsDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class PaymentDetailsDataFee {
  int? id = 0;
  @JSONField(name: "course_name")
  String? courseName = '';
  @JSONField(name: "batch_id")
  int? batchId = 0;
  @JSONField(name: "user_id")
  int? userId = 0;
  @JSONField(name: "paid_amount")
  int? paidAmount = 0;
  @JSONField(name: "balance_amount")
  int? balanceAmount = 0;
  @JSONField(name: "payment_type")
  String? paymentType = '';
  @JSONField(name: "paid_status")
  int paidStatus = 0;
  @JSONField(name: "paid_date")
  String? paidDate = '';
  @JSONField(name: "paid_time")
  String? paidTime = '';
  @JSONField(name: "created_at")
  String? createdAt = '';
  @JSONField(name: "updated_at")
  String? updatedAt = '';

  PaymentDetailsDataFee();

  factory PaymentDetailsDataFee.fromJson(Map<String, dynamic> json) => $PaymentDetailsDataFeeFromJson(json);

  Map<String, dynamic> toJson() => $PaymentDetailsDataFeeToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
