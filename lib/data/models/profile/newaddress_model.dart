import 'dart:convert';

NewAddressModel newAddressModelFromJson(String str) =>
    NewAddressModel.fromJson(json.decode(str));

String newAddressModelToJson(NewAddressModel data) =>
    json.encode(data.toJson());

class NewAddressModel {
  int statusCode;
  bool success;
  String message;
  String data;
  dynamic meta;

  NewAddressModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
    required this.meta,
  });

  factory NewAddressModel.fromJson(Map<String, dynamic> json) =>
      NewAddressModel(
        statusCode: json["statusCode"] ?? 0,
        success: json["success"] ?? false,
        message: json["message"] ?? "",
        data: json["data"] ?? "",
        meta: json["meta"] ?? {},
      );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "data": data,
    "meta": meta,
  };
}
