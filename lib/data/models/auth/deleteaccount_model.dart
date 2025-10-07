import 'dart:convert';

DeleteAccountModel deleteAccountModelFromJson(String str) =>
    DeleteAccountModel.fromJson(json.decode(str));

String deleteAccountModelToJson(DeleteAccountModel data) =>
    json.encode(data.toJson());

class DeleteAccountModel {
  final int statusCode;
  final bool success;
  final String message;
  final Data data;
  final dynamic meta;

  DeleteAccountModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
    this.meta,
  });

  factory DeleteAccountModel.fromJson(Map<String, dynamic> json) =>
      DeleteAccountModel(
        statusCode: json["statusCode"] ?? 0, // default 0 if null
        success: json["success"] ?? false, // default false if null
        message: json["message"] ?? "", // default empty string
        data:
            json["data"] != null
                ? Data.fromJson(json["data"])
                : Data(), // safe fallback
        meta: json["meta"], // meta can stay null/dynamic
      );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "data": data.toJson(),
    "meta": meta,
  };
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
