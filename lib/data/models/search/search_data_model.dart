// To parse this JSON data, do
//
//     final searchDataModel = searchDataModelFromJson(jsonString);

import 'dart:convert';

SearchDataModel searchDataModelFromJson(String str) =>
    SearchDataModel.fromJson(json.decode(str));

String searchDataModelToJson(SearchDataModel data) =>
    json.encode(data.toJson());

class SearchDataModel {
  int statusCode;
  bool success;
  String message;
  List<AllSearchData> data;
  dynamic meta;

  SearchDataModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
    this.meta,
  });

  factory SearchDataModel.fromJson(Map<String, dynamic> json) =>
      SearchDataModel(
        statusCode: json["statusCode"] ?? 0,
        success: json["success"] ?? false,
        message: json["message"] ?? "",
        data:
            json["data"] == null
                ? []
                : List<AllSearchData>.from(
                  json["data"].map((x) => AllSearchData.fromJson(x)),
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

class AllSearchData {
  String id;
  String img;
  String name;
  List<String> type;
  String quality;
  String description;
  Unit? unit;
  String weight;
  String pieces;
  int serves;
  int totalEnergy;
  int carbohydrate;
  int fat;
  int protein;
  double price; // <-- Changed to double
  double discount; // <-- Changed to double
  double discountPrice;
  bool bestSellers;
  bool available;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  int count;
  bool notify;

  AllSearchData({
    required this.id,
    required this.img,
    required this.name,
    required this.type,
    required this.quality,
    required this.description,
    this.unit,
    required this.weight,
    required this.pieces,
    required this.serves,
    required this.totalEnergy,
    required this.carbohydrate,
    required this.fat,
    required this.protein,
    required this.price,
    required this.discount,
    required this.discountPrice,
    required this.bestSellers,
    required this.available,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.count,
    required this.notify,
  });

  factory AllSearchData.fromJson(Map<String, dynamic> json) => AllSearchData(
    id: json["_id"] ?? "",
    img: json["img"] ?? "",
    name: json["name"] ?? "",
    type:
        json["type"] == null
            ? []
            : List<String>.from(json["type"].map((x) => x ?? "")),
    quality: json["quality"] ?? "",
    description: json["description"] ?? "",
    unit: json["unit"] != null ? unitValues.map[json["unit"]] : null,
    weight: json["weight"] ?? "",
    pieces: json["pieces"] ?? "",
    serves: json["serves"] != null ? (json["serves"] as num).toInt() : 0,
    totalEnergy:
        json["totalEnergy"] != null ? (json["totalEnergy"] as num).toInt() : 0,
    carbohydrate:
        json["carbohydrate"] != null
            ? (json["carbohydrate"] as num).toInt()
            : 0,
    fat: json["fat"] != null ? (json["fat"] as num).toInt() : 0,
    protein: json["protein"] != null ? (json["protein"] as num).toInt() : 0,
    price: json["price"] != null ? (json["price"] as num).toDouble() : 0.0,
    discount:
        json["discount"] != null ? (json["discount"] as num).toDouble() : 0.0,
    discountPrice:
        json["discountPrice"] != null
            ? (json["discountPrice"] as num).toDouble()
            : 0.0,
    bestSellers: json["bestSellers"] ?? false,
    available: json["available"] ?? true,
    createdAt:
        json["createdAt"] != null
            ? DateTime.tryParse(json["createdAt"]) ?? DateTime.now()
            : DateTime.now(),
    updatedAt:
        json["updatedAt"] != null
            ? DateTime.tryParse(json["updatedAt"]) ?? DateTime.now()
            : DateTime.now(),
    v: json["__v"] != null ? (json["__v"] as num).toInt() : 0,
    count: json["count"] != null ? (json["count"] as num).toInt() : 0,
    notify: json["notify"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "img": img,
    "name": name,
    "type": List<dynamic>.from(type.map((x) => x)),
    "quality": quality,
    "description": description,
    "unit": unitValues.reverse[unit],
    "weight": weight,
    "pieces": pieces,
    "serves": serves,
    "totalEnergy": totalEnergy,
    "carbohydrate": carbohydrate,
    "fat": fat,
    "protein": protein,
    "price": price,
    "discount": discount,
    "discountPrice": discountPrice,
    "bestSellers": bestSellers,
    "available": available,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
    "count": count,
    "notify": notify,
  };
}

enum Unit { GRAM, KG, PIECES }

final unitValues = EnumValues({
  "gram": Unit.GRAM,
  "kg": Unit.KG,
  "pieces": Unit.PIECES,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
