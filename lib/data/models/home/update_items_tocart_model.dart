import 'dart:convert';

UpdateItemToCartModel updateItemToCartModelFromJson(String str) =>
    UpdateItemToCartModel.fromJson(json.decode(str));

String updateItemToCartModelToJson(UpdateItemToCartModel data) =>
    json.encode(data.toJson());

class UpdateItemToCartModel {
  String message;
  UpdatedItem updatedItem;

  UpdateItemToCartModel({
    required this.message,
    required this.updatedItem,
  });

  factory UpdateItemToCartModel.fromJson(Map<String, dynamic> json) =>
      UpdateItemToCartModel(
        message: json["message"] ?? "",
        updatedItem: UpdatedItem.fromJson(json["updatedItem"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "updatedItem": updatedItem.toJson(),
      };
}

class UpdatedItem {
  String subCategory;
  int count;
  String id;
  DateTime orderedAt;

  UpdatedItem({
    required this.subCategory,
    required this.count,
    required this.id,
    required this.orderedAt,
  });

  factory UpdatedItem.fromJson(Map<String, dynamic> json) => UpdatedItem(
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
