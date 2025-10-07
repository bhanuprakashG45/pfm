import 'dart:convert';

SearchShopByCategoryModel searchShopByCategoryModelFromJson(String str) =>
    SearchShopByCategoryModel.fromJson(json.decode(str));

String searchShopByCategoryModelToJson(SearchShopByCategoryModel data) =>
    json.encode(data.toJson());

class SearchShopByCategoryModel {
  int statusCode;
  bool success;
  String message;
  List<SearchCategoryData> data;
  dynamic meta;

  SearchShopByCategoryModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
    required this.meta,
  });

  factory SearchShopByCategoryModel.fromJson(Map<String, dynamic> json) =>
      SearchShopByCategoryModel(
        statusCode: json["statusCode"] ?? 0,
        success: json["success"] ?? false,
        message: json["message"] ?? '',
        data:
            json["data"] != null
                ? List<SearchCategoryData>.from(
                  json["data"].map((x) => SearchCategoryData.fromJson(x)),
                )
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

class SearchCategoryData {
  String id;
  String name;
  String img;
  List<String> type;
  String quality;
  String description;
  String? unit;
  String weight;
  String pieces;
  int serves;
  num totalEnergy;
  num carbohydrate;
  num fat;
  num protein;
  num price;
  num discount;
  num discountPrice;
  bool bestSellers;
  bool available;
  String createdAt;
  String updatedAt;
  int v;
  int count;
  bool notify;

  SearchCategoryData({
    required this.id,
    required this.name,
    required this.img,
    required this.type,
    required this.quality,
    required this.description,
    required this.unit,
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

  factory SearchCategoryData.fromJson(Map<String, dynamic> json) {
    // "type" sometimes comes like ["[]"], ["[\"value\"]"], etc.
    List<String> parsedType = [];
    if (json["type"] != null) {
      parsedType = List<String>.from(json["type"].map((x) => x.toString()));
    }

    return SearchCategoryData(
      id: json["_id"] ?? '',
      name: json["name"] ?? '',
      img: json["img"] ?? '',
      type: parsedType,
      quality: json["quality"] ?? '',
      description: json["description"] ?? '',
      unit: json["unit"],
      weight: json["weight"]?.toString() ?? '0',
      pieces: json["pieces"]?.toString() ?? '0',
      serves: json["serves"] ?? 0,
      totalEnergy: json["totalEnergy"] ?? 0,
      carbohydrate: json["carbohydrate"] ?? 0,
      fat: json["fat"] ?? 0,
      protein: json["protein"] ?? 0,
      price: json["price"] ?? 0,
      discount: json["discount"] ?? 0,
      discountPrice: json["discountPrice"] ?? 0,
      bestSellers: json["bestSellers"] ?? false,
      available: json["available"] ?? false,
      createdAt: json["createdAt"] ?? '',
      updatedAt: json["updatedAt"] ?? '',
      v: json["__v"] ?? 0,
      count: json["count"] ?? 0,
      notify: json["notify"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "img": img,
    "type": List<dynamic>.from(type.map((x) => x)),
    "quality": quality,
    "description": description,
    "unit": unit,
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
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "__v": v,
    "count": count,
    "notify": notify,
  };
}
