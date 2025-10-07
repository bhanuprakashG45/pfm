import 'dart:convert';

ItemModel itemModelFromJson(String str) => ItemModel.fromJson(json.decode(str));

String itemModelToJson(ItemModel data) => json.encode(data.toJson());

class ItemModel {
  int statusCode;
  bool success;
  String message;
  ItemData data;
  dynamic meta;

  ItemModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
    required this.meta,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
    statusCode: json["statusCode"] ?? 0,
    success: json["success"] ?? false,
    message: json["message"] ?? "",
    data:
        json["data"] != null
            ? ItemData.fromJson(json["data"])
            : ItemData(id: "", name: "", subCategories: []),
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

class ItemData {
  String id;
  String name;
  List<SubCategoryItem> subCategories;

  ItemData({required this.id, required this.name, required this.subCategories});

  factory ItemData.fromJson(Map<String, dynamic> json) => ItemData(
    id: json["_id"] ?? "",
    name: json["name"] ?? "",
    subCategories:
        json["subCategories"] == null
            ? []
            : List<SubCategoryItem>.from(
              json["subCategories"].map((x) => SubCategoryItem.fromJson(x)),
            ),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "subCategories": List<dynamic>.from(subCategories.map((x) => x.toJson())),
  };
}

class SubCategoryItem {
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

  SubCategoryItem({
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

  factory SubCategoryItem.fromJson(Map<String, dynamic> json) =>
      SubCategoryItem(
        id: json["_id"] ?? "",
        img: json["img"] ?? "",
        name: json["name"] ?? "",
        description: json["description"] ?? "",
        weight: json["weight"] ?? "",
        pieces: json["pieces"] ?? "",
        serves: json["serves"] != null ? (json["serves"] as num).toInt() : 0,
        price: json["price"] != null ? (json["price"] as num).toDouble() : 0.0,
        available: json["available"] ?? true,
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
