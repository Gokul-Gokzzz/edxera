import 'package:edxera/generated/json/base/json_convert_content.dart';
import 'package:edxera/profile/Models/payment_details_entity.dart';

PaymentDetailsEntity $PaymentDetailsEntityFromJson(Map<String, dynamic> json) {
  final PaymentDetailsEntity paymentDetailsEntity = PaymentDetailsEntity();
  final bool? success = jsonConvert.convert<bool>(json['success']);
  if (success != null) {
    paymentDetailsEntity.success = success;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    paymentDetailsEntity.message = message;
  }
  final PaymentDetailsData? data = jsonConvert.convert<PaymentDetailsData>(json['data']);
  if (data != null) {
    paymentDetailsEntity.data = data;
  }
  return paymentDetailsEntity;
}

Map<String, dynamic> $PaymentDetailsEntityToJson(PaymentDetailsEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['success'] = entity.success;
  data['message'] = entity.message;
  data['data'] = entity.data?.toJson();
  return data;
}

extension PaymentDetailsEntityExtension on PaymentDetailsEntity {
  PaymentDetailsEntity copyWith({
    bool? success,
    String? message,
    PaymentDetailsData? data,
  }) {
    return PaymentDetailsEntity()
      ..success = success ?? this.success
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

PaymentDetailsData $PaymentDetailsDataFromJson(Map<String, dynamic> json) {
  final PaymentDetailsData paymentDetailsData = PaymentDetailsData();
  final String? studentDetails = jsonConvert.convert<String>(json['student_details']);
  if (studentDetails != null) {
    paymentDetailsData.studentDetails = studentDetails;
  }
  final String? email = jsonConvert.convert<String>(json['email']);
  if (email != null) {
    paymentDetailsData.email = email;
  }
  final List<PaymentDetailsDataFee>? fee =
      (json['fee'] as List<dynamic>?)?.map((e) => jsonConvert.convert<PaymentDetailsDataFee>(e) as PaymentDetailsDataFee).toList();
  if (fee != null) {
    paymentDetailsData.fee = fee;
  }
  return paymentDetailsData;
}

Map<String, dynamic> $PaymentDetailsDataToJson(PaymentDetailsData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['student_details'] = entity.studentDetails;
  data['email'] = entity.email;
  data['fee'] = entity.fee?.map((v) => v.toJson()).toList();
  return data;
}

extension PaymentDetailsDataExtension on PaymentDetailsData {
  PaymentDetailsData copyWith({
    String? studentDetails,
    String? email,
    List<PaymentDetailsDataFee>? fee,
  }) {
    return PaymentDetailsData()
      ..studentDetails = studentDetails ?? this.studentDetails
      ..email = email ?? this.email
      ..fee = fee ?? this.fee;
  }
}

PaymentDetailsDataFee $PaymentDetailsDataFeeFromJson(Map<String, dynamic> json) {
  final PaymentDetailsDataFee paymentDetailsDataFee = PaymentDetailsDataFee();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    paymentDetailsDataFee.id = id;
  }
  final String? courseName = jsonConvert.convert<String>(json['course_name']);
  if (courseName != null) {
    paymentDetailsDataFee.courseName = courseName;
  }
  final int? batchId = jsonConvert.convert<int>(json['batch_id']);
  if (batchId != null) {
    paymentDetailsDataFee.batchId = batchId;
  }
  final int? userId = jsonConvert.convert<int>(json['user_id']);
  if (userId != null) {
    paymentDetailsDataFee.userId = userId;
  }
  final int? paidAmount = jsonConvert.convert<int>(json['paid_amount']);
  if (paidAmount != null) {
    paymentDetailsDataFee.paidAmount = paidAmount;
  }
  final int? balanceAmount = jsonConvert.convert<int>(json['balance_amount']);
  if (balanceAmount != null) {
    paymentDetailsDataFee.balanceAmount = balanceAmount;
  }
  final String? paymentType = jsonConvert.convert<String>(json['payment_type']);
  if (paymentType != null) {
    paymentDetailsDataFee.paymentType = paymentType;
  }
  final int? paidStatus = jsonConvert.convert<int>(json['paid_status']);
  if (paidStatus != null) {
    paymentDetailsDataFee.paidStatus = paidStatus;
  }
  final String? paidDate = jsonConvert.convert<String>(json['paid_date']);
  if (paidDate != null) {
    paymentDetailsDataFee.paidDate = paidDate;
  }
  final String? paidTime = jsonConvert.convert<String>(json['paid_time']);
  if (paidTime != null) {
    paymentDetailsDataFee.paidTime = paidTime;
  }
  final String? createdAt = jsonConvert.convert<String>(json['created_at']);
  if (createdAt != null) {
    paymentDetailsDataFee.createdAt = createdAt;
  }
  final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
  if (updatedAt != null) {
    paymentDetailsDataFee.updatedAt = updatedAt;
  }
  return paymentDetailsDataFee;
}

Map<String, dynamic> $PaymentDetailsDataFeeToJson(PaymentDetailsDataFee entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['course_name'] = entity.courseName;
  data['batch_id'] = entity.batchId;
  data['user_id'] = entity.userId;
  data['paid_amount'] = entity.paidAmount;
  data['balance_amount'] = entity.balanceAmount;
  data['payment_type'] = entity.paymentType;
  data['paid_status'] = entity.paidStatus;
  data['paid_date'] = entity.paidDate;
  data['paid_time'] = entity.paidTime;
  data['created_at'] = entity.createdAt;
  data['updated_at'] = entity.updatedAt;
  return data;
}

extension PaymentDetailsDataFeeExtension on PaymentDetailsDataFee {
  PaymentDetailsDataFee copyWith({
    int? id,
    String? courseName,
    int? batchId,
    int? userId,
    int? paidAmount,
    int? balanceAmount,
    String? paymentType,
    int? paidStatus,
    String? paidDate,
    String? paidTime,
    String? createdAt,
    String? updatedAt,
  }) {
    return PaymentDetailsDataFee()
      ..id = id ?? this.id
      ..courseName = courseName ?? this.courseName
      ..batchId = batchId ?? this.batchId
      ..userId = userId ?? this.userId
      ..paidAmount = paidAmount ?? this.paidAmount
      ..balanceAmount = balanceAmount ?? this.balanceAmount
      ..paymentType = paymentType ?? this.paymentType
      ..paidStatus = paidStatus ?? this.paidStatus
      ..paidDate = paidDate ?? this.paidDate
      ..paidTime = paidTime ?? this.paidTime
      ..createdAt = createdAt ?? this.createdAt
      ..updatedAt = updatedAt ?? this.updatedAt;
  }
}
