import 'package:flutter/material.dart';
import 'package:priya_fresh_meats/data/models/category/item_model.dart';
import 'package:priya_fresh_meats/data/repository/category_rep/category_repository.dart';
import 'package:priya_fresh_meats/utils/exports.dart';

class CategoryViewmodel with ChangeNotifier {
  final CategoryRepo _repo = CategoryRepo();

  List<SubCategoryItem> _itemData = [];
  List<SubCategoryItem> get itemdata => _itemData;

  bool _isItemsLoading = false;
  bool get isItemsLoading => _isItemsLoading;

  set isItemsLoading(bool value) {
    _isItemsLoading = value;
    notifyListeners();
  }

  Future<void> fetchSubCategoryItems(String itemId) async {
    isItemsLoading = true;

    try {
      final response = await _repo.fetchSubItems(itemId);
      if (response.success) {
        _itemData = response.data.subCategories;
        debugPrint(response.message);
      } else {
        debugPrint(response.message);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isItemsLoading = false;
    }
  }
}
