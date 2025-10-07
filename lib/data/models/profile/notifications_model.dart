import 'dart:convert';

NotificationsModel notificationsModelFromJson(String str) =>
    NotificationsModel.fromJson(json.decode(str));

String notificationsModelToJson(NotificationsModel data) =>
    json.encode(data.toJson());

class NotificationsModel {
  final int statusCode;
  final bool success;
  final String message;
  final Data data;
  final dynamic meta;

  NotificationsModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
    required this.meta,
  });

  factory NotificationsModel.fromJson(Map<String, dynamic> json) =>
      NotificationsModel(
        statusCode: json["statusCode"] ?? 0,
        success: json["success"] ?? false,
        message: json["message"] ?? '',
        data: json["data"] != null
            ? Data.fromJson(json["data"])
            : Data(total: 0, notifications: []),
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
  final int total;
  final List<NotificationData> notifications;

  Data({
    required this.total,
    required this.notifications,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        total: json["total"] ?? 0,
        notifications: json["notifications"] != null
            ? List<NotificationData>.from(
                json["notifications"].map((x) => NotificationData.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "notifications":
            List<dynamic>.from(notifications.map((x) => x.toJson())),
      };
}

class NotificationData {
  final String id;
  final String title;
  final String body;
  final String link;
  final String img;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  NotificationData({
    required this.id,
    required this.title,
    required this.body,
    required this.link,
    required this.img,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) => NotificationData(
        id: json["_id"] ?? '',
        title: json["title"] ?? '',
        body: json["body"] ?? '',
        link: json["link"] ?? '',
        img: json["img"] ?? '',
        createdAt: json["createdAt"] != null
            ? DateTime.tryParse(json["createdAt"]) ?? DateTime.now()
            : DateTime.now(),
        updatedAt: json["updatedAt"] != null
            ? DateTime.tryParse(json["updatedAt"]) ?? DateTime.now()
            : DateTime.now(),
        v: json["__v"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "body": body,
        "link": link,
        "img": img,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
