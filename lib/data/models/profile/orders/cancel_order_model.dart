import 'dart:convert';

CancelOrderModel cancelOrderModelFromJson(String str) =>
    CancelOrderModel.fromJson(json.decode(str));

String cancelOrderModelToJson(CancelOrderModel data) =>
    json.encode(data.toJson());

class CancelOrderModel {
  String message;
  CancelOrder order;

  CancelOrderModel({required this.message, required this.order});

  factory CancelOrderModel.fromJson(Map<String, dynamic> json) =>
      CancelOrderModel(
        message: json["message"] ?? "",
        order: CancelOrder.fromJson(json["order"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "order": order.toJson(),
  };
}

class CancelOrder {
  GeoLocation geoLocation;
  String id;
  String customer;
  String clientName;
  String location;
  String pincode;
  List<OrderDetail> orderDetails;
  String phone;
  int amount;
  String status;
  String store;
  String manager;
  String notes;
  bool isUrgent;
  String deliveryStatus;
  dynamic deliveryRejectionReason;
  String reason;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  CancelOrder({
    required this.geoLocation,
    required this.id,
    required this.customer,
    required this.clientName,
    required this.location,
    required this.pincode,
    required this.orderDetails,
    required this.phone,
    required this.amount,
    required this.status,
    required this.store,
    required this.manager,
    required this.notes,
    required this.isUrgent,
    required this.deliveryStatus,
    required this.deliveryRejectionReason,
    required this.reason,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory CancelOrder.fromJson(Map<String, dynamic> json) => CancelOrder(
    geoLocation: GeoLocation.fromJson(json["geoLocation"] ?? {}),
    id: json["_id"] ?? "",
    customer: json["customer"] ?? "",
    clientName: json["clientName"] ?? "",
    location: json["location"] ?? "",
    pincode: json["pincode"] ?? "",
    orderDetails: List<OrderDetail>.from(
      (json["orderDetails"] ?? []).map((x) => OrderDetail.fromJson(x)),
    ),
    phone: json["phone"] ?? "",
    amount: json["amount"] ?? 0,
    status: json["status"] ?? "",
    store: json["store"] ?? "",
    manager: json["manager"] ?? "",
    notes: json["notes"] ?? "",
    isUrgent: json["isUrgent"] ?? false,
    deliveryStatus: json["deliveryStatus"] ?? "",
    deliveryRejectionReason: json["deliveryRejectionReason"] ?? "",
    reason: json["reason"] ?? "",
    createdAt: DateTime.tryParse(json["createdAt"] ?? "") ?? DateTime(1970),
    updatedAt: DateTime.tryParse(json["updatedAt"] ?? "") ?? DateTime(1970),
    v: json["__v"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "geoLocation": geoLocation.toJson(),
    "_id": id,
    "customer": customer,
    "clientName": clientName,
    "location": location,
    "pincode": pincode,
    "orderDetails": List<dynamic>.from(orderDetails.map((x) => x.toJson())),
    "phone": phone,
    "amount": amount,
    "status": status,
    "store": store,
    "manager": manager,
    "notes": notes,
    "isUrgent": isUrgent,
    "deliveryStatus": deliveryStatus,
    "deliveryRejectionReason": deliveryRejectionReason,
    "reason": reason,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}

class GeoLocation {
  String type;
  List<double> coordinates;

  GeoLocation({required this.type, required this.coordinates});

  factory GeoLocation.fromJson(Map<String, dynamic> json) => GeoLocation(
    type: json["type"] ?? "",
    coordinates: List<double>.from(
      (json["coordinates"] ?? []).map((x) => (x ?? 0).toDouble()),
    ),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
  };
}

class OrderDetail {
  String name;
  int quantity;
  int price;
  String img;
  String orderId;
  String id;

  OrderDetail({
    required this.name,
    required this.quantity,
    required this.price,
    required this.img,
    required this.orderId,
    required this.id,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
    name: json["name"] ?? "",
    quantity: json["quantity"] ?? 0,
    price: json["price"] ?? 0,
    img: json["img"] ?? "",
    orderId: json["orderId"] ?? "",
    id: json["_id"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "quantity": quantity,
    "price": price,
    "img": img,
    "orderId": orderId,
    "_id": id,
  };
}
