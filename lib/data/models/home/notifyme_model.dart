import 'dart:convert';

NotifyMeModel notifyMeModelFromJson(String str) =>
    NotifyMeModel.fromJson(json.decode(str));

String notifyMeModelToJson(NotifyMeModel data) => json.encode(data.toJson());

class NotifyMeModel {
  int statusCode;
  bool success;
  String message;
  Data data;
  dynamic meta;

  NotifyMeModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
    this.meta,
  });

  factory NotifyMeModel.fromJson(Map<String, dynamic> json) => NotifyMeModel(
    statusCode: json["statusCode"] ?? 0,
    success: json["success"] ?? false,
    message: json["message"] ?? "",
    data: json["data"] != null ? Data.fromJson(json["data"]) : Data.empty(),
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

class Data {
  String id;
  String subCategory;
  int v;
  DateTime createdAt;
  DateTime updatedAt;
  List<User> users;

  Data({
    required this.id,
    required this.subCategory,
    required this.v,
    required this.createdAt,
    required this.updatedAt,
    required this.users,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"] ?? "",
    subCategory: json["subCategory"] ?? "",
    v: json["__v"] ?? 0,
    createdAt:
        json["createdAt"] != null
            ? DateTime.tryParse(json["createdAt"]) ?? DateTime(1970)
            : DateTime(1970),
    updatedAt:
        json["updatedAt"] != null
            ? DateTime.tryParse(json["updatedAt"]) ?? DateTime(1970)
            : DateTime(1970),
    users:
        json["users"] != null
            ? List<User>.from(json["users"].map((x) => User.fromJson(x)))
            : [],
  );

  /// Helper empty object (so we never pass null)
  factory Data.empty() => Data(
    id: "",
    subCategory: "",
    v: 0,
    createdAt: DateTime(1970),
    updatedAt: DateTime(1970),
    users: [],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "subCategory": subCategory,
    "__v": v,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "users": List<dynamic>.from(users.map((x) => x.toJson())),
  };
}

class User {
  String id;
  String name;
  String phone;

  User({required this.id, required this.name, required this.phone});

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"] ?? "",
    name: json["name"] ?? "",
    phone: json["phone"] ?? "",
  );

  Map<String, dynamic> toJson() => {"_id": id, "name": name, "phone": phone};
}
