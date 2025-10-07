import 'dart:convert';

CartCountModel cartCountModelFromJson(String str) =>
    CartCountModel.fromJson(json.decode(str));

String cartCountModelToJson(CartCountModel data) => json.encode(data.toJson());

class CartCountModel {
  final int statusCode;
  final bool success;
  final String message;
  final CartCount data;
  final dynamic meta;

  CartCountModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
    required this.meta,
  });

  factory CartCountModel.fromJson(Map<String, dynamic> json) => CartCountModel(
    statusCode: json["statusCode"] ?? 0,
    success: json["success"] ?? false,
    message: json["message"] ?? '',
    data:
        json["data"] != null
            ? CartCount.fromJson(json["data"])
            : CartCount(totalCount: 0, totalAmount: 0),
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

class CartCount {
  final int totalCount;
  final double totalAmount;

  CartCount({required this.totalCount, required this.totalAmount});

  factory CartCount.fromJson(Map<String, dynamic> json) => CartCount(
    totalCount: json["totalCount"] ?? 0,
    totalAmount:
        (json["totalAmount"] != null)
            ? (json["totalAmount"] as num).toDouble()
            : 0.0,
  );

  Map<String, dynamic> toJson() => {
    "totalCount": totalCount,
    "totalAmount": totalAmount,
  };
}
