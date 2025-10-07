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
        message: json["message"] ?? "",
        data:
            json["data"] == null
                ? TrackorderData.empty()
                : TrackorderData.fromJson(json["data"]),
        meta: json["meta"] ?? {},
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
  Stages stages;
  DisplayOrder displayOrder;

  TrackorderData({
    required this.orderId,
    required this.status,
    required this.deliveryStatus,
    required this.stages,
    required this.displayOrder,
  });

  factory TrackorderData.fromJson(Map<String, dynamic> json) => TrackorderData(
    orderId: json["orderId"] ?? "",
    status: json["status"] ?? "",
    deliveryStatus: json["deliveryStatus"] ?? "",
    stages:
        json["stages"] == null
            ? Stages.empty()
            : Stages.fromJson(json["stages"]),
    displayOrder:
        json["displayOrder"] == null
            ? DisplayOrder.empty()
            : DisplayOrder.fromJson(json["displayOrder"]),
  );

  Map<String, dynamic> toJson() => {
    "orderId": orderId,
    "status": status,
    "deliveryStatus": deliveryStatus,
    "stages": stages.toJson(),
    "displayOrder": displayOrder.toJson(),
  };

  factory TrackorderData.empty() => TrackorderData(
    orderId: "",
    status: "",
    deliveryStatus: "",
    stages: Stages.empty(),
    displayOrder: DisplayOrder.empty(),
  );
}

class DisplayOrder {
  TrackGeoLocation geoLocation;
  String id;
  String customer;
  String clientName;
  String location;
  String pincode;
  List<TrackOrderDetail> orderDetails;
  String phone;
  double amount;
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

  DisplayOrder({
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

  factory DisplayOrder.fromJson(Map<String, dynamic> json) => DisplayOrder(
    geoLocation:
        json["geoLocation"] == null
            ? TrackGeoLocation.empty()
            : TrackGeoLocation.fromJson(json["geoLocation"]),
    id: json["_id"] ?? "",
    customer: json["customer"] ?? "",
    clientName: json["clientName"] ?? "",
    location: json["location"] ?? "",
    pincode: json["pincode"] ?? "",
    orderDetails:
        json["orderDetails"] == null
            ? []
            : List<TrackOrderDetail>.from(
              json["orderDetails"].map((x) => TrackOrderDetail.fromJson(x)),
            ),
    phone: json["phone"] ?? "",
    amount: (json["amount"] ?? 0).toDouble(),
    status: json["status"] ?? "",
    store: json["store"] ?? "",
    manager: json["manager"] ?? "",
    notes: json["notes"] ?? "",
    isUrgent: json["isUrgent"] ?? false,
    deliveryStatus: json["deliveryStatus"] ?? "",
    deliveryRejectionReason: json["deliveryRejectionReason"] ?? "",
    reason: json["reason"] ?? "",
    createdAt:
        json["createdAt"] == null
            ? DateTime(1970)
            : DateTime.parse(json["createdAt"]),
    updatedAt:
        json["updatedAt"] == null
            ? DateTime(1970)
            : DateTime.parse(json["updatedAt"]),
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

  factory DisplayOrder.empty() => DisplayOrder(
    geoLocation: TrackGeoLocation.empty(),
    id: "",
    customer: "",
    clientName: "",
    location: "",
    pincode: "",
    orderDetails: [],
    phone: "",
    amount: 0.0,
    status: "",
    store: "",
    manager: "",
    notes: "",
    isUrgent: false,
    deliveryStatus: "",
    deliveryRejectionReason: "",
    reason: "",
    createdAt: DateTime(1970),
    updatedAt: DateTime(1970),
    v: 0,
  );
}

class TrackGeoLocation {
  String type;
  List<double> coordinates;

  TrackGeoLocation({required this.type, required this.coordinates});

  factory TrackGeoLocation.fromJson(Map<String, dynamic> json) =>
      TrackGeoLocation(
        type: json["type"] ?? "",
        coordinates:
            json["coordinates"] == null
                ? []
                : List<double>.from(
                  json["coordinates"].map((x) => (x ?? 0).toDouble()),
                ),
      );

  Map<String, dynamic> toJson() => {
    "type": type,
    "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
  };

  factory TrackGeoLocation.empty() =>
      TrackGeoLocation(type: "", coordinates: []);
}

class TrackOrderDetail {
  String name;
  int quantity;
  double price;
  String img;
  String orderId;
  String id;

  TrackOrderDetail({
    required this.name,
    required this.quantity,
    required this.price,
    required this.img,
    required this.orderId,
    required this.id,
  });

  factory TrackOrderDetail.fromJson(Map<String, dynamic> json) =>
      TrackOrderDetail(
        name: json["name"] ?? "",
        quantity: json["quantity"] ?? 0,
        price: (json["price"] ?? 0).toDouble(),
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

  factory TrackOrderDetail.empty() => TrackOrderDetail(
    name: "",
    quantity: 0,
    price: 0,
    img: "",
    orderId: "",
    id: "",
  );
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
