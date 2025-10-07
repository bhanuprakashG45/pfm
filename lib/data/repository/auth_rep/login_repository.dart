import 'package:priya_fresh_meats/data/models/auth/deleteaccount_model.dart';
import 'package:priya_fresh_meats/utils/exports.dart';

class LoginRepository {
  final NetworkApiServices _apiServices = NetworkApiServices();
  Future<LoginOtpModel> sendOtp(String phone) async {
    try {
      final payload = {"phone": phone};

      final response = await _apiServices.postApiResponse(
        AppUrls.sendOtp,
        payload,
      );

      return LoginOtpModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserDataModel> verifyOtp(
    String otp,
    String phone,
    String userId,
  ) async {
    try {
      final payload = {"otp": otp, "phone": phone, "userId": userId};

      final response = await _apiServices.postApiResponse(
        AppUrls.verifyOtp,
        payload,
      );
      return UserDataModel.fromJson(response);
    } on AppException catch (e) {
      throw e;
    } catch (e) {
      debugPrint("Unexpected error in verifyOtp: $e");
      rethrow;
    }
  }

  Future<DeleteAccountModel> deleteAccount(String userId) async {
    try {
      debugPrint(userId);
      final url = '${AppUrls.deleteAccountUrl}/$userId';
      debugPrint(url);

      final response = await _apiServices.deleteApiResponse(url);

      return DeleteAccountModel.fromJson(response);
    } on AppException catch (e) {
      throw e;
    } catch (e) {
      debugPrint("Unexpected error in Delete Account: $e");
      rethrow;
    }
  }
}
