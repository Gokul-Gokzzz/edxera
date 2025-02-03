class AddJobModel {
  final int userId;
  final String title;
  final String description;
  final String contactEmail;
  final String contactWhatsappNumber;
  final int applyAllowedStatus;

  AddJobModel({
    required this.userId,
    required this.title,
    required this.description,
    required this.contactEmail,
    required this.contactWhatsappNumber,
    required this.applyAllowedStatus,
  });

  Map<String, dynamic> toJson() {
    return {
      "user_id": userId,
      "title": title,
      "description": description,
      "contact_email": contactEmail,
      "contact_whatsapp_number": contactWhatsappNumber,
      "apply_allowed_status": applyAllowedStatus,
    };
  }
}

class AddJobResponse {
  final bool status;
  final String message;

  AddJobResponse({
    required this.status,
    required this.message,
  });

  factory AddJobResponse.fromJson(Map<String, dynamic> json) {
    return AddJobResponse(
      status: json["status"] ?? false,
      message: json["message"] ?? "",
    );
  }
}
