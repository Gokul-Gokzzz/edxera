import 'package:edxera/generated/json/base/json_field.dart';
import 'package:edxera/generated/json/privacypolicy_entity.g.dart';
import 'dart:convert';
export 'package:edxera/generated/json/privacypolicy_entity.g.dart';

@JsonSerializable()
class PrivacypolicyEntity {
  bool? success = false;
  String? message = '';
  PrivacypolicyData? data;

  PrivacypolicyEntity();

  factory PrivacypolicyEntity.fromJson(Map<String, dynamic> json) => $PrivacypolicyEntityFromJson(json);

  Map<String, dynamic> toJson() => $PrivacypolicyEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class PrivacypolicyData {
  @JSONField(name: "privacy_policy_page")
  PrivacypolicyDataPrivacyPolicyPage privacyPolicyPage = new PrivacypolicyDataPrivacyPolicyPage();
  @JSONField(name: "terms_and_conditions_page")
  PrivacypolicyDataTermsAndConditionsPage? termsAndConditionsPage;
  @JSONField(name: "support_page")
  PrivacypolicyDataSupportPage? supportPage;
  @JSONField(name: "about_us_page")
  PrivacypolicyDataAboutUsPage? aboutUsPage;

  PrivacypolicyData();

  factory PrivacypolicyData.fromJson(Map<String, dynamic> json) => $PrivacypolicyDataFromJson(json);

  Map<String, dynamic> toJson() => $PrivacypolicyDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class PrivacypolicyDataPrivacyPolicyPage {
  String? title = '';
  String content = '';

  PrivacypolicyDataPrivacyPolicyPage();

  factory PrivacypolicyDataPrivacyPolicyPage.fromJson(Map<String, dynamic> json) => $PrivacypolicyDataPrivacyPolicyPageFromJson(json);

  Map<String, dynamic> toJson() => $PrivacypolicyDataPrivacyPolicyPageToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class PrivacypolicyDataTermsAndConditionsPage {
  String? title = '';
  String? content = '';

  PrivacypolicyDataTermsAndConditionsPage();

  factory PrivacypolicyDataTermsAndConditionsPage.fromJson(Map<String, dynamic> json) => $PrivacypolicyDataTermsAndConditionsPageFromJson(json);

  Map<String, dynamic> toJson() => $PrivacypolicyDataTermsAndConditionsPageToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class PrivacypolicyDataSupportPage {
  String? title = '';
  String? content = '';

  PrivacypolicyDataSupportPage();

  factory PrivacypolicyDataSupportPage.fromJson(Map<String, dynamic> json) => $PrivacypolicyDataSupportPageFromJson(json);

  Map<String, dynamic> toJson() => $PrivacypolicyDataSupportPageToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class PrivacypolicyDataAboutUsPage {
  String? title = '';
  String? content = '';

  PrivacypolicyDataAboutUsPage();

  factory PrivacypolicyDataAboutUsPage.fromJson(Map<String, dynamic> json) => $PrivacypolicyDataAboutUsPageFromJson(json);

  Map<String, dynamic> toJson() => $PrivacypolicyDataAboutUsPageToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
