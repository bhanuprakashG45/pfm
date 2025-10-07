import 'dart:convert';

ActiveOrderModel activeOrderModelFromJson(String str) =>
    ActiveOrderModel.fromJson(json.decode(str));

String activeOrderModelToJson(ActiveOrderModel data) =>
    json.encode(data.toJson());

class ActiveOrderModel {
  int statusCode;
  bool success;
  String message;
  List<ActiveOrderData> data;
  dynamic meta;

  ActiveOrderModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
    required this.meta,
  });

  factory ActiveOrderModel.fromJson(Map<String, dynamic> json) =>
      ActiveOrderModel(
        statusCode: json["statusCode"] ?? 0,
        success: json["success"] ?? false,
        message: json["message"] ?? "",
        data:
            json["data"] == null
                ? []
                : List<ActiveOrderData>.from(
                  json["data"].map((x) => ActiveOrderData.fromJson(x)),
                ),
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

class ActiveOrderData {
  String orderId;
  String status;
  ActiveStore store;
  List<ActiveItem> items;
  ActiveTimestamps timestamps;

  ActiveOrderData({
    required this.orderId,
    required this.status,
    required this.store,
    required this.items,
    required this.timestamps,
  });

  factory ActiveOrderData.fromJson(Map<String, dynamic> json) =>
      ActiveOrderData(
        orderId: json["orderId"] ?? "",
        status: json["status"] ?? "",
        store:
            json["store"] == null
                ? ActiveStore(name: "", address: "", phone: "")
                : ActiveStore.fromJson(json["store"]),
        items:
            json["items"] == null
                ? []
                : List<ActiveItem>.from(
                  json["items"].map((x) => ActiveItem.fromJson(x)),
                ),
        timestamps:
            json["timestamps"] == null
                ? ActiveTimestamps(orderedAt: DateTime.now(), deliveredAt: null)
                : ActiveTimestamps.fromJson(json["timestamps"]),
      );

  Map<String, dynamic> toJson() => {
    "orderId": orderId,
    "status": status,
    "store": store.toJson(),
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "timestamps": timestamps.toJson(),
  };
}

class ActiveItem {
  String name;
  int quantity;
  double price;
  double total;
  String image;

  ActiveItem({
    required this.name,
    required this.quantity,
    required this.price,
    required this.total,
    required this.image,
  });

  factory ActiveItem.fromJson(Map<String, dynamic> json) => ActiveItem(
    name: json["name"] ?? "",
    quantity: json["quantity"] != null ? (json["quantity"] as num).toInt() : 0,
    price: json["price"] != null ? (json["price"] as num).toDouble() : 0.0,
    total: json["total"] != null ? (json["total"] as num).toDouble() : 0.0,
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

class ActiveStore {
  String name;
  String address;
  String phone;

  ActiveStore({required this.name, required this.address, required this.phone});

  factory ActiveStore.fromJson(Map<String, dynamic> json) => ActiveStore(
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

class ActiveTimestamps {
  DateTime orderedAt;
  dynamic deliveredAt;

  ActiveTimestamps({required this.orderedAt, required this.deliveredAt});

  factory ActiveTimestamps.fromJson(Map<String, dynamic> json) =>
      ActiveTimestamps(
        orderedAt:
            json["orderedAt"] == null
                ? DateTime.now()
                : DateTime.tryParse(json["orderedAt"]) ?? DateTime.now(),
        deliveredAt: json["deliveredAt"],
      );

  Map<String, dynamic> toJson() => {
    "orderedAt": orderedAt.toIso8601String(),
    "deliveredAt": deliveredAt,
  };
}
