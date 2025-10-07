import 'package:priya_fresh_meats/data/models/profile/orders/active_order_model.dart';
import 'package:priya_fresh_meats/data/models/profile/orders/cancel_order_model.dart';
import 'package:priya_fresh_meats/data/models/profile/orders/delete_order_history_model.dart';
import 'package:priya_fresh_meats/data/models/profile/orders/order_details_model.dart';
import 'package:priya_fresh_meats/data/models/profile/orders/re_order_model.dart';
import 'package:priya_fresh_meats/data/models/profile/orders/track_order_model.dart';
import 'package:priya_fresh_meats/utils/exports.dart';

class OrderRepository {
  final NetworkApiServices _apiServices = NetworkApiServices();
  final SharedPref _pref = SharedPref();

  Future<OrderHistoryModel> fetchHistory() async {
    try {
      final userId = await _pref.getUserId();

      if (userId.isEmpty) {
        throw Exception("User ID is null or empty");
      }

      final url = "${AppUrls.orderHistoryUrl}/$userId";
      debugPrint("Fetching Order History from: $url");

      final response = await _apiServices.getApiResponse(url);

      if (response == null) {
        throw Exception("API returned null response");
      }

      if (response is Map<String, dynamic>) {
        return OrderHistoryModel.fromJson(response);
      } else if (response is String) {
        final decoded = jsonDecode(response);
        if (decoded is Map<String, dynamic>) {
          return OrderHistoryModel.fromJson(decoded);
        } else {
          throw Exception("Decoded response is not a valid JSON object");
        }
      } else {
        throw Exception("Unexpected response type: ${response.runtimeType}");
      }
    } on AppException catch (e) {
      debugPrint("AppException in Order History: $e");
      rethrow;
    } catch (e, stack) {
      debugPrint("Unexpected error in Order History: $e");
      debugPrint("Stacktrace: $stack");
      rethrow;
    }
  }

  Future<OrderDetailsModel> fetchOrderDetails(String orderId) async {
    try {
      final url = "${AppUrls.orderDetailsUrl}/$orderId";
      debugPrint("Fetching Order Details from: $url");

      final response = await _apiServices.getApiResponse(url);

      if (response == null) {
        throw Exception("API returned null response");
      }

      if (response is Map<String, dynamic>) {
        return OrderDetailsModel.fromJson(response);
      } else if (response is String) {
        final decoded = jsonDecode(response);
        if (decoded is Map<String, dynamic>) {
          return OrderDetailsModel.fromJson(decoded);
        } else {
          throw Exception("Decoded response is not a valid JSON object");
        }
      } else {
        throw Exception("Unexpected response type: ${response.runtimeType}");
      }
    } on AppException catch (e) {
      debugPrint("AppException in Order Details: $e");
      rethrow;
    } catch (e, stack) {
      debugPrint("Unexpected error in Order History: $e");
      debugPrint("Stacktrace: $stack");
      rethrow;
    }
  }

  Future<DeleteOrderHistoryModel> deleteOrderHistory(String orderId) async {
    try {
      final url = '${AppUrls.deleteOrderHistoryUrl}/$orderId';
      debugPrint(url);
      final response = await _apiServices.deleteApiResponse(url);

      return DeleteOrderHistoryModel.fromJson(response);
    } on AppException catch (e) {
      throw e;
    } catch (e) {
      debugPrint("Unexpected error in Delete History: $e");
      rethrow;
    }
  }

  Future<ReOrderModel> reOrder(String itemId) async {
    try {
      final userId = await _pref.getUserId();

      final url = "${AppUrls.reorderUrl}/$userId/order/$itemId";
      debugPrint("Fetching Re Order from: $url");

      final response = await _apiServices.getApiResponse(url);

      if (response == null) {
        throw Exception("API returned null response");
      }

      if (response is Map<String, dynamic>) {
        return ReOrderModel.fromJson(response);
      } else if (response is String) {
        final decoded = jsonDecode(response);
        if (decoded is Map<String, dynamic>) {
          return ReOrderModel.fromJson(decoded);
        } else {
          throw Exception("Decoded response is not a valid JSON object");
        }
      } else {
        throw Exception("Unexpected response type: ${response.runtimeType}");
      }
    } on AppException catch (e) {
      debugPrint("AppException in ReOrder: $e");
      rethrow;
    } catch (e, stack) {
      debugPrint("Unexpected error in ReOrder: $e");
      debugPrint("Stacktrace: $stack");
      rethrow;
    }
  }

  Future<TrackOrderModel> fetchTrackOrder(String itemId) async {
    try {
      final url = "${AppUrls.trackorderUrl}/$itemId";
      debugPrint("Fetching Track Order from: $url");

      final response = await _apiServices.getApiResponse(url);

      if (response == null) {
        throw Exception("API returned null response");
      }

      if (response is Map<String, dynamic>) {
        return TrackOrderModel.fromJson(response);
      } else if (response is String) {
        final decoded = jsonDecode(response);
        if (decoded is Map<String, dynamic>) {
          return TrackOrderModel.fromJson(decoded);
        } else {
          throw Exception("Decoded response is not a valid JSON object");
        }
      } else {
        throw Exception("Unexpected response type: ${response.runtimeType}");
      }
    } on AppException catch (e) {
      debugPrint("AppException in Track Order: $e");
      rethrow;
    } catch (e, stack) {
      debugPrint("Unexpected error in Track Order: $e");
      debugPrint("Stacktrace: $stack");
      rethrow;
    }
  }

  Future<ActiveOrderModel> fetchActiveorders() async {
    try {
      final userId = await _pref.getUserId();
      final url = "${AppUrls.activeOrderUrl}/$userId";
      debugPrint("Fetching Active Order from: $url");

      final response = await _apiServices.getApiResponse(url);

      if (response == null) {
        throw Exception("API returned null response");
      }

      if (response is Map<String, dynamic>) {
        return ActiveOrderModel.fromJson(response);
      } else if (response is String) {
        final decoded = jsonDecode(response);
        if (decoded is Map<String, dynamic>) {
          return ActiveOrderModel.fromJson(decoded);
        } else {
          throw Exception("Decoded response is not a valid JSON object");
        }
      } else {
        throw Exception("Unexpected response type: ${response.runtimeType}");
      }
    } on AppException catch (e) {
      debugPrint("AppException in Track Order: $e");
      rethrow;
    } catch (e, stack) {
      debugPrint("Unexpected error in Active Order: $e");
      debugPrint("Stacktrace: $stack");
      rethrow;
    }
  }

  Future<CancelOrderModel> cancelOrder(String orderId, String reason) async {
    try {
      String? userId = await _pref.getUserId();
      debugPrint(userId);
      final url = "${AppUrls.cancelorderUrl}/$userId/$orderId";
      debugPrint(url);
      final data = {"notes": reason};

      final response = await _apiServices.postApiResponse(url, data);

      return CancelOrderModel.fromJson(response);
    } on AppException catch (e) {
      throw e;
    } catch (e) {
      debugPrint("Unexpected error in Add New Address: $e");
      rethrow;
    }
  }
}
