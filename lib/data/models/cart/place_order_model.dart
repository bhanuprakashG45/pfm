// To parse this JSON data, do
//
//     final placeOrderModel = placeOrderModelFromJson(jsonString);

import 'dart:convert';

PlaceOrderModel placeOrderModelFromJson(String str) =>
    PlaceOrderModel.fromJson(json.decode(str));

String placeOrderModelToJson(PlaceOrderModel data) =>
    json.encode(data.toJson());

class PlaceOrderModel {
  int statusCode;
  bool success;
  String message;
  Data data;
  dynamic meta;

  PlaceOrderModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
    required this.meta,
  });

  factory PlaceOrderModel.fromJson(Map<String, dynamic> json) =>
      PlaceOrderModel(
        statusCode: json["statusCode"] ?? 0,
        success: json["success"] ?? false,
        message: json["message"] ?? "",
        data: Data.fromJson(json["data"] ?? {}),
        meta: json["meta"] ?? {},
      );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "data": data.toJson(),
    "meta": meta ?? {},
  };
}

class Data {
  String order;
  DateTime orderedAt;
  String id;

  Data({required this.order, required this.orderedAt, required this.id});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    order: json["order"] ?? "",
    orderedAt:
        (json["orderedAt"] != null && json["orderedAt"] != "")
            ? DateTime.tryParse(json["orderedAt"]) ?? DateTime(1970)
            : DateTime(1970),
    id: json["_id"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "order": order,
    "orderedAt": orderedAt.toIso8601String(),
    "_id": id,
  };
}
