import 'package:priya_fresh_meats/data/models/cart/cart_items_model.dart';
import 'package:priya_fresh_meats/data/models/cart/wallet_model.dart';
import 'package:priya_fresh_meats/utils/exports.dart';

class CartRepository {
  final NetworkApiServices _apiServices = NetworkApiServices();
  final SharedPref _pref = SharedPref();

  Future<CartItemsModel> fetchCartItems() async {
    try {
      final userId = await _pref.getUserId();
      final url = "${AppUrls.fetchCartItemsUrl}/$userId";
      debugPrint(url);

      final response = await _apiServices.getApiResponse(url);

      if (response is Map<String, dynamic>) {
        return CartItemsModel.fromJson(response);
      } else {
        throw Exception('Unexpected response type: ${response.runtimeType}');
      }
    } on AppException catch (e) {
      throw e;
    } catch (e) {
      debugPrint("Unexpected error in CartItems : $e");
      rethrow;
    }
  }

  Future<AllCouponsModel> fetchAllCoupons() async {
    try {
      final userId = await _pref.getUserId();
      final url = "${AppUrls.fetchCouponsUrl}/$userId";
      debugPrint(url);

      final response = await _apiServices.getApiResponse(url);

      if (response is Map<String, dynamic>) {
        return AllCouponsModel.fromJson(response);
      } else {
        throw Exception('Unexpected response type: ${response.runtimeType}');
      }
    } on AppException catch (e) {
      throw e;
    } catch (e) {
      debugPrint("Unexpected error in All Coupons : $e");
      rethrow;
    }
  }

  Future<PlaceOrderModel> placeOrder(
    String userType,
    String userName,
    String userPhone,
    String userFloor,
    String location,
    String notes,
    double lat,
    double long,
    String pincode,
    int? walletPoint,
    String? couponsId,
  ) async {
    try {
      final Map<String, dynamic> payload = {
        "houseNo": userFloor,
        "deleveyFor": userType,
        "recieverName": userName,
        "location": location,
        "phone": userPhone,
        "notes": 'Deliver with Care',
        "latitude": lat,
        "longitude": long,
        "pincode": pincode,
      };
      debugPrint(pincode.toString());

      if (walletPoint != null) {
        payload["walletPoint"] = walletPoint;
      } else if (couponsId != null && couponsId.isNotEmpty) {
        payload["couponsId"] = couponsId;
      }
      final userId = await _pref.getUserId();

      final url = "${AppUrls.placeOrderUrl}/$userId";
      final response = await _apiServices.postApiResponse(url, payload);
      return PlaceOrderModel.fromJson(response);
    } on AppException catch (e) {
      throw e;
    } catch (e) {
      debugPrint("Unexpected error in Place order: $e");
      rethrow;
    }
  }

  Future<WalletModel> fetchWallet() async {
    try {
      final userId = await _pref.getUserId();
      final url = "${AppUrls.walletUrl}/$userId";
      debugPrint(url);

      final response = await _apiServices.getApiResponse(url);

      if (response is Map<String, dynamic>) {
        return WalletModel.fromJson(response);
      } else {
        throw Exception('Unexpected response type: ${response.runtimeType}');
      }
    } on AppException catch (e) {
      throw e;
    } catch (e) {
      debugPrint("Unexpected error in Wallet  : $e");
      rethrow;
    }
  }
}
