// providers/category_provider.dart
import 'package:flutter/material.dart';

import 'package:priya_fresh_meats/views/bottomNavScreens/model/categories_model.dart';
import 'package:priya_fresh_meats/views/bottomNavScreens/model/sub_category_model.dart';
import 'package:priya_fresh_meats/views/bottomNavScreens/repo/categories_repo.dart';

class CategoryProvider with ChangeNotifier {
  final CategoryRepository _categoryRepository;

  CategoryProvider(this._categoryRepository);

  // State variables
  List<CategoryModel> _categories = [];
  List<CategoryModel> _categoriesWithSubcategories = [];
  bool _isLoading = false;
  bool _isLoadingSubcategories = false;
  String _errorMessage = '';
  int? _expandedIndex;

  // Getters
  List<CategoryModel> get categories => _categories;
  List<CategoryModel> get categoriesWithSubcategories =>
      _categoriesWithSubcategories;
  bool get isLoading => _isLoading;
  bool get isLoadingSubcategories => _isLoadingSubcategories;
  String get errorMessage => _errorMessage;
  int? get expandedIndex => _expandedIndex;

  // Methods
  Future<void> fetchCategories() async {
    print('🚀 Starting to fetch categories...');

    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      print('📡 Making API call...');
      final categoriesList = await _categoryRepository.getAllCategories();

      print('✅ Categories fetched successfully!');
      print('📊 Categories List Length: ${categoriesList.length}');

      _categories = categoriesList;

      // Print each category for debugging
      for (int i = 0; i < _categories.length; i++) {
        print('📦 Category $i: ${_categories[i]}');
      }
    } catch (e) {
      _errorMessage = 'Failed to load categories: $e';
      print('❌ Error in fetchCategories: $e');

      // DO NOT show SnackBar here - just log and set error message
      print('🚨 Setting error message: $_errorMessage');
    } finally {
      _isLoading = false;
      print(
        '🏁 Finished fetching categories. Loading: $_isLoading, Error: $_errorMessage',
      );
      notifyListeners();
    }
  }

  Future<void> fetchCategoriesWithSubcategories() async {
    print('🚀 Starting to fetch categories with subcategories...');

    _isLoadingSubcategories = true;
    _errorMessage = '';
    notifyListeners();

    try {
      print('📡 Making API call for subcategories...');
      final categoriesWithSubcategoriesList =
          await _categoryRepository.getCategoriesWithSubcategories();

      print('✅ Categories with subcategories fetched successfully!');
      print(
        '📊 Categories with Subcategories List Length: ${categoriesWithSubcategoriesList.length}',
      );

      _categoriesWithSubcategories = categoriesWithSubcategoriesList;
      for (int i = 0; i < _categoriesWithSubcategories.length; i++) {
        final category = _categoriesWithSubcategories[i];
        print(
          '📦 Category $i: ${category.name} (${category.typeCategories.length} subcategories)',
        );
        for (int j = 0; j < category.typeCategories.length; j++) {
          print('   📦 Subcategory $j: ${category.typeCategories[j].name}');
        }
      }
    } catch (e) {
      _errorMessage = 'Failed to load categories with subcategories: $e';
      print('❌ Error in fetchCategoriesWithSubcategories: $e');
      print('🚨 Setting error message: $_errorMessage');
    } finally {
      _isLoadingSubcategories = false;
      print(
        '🏁 Finished fetching categories with subcategories. Loading: $_isLoadingSubcategories, Error: $_errorMessage',
      );
      notifyListeners();
    }
  }

  void setExpandedIndex(int? index) {
    print('🔄 Setting expanded index: $index');
    _expandedIndex = _expandedIndex == index ? null : index;
    notifyListeners();
  }

  void clearError() {
    print('🧹 Clearing error message');
    _errorMessage = '';
    notifyListeners();
  }

  // Method to retry loading categories
  Future<void> retryFetchCategories() async {
    print('🔄 Retrying to fetch categories...');
    clearError();
    await fetchCategories();
  }

  // Method to retry loading categories with subcategories
  Future<void> retryFetchCategoriesWithSubcategories() async {
    print('🔄 Retrying to fetch categories with subcategories...');
    clearError();
    await fetchCategoriesWithSubcategories();
  }

  // Helper method to get a category by ID
  CategoryModel? getCategoryById(String id) {
    try {
      return _categoriesWithSubcategories.firstWhere(
        (category) => category.id == id,
      );
    } catch (e) {
      return null;
    }
  }

  // Helper method to get subcategories for a specific category
  List<SubcategoryModel> getSubcategoriesForCategory(String categoryId) {
    final category = getCategoryById(categoryId);
    return category?.typeCategories ?? [];
  }
}
