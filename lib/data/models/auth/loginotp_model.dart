import 'dart:convert';

LoginOtpModel loginOtpModelFromJson(String str) =>
    LoginOtpModel.fromJson(json.decode(str));

String loginOtpModelToJson(LoginOtpModel data) => json.encode(data.toJson());

class LoginOtpModel {
  int statusCode;
  bool success;
  String message;
  OtpData data;
  dynamic meta;

  LoginOtpModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
    required this.meta,
  });

  factory LoginOtpModel.fromJson(Map<String, dynamic> json) => LoginOtpModel(
    statusCode: json["statusCode"] ?? 0,
    success: json["success"] ?? false,
    message: json["message"] ?? "No message",
    data:
        json["data"] != null
            ? OtpData.fromJson(json["data"])
            : OtpData(userId: ""),
    meta: json["meta"],
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "data": data.toJson(),
    "meta": meta,
  };
}

class OtpData {
  String userId;

  OtpData({required this.userId});

  factory OtpData.fromJson(Map<String, dynamic> json) =>
      OtpData(userId: json["userId"] ?? "");

  Map<String, dynamic> toJson() => {"userId": userId};
}
