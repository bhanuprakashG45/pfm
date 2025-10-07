import 'package:priya_fresh_meats/data/models/home/shopbycategory_model.dart';
import 'package:priya_fresh_meats/data/models/home/shopbysubcategory_model.dart';
import 'package:priya_fresh_meats/utils/exports.dart';

class ShopbycategoryRepository {
  final NetworkApiServices _apiServices = NetworkApiServices();
  final SharedPref _pref = SharedPref();

  Future<ShopByCategoryModel> fetchShopByCategory() async {
    try {
      final url = AppUrls.shopbyCategoryUrl;
      debugPrint(url);

      final response = await _apiServices.getApiResponse(url);

      if (response is Map<String, dynamic>) {
        return ShopByCategoryModel.fromJson(response);
      } else {
        throw Exception('Unexpected response type: ${response.runtimeType}');
      }
    } on AppException catch (e) {
      throw e;
    } catch (e) {
      debugPrint("Unexpected error in ShopByCategory : $e");
      rethrow;
    }
  }

  Future<ShopBySubCategoryModel> fetchSubCategory(String itemId) async {
    try {
      final userId = await _pref.getUserId();
      final url = "${AppUrls.shopbysubCategoryUrl}/$itemId?userId=$userId";
      debugPrint(url);

      final response = await _apiServices.getApiResponse(url);

      if (response is Map<String, dynamic>) {
        return ShopBySubCategoryModel.fromJson(response);
      } else {
        throw Exception('Unexpected response type: ${response.runtimeType}');
      }
    } on AppException catch (e) {
      throw e;
    } catch (e) {
      debugPrint("Unexpected error in ShopBySubCategory : $e");
      rethrow;
    }
  }
}
