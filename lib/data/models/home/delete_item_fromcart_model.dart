import 'dart:convert';

DeleteCartItemModel deleteCartItemModelFromJson(String str) =>
    DeleteCartItemModel.fromJson(json.decode(str));

String deleteCartItemModelToJson(DeleteCartItemModel data) =>
    json.encode(data.toJson());

class DeleteCartItemModel {
  int statusCode;
  bool success;
  String message;
  Data data;
  dynamic meta;

  DeleteCartItemModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
    required this.meta,
  });

  factory DeleteCartItemModel.fromJson(Map<String, dynamic> json) =>
      DeleteCartItemModel(
        statusCode: json["statusCode"] ?? 0,
        success: json["success"] ?? false,
        message: json["message"] ?? '',
        data:
            json["data"] != null
                ? Data.fromJson(json["data"])
                : Data(orders: [], totalItems: 0),
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

class Data {
  List<Order> orders;
  int totalItems;

  Data({required this.orders, required this.totalItems});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    orders:
        json["orders"] != null
            ? List<Order>.from(json["orders"].map((x) => Order.fromJson(x)))
            : [],
    totalItems: json["totalItems"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
    "totalItems": totalItems,
  };
}

class Order {
  String subCategory;
  int count;
  String id;
  DateTime orderedAt;

  Order({
    required this.subCategory,
    required this.count,
    required this.id,
    required this.orderedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    subCategory: json["subCategory"] ?? '',
    count: json["count"] ?? 0,
    id: json["_id"] ?? '',
    orderedAt:
        json["orderedAt"] != null
            ? DateTime.tryParse(json["orderedAt"]) ?? DateTime.now()
            : DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    "subCategory": subCategory,
    "count": count,
    "_id": id,
    "orderedAt": orderedAt.toIso8601String(),
  };
}
