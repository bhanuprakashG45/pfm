import 'package:priya_fresh_meats/utils/exports.dart';

abstract class ItemDetailsRepository {
  Future<ItemDetailsModel> getItemDetails(String itemId);
}

class ItemDetailsRepositoryImpl implements ItemDetailsRepository {
  final NetworkApiServices _apiServices = NetworkApiServices();

  @override
  Future<ItemDetailsModel> getItemDetails(String itemId) async {
    try {
      final url = '${AppUrls.itemDetailsView}/$itemId';

      final response = await _apiServices.getApiResponse(url);

      print('Raw Item Details API Response: $response');

      if (response != null && response is Map) {
        if (response['success'] == true && response['data'] != null) {
          final Map<String, dynamic> itemData =
              response['data'] as Map<String, dynamic>;

          print('Item details received successfully');

          return ItemDetailsModel.fromJson(itemData);
        } else {
          print('Response message: ${response['message'] ?? 'No message'}');
          throw Exception(response['message'] ?? 'Failed to load item details');
        }
      } else {
        throw Exception('Invalid response format');
      }
    } catch (e) {
      print('Error in getItemDetails: $e');
      if (e.toString().contains('UnauthorizedException') ||
          e.toString().contains('Invalid or expired token')) {
        throw Exception('Session expired. Please login again.');
      }
      rethrow;
    }
  }
}
