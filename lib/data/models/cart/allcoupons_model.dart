import 'dart:convert';

AllCouponsModel allCouponsModelFromJson(String str) =>
    AllCouponsModel.fromJson(json.decode(str));

String allCouponsModelToJson(AllCouponsModel data) =>
    json.encode(data.toJson());

class AllCouponsModel {
  final int statusCode;
  final bool success;
  final String message;
  final CouponData data;
  final dynamic meta;

  AllCouponsModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
    required this.meta,
  });

  factory AllCouponsModel.fromJson(Map<String, dynamic> json) =>
      AllCouponsModel(
        statusCode: json["statusCode"] ?? 0,
        success: json["success"] ?? false,
        message: json["message"] ?? '',
        data:
            json["data"] != null
                ? CouponData.fromJson(json["data"])
                : CouponData.empty(),
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

class CouponData {
  final List<Coupon> userCoupons;
  final List<Coupon> availableCoupons;

  CouponData({required this.userCoupons, required this.availableCoupons});

  factory CouponData.fromJson(Map<String, dynamic> json) => CouponData(
    userCoupons:
        json["userCoupons"] != null
            ? List<Coupon>.from(
              json["userCoupons"].map((x) => Coupon.fromJson(x)),
            )
            : [],
    availableCoupons:
        json["availableCoupons"] != null
            ? List<Coupon>.from(
              json["availableCoupons"].map((x) => Coupon.fromJson(x)),
            )
            : [],
  );

  Map<String, dynamic> toJson() => {
    "userCoupons": List<dynamic>.from(userCoupons.map((x) => x.toJson())),
    "availableCoupons": List<dynamic>.from(
      availableCoupons.map((x) => x.toJson()),
    ),
  };

  factory CouponData.empty() =>
      CouponData(userCoupons: [], availableCoupons: []);
}

class Coupon {
  final String id;
  final String name;
  final String code;
  final int discount;
  final DateTime expiryDate;
  final int limit;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Coupon({
    required this.id,
    required this.name,
    required this.code,
    required this.discount,
    required this.expiryDate,
    required this.limit,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
    id: json["_id"] ?? '',
    name: json["name"] ?? '',
    code: json["code"] ?? '',
    discount: json["discount"] ?? 0,
    expiryDate:
        json["expiryDate"] != null
            ? DateTime.tryParse(json["expiryDate"]) ?? DateTime.now()
            : DateTime.now(),
    limit: json["limit"] ?? 0,
    createdAt:
        json["createdAt"] != null
            ? DateTime.tryParse(json["createdAt"]) ?? DateTime.now()
            : DateTime.now(),
    updatedAt:
        json["updatedAt"] != null
            ? DateTime.tryParse(json["updatedAt"]) ?? DateTime.now()
            : DateTime.now(),
    v: json["__v"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "code": code,
    "discount": discount,
    "expiryDate": expiryDate.toIso8601String(),
    "limit": limit,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
