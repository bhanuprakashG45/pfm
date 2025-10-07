import 'dart:convert';

ShopByCategoryModel shopByCategoryModelFromJson(String str) =>
    ShopByCategoryModel.fromJson(json.decode(str));

String shopByCategoryModelToJson(ShopByCategoryModel data) =>
    json.encode(data.toJson());

class ShopByCategoryModel {
  int statusCode;
  bool success;
  String message;
  List<CategoryData> data;
  dynamic meta;

  ShopByCategoryModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
    required this.meta,
  });

  factory ShopByCategoryModel.fromJson(Map<String, dynamic> json) =>
      ShopByCategoryModel(
        statusCode: json["statusCode"] ?? 0,
        success: json["success"] ?? false,
        message: json["message"] ?? '',
        data:
            (json["data"] != null)
                ? List<CategoryData>.from(
                  json["data"].map((x) => CategoryData.fromJson(x)),
                )
                : [],
        meta: json["meta"] ?? null,
      );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "meta": meta,
  };
}

class CategoryData {
  String id;
  String name;
  String img;

  CategoryData({required this.id, required this.name, required this.img});

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
    id: json["_id"] ?? '',
    name: json["name"] ?? '',
    img: json["img"] ?? '',
  );

  Map<String, dynamic> toJson() => {"_id": id, "name": name, "img": img};
}
