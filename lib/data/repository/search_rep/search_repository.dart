import 'package:priya_fresh_meats/utils/exports.dart';

class SearchRepository {
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<SearchShopByCategoryModel> fetchAllShopByCategory() async {
    try {
      final url = AppUrls.searchShopByCategoryUrl;
      debugPrint(url);

      final response = await _apiServices.getApiResponse(url);

      if (response is Map<String, dynamic>) {
        return SearchShopByCategoryModel.fromJson(response);
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

  Future<SearchDataModel> fetchSearchData() async {
    try {
      final url = AppUrls.searchDataUrl;
      debugPrint(url);

      final response = await _apiServices.getApiResponse(url);

      if (response is Map<String, dynamic>) {
        return SearchDataModel.fromJson(response);
      } else {
        throw Exception('Unexpected response type: ${response.runtimeType}');
      }
    } on AppException catch (e) {
      throw e;
    } catch (e) {
      debugPrint("Unexpected error in All Search Data  : $e");
      rethrow;
    }
  }
}
