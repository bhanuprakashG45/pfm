// models/subcategory_model.dart
class SubcategoryModel {
  final String id;
  final String name;
  final String img;

  SubcategoryModel({
    required this.id,
    required this.name,
    required this.img,
  });

  factory SubcategoryModel.fromJson(Map<String, dynamic> json) {
    return SubcategoryModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      img: json['img'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'img': img,
    };
  }

  @override
  String toString() {
    return 'SubcategoryModel(id: $id, name: $name, img: $img)';
  }
}