import 'package:priya_fresh_meats/data/models/profile/contact_us_model.dart';
import 'package:priya_fresh_meats/data/models/profile/delete_address_model.dart';
import 'package:priya_fresh_meats/data/models/profile/newaddress_model.dart';
import 'package:priya_fresh_meats/data/models/profile/notifications_model.dart';
import 'package:priya_fresh_meats/data/models/profile/profile_details_model.dart';
import 'package:priya_fresh_meats/data/models/profile/update_address_model.dart';
import 'package:priya_fresh_meats/data/models/profile/update_profile_model.dart';
import 'package:priya_fresh_meats/utils/exports.dart';

class ProfileRepository {
  final NetworkApiServices _apiServices = NetworkApiServices();
  final SharedPref _pref = SharedPref();

  Future<ProfileDetailsModel> fetchprofile() async {
    try {
      final userId = await _pref.getUserId();
      final url = "${AppUrls.fetchProfileUrl}/$userId";
      final response = await _apiServices.getApiResponse(url);

      debugPrint("API Response: $response");

      if (response is Map<String, dynamic>) {
        return ProfileDetailsModel.fromJson(response);
      } else {
        throw Exception("Invalid response format");
      }
    } catch (e) {
      debugPrint("Error in Profile Details: $e");
      rethrow;
    }
  }

  Future<UpdateProfileModel> updateProfile(String name, String email) async {
    try {
      String? userId = await _pref.getUserId();
      debugPrint(userId);
      final url = "${AppUrls.updateProfileUrl}/$userId";
      debugPrint(url);
      final data = {"name": name, "email": email};

      final response = await _apiServices.patchApiResponse(url, data);

      return UpdateProfileModel.fromJson(response);
    } on AppException catch (e) {
      throw e;
    } catch (e) {
      debugPrint("Unexpected error in Update Profile: $e");
      rethrow;
    }
  }

  Future<ContactResponse> getContacts() async {
    try {
      final url = AppUrls.getcontact;
      final response = await _apiServices.getApiResponse(url);

      print("API Response: $response");

      if (response is Map<String, dynamic>) {
        return ContactResponse.fromJson(response);
      } else {
        throw Exception("Invalid response format");
      }
    } catch (e) {
      print("Error in getContacts: $e");
      rethrow;
    }
  }

  Future<NotificationsModel> fetchNotifications() async {
    try {
      final userId = await _pref.getUserId();
      final url = "${AppUrls.fetchNotificationsUrl}/$userId";
      debugPrint(url);

      final response = await _apiServices.getApiResponse(url);

      if (response is Map<String, dynamic>) {
        return NotificationsModel.fromJson(response);
      } else {
        throw Exception('Unexpected response type: ${response.runtimeType}');
      }
    } on AppException catch (e) {
      throw e;
    } catch (e) {
      debugPrint("Unexpected error in Notifications : $e");
      rethrow;
    }
  }

  Future<AllAddressModel> fetchAllAddress() async {
    try {
      final userId = await _pref.getUserId();
      final url = "${AppUrls.getAllAddedAddressUrl}/$userId";
      debugPrint(url);

      final response = await _apiServices.getApiResponse(url);

      if (response is Map<String, dynamic>) {
        return AllAddressModel.fromJson(response);
      } else {
        throw Exception('Unexpected response type: ${response.runtimeType}');
      }
    } on AppException catch (e) {
      throw e;
    } catch (e) {
      debugPrint("Unexpected error in All Address : $e");
      rethrow;
    }
  }

  Future<NewAddressModel> addNewAddress(
    String name,
    String phone,
    String houseNo,
    String streetName,
    String city,
    String state,
    String pincode,
    String type,
    String lat,
    String long,
  ) async {
    try {
      String? userId = await _pref.getUserId();
      debugPrint(userId);
      final url = "${AppUrls.addAddressUrl}/$userId";
      debugPrint(url);
      final data = {
        "name": name,
        "phone": phone,
        "houseNo": houseNo,
        "street": streetName,
        "city": city,
        "state": state,
        "pincode": pincode,
        "type": type,
        "latitude": lat,
        "longitude": long,
      };

      final response = await _apiServices.postApiResponse(url, data);

      return NewAddressModel.fromJson(response);
    } on AppException catch (e) {
      throw e;
    } catch (e) {
      debugPrint("Unexpected error in Add New Address: $e");
      rethrow;
    }
  }

  Future<UpdateAddressModel> updateAddress(
    String id,
    String name,
    String phone,
    String houseNo,
    String streetName,
    String city,
    String state,
    String pincode,
    String type,
    String lat,
    String long,
  ) async {
    try {
      String? userId = await _pref.getUserId();
      debugPrint(userId);
      final url = "${AppUrls.updateAddressUrl}/$userId/$id";
      debugPrint(url);
      final data = {
        "name": name,
        "phone": phone,
        "houseNo": houseNo,
        "street": streetName,
        "city": city,
        "state": state,
        "pincode": pincode,
        "type": type,
        "latitude": lat,
        "longitude": long,
      };

      final response = await _apiServices.patchApiResponse(url, data);

      return UpdateAddressModel.fromJson(response);
    } on AppException catch (e) {
      throw e;
    } catch (e) {
      debugPrint("Unexpected error in Update New Address: $e");
      rethrow;
    }
  }

  Future<UpdateAddressModel> updateDefaultAddress(String id, bool value) async {
    try {
      String? userId = await _pref.getUserId();
      debugPrint(userId);
      final url = "${AppUrls.updateAddressUrl}/$userId/$id";
      debugPrint(url);
      final data = {"isSelected": value};

      final response = await _apiServices.patchApiResponse(url, data);

      return UpdateAddressModel.fromJson(response);
    } on AppException catch (e) {
      throw e;
    } catch (e) {
      debugPrint("Unexpected error in Update Default Address: $e");
      rethrow;
    }
  }

  Future<DeleteAddressModel> deleteAddress(String itemId) async {
    try {
      String? userId = await _pref.getUserId();
      debugPrint(userId);
      final url = '${AppUrls.deleteAddressUrl}/$userId/$itemId';
      debugPrint(url);

      final response = await _apiServices.deleteApiResponse(url);

      return DeleteAddressModel.fromJson(response);
    } on AppException catch (e) {
      throw e;
    } catch (e) {
      debugPrint("Unexpected error in Delete Address : $e");
      rethrow;
    }
  }

  Future<void> orderhistory() async {}
}
