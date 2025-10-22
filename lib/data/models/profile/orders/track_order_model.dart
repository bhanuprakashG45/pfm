import 'dart:convert';

TrackOrderModel trackOrderModelFromJson(String str) =>
    TrackOrderModel.fromJson(json.decode(str));

String trackOrderModelToJson(TrackOrderModel data) =>
    json.encode(data.toJson());

class TrackOrderModel {
  int statusCode;
  bool success;
  String message;
  TrackorderData data;
  dynamic meta;

  TrackOrderModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
    required this.meta,
  });

  factory TrackOrderModel.fromJson(Map<String, dynamic> json) =>
      TrackOrderModel(
        statusCode: json["statusCode"] ?? 0,
        success: json["success"] ?? false,
        message: json["message"] ?? '',
        data: json["data"] != null
            ? TrackorderData.fromJson(json["data"])
            : TrackorderData.empty(),
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

class TrackorderData {
  String orderId;
  String status;
  String deliveryStatus;
  bool isCancelled;
  bool isRejected;
  Stages stages;
  Customer customer;
  Customer? deliveryPartner;
  TrackStore store;
  Manager manager;
  List<Item> items;
  int amount;
  dynamic deliveryRejectionReason;
  String notes;
  DateTime? createdAt;
  DateTime? updatedAt;

  TrackorderData({
    required this.orderId,
    required this.status,
    required this.deliveryStatus,
    required this.isCancelled,
    required this.isRejected,
    required this.stages,
    required this.customer,
    this.deliveryPartner,
    required this.store,
    required this.manager,
    required this.items,
    required this.amount,
    required this.deliveryRejectionReason,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TrackorderData.fromJson(Map<String, dynamic> json) => TrackorderData(
        orderId: json["orderId"] ?? '',
        status: json["status"] ?? '',
        deliveryStatus: json["deliveryStatus"] ?? '',
        isCancelled: json["isCancelled"] ?? false,
        isRejected: json["isRejected"] ?? false,
        stages: Stages.fromJson(json["stages"] ?? {}),
        customer: Customer.fromJson(json["customer"] ?? {}),
        deliveryPartner: json["deliveryPartner"] != null
            ? Customer.fromJson(json["deliveryPartner"])
            : null,
        store: TrackStore.fromJson(json["store"] ?? {}),
        manager: Manager.fromJson(json["manager"] ?? {}),
        items:
            (json["items"] as List?)?.map((x) => Item.fromJson(x)).toList() ??
                [],
        amount: json["amount"] ?? 0,
        deliveryRejectionReason: json["deliveryRejectionReason"],
        notes: json["notes"] ?? '',
        createdAt: json["createdAt"] != null
            ? DateTime.tryParse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.tryParse(json["updatedAt"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "status": status,
        "deliveryStatus": deliveryStatus,
        "isCancelled": isCancelled,
        "isRejected": isRejected,
        "stages": stages.toJson(),
        "customer": customer.toJson(),
        "deliveryPartner": deliveryPartner?.toJson(),
        "store": store.toJson(),
        "manager": manager.toJson(),
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "amount": amount,
        "deliveryRejectionReason": deliveryRejectionReason,
        "notes": notes,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };

  factory TrackorderData.empty() => TrackorderData(
        orderId: '',
        status: '',
        deliveryStatus: '',
        isCancelled: false,
        isRejected: false,
        stages: Stages.empty(),
        customer: Customer.empty(),
        deliveryPartner: null,
        store: TrackStore.empty(),
        manager: Manager.empty(),
        items: [],
        amount: 0,
        deliveryRejectionReason: null,
        notes: '',
        createdAt: null,
        updatedAt: null,
      );
}

class Customer {
  String id;
  String name;
  String phone;

  Customer({
    required this.id,
    required this.name,
    required this.phone,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["_id"] ?? '',
        name: json["name"] ?? '',
        phone: json["phone"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "phone": phone,
      };

  factory Customer.empty() => Customer(id: '', name: '', phone: '');
}

class Item {
  String name;
  int quantity;
  int price;
  String unit;
  String weight;
  String img;
  String orderId;
  String id;

  Item({
    required this.name,
    required this.quantity,
    required this.price,
    required this.unit,
    required this.weight,
    required this.img,
    required this.orderId,
    required this.id,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        name: json["name"] ?? '',
        quantity: json["quantity"] ?? 0,
        price: json["price"] ?? 0,
        unit: json["unit"] ?? '',
        weight: json["weight"] ?? '',
        img: json["img"] ?? '',
        orderId: json["orderId"] ?? '',
        id: json["_id"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "quantity": quantity,
        "price": price,
        "unit": unit,
        "weight": weight,
        "img": img,
        "orderId": orderId,
        "_id": id,
      };
}

class Manager {
  String id;
  String phone;

  Manager({
    required this.id,
    required this.phone,
  });

  factory Manager.fromJson(Map<String, dynamic> json) => Manager(
        id: json["_id"] ?? '',
        phone: json["phone"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "phone": phone,
      };

  factory Manager.empty() => Manager(id: '', phone: '');
}

class Stages {
  bool pending;
  bool accepted;
  bool pickedUp;
  bool inTransit;
  bool delivered;
  bool cancelled;
  bool rejected;

  Stages({
    required this.pending,
    required this.accepted,
    required this.pickedUp,
    required this.inTransit,
    required this.delivered,
    required this.cancelled,
    required this.rejected,
  });

  factory Stages.fromJson(Map<String, dynamic> json) => Stages(
        pending: json["pending"] ?? false,
        accepted: json["accepted"] ?? false,
        pickedUp: json["picked_up"] ?? false,
        inTransit: json["in_transit"] ?? false,
        delivered: json["delivered"] ?? false,
        cancelled: json["cancelled"] ?? false,
        rejected: json["rejected"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "pending": pending,
        "accepted": accepted,
        "picked_up": pickedUp,
        "in_transit": inTransit,
        "delivered": delivered,
        "cancelled": cancelled,
        "rejected": rejected,
      };

  factory Stages.empty() => Stages(
        pending: false,
        accepted: false,
        pickedUp: false,
        inTransit: false,
        delivered: false,
        cancelled: false,
        rejected: false,
      );
}

class TrackStore {
  String id;
  String name;

  TrackStore({
    required this.id,
    required this.name,
  });

  factory TrackStore.fromJson(Map<String, dynamic> json) => TrackStore(
        id: json["_id"] ?? '',
        name: json["name"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };

  factory TrackStore.empty() => TrackStore(id: '', name: '');
}
