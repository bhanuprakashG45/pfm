import 'package:priya_fresh_meats/views/bottomNavScreens/model/sub_category_model.dart';

class CategoryModel {
  final String id;
  final String name;
  final String img;
  final List<SubcategoryModel> typeCategories;

  CategoryModel({
    required this.id,
    required this.name,
    required this.img,
    this.typeCategories = const [], // Default empty list
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    // Handle typeCategories field from API
    List<SubcategoryModel> subcategories = [];
    if (json['typeCategories'] != null) {
      final List<dynamic> typeCategoriesJson = json['typeCategories'] as List<dynamic>;
      subcategories = typeCategoriesJson
          .map((subcategoryJson) => SubcategoryModel.fromJson(subcategoryJson as Map<String, dynamic>))
          .toList();
    }

    return CategoryModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      img: json['img'] ?? '',
      typeCategories: subcategories,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'img': img,
      'typeCategories': typeCategories.map((subcategory) => subcategory.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'CategoryModel(id: $id, name: $name, img: $img, typeCategories: ${typeCategories.length})';
  }
}