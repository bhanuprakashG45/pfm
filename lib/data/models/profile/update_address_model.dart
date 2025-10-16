import 'dart:convert';

UpdateAddressModel updateAddressModelFromJson(String str) =>
    UpdateAddressModel.fromJson(json.decode(str));

String updateAddressModelToJson(UpdateAddressModel data) =>
    json.encode(data.toJson());

class UpdateAddressModel {
  int statusCode;
  bool success;
  String message;
  UpdatedData data;
  dynamic meta;

  UpdateAddressModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
    required this.meta,
  });

  factory UpdateAddressModel.fromJson(Map<String, dynamic> json) =>
      UpdateAddressModel(
        statusCode: json["statusCode"] ?? 0,
        success: json["success"] ?? false,
        message: json["message"] ?? "",
        data:
            json["data"] != null
                ? UpdatedData.fromJson(json["data"])
                : UpdatedData.empty(),
        meta: json["meta"] ?? {},
      );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "data": data.toJson(),
    "meta": meta,
  };
}

class UpdatedData {
  String name;
  String phone;
  String houseNo;
  String street;
  String city;
  String state;
  String pincode;
  String type;
  double latitude;
  double longitude;
  bool isSelected;
  String id;

  UpdatedData({
    required this.name,
    required this.phone,
    required this.houseNo,
    required this.street,
    required this.city,
    required this.state,
    required this.pincode,
    required this.type,
    required this.latitude,
    required this.longitude,
    required this.isSelected,
    required this.id,
  });

  factory UpdatedData.fromJson(Map<String, dynamic> json) => UpdatedData(
    name: json["name"] ?? "",
    phone: json["phone"] ?? "",
    houseNo: json["houseNo"] ?? "",
    street: json["street"] ?? "",
    city: json["city"] ?? "",
    state: json["state"] ?? "",
    pincode: json["pincode"] ?? "",
    type: json["type"] ?? "",
    latitude: (json["latitude"] ?? 0).toDouble(),
    longitude: (json["longitude"] ?? 0).toDouble(),
    isSelected: json["isSelected"] ?? false,
    id: json["_id"] ?? "",
  );

  factory UpdatedData.empty() => UpdatedData(
    name: "",
    phone: "",
    houseNo: "",
    street: "",
    city: "",
    state: "",
    pincode: "",
    type: "",
    latitude: 0,
    longitude: 0,
    isSelected: false,
    id: "",
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "phone": phone,
    "houseNo": houseNo,
    "street": street,
    "city": city,
    "state": state,
    "pincode": pincode,
    "type": type,
    "latitude": latitude,
    "longitude": longitude,
    "isSelected": isSelected,
    "_id": id,
  };
}
