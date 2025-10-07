// import 'dart:convert';

// SearchByNameModel searchByNameModelFromJson(String str) =>
//     SearchByNameModel.fromJson(json.decode(str));

// String searchByNameModelToJson(SearchByNameModel data) =>
//     json.encode(data.toJson());

// class SearchByNameModel {
//   int statusCode;
//   bool success;
//   String message;
//   List<SearchData> data;
//   dynamic meta;

//   SearchByNameModel({
//     required this.statusCode,
//     required this.success,
//     required this.message,
//     required this.data,
//     required this.meta,
//   });

//   factory SearchByNameModel.fromJson(Map<String, dynamic> json) =>
//       SearchByNameModel(
//         statusCode: json["statusCode"] ?? 0,
//         success: json["success"] ?? false,
//         message: json["message"] ?? "",
//         data:
//             json["data"] != null
//                 ? List<SearchData>.from(
//                   json["data"].map((x) => SearchData.fromJson(x)),
//                 )
//                 : [],
//         meta: json["meta"],
//       );

//   Map<String, dynamic> toJson() => {
//     "statusCode": statusCode,
//     "success": success,
//     "message": message,
//     "data": List<dynamic>.from(data.map((x) => x.toJson())),
//     "meta": meta,
//   };
// }

// class SearchData {
//   String img;
//   String name;

//   SearchData({required this.img, required this.name});

//   factory SearchData.fromJson(Map<String, dynamic> json) =>
//       SearchData(img: json["img"] ?? "", name: json["name"] ?? "");

//   Map<String, dynamic> toJson() => {"img": img, "name": name};
// }
