import 'dart:convert';

ReOrderModel reOrderModelFromJson(String str) =>
    ReOrderModel.fromJson(json.decode(str));

String reOrderModelToJson(ReOrderModel data) => json.encode(data.toJson());

double parseDouble(dynamic value) {
  if (value == null) return 0.0;
  if (value is int) return value.toDouble();
  if (value is double) return value;
  if (value is String) return double.tryParse(value) ?? 0.0;
  return 0.0;
}

int parseInt(dynamic value) {
  if (value == null) return 0;
  if (value is int) return value;
  if (value is double) return value.toInt();
  if (value is String) return int.tryParse(value) ?? 0;
  return 0;
}

class ReOrderModel {
  int statusCode;
  bool success;
  String message;
  List<Datum> data;
  dynamic meta;

  ReOrderModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
    required this.meta,
  });

  factory ReOrderModel.fromJson(Map<String, dynamic> json) => ReOrderModel(
    statusCode: json["statusCode"] ?? 0,
    success: json["success"] ?? false,
    message: json["message"] ?? "",
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
  SubCategory subCategory;
  int count;
  DateTime orderedAt;
  String id;

  Datum({
    required this.subCategory,
    required this.count,
    required this.orderedAt,
    required this.id,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    subCategory: SubCategory.fromJson(json["subCategory"] ?? {}),
    count: parseInt(json["count"]),
    orderedAt:
        json["orderedAt"] != null
            ? DateTime.tryParse(json["orderedAt"]) ?? DateTime.now()
            : DateTime.now(),
    id: json["_id"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "subCategory": subCategory.toJson(),
    "count": count,
    "orderedAt": orderedAt.toIso8601String(),
    "_id": id,
  };
}

class SubCategory {
  String id;
  String name;
  List<String> type;
  String quality;
  String description;
  String weight;
  String pieces;
  int serves;
  int totalEnergy;
  int carbohydrate;
  int fat;
  int protein;
  double price;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String img;
  bool bestSellers;
  int discount;
  double discountPrice;
  List<Quantity> quantity;

  SubCategory({
    required this.id,
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
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.img,
    required this.bestSellers,
    required this.discount,
    required this.discountPrice,
    required this.quantity,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    id: json["_id"] ?? "",
    name: json["name"] ?? "",
    type: json["type"] != null ? List<String>.from(json["type"]) : [],
    quality: json["quality"] ?? "",
    description: json["description"] ?? "",
    weight: json["weight"]?.toString() ?? "",
    pieces: json["pieces"]?.toString() ?? "",
    serves: parseInt(json["serves"]),
    totalEnergy: parseInt(json["totalEnergy"]),
    carbohydrate: parseInt(json["carbohydrate"]),
    fat: parseInt(json["fat"]),
    protein: parseInt(json["protein"]),
    price: parseDouble(json["price"]),
    createdAt:
        json["createdAt"] != null
            ? DateTime.tryParse(json["createdAt"]) ?? DateTime.now()
            : DateTime.now(),
    updatedAt:
        json["updatedAt"] != null
            ? DateTime.tryParse(json["updatedAt"]) ?? DateTime.now()
            : DateTime.now(),
    v: parseInt(json["__v"]),
    img: json["img"] ?? "",
    bestSellers: json["bestSellers"] ?? false,
    discount: parseInt(json["discount"]),
    discountPrice: parseDouble(json["discountPrice"]),
    quantity:
        json["quantity"] != null
            ? List<Quantity>.from(
              json["quantity"].map((x) => Quantity.fromJson(x)),
            )
            : [],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
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
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
    "img": img,
    "bestSellers": bestSellers,
    "discount": discount,
    "discountPrice": discountPrice,
    "quantity": List<dynamic>.from(quantity.map((x) => x.toJson())),
  };
}

class Quantity {
  String managerId;
  int count;

  Quantity({required this.managerId, required this.count});

  factory Quantity.fromJson(Map<String, dynamic> json) => Quantity(
    managerId: json["managerId"] ?? "",
    count: parseInt(json["count"]),
  );

  Map<String, dynamic> toJson() => {"managerId": managerId, "count": count};
}
