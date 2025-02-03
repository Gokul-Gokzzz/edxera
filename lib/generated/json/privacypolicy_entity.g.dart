import 'package:edxera/generated/json/base/json_convert_content.dart';
import 'package:edxera/profile/Models/privacypolicy_entity.dart';

PrivacypolicyEntity $PrivacypolicyEntityFromJson(Map<String, dynamic> json) {
  final PrivacypolicyEntity privacypolicyEntity = PrivacypolicyEntity();
  final bool? success = jsonConvert.convert<bool>(json['success']);
  if (success != null) {
    privacypolicyEntity.success = success;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    privacypolicyEntity.message = message;
  }
  final PrivacypolicyData? data = jsonConvert.convert<PrivacypolicyData>(json['data']);
  if (data != null) {
    privacypolicyEntity.data = data;
  }
  return privacypolicyEntity;
}

Map<String, dynamic> $PrivacypolicyEntityToJson(PrivacypolicyEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['success'] = entity.success;
  data['message'] = entity.message;
  data['data'] = entity.data?.toJson();
  return data;
}

extension PrivacypolicyEntityExtension on PrivacypolicyEntity {
  PrivacypolicyEntity copyWith({
    bool? success,
    String? message,
    PrivacypolicyData? data,
  }) {
    return PrivacypolicyEntity()
      ..success = success ?? this.success
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

PrivacypolicyData $PrivacypolicyDataFromJson(Map<String, dynamic> json) {
  final PrivacypolicyData privacypolicyData = PrivacypolicyData();
  final PrivacypolicyDataPrivacyPolicyPage? privacyPolicyPage = jsonConvert.convert<PrivacypolicyDataPrivacyPolicyPage>(json['privacy_policy_page']);
  if (privacyPolicyPage != null) {
    privacypolicyData.privacyPolicyPage = privacyPolicyPage;
  }
  final PrivacypolicyDataTermsAndConditionsPage? termsAndConditionsPage =
      jsonConvert.convert<PrivacypolicyDataTermsAndConditionsPage>(json['terms_and_conditions_page']);
  if (termsAndConditionsPage != null) {
    privacypolicyData.termsAndConditionsPage = termsAndConditionsPage;
  }
  final PrivacypolicyDataSupportPage? supportPage = jsonConvert.convert<PrivacypolicyDataSupportPage>(json['support_page']);
  if (supportPage != null) {
    privacypolicyData.supportPage = supportPage;
  }
  final PrivacypolicyDataAboutUsPage? aboutUsPage = jsonConvert.convert<PrivacypolicyDataAboutUsPage>(json['about_us_page']);
  if (aboutUsPage != null) {
    privacypolicyData.aboutUsPage = aboutUsPage;
  }
  return privacypolicyData;
}

Map<String, dynamic> $PrivacypolicyDataToJson(PrivacypolicyData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['privacy_policy_page'] = entity.privacyPolicyPage.toJson();
  data['terms_and_conditions_page'] = entity.termsAndConditionsPage?.toJson();
  data['support_page'] = entity.supportPage?.toJson();
  data['about_us_page'] = entity.aboutUsPage?.toJson();
  return data;
}

extension PrivacypolicyDataExtension on PrivacypolicyData {
  PrivacypolicyData copyWith({
    PrivacypolicyDataPrivacyPolicyPage? privacyPolicyPage,
    PrivacypolicyDataTermsAndConditionsPage? termsAndConditionsPage,
    PrivacypolicyDataSupportPage? supportPage,
    PrivacypolicyDataAboutUsPage? aboutUsPage,
  }) {
    return PrivacypolicyData()
      ..privacyPolicyPage = privacyPolicyPage ?? this.privacyPolicyPage
      ..termsAndConditionsPage = termsAndConditionsPage ?? this.termsAndConditionsPage
      ..supportPage = supportPage ?? this.supportPage
      ..aboutUsPage = aboutUsPage ?? this.aboutUsPage;
  }
}

PrivacypolicyDataPrivacyPolicyPage $PrivacypolicyDataPrivacyPolicyPageFromJson(Map<String, dynamic> json) {
  final PrivacypolicyDataPrivacyPolicyPage privacypolicyDataPrivacyPolicyPage = PrivacypolicyDataPrivacyPolicyPage();
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    privacypolicyDataPrivacyPolicyPage.title = title;
  }
  final String? content = jsonConvert.convert<String>(json['content']);
  if (content != null) {
    privacypolicyDataPrivacyPolicyPage.content = content;
  }
  return privacypolicyDataPrivacyPolicyPage;
}

Map<String, dynamic> $PrivacypolicyDataPrivacyPolicyPageToJson(PrivacypolicyDataPrivacyPolicyPage entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['title'] = entity.title;
  data['content'] = entity.content;
  return data;
}

extension PrivacypolicyDataPrivacyPolicyPageExtension on PrivacypolicyDataPrivacyPolicyPage {
  PrivacypolicyDataPrivacyPolicyPage copyWith({
    String? title,
    String? content,
  }) {
    return PrivacypolicyDataPrivacyPolicyPage()
      ..title = title ?? this.title
      ..content = content ?? this.content;
  }
}

PrivacypolicyDataTermsAndConditionsPage $PrivacypolicyDataTermsAndConditionsPageFromJson(Map<String, dynamic> json) {
  final PrivacypolicyDataTermsAndConditionsPage privacypolicyDataTermsAndConditionsPage = PrivacypolicyDataTermsAndConditionsPage();
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    privacypolicyDataTermsAndConditionsPage.title = title;
  }
  final String? content = jsonConvert.convert<String>(json['content']);
  if (content != null) {
    privacypolicyDataTermsAndConditionsPage.content = content;
  }
  return privacypolicyDataTermsAndConditionsPage;
}

Map<String, dynamic> $PrivacypolicyDataTermsAndConditionsPageToJson(PrivacypolicyDataTermsAndConditionsPage entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['title'] = entity.title;
  data['content'] = entity.content;
  return data;
}

extension PrivacypolicyDataTermsAndConditionsPageExtension on PrivacypolicyDataTermsAndConditionsPage {
  PrivacypolicyDataTermsAndConditionsPage copyWith({
    String? title,
    String? content,
  }) {
    return PrivacypolicyDataTermsAndConditionsPage()
      ..title = title ?? this.title
      ..content = content ?? this.content;
  }
}

PrivacypolicyDataSupportPage $PrivacypolicyDataSupportPageFromJson(Map<String, dynamic> json) {
  final PrivacypolicyDataSupportPage privacypolicyDataSupportPage = PrivacypolicyDataSupportPage();
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    privacypolicyDataSupportPage.title = title;
  }
  final String? content = jsonConvert.convert<String>(json['content']);
  if (content != null) {
    privacypolicyDataSupportPage.content = content;
  }
  return privacypolicyDataSupportPage;
}

Map<String, dynamic> $PrivacypolicyDataSupportPageToJson(PrivacypolicyDataSupportPage entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['title'] = entity.title;
  data['content'] = entity.content;
  return data;
}

extension PrivacypolicyDataSupportPageExtension on PrivacypolicyDataSupportPage {
  PrivacypolicyDataSupportPage copyWith({
    String? title,
    String? content,
  }) {
    return PrivacypolicyDataSupportPage()
      ..title = title ?? this.title
      ..content = content ?? this.content;
  }
}

PrivacypolicyDataAboutUsPage $PrivacypolicyDataAboutUsPageFromJson(Map<String, dynamic> json) {
  final PrivacypolicyDataAboutUsPage privacypolicyDataAboutUsPage = PrivacypolicyDataAboutUsPage();
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    privacypolicyDataAboutUsPage.title = title;
  }
  final String? content = jsonConvert.convert<String>(json['content']);
  if (content != null) {
    privacypolicyDataAboutUsPage.content = content;
  }
  return privacypolicyDataAboutUsPage;
}

Map<String, dynamic> $PrivacypolicyDataAboutUsPageToJson(PrivacypolicyDataAboutUsPage entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['title'] = entity.title;
  data['content'] = entity.content;
  return data;
}

extension PrivacypolicyDataAboutUsPageExtension on PrivacypolicyDataAboutUsPage {
  PrivacypolicyDataAboutUsPage copyWith({
    String? title,
    String? content,
  }) {
    return PrivacypolicyDataAboutUsPage()
      ..title = title ?? this.title
      ..content = content ?? this.content;
  }
}
