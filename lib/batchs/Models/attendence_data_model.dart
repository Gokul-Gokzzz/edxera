class AttendencePresentDataModel {
  bool? status;
  String? message;
  bool? success;

  AttendencePresentDataModel({
    this.status,
    this.success,
    this.message,
  });

  AttendencePresentDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['success'] = this.success;

    return data;
  }
}
