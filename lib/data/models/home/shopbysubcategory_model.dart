import 'dart:convert';

ShopBySubCategoryModel shopBySubCategoryModelFromJson(String str) =>
    ShopBySubCategoryModel.fromJson(json.decode(str));

String shopBySubCategoryModelToJson(ShopBySubCategoryModel data) =>
    json.encode(data.toJson());

class ShopBySubCategoryModel {
  int statusCode;
  bool success;
  String message;
  List<ShopBySubCategoryData> data;
  dynamic meta;

  ShopBySubCategoryModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
    required this.meta,
  });

  factory ShopBySubCategoryModel.fromJson(Map<String, dynamic> json) =>
      ShopBySubCategoryModel(
        statusCode: json["statusCode"] ?? 0,
        success: json["success"] ?? false,
        message: json["message"] ?? "",
        data:
            json["data"] == null
                ? []
                : List<ShopBySubCategoryData>.from(
                  json["data"].map((x) => ShopBySubCategoryData.fromJson(x)),
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

class ShopBySubCategoryData {
  String id;
  String img;
  String name;
  String description;
  String weight;
  String pieces;
  int serves;
  double price;
  bool available;
  int count;
  bool notify;

  ShopBySubCategoryData({
    required this.id,
    required this.img,
    required this.name,
    required this.description,
    required this.weight,
    required this.pieces,
    required this.serves,
    required this.price,
    required this.available,
    required this.count,
    required this.notify,
  });

  factory ShopBySubCategoryData.fromJson(Map<String, dynamic> json) =>
      ShopBySubCategoryData(
        id: json["_id"] ?? "",
        img: json["img"] ?? "",
        name: json["name"] ?? "",
        description: json["description"] ?? "",
        weight: json["weight"] ?? "",
        pieces: json["pieces"] ?? "",
        serves: json["serves"] != null ? (json["serves"] as num).toInt() : 0,
        price: json["price"] != null ? (json["price"] as num).toDouble() : 0.0,
        available: json["available"] ?? false,
        count: json["count"] != null ? (json["count"] as num).toInt() : 0,
        notify: json["notify"] ?? false,
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "img": img,
    "name": name,
    "description": description,
    "weight": weight,
    "pieces": pieces,
    "serves": serves,
    "price": price,
    "available": available,
    "count": count,
    "notify": notify,
  };
}

// import 'dart:convert';

// ShopBySubCategoryModel shopBySubCategoryModelFromJson(String str) =>
//     ShopBySubCategoryModel.fromJson(json.decode(str));

// String shopBySubCategoryModelToJson(ShopBySubCategoryModel data) =>
//     json.encode(data.toJson());

// class ShopBySubCategoryModel {
//   int statusCode;
//   bool success;
//   String message;
//   List<ShopBySubCategoryData> data;
//   dynamic meta;

//   ShopBySubCategoryModel({
//     required this.statusCode,
//     required this.success,
//     required this.message,
//     required this.data,
//     required this.meta,
//   });

//   factory ShopBySubCategoryModel.fromJson(Map<String, dynamic> json) =>
//       ShopBySubCategoryModel(
//         statusCode: json["statusCode"],
//         success: json["success"],
//         message: json["message"],
//         data: List<ShopBySubCategoryData>.from(
//           json["data"].map((x) => ShopBySubCategoryData.fromJson(x)),
//         ),
//         meta: json["meta"],
//       );

//   Map<String, dynamic> toJson() => {
//     "statusCode": statusCode,
//     "success": success,
//     "message": message,
//     "data": List<dynamic>.from(data.map((x) => x.toJson())),
//     "meta": meta,
//   };
// }

// class ShopBySubCategoryData {
//   String id;
//   String name;
//   String description;
//   String weight;
//   String pieces;
//   int serves;
//   int price;
//   String img;

//   ShopBySubCategoryData({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.weight,
//     required this.pieces,
//     required this.serves,
//     required this.price,
//     required this.img,
//   });

//   factory ShopBySubCategoryData.fromJson(Map<String, dynamic> json) =>
//       ShopBySubCategoryData(
//         id: json["_id"] ?? '',
//         name: json["name"] ?? '',
//         description: json["description"] ?? '',
//         weight: json["weight"] ?? '',
//         pieces: json["pieces"] ?? '',
//         serves: json["serves"] ?? 0,
//         price: json["price"] ?? 0,
//         img: json["img"] ?? '',
//       );

//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "name": name,
//     "description": description,
//     "weight": weight,
//     "pieces": pieces,
//     "serves": serves,
//     "price": price,
//     "img": img,
//   };
// }
