import 'dart:convert';

DeleteOrderHistoryModel deleteOrderHistoryModelFromJson(String str) =>
    DeleteOrderHistoryModel.fromJson(json.decode(str));

String deleteOrderHistoryModelToJson(DeleteOrderHistoryModel data) =>
    json.encode(data.toJson());

class DeleteOrderHistoryModel {
  int statusCode;
  bool success;
  String message;
  String? data;
  dynamic meta;

  DeleteOrderHistoryModel({
    required this.statusCode,
    required this.success,
    required this.message,
    this.data,
    this.meta,
  });

  factory DeleteOrderHistoryModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return DeleteOrderHistoryModel(
        statusCode: 0,
        success: false,
        message: '',
        data: null,
        meta: null,
      );
    }

    return DeleteOrderHistoryModel(
      statusCode: json["statusCode"] ?? 0,
      success: json["success"] ?? false,
      message: json["message"] ?? '',
      data: json["data"],
      meta: json["meta"],
    );
  }

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "data": data,
    "meta": meta,
  };
}
