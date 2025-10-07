import 'package:priya_fresh_meats/data/models/home/additems_tocart_model.dart';
import 'package:priya_fresh_meats/data/models/home/best_sellers_model.dart';
import 'package:priya_fresh_meats/data/models/home/cartcount_model.dart';
import 'package:priya_fresh_meats/data/models/home/delete_item_fromcart_model.dart';
import 'package:priya_fresh_meats/data/models/home/notifyme_model.dart';
import 'package:priya_fresh_meats/data/models/home/update_items_tocart_model.dart';
import 'package:priya_fresh_meats/utils/exports.dart';

class HomeRepository {
  final NetworkApiServices _apiServices = NetworkApiServices();
  final SharedPref _pref = SharedPref();
  Future<BestSellersModel> fetchBestSellers() async {
    try {
      final userId = await _pref.getUserId();
      String url;
      if (userId.isNotEmpty) {
        url = '${AppUrls.bestSellersUrl}?userId=$userId';
      } else {
        url = AppUrls.bestSellersUrl;
      }
      debugPrint(url);

      final response = await _apiServices.getApiResponse(url);

      if (response is Map<String, dynamic>) {
        return BestSellersModel.fromJson(response);
      } else {
        throw Exception('Unexpected response type: ${response.runtimeType}');
      }
    } on AppException catch (e) {
      throw e;
    } catch (e) {
      debugPrint("Unexpected error in fetchBestSellers: $e");
      rethrow;
    }
  }

  Future<AddItemToCartModel> addItemsToCart(String itemId) async {
    try {
      String? userId = await _pref.getUserId();
      debugPrint(userId);
      final url = AppUrls.addToCartUrl + userId;
      debugPrint(url);
      final data = {"subCategoryId": itemId};

      final response = await _apiServices.postApiResponse(url, data);

      return AddItemToCartModel.fromJson(response);
    } on AppException catch (e) {
      throw e;
    } catch (e) {
      debugPrint("Unexpected error in addItemsToCart: $e");
      rethrow;
    }
  }

  Future<UpdateItemToCartModel> updateCount(String itemId, int count) async {
    try {
      String? userId = await _pref.getUserId();
      debugPrint(userId);
      final url = '${AppUrls.updateCountUrl}$userId/item/$itemId';
      debugPrint(url);
      final data = {"count": count};

      final response = await _apiServices.patchApiResponse(url, data);

      return UpdateItemToCartModel.fromJson(response);
    } on AppException catch (e) {
      throw e;
    } catch (e) {
      debugPrint("Unexpected error in UpdateItems To cart: $e");
      rethrow;
    }
  }

  Future<DeleteCartItemModel> deleteCount(String itemId) async {
    try {
      String? userId = await _pref.getUserId();
      debugPrint(userId);
      final url = '${AppUrls.deleteItemUrl}/$userId/item/$itemId';
      debugPrint(url);

      final response = await _apiServices.deleteApiResponse(url);

      return DeleteCartItemModel.fromJson(response);
    } on AppException catch (e) {
      throw e;
    } catch (e) {
      debugPrint("Unexpected error in UpdateItems To cart: $e");
      rethrow;
    }
  }

  Future<CartCountModel> fetchCartCount() async {
    try {
      String? userId = await _pref.getUserId();
      debugPrint(userId);
      final url = "${AppUrls.fetchCartUrl}/$userId";
      debugPrint(url);

      final response = await _apiServices.getApiResponse(url);
      print(response);

      return CartCountModel.fromJson(response);
    } on AppException catch (e) {
      throw e;
    } catch (e) {
      debugPrint("Unexpected error in Fetch Count From cart: $e");
      rethrow;
    }
  }

  Future<NotifyMeModel> notifyMe(String itemId) async {
    debugPrint("Entered inside Notify me repo");
    try {
      String? userId = await _pref.getUserId();
      debugPrint(userId);
      final url = "${AppUrls.notifymeUrl}/$itemId/user/$userId";
      debugPrint(url);
      final data = {};

      final response = await _apiServices.postApiResponse(url, data);

      return NotifyMeModel.fromJson(response);
    } on AppException catch (e) {
      throw e;
    } catch (e) {
      debugPrint("Unexpected error in NotifyMe : $e");
      rethrow;
    }
  }
}
