import 'dart:convert';

WalletModel walletModelFromJson(String str) =>
    WalletModel.fromJson(json.decode(str));

String walletModelToJson(WalletModel data) => json.encode(data.toJson());

class WalletModel {
  int statusCode;
  bool success;
  String message;
  WalletData data;
  dynamic meta;

  WalletModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
    required this.meta,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) => WalletModel(
    statusCode: json["statusCode"] ?? 0,
    success: json["success"] ?? false,
    message: json["message"] ?? '',
    data:
        json["data"] != null
            ? WalletData.fromJson(json["data"])
            : WalletData(walletPoints: 0),
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

class WalletData {
  int walletPoints;

  WalletData({required this.walletPoints});

  factory WalletData.fromJson(Map<String, dynamic> json) =>
      WalletData(walletPoints: json["walletPoints"] ?? 0);

  Map<String, dynamic> toJson() => {"walletPoints": walletPoints};
}
