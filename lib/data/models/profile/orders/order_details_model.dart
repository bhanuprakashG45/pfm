import 'dart:convert';

OrderDetailsModel orderDetailsModelFromJson(String str) =>
    OrderDetailsModel.fromJson(json.decode(str));

String orderDetailsModelToJson(OrderDetailsModel data) =>
    json.encode(data.toJson());

class OrderDetailsModel {
  final int statusCode;
  final bool success;
  final String message;
  final OrderDetailsData data;
  final dynamic meta;

  OrderDetailsModel({
    this.statusCode = 0,
    this.success = false,
    this.message = "",
    required this.data,
    this.meta,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailsModel(
        statusCode: json["statusCode"] ?? 0,
        success: json["success"] ?? false,
        message: json["message"] ?? "",
        data: OrderDetailsData.fromJson(json["data"] ?? {}),
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

class OrderDetailsData {
  final String orderId;
  final String status;
  final StoreDetails store;
  final List<ItemDetails> items;
  final BillDetails billDetails;
  final DeliveryAddress deliveryAddress;
  final TimestampsDetails timestamps;

  OrderDetailsData({
    this.orderId = "",
    this.status = "",
    required this.store,
    this.items = const [],
    required this.billDetails,
    required this.deliveryAddress,
    required this.timestamps,
  });

  factory OrderDetailsData.fromJson(Map<String, dynamic> json) =>
      OrderDetailsData(
        orderId: json["orderId"] ?? "",
        status: json["status"] ?? "",
        store: StoreDetails.fromJson(json["store"] ?? {}),
        items:
            (json["items"] as List<dynamic>?)
                ?.map((x) => ItemDetails.fromJson(x))
                .toList() ??
            [],
        billDetails: BillDetails.fromJson(json["billDetails"] ?? {}),
        deliveryAddress: DeliveryAddress.fromJson(
          json["deliveryAddress"] ?? {},
        ),
        timestamps: TimestampsDetails.fromJson(json["timestamps"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
    "orderId": orderId,
    "status": status,
    "store": store.toJson(),
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "billDetails": billDetails.toJson(),
    "deliveryAddress": deliveryAddress.toJson(),
    "timestamps": timestamps.toJson(),
  };
}

class BillDetails {
  final int itemTotal;
  final int deliveryCharges;
  final int discount;
  final int grandTotal;

  BillDetails({
    this.itemTotal = 0,
    this.deliveryCharges = 0,
    this.discount = 0,
    this.grandTotal = 0,
  });

  factory BillDetails.fromJson(Map<String, dynamic> json) => BillDetails(
    itemTotal: json["itemTotal"] ?? 0,
    deliveryCharges: json["deliveryCharges"] ?? 0,
    discount: json["discount"] ?? 0,
    grandTotal: json["grandTotal"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "itemTotal": itemTotal,
    "deliveryCharges": deliveryCharges,
    "discount": discount,
    "grandTotal": grandTotal,
  };
}

class DeliveryAddress {
  final String name;
  final String location;
  final String pincode;
  final String phone;

  DeliveryAddress({
    this.name = "",
    this.location = "",
    this.pincode = "",
    this.phone = "",
  });

  factory DeliveryAddress.fromJson(Map<String, dynamic> json) =>
      DeliveryAddress(
        name: json["name"] ?? "",
        location: json["location"] ?? "",
        pincode: json["pincode"] ?? "",
        phone: json["phone"] ?? "",
      );

  Map<String, dynamic> toJson() => {
    "name": name,
    "location": location,
    "pincode": pincode,
    "phone": phone,
  };
}

class ItemDetails {
  final String name;
  final int quantity;
  final int price;
  final int total;

  ItemDetails({
    this.name = "",
    this.quantity = 0,
    this.price = 0,
    this.total = 0,
  });

  factory ItemDetails.fromJson(Map<String, dynamic> json) => ItemDetails(
    name: json["name"] ?? "",
    quantity: json["quantity"] ?? 0,
    price: json["price"] ?? 0,
    total: json["total"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "quantity": quantity,
    "price": price,
    "total": total,
  };
}

class StoreDetails {
  final String name;
  final String address;
  final String phone;

  StoreDetails({this.name = "", this.address = "", this.phone = ""});

  factory StoreDetails.fromJson(Map<String, dynamic> json) => StoreDetails(
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

class TimestampsDetails {
  final DateTime createdAt;

  TimestampsDetails({required this.createdAt});

  factory TimestampsDetails.fromJson(Map<String, dynamic> json) =>
      TimestampsDetails(
        createdAt:
            json["createdAt"] != null
                ? DateTime.tryParse(json["createdAt"]) ?? DateTime.now()
                : DateTime.now(),
      );

  Map<String, dynamic> toJson() => {"createdAt": createdAt.toIso8601String()};
}
