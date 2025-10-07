import 'package:flutter/material.dart';
import 'package:priya_fresh_meats/data/models/home/shopbycategory_model.dart';
import 'package:priya_fresh_meats/data/models/home/shopbysubcategory_model.dart';
import 'package:priya_fresh_meats/data/repository/home_rep/shopbycategory_repository.dart';

class ShopbycategoryViewmodel with ChangeNotifier {
  final ShopbycategoryRepository _repository = ShopbycategoryRepository();

  List<CategoryData> _categoryData = [];
  List<CategoryData> get shopbyCategoryData => _categoryData;

  List<ShopBySubCategoryData> _subcategoryData = [];
  List<ShopBySubCategoryData> get subcategoryData => _subcategoryData;

  bool _isShopByCategoryLoading = false;

  bool get isShopByCategoryLoading => _isShopByCategoryLoading;

  set isShopByCategoryLoading(bool value) {
    _isShopByCategoryLoading = value;
    notifyListeners();
  }

  bool _isShopBySubCategoryLoading = false;

  bool get isShopBySubCategoryLoading => _isShopBySubCategoryLoading;

  set isShopBySubCategoryLoading(bool value) {
    _isShopBySubCategoryLoading = value;
    notifyListeners();
  }

  Future<void> fetchShopByCategory() async {
    isShopByCategoryLoading = true;
    try {
      final result = await _repository.fetchShopByCategory();

      if (result.success) {
        _categoryData = result.data;
        // notifyListeners();
      } else {
        debugPrint(result.message);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isShopByCategoryLoading = false;
      // notifyListeners();
    }
  }

  Future<void> fetchSubCategory(String itemId) async {
    isShopBySubCategoryLoading = true;
    try {
      final result = await _repository.fetchSubCategory(itemId);

      if (result.success) {
        _subcategoryData = result.data;
        // notifyListeners();
      } else {
        debugPrint(result.message);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isShopBySubCategoryLoading = false;
      // notifyListeners();
    }
  }
}
