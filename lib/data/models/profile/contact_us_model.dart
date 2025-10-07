// contact_us_model.dart
class ContactResponse {
  final bool success;
  final List<String> data;
  final String message;

  ContactResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory ContactResponse.fromJson(Map<String, dynamic> json) {
    return ContactResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null 
        ? List<String>.from(json['data']) 
        : [],
    );
  }
}