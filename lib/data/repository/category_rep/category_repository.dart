import 'package:priya_fresh_meats/data/models/category/item_model.dart';
import 'package:priya_fresh_meats/utils/exports.dart';

class CategoryRepo {
  final NetworkApiServices _apiServices = NetworkApiServices();
  final SharedPref _pref = SharedPref();

  Future<ItemModel> fetchSubItems(String itemId) async {
    try {
      final userId = await _pref.getUserId();
      final url = '${AppUrls.subcategoriesboxes}/$itemId?userId=$userId';
      debugPrint(url);

      final response = await _apiServices.getApiResponse(url);

      if (response is Map<String, dynamic>) {
        return ItemModel.fromJson(response);
      } else {
        throw Exception('Unexpected response type: ${response.runtimeType}');
      }
    } on AppException catch (e) {
      throw e;
    } catch (e) {
      debugPrint("Unexpected error in Item Model : $e");
      rethrow;
    }
  }
}
