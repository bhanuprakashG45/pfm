import 'dart:convert';

DeleteAddressModel deleteAddressModelFromJson(String str) =>
    DeleteAddressModel.fromJson(json.decode(str));

String deleteAddressModelToJson(DeleteAddressModel data) =>
    json.encode(data.toJson());

class DeleteAddressModel {
  int statusCode;
  bool success;
  String message;
  String data;
  dynamic meta;

  DeleteAddressModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
    required this.meta,
  });

  factory DeleteAddressModel.fromJson(Map<String, dynamic> json) =>
      DeleteAddressModel(
        statusCode: json["statusCode"] ?? 0,
        success: json["success"] ?? false,
        message: json["message"] ?? "",
        data: json["data"] ?? "",
        meta: json["meta"],
      );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "data": data,
    "meta": meta,
  };
}
