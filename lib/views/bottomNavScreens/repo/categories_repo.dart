import 'package:priya_fresh_meats/utils/exports.dart';
import 'package:priya_fresh_meats/views/bottomNavScreens/model/categories_model.dart';

abstract class CategoryRepository {
  Future<List<CategoryModel>> getAllCategories();
  Future<List<CategoryModel>> getCategoriesWithSubcategories();
}

class CategoryRepositoryImpl implements CategoryRepository {
  final NetworkApiServices _apiServices = NetworkApiServices();

  @override
  Future<List<CategoryModel>> getAllCategories() async {
    try {

      final response = await _apiServices.getApiResponse(
        AppUrls.shopcategories,
      );

      print('Raw API Response: $response');

      if (response != null && response is Map) {
        if (response['success'] == true && response['data'] != null) {
          final List dataList = response['data'] as List;

          print('Number of categories received: ${dataList.length}');

          return dataList
              .map(
                (item) => CategoryModel.fromJson(item as Map<String, dynamic>),
              )
              .toList();
        } else {
          print('Response message: ${response['message'] ?? 'No message'}');
          throw Exception(response['message'] ?? 'Failed to load categories');
        }
      } else {
        throw Exception('Invalid response format');
      }
    } catch (e) {
      print('Error in getAllCategories: $e');
      if (e.toString().contains('UnauthorizedException') ||
          e.toString().contains('Invalid or expired token')) {
        throw Exception('Session expired. Please login again.');
      }

      rethrow;
    }
  }

  @override
  Future<List<CategoryModel>> getCategoriesWithSubcategories() async {
    try {
      final response = await _apiServices.getApiResponse(
        AppUrls.categoriestypes,
      );

      print('Raw Subcategories API Response: $response');

      if (response != null && response is Map) {
        if (response['success'] == true && response['data'] != null) {
          final List dataList = response['data'] as List;

          print(
            'Number of categories with subcategories received: ${dataList.length}',
          );

          return dataList
              .map(
                (item) => CategoryModel.fromJson(item as Map<String, dynamic>),
              )
              .toList();
        } else {
          print('Response message: ${response['message'] ?? 'No message'}');
          throw Exception(
            response['message'] ??
                'Failed to load categories with subcategories',
          );
        }
      } else {
        print('Invalid response format');
        throw Exception('Invalid response format');
      }
    } catch (e) {
      if (e.toString().contains('UnauthorizedException') ||
          e.toString().contains('Invalid or expired token')) {
        throw Exception('Session expired. Please login again.');
      }

      rethrow;
    }
  }
}
