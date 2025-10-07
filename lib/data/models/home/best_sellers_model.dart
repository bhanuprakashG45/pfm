import 'dart:convert';

BestSellersModel bestSellersModelFromJson(String str) =>
    BestSellersModel.fromJson(json.decode(str));

String bestSellersModelToJson(BestSellersModel data) =>
    json.encode(data.toJson());

class BestSellersModel {
  int statusCode;
  bool success;
  String message;
  List<Datum> data;
  dynamic meta;

  BestSellersModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
    required this.meta,
  });

  factory BestSellersModel.fromJson(Map<String, dynamic> json) =>
      BestSellersModel(
        statusCode: json["statusCode"] ?? 0,
        success: json["success"] ?? false,
        message: json["message"] ?? '',
        data:
            json["data"] != null
                ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)))
                : [],
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

class Datum {
  String id;
  String img;
  String name;
  List<String> type;
  String quality;
  String description;
  String weight;
  String pieces;
  int serves;
  int totalEnergy;
  double carbohydrate;
  double fat;
  double protein;
  int price;
  bool bestSellers;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  int discount;
  double discountPrice;
  int count;
  bool available;
  List<dynamic> quantity;
  String unit;

  Datum({
    required this.id,
    required this.img,
    required this.name,
    required this.type,
    required this.quality,
    required this.description,
    required this.weight,
    required this.pieces,
    required this.serves,
    required this.totalEnergy,
    required this.carbohydrate,
    required this.fat,
    required this.protein,
    required this.price,
    required this.bestSellers,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.discount,
    required this.discountPrice,
    required this.count,
    required this.available,
    required this.quantity,
    required this.unit,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"] ?? '',
    img: json["img"] ?? '',
    name: json["name"] ?? '',
    type:
        json["type"] != null
            ? List<String>.from(json["type"].map((x) => x.toString()))
            : [],
    quality: json["quality"] ?? '',
    description: json["description"] ?? '',
    weight: json["weight"] ?? '',
    pieces: json["pieces"] ?? '',
    serves: json["serves"] != null ? (json["serves"] as num).toInt() : 0,
    totalEnergy:
        json["totalEnergy"] != null ? (json["totalEnergy"] as num).toInt() : 0,
    carbohydrate:
        json["carbohydrate"] != null
            ? (json["carbohydrate"] as num).toDouble()
            : 0.0,
    fat: json["fat"] != null ? (json["fat"] as num).toDouble() : 0.0,
    protein:
        json["protein"] != null ? (json["protein"] as num).toDouble() : 0.0,
    price: json["price"] != null ? (json["price"] as num).toInt() : 0,
    bestSellers: json["bestSellers"] ?? false,
    createdAt:
        json["createdAt"] != null
            ? DateTime.tryParse(json["createdAt"]) ?? DateTime.now()
            : DateTime.now(),
    updatedAt:
        json["updatedAt"] != null
            ? DateTime.tryParse(json["updatedAt"]) ?? DateTime.now()
            : DateTime.now(),
    v: json["__v"] != null ? (json["__v"] as num).toInt() : 0,
    discount: json["discount"] != null ? (json["discount"] as num).toInt() : 0,
    discountPrice:
        json["discountPrice"] != null
            ? (json["discountPrice"] as num).toDouble()
            : 0.0,
    count: json["count"] != null ? (json["count"] as num).toInt() : 0,
    available: json["available"] ?? false,
    quantity: json["quantity"] ?? [],
    unit: json["unit"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "img": img,
    "name": name,
    "type": List<dynamic>.from(type.map((x) => x)),
    "quality": quality,
    "description": description,
    "weight": weight,
    "pieces": pieces,
    "serves": serves,
    "totalEnergy": totalEnergy,
    "carbohydrate": carbohydrate,
    "fat": fat,
    "protein": protein,
    "price": price,
    "bestSellers": bestSellers,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
    "discount": discount,
    "discountPrice": discountPrice,
    "count": count,
    "available": available,
    "quantity": quantity,
    "unit": unit,
  };
}
