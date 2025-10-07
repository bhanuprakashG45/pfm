import 'dart:convert';

AllAddressModel allAddressModelFromJson(String str) =>
    AllAddressModel.fromJson(json.decode(str));

String allAddressModelToJson(AllAddressModel data) =>
    json.encode(data.toJson());

class AllAddressModel {
  int statusCode;
  bool success;
  String message;
  List<AddressData> data;
  dynamic meta;

  AllAddressModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
    required this.meta,
  });

  factory AllAddressModel.fromJson(Map<String, dynamic> json) =>
      AllAddressModel(
        statusCode: json["statusCode"] ?? 0,
        success: json["success"] ?? false,
        message: json["message"] ?? "",
        data:
            json["data"] == null
                ? []
                : List<AddressData>.from(
                  json["data"].map((x) => AddressData.fromJson(x)),
                ),
        meta: json["meta"] ?? {},
      );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "meta": meta,
  };
}

class AddressData {
  String houseNo;
  String street;
  String city;
  String state;
  String pincode;
  String type;
  double latitude;
  double longitude;
  String id;
  bool isSelected;

  AddressData({
    required this.houseNo,
    required this.street,
    required this.city,
    required this.state,
    required this.pincode,
    required this.type,
    required this.latitude,
    required this.longitude,
    required this.id,
    required this.isSelected,
  });

  factory AddressData.fromJson(Map<String, dynamic> json) => AddressData(
    houseNo: json["houseNo"] ?? "",
    street: json["street"] ?? "",
    city: json["city"] ?? "",
    state: json["state"] ?? "",
    pincode: json["pincode"] ?? "",
    type: json["type"] ?? "",
    latitude: (json["latitude"] ?? 0).toDouble(),
    longitude: (json["longitude"] ?? 0).toDouble(),
    id: json["_id"] ?? "",
    isSelected: json["isSelected"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "houseNo": houseNo,
    "street": street,
    "city": city,
    "state": state,
    "pincode": pincode,
    "type": type,
    "latitude": latitude,
    "longitude": longitude,
    "_id": id,
    "isSelected": isSelected,
  };
}
