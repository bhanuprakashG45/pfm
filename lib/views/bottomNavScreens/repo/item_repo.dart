// import 'package:priya_fresh_meats/utils/exports.dart';

// abstract class ItemRepository {
//   Future<List<ItemModel>> getItemsBySubcategoryId(String subcategoryId);
// }

// class ItemRepositoryImpl implements ItemRepository {
//   final NetworkApiServices _apiServices = NetworkApiServices();

//   @override
//   Future<List<ItemModel>> getItemsBySubcategoryId(String subcategoryId) async {
//     try {
//       final sharedPref = SharedPref();
//       final hasToken = await sharedPref.hasAccessToken();
//       final token = await sharedPref.getAccessToken();

//       print('Has Access Token: $hasToken');
//       print('Token Length: ${token.length}');
//       print('Fetching items for subcategory ID: $subcategoryId');

//       if (!hasToken) {
//         throw Exception('No access token available. Please login first.');
//       }

//       final url = '${AppUrls.subcategoriesboxes}/$subcategoryId';

//       final response = await _apiServices.getApiResponse(url);

//       print('Raw Items API Response: $response');

//       if (response != null && response is Map) {
//         if (response['success'] == true && response['data'] != null) {
//           final Map<String, dynamic> responseData =
//               response['data'] as Map<String, dynamic>;
//           if (responseData['subCategories'] != null &&
//               responseData['subCategories'] is List) {
//             final List dataList = responseData['subCategories'] as List;

//             print('Number of items received: ${dataList.length}');

//             return dataList
//                 .map((item) => ItemModel.fromJson(item as Map<String, dynamic>))
//                 .toList();
//           } else {
//             print('No subCategories found in response data');
//             throw Exception('No items found for this subcategory');
//           }
//         } else {
//           print('Response message: ${response['message'] ?? 'No message'}');
//           throw Exception(response['message'] ?? 'Failed to load items');
//         }
//       } else {
//         throw Exception('Invalid response format');
//       }
//     } catch (e) {
//       print('Error in getItemsBySubcategoryId: $e');
//       if (e.toString().contains('UnauthorizedException') ||
//           e.toString().contains('Invalid or expired token')) {
//         throw Exception('Session expired. Please login again.');
//       }
//       rethrow;
//     }
//   }
// }
