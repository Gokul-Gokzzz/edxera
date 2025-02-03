class FreeStudyMatrialListDataModel {
  bool? success;
  String? message;
  Data? data;

  FreeStudyMatrialListDataModel({this.success, this.message, this.data});

  FreeStudyMatrialListDataModel.fromJson(Map<String, dynamic> json) {
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
  List<FreeStudyMaterials>? freeStudyMaterials;

  Data({this.freeStudyMaterials});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['free_study_materials'] != null) {
      freeStudyMaterials = <FreeStudyMaterials>[];
      json['free_study_materials'].forEach((v) {
        freeStudyMaterials!.add(new FreeStudyMaterials.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.freeStudyMaterials != null) {
      data['free_study_materials'] = this.freeStudyMaterials!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FreeStudyMaterials {
  int? id;
  int? batchId;
  String? notes;
  String? title;
  String? image;
  String? video;
  String? pdf;
  int? orderNo;
  int? status;
  String? createdAt;
  String? updatedAt;

  FreeStudyMaterials(
      {this.id, this.batchId, this.notes, this.image, this.title, this.video, this.pdf, this.orderNo, this.status, this.createdAt, this.updatedAt});

  FreeStudyMaterials.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    batchId = json['batch_id'];
    title = json['title'];
    notes = json['notes'];
    image = json['image'];
    video = json['video'];
    pdf = json['pdf'];
    orderNo = json['order_no'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['batch_id'] = this.batchId;
    data['notes'] = this.notes;
    data['title'] = this.title;
    data['image'] = this.image;
    data['video'] = this.video;
    data['pdf'] = this.pdf;
    data['order_no'] = this.orderNo;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
