import 'dart:convert';

CartItemsModel cartItemsModelFromJson(String str) =>
    CartItemsModel.fromJson(json.decode(str));

String cartItemsModelToJson(CartItemsModel data) => json.encode(data.toJson());

class CartItemsModel {
  int statusCode;
  bool success;
  String message;
  List<CartItems> data;
  dynamic meta;

  CartItemsModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
    required this.meta,
  });

  factory CartItemsModel.fromJson(Map<String, dynamic> json) => CartItemsModel(
    statusCode: json["statusCode"] ?? 0,
    success: json["success"] ?? false,
    message: json["message"] ?? '',
    data:
        json["data"] != null
            ? List<CartItems>.from(
              json["data"].map((x) => CartItems.fromJson(x)),
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

class CartItems {
  SubCategory subCategory;
  int count;
  String id;
  DateTime orderedAt;

  CartItems({
    required this.subCategory,
    required this.count,
    required this.id,
    required this.orderedAt,
  });

  factory CartItems.fromJson(Map<String, dynamic> json) => CartItems(
    subCategory:
        json["subCategory"] != null
            ? SubCategory.fromJson(json["subCategory"])
            : SubCategory.empty(),
    count: json["count"] != null ? (json["count"] as num).toInt() : 0,
    id: json["_id"] ?? '',
    orderedAt:
        json["orderedAt"] != null
            ? DateTime.tryParse(json["orderedAt"]) ?? DateTime.now()
            : DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    "subCategory": subCategory.toJson(),
    "count": count,
    "_id": id,
    "orderedAt": orderedAt.toIso8601String(),
  };
}

class SubCategory {
  int discount;
  double discountPrice;
  String id;
  String name;
  String description;
  String weight;
  double price;
  String img;

  SubCategory({
    required this.discount,
    required this.discountPrice,
    required this.id,
    required this.name,
    required this.description,
    required this.weight,
    required this.price,
    required this.img,
  });

  factory SubCategory.empty() => SubCategory(
    discount: 0,
    discountPrice: 0.0,
    id: '',
    name: '',
    description: '',
    weight: '',
    price: 0.0,
    img: '',
  );

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    discount: json["discount"] != null ? (json["discount"] as num).toInt() : 0,
    discountPrice:
        json["discountPrice"] != null
            ? (json["discountPrice"] as num).toDouble()
            : 0.0,
    id: json["_id"] ?? '',
    name: json["name"] ?? '',
    description: json["description"] ?? '',
    weight: json["weight"] ?? '',
    price: (json["price"] ?? 0).toDouble(),
    img: json["img"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "discount": discount,
    "discountPrice": discountPrice,
    "_id": id,
    "name": name,
    "description": description,
    "weight": weight,
    "price": price,
    "img": img,
  };
}
