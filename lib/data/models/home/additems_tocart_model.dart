import 'dart:convert';

AddItemToCartModel addItemToCartModelFromJson(String str) =>
    AddItemToCartModel.fromJson(json.decode(str));

String addItemToCartModelToJson(AddItemToCartModel data) =>
    json.encode(data.toJson());

class AddItemToCartModel {
  int statusCode;
  bool success;
  String message;
  List<Datum> data;
  dynamic meta;

  AddItemToCartModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
    required this.meta,
  });

  factory AddItemToCartModel.fromJson(Map<String, dynamic> json) =>
      AddItemToCartModel(
        statusCode: json["statusCode"] ?? 0,
        success: json["success"] ?? false,
        message: json["message"] ?? "",
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
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
  String subCategory;
  int count;
  String id;
  DateTime orderedAt;

  Datum({
    required this.subCategory,
    required this.count,
    required this.id,
    required this.orderedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        subCategory: json["subCategory"] ?? "",
        count: json["count"] ?? 0,
        id: json["_id"] ?? "",
        orderedAt: DateTime.tryParse(json["orderedAt"] ?? "") ??
            DateTime.fromMillisecondsSinceEpoch(0),
      );

  Map<String, dynamic> toJson() => {
        "subCategory": subCategory,
        "count": count,
        "_id": id,
        "orderedAt": orderedAt.toIso8601String(),
      };
}
