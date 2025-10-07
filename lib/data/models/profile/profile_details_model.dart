import 'dart:convert';

ProfileDetailsModel profileDetailsModelFromJson(String str) =>
    ProfileDetailsModel.fromJson(json.decode(str));

String profileDetailsModelToJson(ProfileDetailsModel data) =>
    json.encode(data.toJson());

class ProfileDetailsModel {
  int statusCode;
  bool success;
  String message;
  ProfileData data;
  dynamic meta;

  ProfileDetailsModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
    required this.meta,
  });

  factory ProfileDetailsModel.fromJson(Map<String, dynamic> json) =>
      ProfileDetailsModel(
        statusCode: json["statusCode"] ?? 0,
        success: json["success"] ?? false,
        message: json["message"] ?? "",
        data:
            json["data"] != null
                ? ProfileData.fromJson(json["data"])
                : ProfileData.empty(),
        meta: json["meta"] ?? {},
      );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "data": data.toJson(),
    "meta": meta,
  };
}

class ProfileData {
  String name;
  String phone;
  String email;

  ProfileData({required this.name, required this.phone, required this.email});

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
    name: json["name"] ?? "",
    phone: json["phone"] ?? "",
    email: json["email"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "phone": phone,
    "email": email,
  };

  factory ProfileData.empty() => ProfileData(name: "", phone: "", email: "");
}
