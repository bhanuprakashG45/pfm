import 'dart:convert';

OrderHistoryModel orderHistoryModelFromJson(String str) =>
    OrderHistoryModel.fromJson(json.decode(str));

String orderHistoryModelToJson(OrderHistoryModel data) =>
    json.encode(data.toJson());

class OrderHistoryModel {
  final int statusCode;
  final bool success;
  final String message;
  final List<OrderHistory> data;
  final dynamic meta;

  OrderHistoryModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
    this.meta,
  });

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) =>
      OrderHistoryModel(
        statusCode: json["statusCode"] ?? 0,
        success: json["success"] ?? false,
        message: json["message"] ?? "",
        data:
            (json["data"] as List<dynamic>?)
                ?.map((x) => OrderHistory.fromJson(x))
                .toList() ??
            [],
        meta: json["meta"],
      );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "meta": meta,
  };
}

class OrderHistory {
  final String orderId;
  final String status;
  final Store store;
  final List<Item> items;
  final Timestamps timestamps;

  OrderHistory({
    this.orderId = "",
    this.status = "",
    required this.store,
    this.items = const [],
    required this.timestamps,
  });

  factory OrderHistory.fromJson(Map<String, dynamic> json) => OrderHistory(
    orderId: json["orderId"] ?? "",
    status: json["status"] ?? "",
    store: Store.fromJson(json["store"] ?? {}),
    items:
        (json["items"] as List<dynamic>?)
            ?.map((x) => Item.fromJson(x))
            .toList() ??
        [],
    timestamps: Timestamps.fromJson(json["timestamps"] ?? {}),
  );

  Map<String, dynamic> toJson() => {
    "orderId": orderId,
    "status": status,
    "store": store.toJson(),
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "timestamps": timestamps.toJson(),
  };
}

class Store {
  final String name;
  final String address;
  final String phone;

  Store({this.name = "", this.address = "", this.phone = ""});

  factory Store.fromJson(Map<String, dynamic> json) => Store(
    name: json["name"] ?? "",
    address: json["address"] ?? "",
    phone: json["phone"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "address": address,
    "phone": phone,
  };
}

class Item {
  final String name;
  final int quantity;
  final int price;
  final int total;
  final String image;

  Item({
    this.name = "",
    this.quantity = 0,
    this.price = 0,
    this.total = 0,
    this.image = "",
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    name: json["name"] ?? "",
    quantity: json["quantity"] ?? 0,
    price: json["price"] ?? 0,
    total: json["total"] ?? 0,
    image: json["image"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "quantity": quantity,
    "price": price,
    "total": total,
    "image": image,
  };
}

class Timestamps {
  final DateTime orderedAt;
  final DateTime? deliveredAt;

  Timestamps({required this.orderedAt, this.deliveredAt});

  factory Timestamps.fromJson(Map<String, dynamic> json) => Timestamps(
    orderedAt:
        json["orderedAt"] != null
            ? DateTime.tryParse(json["orderedAt"]) ?? DateTime.now()
            : DateTime.now(),
    deliveredAt:
        json["deliveredAt"] != null
            ? DateTime.tryParse(json["deliveredAt"])
            : null,
  );

  Map<String, dynamic> toJson() => {
    "orderedAt": orderedAt.toIso8601String(),
    "deliveredAt": deliveredAt?.toIso8601String(),
  };
}
