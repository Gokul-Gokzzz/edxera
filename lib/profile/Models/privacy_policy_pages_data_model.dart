class PrivacyPolicyPagesDataModel {
  bool? success;
  String? message;
  Data? data;

  PrivacyPolicyPagesDataModel({this.success, this.message, this.data});

  PrivacyPolicyPagesDataModel.fromJson(Map<String, dynamic> json) {
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
  PrivacyPolicyPage? privacyPolicyPage;
  PrivacyPolicyPage? termsAndConditionsPage;
  PrivacyPolicyPage? supportPage;
  PrivacyPolicyPage? aboutUsPage;

  Data({this.privacyPolicyPage, this.termsAndConditionsPage, this.supportPage, this.aboutUsPage});

  Data.fromJson(Map<String, dynamic> json) {
    privacyPolicyPage = json['privacy_policy_page'] != null ? new PrivacyPolicyPage.fromJson(json['privacy_policy_page']) : null;
    termsAndConditionsPage = json['terms_and_conditions_page'] != null ? new PrivacyPolicyPage.fromJson(json['terms_and_conditions_page']) : null;
    supportPage = json['support_page'] != null ? new PrivacyPolicyPage.fromJson(json['support_page']) : null;
    aboutUsPage = json['about_us_page'] != null ? new PrivacyPolicyPage.fromJson(json['about_us_page']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.privacyPolicyPage != null) {
      data['privacy_policy_page'] = this.privacyPolicyPage!.toJson();
    }
    if (this.termsAndConditionsPage != null) {
      data['terms_and_conditions_page'] = this.termsAndConditionsPage!.toJson();
    }
    if (this.supportPage != null) {
      data['support_page'] = this.supportPage!.toJson();
    }
    if (this.aboutUsPage != null) {
      data['about_us_page'] = this.aboutUsPage!.toJson();
    }
    return data;
  }
}

class PrivacyPolicyPage {
  String? title;
  String? content;

  PrivacyPolicyPage({this.title, this.content});

  PrivacyPolicyPage.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    return data;
  }
}
